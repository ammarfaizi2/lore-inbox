Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290010AbSAWTxo>; Wed, 23 Jan 2002 14:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290014AbSAWTxf>; Wed, 23 Jan 2002 14:53:35 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:31492 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S290010AbSAWTxP>; Wed, 23 Jan 2002 14:53:15 -0500
Message-ID: <3C4F1325.C65001EE@zip.com.au>
Date: Wed, 23 Jan 2002 11:46:45 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Stern <stern@rowland.org>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Daemonize() should re-parent its caller
In-Reply-To: <Pine.LNX.4.33L2.0201231050440.687-100000@ida.rowland.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> 
> Consider the question: what happens when a kernel thread dies?  For
> the most part this doesn't come up, since most kernel threads stay
> alive as long as the system is up.  But when a kernel thread dies, the
> same thing happens as with any other thread: it becomes a zombie, and
> its exit_signal (if any) is posted to its parent.
> 
> ...
> 
> But a more elegant and economical solution is to have the daemonize()
> routine automatically re-parent its caller to be a child of init
> (assuming the caller's parent isn't init already).  At the same time,
> the caller's exit_signal should be set to SIGCHLD.  This would
> definitely solve the problem, and it is unlikely to introduce any
> incompatibilities with existing code.
> 

Yes.   There's a function in the 2.4 series called reparent_to_init()
whch does this.  Typically a kernel thread will call that immediately
after calling daemonize().  It _should_ solve any problem which you're
observing.  Could you please test that, and if it fixes the problem
which you're seeing, send a patch to the USB maintainers?

Perhaps we should unconditionally call reparent_to_init() from within
daemonize().  I wimped out on doing that because of the possibility
of strangely breaking something.

Really, an audit of all callers of kernel_thread() is needed, and
most of them should would end up using reparent_to_init().  Difficult
to do in the 2.4 context, so we should only do this when and where
problems are demonstrated.

(But you Cc'ed Alan.  Are you using 2.2.x?)

-
