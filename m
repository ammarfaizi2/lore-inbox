Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVGLP0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVGLP0E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 11:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVGLP0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 11:26:04 -0400
Received: from ms005msg.fastwebnet.it ([213.140.2.50]:38339 "EHLO
	ms005msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S261394AbVGLP0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 11:26:01 -0400
Date: Tue, 12 Jul 2005 17:25:04 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Lack of Documentation about SA_RESTART...
Message-ID: <20050712172504.1216a174@localhost>
In-Reply-To: <20050712120456.GA14032@thunk.org>
References: <20050711123237.787dfcde@localhost>
	<20050711143427.GC14529@thunk.org>
	<20050712103811.0087a7e3@localhost>
	<20050712120456.GA14032@thunk.org>
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2005 08:04:56 -0400
Theodore Ts'o <tytso@mit.edu> wrote:

> > 
> > The logically correct behaviur with blocking connect interrupted and
> > then restarted should be to continue the blocking wait... IHMO.
> 
> I was looking at what happened with a *non-blocking* connect
> interrupted by an SA_RESTART signal.  Since it is non-blocking, it
> will never continue with the wait.  The only question is whether it
> should return with an EINTR (which is what it currently does) or
> return with whatever error code it would have returned if the signal
> had not been delievered in the first place.  We currently do the
> former; a close reading of the spec seems the require the latter.
> Fortunately this is a pretty narrow race condition since the chances
> of a signal being delivered right in the middle of a non-blocking
> connect are small.

Hmmm... no, no. A connect() on non-blocking socket will NEVER return
EINTR. SUSV3 and Linux code agree.

A syscall isn't magically interrupted if a signal arrives... it's the
syscall that must check for pending signals and do the proper action
(usually it will return with -EINTR or -ERESTARTSYS).

A connect() on a blocking socket is something like this (very
approssimative):

	1) code to activate the connection
	2) sleep waiting for something (connection ready / signal received...)
	3) if connection is ready then return 0, else if there are pending
	signals return -ERESTARTSYS

With non-blocking socket the syscall never sleeps, and never checks for
pending signals.

Look at "net/ipv4/af_inet.c": in particular at "net_wait_for_connect"
and its usage in "inet_stream_connect".

--
	Paolo Ornati
	Linux 2.6.12.2 on x86_64
