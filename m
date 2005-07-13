Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262624AbVGMHqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbVGMHqx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 03:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbVGMHqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 03:46:52 -0400
Received: from ms003msg.fastwebnet.it ([213.140.2.42]:29135 "EHLO
	ms003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S262624AbVGMHqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 03:46:52 -0400
Date: Wed, 13 Jul 2005 09:45:53 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Lack of Documentation about SA_RESTART...
Message-ID: <20050713094553.30bebac9@localhost>
In-Reply-To: <20050712181635.GA7441@thunk.org>
References: <20050711123237.787dfcde@localhost>
	<20050711143427.GC14529@thunk.org>
	<20050712103811.0087a7e3@localhost>
	<20050712120456.GA14032@thunk.org>
	<20050712172504.1216a174@localhost>
	<20050712181635.GA7441@thunk.org>
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2005 14:16:35 -0400
Theodore Ts'o <tytso@mit.edu> wrote:

> Yes, do look at that.  From the latest 2.6 sources:
> 
> 	timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);
> 
> 	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV)) {
> 		/* Error code is set above */
> 		if (!timeo || !inet_wait_for_connect(sk, timeo))
> 			goto out;
> 
> 		err = sock_intr_errno(timeo);
> 		if (signal_pending(current))
> 			goto out;
> 	}
> 
> If the socket is non-blocking, then we don't call
> inet_wiat_for_connect(), yes.  But sock_intr_errno() will set the
> error code to -EINTR if the socket is set to non-nonblocking (see
> include/net/sock.h), and if a signal is pending, return it.

No.

With non-blocking socket "timeo" is set to 0. So the instruction:

	if (!timeo || !inet_wait_for_connect(sk, timeo))
		goto out;

jumps directly to "out" label. "sock_intr_errno()" isn't called.

-- 
	Paolo Ornati
	Linux 2.6.12.2 on x86_64
