Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129810AbQLUKN2>; Thu, 21 Dec 2000 05:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129884AbQLUKNT>; Thu, 21 Dec 2000 05:13:19 -0500
Received: from smtp5.mail.yahoo.com ([128.11.69.102]:13061 "HELO
	smtp5.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129810AbQLUKNE>; Thu, 21 Dec 2000 05:13:04 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A41CD4F.1259FB08@yahoo.com>
Date: Thu, 21 Dec 2000 04:28:47 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.18 i486)
MIME-Version: 1.0
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
CC: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: set_rtc_mmss: can't update from 0 to 59
In-Reply-To: <UTC200012172054.VAA173604.aeb@aak.cwi.nl> <20001217194737.C11947@one-eyed-alien.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dharm wrote:
> 
> On Sun, Dec 17, 2000 at 09:54:18PM +0100, Andries.Brouwer@cwi.nl wrote:
> 
> > Of course, messing with the cmos clock at all was a rather bad idea,
> > but that is a different discussion.
> 
> True enough...  but, the question is, how do we fix this?  Make the logic
> more buff?  Or change the algorithm to use something like minutes since the
> epoch?

Actually I agree 100% with Andries -- having the kernel write back its
time into the CMOS RTC every 11 minutes just because NTP is active seems
like a random heuristic that probably "seemed like a good idea at the time".
(Probably made more sense back when there were no other users of the RTC.)

It smells like policy in the kernel to me.  What if a user wants to run NTP
but wants the CMOS RTC time as an independent clock to do something else
(possibly with the option of having a meaningful /etc/adjtime too) ?

Can't the people who want the current behaviour simply have a crontab
that runs (hw)clock -[u]w from util-linux at whatever interval they want?
Then set_rtc_mmss magically goes away,  the kernel doesn't need to know
UTC vs. local, and the timer interrupt gets smaller - a Good Thing(tm).

I'd delete set_rtc_mmss entirely, but I just #ifdef'd it out in case
I'm overlooking something...

Paul.


--- linux/arch/i386/kernel/time.c~	Mon Nov 20 04:16:25 2000
+++ linux/arch/i386/kernel/time.c	Thu Dec 21 04:10:37 2000
@@ -28,6 +28,9 @@
  * 1998-12-24 Copyright (C) 1998  Andrea Arcangeli
  *	Fixed a xtime SMP race (we need the xtime_lock rw spinlock to
  *	serialize accesses to xtime/lost_ticks).
+ * 2000-12-20	Paul Gortmaker
+ *	Don't mess with the CMOS clock just because NTP is used.  This
+ *	gets rid of annoying "set_rtc_mmss: can't update ..." messages.
  */
 
 #include <linux/errno.h>
@@ -304,7 +307,16 @@
 	write_unlock_irq(&xtime_lock);
 }
 
+#ifdef INVALIDATE_ADJTIME
 /*
+ * NOTE: This is NOT an externally exported interface for setting 
+ * the time stored in the RTC.  It is ONLY used internally to store
+ * the kernel time back into the RTC if the kernel time is externally
+ * synchronized.  (Yes, this smells like policy in the kernel...)
+ * If you enable this then your /etc/adjtime value(s) are no longer 
+ * valid. Conversely, non-zero /etc/adjtime values can result in this
+ * spewing the "set_rtc_mmss: cant update from N to M" messages.
+ *
  * In order to set the CMOS clock precisely, set_rtc_mmss has to be
  * called 500 ms after the second nowtime has started, because when
  * nowtime is written into the registers of the CMOS clock, it will
@@ -374,6 +386,7 @@
 
 /* last time the cmos clock got updated */
 static long last_rtc_update;
+#endif
 
 int timer_ack;
 
@@ -417,6 +430,7 @@
 		smp_local_timer_interrupt(regs);
 #endif
 
+#ifdef INVALIDATE_ADJTIME
 	/*
 	 * If we have an externally synchronized Linux clock, then update
 	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
@@ -431,6 +445,7 @@
 		else
 			last_rtc_update = xtime.tv_sec - 600; /* do it again in 60 s */
 	}
+#endif
 	    
 #ifdef CONFIG_MCA
 	if( MCA_bus ) {




_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
