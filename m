Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261328AbTC3Xtg>; Sun, 30 Mar 2003 18:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261334AbTC3Xtg>; Sun, 30 Mar 2003 18:49:36 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:13813 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id <S261328AbTC3Xtf>; Sun, 30 Mar 2003 18:49:35 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: "Shawn Starr" <spstarr@sh0n.net>, rml@tech9.net,
       linux-kernel@vger.kernel.org
Subject: Re: [OOPS][2.5.66bk3+] run_timer_softirq - IRQ Mishandlings - New OOPS w/ timer
References: <000b01c2f6d6$f843eab0$030aa8c0@unknown>
	<52he9k4lgc.fsf@topspin.com> <000701c2f703$58f50390$030aa8c0@unknown>
	<20030330151746.4394dd2e.akpm@digeo.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 30 Mar 2003 16:00:51 -0800
In-Reply-To: <20030330151746.4394dd2e.akpm@digeo.com>
Message-ID: <52d6k84d70.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 31 Mar 2003 00:00:54.0605 (UTC) FILETIME=[997B0FD0:01C2F718]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  > --- 25/drivers/char/tty_io.c~a	2003-03-30 15:12:37.000000000 -0800
  > +++ 25-akpm/drivers/char/tty_io.c	2003-03-30 15:16:59.000000000 -0800
  > @@ -1288,6 +1288,8 @@ static void release_dev(struct file * fi
  >  	/*
  >  	 * Make sure that the tty's task queue isn't activated. 
  >  	 */
  > +	clear_bit(TTY_DONT_FLIP, &tty->flags);
  > +	del_timer_sync(&tty->flip.work.timer);
  >  	flush_scheduled_work();

I'm confused by this for two reasons:

First, from looking at workqueue.c (especially the comment in
queue_delayed_work() that says "Increase nr_queued so that the flush
function knows that there's something pending."), it seems like
flush_scheduled_work() should wait until even delayed work is done.
Given that, I don't think the del_timer_sync() should be there --
wouldn't flush_scheduled_work() block forever, since nr_queued can
never reach 0 now?

(I guess I'm assuming the real race is that tty_io.c calls
schedule_delayed_work() between flush_scheduled_work() and
release_mem() in release_dev())

Second, I don't see how it's _ever_ safe to call
flush_scheduled_work().  The comment in workqueue.c before
flush_workqueue() says "NOTE: if work is being added to the queue
constantly by some other context then this function might block
indefinitely."  But flush_scheduled_work() is flushing the keventd_wq,
which other code will definitely add work to.  If we're unlucky,
flush_scheduled_work() could block forever.  Am I just being paranoid?

 - Roland

