Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264524AbTCYU0A>; Tue, 25 Mar 2003 15:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264526AbTCYU0A>; Tue, 25 Mar 2003 15:26:00 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:31651 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264524AbTCYUZ4>;
	Tue, 25 Mar 2003 15:25:56 -0500
Subject: [RFC] linux-2.5.66_lost-ticks-fix_A0
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FAzSCORmNuM/OwueexYr"
Organization: 
Message-Id: <1048624259.972.19.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 25 Mar 2003 12:30:59 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FAzSCORmNuM/OwueexYr
Content-Type: multipart/mixed; boundary="=-zPz1oVBWW8lJFTU09vLW"


--=-zPz1oVBWW8lJFTU09vLW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

All,
	I found a broken corner case with my earlier lost-ticks patch, so I'm
planning on submitting this fix to solve the issue.

The problem arises because we're doing two reads from the time source in
the timer_interrupt:
	detect_lost_tick();
	timer->mark_offset();

The problem with this being that even though we're in the interrupt
handler and properly locking our variables. The time sources keep on
ticking, so the two references to the time source are obviously not
atomic.=20

For example

time	function
-------------------------
@1990	detect_lost_tick()
	- calculate # of lost ticks (none, we're < 2000)
@2003	timer->mark_offset()
	- overwrite last_tsc_low/last_cyclone_timer
	- write 3 into delay_at_last_interrupt


Thus jiffies is only incremented once, but delay_at_last_interrupt is
too small so we get a time inconsistency.

This patch resolves the issue by doing the lost-tick compensation inside
timer->mark_offset(), thus there is only one read of the time-source per
interrupt.=20

Comments, flames and suggestions welcome.

thanks
-john


--=-zPz1oVBWW8lJFTU09vLW
Content-Disposition: attachment; filename=linux-2.5.66_lost-tick-fix_A0.patch
Content-Type: text/x-patch; name=linux-2.5.66_lost-tick-fix_A0.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Tue Mar 25 12:08:26 2003
+++ b/arch/i386/kernel/time.c	Tue Mar 25 12:08:26 2003
@@ -268,41 +268,6 @@
 }
=20
 /*
- * Lost tick detection and compensation
- */
-static inline void detect_lost_tick(void)
-{
-	/* read time since last interrupt */
-	unsigned long delta =3D timer->get_offset();
-	static unsigned long dbg_print;
-=09
-	/* check if delta is greater then two ticks */
-	if(delta >=3D 2*(1000000/HZ)){
-
-		/*
-		 * only print debug info first 5 times
-		 */
-		/*
-		 * AKPM: disable this for now; it's nice, but irritating.
-		 */
-		if (0 && dbg_print < 5) {
-			printk(KERN_WARNING "\nWarning! Detected %lu "
-				"micro-second gap between interrupts.\n",
-				delta);
-			printk(KERN_WARNING "  Compensating for %lu lost "
-				"ticks.\n",
-				delta/(1000000/HZ)-1);
-			dump_stack();
-			dbg_print++;
-		}
-		/* calculate number of missed ticks */
-		delta =3D delta/(1000000/HZ)-1;
-		jiffies +=3D delta;
-	}
-	=09
-}
-
-/*
  * This is the same as the above, except we _also_ save the current
  * Time Stamp Counter value at the time of the timer interrupt, so that
  * we later on can estimate the time of day more exactly.
@@ -318,7 +283,6 @@
 	 */
 	write_seqlock(&xtime_lock);
=20
-	detect_lost_tick();
 	timer->mark_offset();
 =20
 	do_timer_interrupt(irq, NULL, regs);
diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/time=
rs/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Tue Mar 25 12:08:26 2003
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Tue Mar 25 12:08:26 2003
@@ -17,6 +17,7 @@
 #include <asm/fixmap.h>
=20
 extern spinlock_t i8253_lock;
+extern unsigned long jiffies;
 extern unsigned long calibrate_tsc(void);
=20
 /* Number of usecs that the last interrupt was delayed */
@@ -35,6 +36,7 @@
=20
 static void mark_offset_cyclone(void)
 {
+	u32 delta =3D last_cyclone_timer;
 	int count;
 	spin_lock(&i8253_lock);
 	/* quickly read the cyclone timer */
@@ -47,6 +49,13 @@
 	count =3D inb_p(0x40);    /* read the latched count */
 	count |=3D inb(0x40) << 8;
 	spin_unlock(&i8253_lock);
+
+	/* lost tick compensation */
+	delta =3D last_cyclone_timer - delta;=09
+	delta /=3D(CYCLONE_TIMER_FREQ/1000000);
+	delta +=3D delay_at_last_interrupt;
+	if(delta >=3D 2*(1000000/HZ))
+		jiffies +=3D delta/(1000000/HZ)-1;
=20
 	count =3D ((LATCH-1) - count) * TICK_SIZE;
 	delay_at_last_interrupt =3D (count + LATCH/2) / LATCH;
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/t=
imer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Tue Mar 25 12:08:26 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Tue Mar 25 12:08:26 2003
@@ -17,6 +17,7 @@
 int tsc_disable __initdata =3D 0;
=20
 extern spinlock_t i8253_lock;
+extern unsigned long jiffies;
=20
 static int use_tsc;
 /* Number of usecs that the last interrupt was delayed */
@@ -62,6 +63,7 @@
=20
 static void mark_offset_tsc(void)
 {
+	unsigned long delta =3D last_tsc_low;
 	int count;
 	int countmp;
 	static int count1=3D0, count2=3DLATCH;
@@ -101,6 +103,21 @@
 			count2 =3D count1; count1 =3D count; count =3D count1;
 		}
 	}
+
+	/* lost tick compensation */
+	delta =3D last_tsc_low - delta;
+	{
+		register unsigned long eax, edx;
+		eax =3D delta;
+		__asm__("mull %2"
+		:"=3Da" (eax), "=3Dd" (edx)
+		:"rm" (fast_gettimeoffset_quotient),
+		 "0" (eax));
+		delta =3D edx;
+	}
+	delta +=3D delay_at_last_interrupt;
+	if(delta >=3D 2*(1000000/HZ))
+		jiffies +=3D delta/(1000000/HZ)-1;
=20
 	count =3D ((LATCH-1) - count) * TICK_SIZE;
 	delay_at_last_interrupt =3D (count + LATCH/2) / LATCH;

--=-zPz1oVBWW8lJFTU09vLW--

--=-FAzSCORmNuM/OwueexYr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA+gLyDMDAZ/OmgHwwRArTXAJ4zO7gkB1OR3dCIA/GqCre+pZiUKwCeOUAX
dbNjtatsHitvrM2tQtDsmY8=
=/8mJ
-----END PGP SIGNATURE-----

--=-FAzSCORmNuM/OwueexYr--

