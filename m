Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261287AbTC3VRa>; Sun, 30 Mar 2003 16:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbTC3VRa>; Sun, 30 Mar 2003 16:17:30 -0500
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:1796
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S261287AbTC3VR2>; Sun, 30 Mar 2003 16:17:28 -0500
Message-ID: <000701c2f703$58f50390$030aa8c0@unknown>
From: "Shawn Starr" <spstarr@sh0n.net>
To: "Roland Dreier" <roland@topspin.com>
Cc: "Andrew Morton" <akpm@digeo.com>, <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
References: <000b01c2f6d6$f843eab0$030aa8c0@unknown> <52he9k4lgc.fsf@topspin.com>
Subject: Re: [OOPS][2.5.66bk3+] run_timer_softirq - IRQ Mishandlings - New OOPS w/ timer
Date: Sun, 30 Mar 2003 16:28:43 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/tty_io.c - Only

I bet it's this function, there's only a kfree, not destruction of any
timers.

Added this rebuilt kernel waiting :-)

Shawn.

----- Original Message -----
From: "Roland Dreier" <roland@topspin.com>
To: "Shawn Starr" <spstarr@sh0n.net>
Cc: "Andrew Morton" <akpm@digeo.com>; <rml@tech9.net>;
<linux-kernel@vger.kernel.org>
Sent: Sunday, March 30, 2003 4:02 PM
Subject: Re: [OOPS][2.5.66bk3+] run_timer_softirq - IRQ Mishandlings - New
OOPS w/ timer


>     Shawn> Function found was: delayed_work_timer_fn
>     Shawn> (kernel/workqueue.c)
>
> It looks to me like something is calling schedule_delayed_work()
> (which calls queue_delayed_work(), which starts a timer) and then
> freeing the work_struct before it's executed.
>
> Here's a list of places that use schedule_delayed_work() where the
> work_struct might be kmalloc()ed.  Are you using any of these drivers?
> (Obviously you're using tty_io, so that bears some looking at)
>
>     drivers/char/cyclades.c
>     drivers/char/mxser.c
>     drivers/char/tty_io.c
>     drivers/isdn/i4l/isdn_tty.c
>     drivers/message/fusion/mptlan.c
>     drivers/net/hamradio/baycom_epp.c
>     drivers/net/plip.c
>     drivers/scsi/imm.c
>     drivers/scsi/ppa.c
>
> If tty_io.c is the problem, then maybe something like the patch below
> will find the culprit.
>
>   - Roland
>
> ===== drivers/char/tty_io.c 1.68 vs edited =====
> --- 1.68/drivers/char/tty_io.c Thu Mar 27 21:15:44 2003
> +++ edited/drivers/char/tty_io.c Sun Mar 30 12:51:00 2003
> @@ -169,6 +169,10 @@
>
>  static inline void free_tty_struct(struct tty_struct *tty)
>  {
> + if (timer_pending(&tty->flip.work.timer)) {
> + printk(KERN_WARNING "freeing tty with pending flip work timer from
[<%p>]\n",
> +        __builtin_return_address(0));
> + }
>   kfree(tty);
>  }
>
>

