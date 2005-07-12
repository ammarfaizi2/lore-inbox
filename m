Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbVGLST7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVGLST7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 14:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261995AbVGLSSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 14:18:00 -0400
Received: from THUNK.ORG ([69.25.196.29]:61872 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261934AbVGLSQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 14:16:36 -0400
Date: Tue, 12 Jul 2005 14:16:35 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Lack of Documentation about SA_RESTART...
Message-ID: <20050712181635.GA7441@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Paolo Ornati <ornati@fastwebnet.it>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050711123237.787dfcde@localhost> <20050711143427.GC14529@thunk.org> <20050712103811.0087a7e3@localhost> <20050712120456.GA14032@thunk.org> <20050712172504.1216a174@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050712172504.1216a174@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 05:25:04PM +0200, Paolo Ornati wrote:
> Hmmm... no, no. A connect() on non-blocking socket will NEVER return
> EINTR. SUSV3 and Linux code agree.
> 
> A syscall isn't magically interrupted if a signal arrives... it's the
> syscall that must check for pending signals and do the proper action
> (usually it will return with -EINTR or -ERESTARTSYS).
> 
> A connect() on a blocking socket is something like this (very
> approssimative):
> 
> 	1) code to activate the connection
> 	2) sleep waiting for something (connection ready / signal received...)
> 	3) if connection is ready then return 0, else if there are pending
> 	signals return -ERESTARTSYS
> 
> With non-blocking socket the syscall never sleeps, and never checks for
> pending signals.
> 
> Look at "net/ipv4/af_inet.c": in particular at "net_wait_for_connect"
> and its usage in "inet_stream_connect".

Yes, do look at that.  From the latest 2.6 sources:

	timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);

	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV)) {
		/* Error code is set above */
		if (!timeo || !inet_wait_for_connect(sk, timeo))
			goto out;

		err = sock_intr_errno(timeo);
		if (signal_pending(current))
			goto out;
	}

If the socket is non-blocking, then we don't call
inet_wiat_for_connect(), yes.  But sock_intr_errno() will set the
error code to -EINTR if the socket is set to non-nonblocking (see
include/net/sock.h), and if a signal is pending, return it.

					- Ted
