Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261191AbTC3UvN>; Sun, 30 Mar 2003 15:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261258AbTC3UvN>; Sun, 30 Mar 2003 15:51:13 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:9446 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id <S261191AbTC3UvM>; Sun, 30 Mar 2003 15:51:12 -0500
To: "Shawn Starr" <spstarr@sh0n.net>
Cc: "Andrew Morton" <akpm@digeo.com>, <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS][2.5.66bk3+] run_timer_softirq - IRQ Mishandlings - New OOPS w/ timer
References: <000b01c2f6d6$f843eab0$030aa8c0@unknown>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 30 Mar 2003 13:02:27 -0800
In-Reply-To: <000b01c2f6d6$f843eab0$030aa8c0@unknown>
Message-ID: <52he9k4lgc.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 30 Mar 2003 21:02:30.0230 (UTC) FILETIME=[AD2D0F60:01C2F6FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Shawn> Function found was: delayed_work_timer_fn
    Shawn> (kernel/workqueue.c)

It looks to me like something is calling schedule_delayed_work()
(which calls queue_delayed_work(), which starts a timer) and then
freeing the work_struct before it's executed.

Here's a list of places that use schedule_delayed_work() where the
work_struct might be kmalloc()ed.  Are you using any of these drivers?
(Obviously you're using tty_io, so that bears some looking at)

    drivers/char/cyclades.c
    drivers/char/mxser.c
    drivers/char/tty_io.c
    drivers/isdn/i4l/isdn_tty.c
    drivers/message/fusion/mptlan.c
    drivers/net/hamradio/baycom_epp.c
    drivers/net/plip.c
    drivers/scsi/imm.c
    drivers/scsi/ppa.c

If tty_io.c is the problem, then maybe something like the patch below
will find the culprit.

  - Roland

===== drivers/char/tty_io.c 1.68 vs edited =====
--- 1.68/drivers/char/tty_io.c	Thu Mar 27 21:15:44 2003
+++ edited/drivers/char/tty_io.c	Sun Mar 30 12:51:00 2003
@@ -169,6 +169,10 @@
 
 static inline void free_tty_struct(struct tty_struct *tty)
 {
+	if (timer_pending(&tty->flip.work.timer)) {
+		printk(KERN_WARNING "freeing tty with pending flip work timer from [<%p>]\n",
+		       __builtin_return_address(0));
+	}
 	kfree(tty);
 }
 
