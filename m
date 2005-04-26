Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVDZGXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVDZGXb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 02:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVDZGXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 02:23:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:55516 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261332AbVDZGXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 02:23:24 -0400
Date: Mon, 25 Apr 2005 23:22:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jason Baron <jbaron@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty races
Message-Id: <20050425232251.6ffac97c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0504201227370.13902@dhcp83-105.boston.redhat.com>
References: <Pine.LNX.4.61.0504201227370.13902@dhcp83-105.boston.redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Baron <jbaron@redhat.com> wrote:
>
> There are a couple of tty race conditions, which lead to inconsistent tty 
>  reference counting and tty layer oopses.
> 
>  The first is a tty_open vs. tty_close race in drivers/char/tty.io.c. 
>  Basically, from the time that the tty->count is deemed to be 1 and that we 
>  are going to free it to the time that TTY_CLOSING bit is set, needs to be 
>  atomic with respect to the manipulation of tty->count in init_dev(). This 
>  atomicity was previously guarded by the BKL. However, this is no longer 
>  true with the addition of a down() call in the middle of the 
>  release_dev()'s atomic path. So either the down() needs to be moved 
>  outside the atomic patch or dropped. I would vote for simply dropping it 
>  as i don't see why it is necessary.

The release_dev() changes looks very fishy to me.  It _removes_ locking. 
If that fixes the testcase then one of two things is happening:

a) we have lock_kernel() coverage and the down()'s sleeping breaks the
   lock_kenrel() coverage or

b) we don't have lock_kernel() coverage, but removing the down() just
   alters the timing and makes the race less probable.

I think it's b).  lock_kernel() coverage in there is very incomplete on the
open() side.

I think it would be better to _increase_ the tty_sem coverage in
release_dev() and to make sure that all callers of init_dev() are using
tty_sem (they are).

One approach would be to require that all callers of release_dev() hold
tty_sem, and make release_dev() drop and reacquire tty_sem in those cases
where release_dev() needs to go to sleep when waiting for other threads of
control to reelase the tty's resources.

>  The second race is tty_open vs. tty_open. This race I've seen when the 
>  virtual console is the tty driver. In con_open(),  vc_allocate() is called 
>  if the tty->count is 1. However, this check of the tty->count is not 
>  guarded by the 'tty_sem'. Thus, it is possible for con_open(), to never 
>  see the tty->count as 1, and thus never call vc_allocate(). This leads to 
>  a NULL filp->private_data, and an oops.
> 
>  The test case below reproduces these problems, and the patch fixes it. The 
>  test case uses /dev/tty9, which is generally restricted to root for 
>  open(). It may be able to exploit these races using pseudo terminals, 
>  although i wasn't able to. A previous report of this issue, with an oops 
>  trace was: http://www.ussg.iu.edu/hypermail/linux/kernel/0503.2/0017.html

So you've extended tty_sem coverage over the tty driver's ->open method.  I
guess that's OK.
