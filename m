Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263185AbTC1Wu4>; Fri, 28 Mar 2003 17:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263186AbTC1Wu4>; Fri, 28 Mar 2003 17:50:56 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:39139 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263185AbTC1Wut>;
	Fri, 28 Mar 2003 17:50:49 -0500
Subject: [PATCH] linux-2.5.66_monotonic-clock_A3
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Joel Becker <Joel.Becker@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jdw/PJMMTAb/k40Dv42U"
Organization: 
Message-Id: <1048892109.975.150.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 28 Mar 2003 14:55:09 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jdw/PJMMTAb/k40Dv42U
Content-Type: multipart/mixed; boundary="=-zW4Yv4UhRE3EYvpOHGIe"


--=-zW4Yv4UhRE3EYvpOHGIe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Linus, all,

	This patch, written with the advice of Joel Becker, addresses a problem
with the hangcheck-timer. The basic problem is that the hangcheck-timer
code (Required for Oracle) needs a accurate hard clock which can be used
to detect OS stalls (due to udelay() or pci bus hangs) that would cause
system time to skew (its sort of a sanity check that insures the
system's notion of time is accurate). However, currently they are using
get_cycles() to fetch the cpu's TSC register, thus this does not work on
systems w/o a synced TSC. As suggested by Andi Kleen (see thread here:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0302.0/1234.html ) I've
worked with Joel and others to implement the monotonic_clock()
interface. Some of the major considerations made when writing this patch
were:=20
o Needs to be able to return accurate time in the absence of
  multiple timer interrupts
o Needs to be abstracted out from the hardware
o Avoids impacting gettimeofday() performance

This interface returns a unsigned long long representing the number of
nanoseconds that has passed since time_init().=20

Please consider for inclusion.

thanks
-john


--=-zW4Yv4UhRE3EYvpOHGIe
Content-Disposition: attachment; filename=linux-2.5.66_monotonic-clock_A3.patch
Content-Type: text/x-patch; name=linux-2.5.66_monotonic-clock_A3.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Fri Mar 28 14:31:18 2003
+++ b/arch/i386/kernel/time.c	Fri Mar 28 14:31:18 2003
@@ -138,6 +138,23 @@
 	clock_was_set();
 }
=20
+/* monotonic_clock(): returns # of nanoseconds passed since time_init()
+ *		Note: This function is required to return accurate
+ *		time even in the absence of multiple timer ticks.
+ */
+unsigned long long monotonic_clock(void)
+{
+	unsigned long long ret;
+	unsigned long seq;
+	do {
+		seq =3D read_seqbegin(&xtime_lock);
+		ret =3D timer->monotonic_clock();
+	} while (read_seqretry(&xtime_lock, seq));
+	return ret;
+}
+EXPORT_SYMBOL(monotonic_clock);
+
+
 /*
  * In order to set the CMOS clock precisely, set_rtc_mmss has to be
  * called 500 ms after the second nowtime has started, because when
diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/time=
rs/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Fri Mar 28 14:31:18 2003
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Fri Mar 28 14:31:18 2003
@@ -27,19 +27,26 @@
 #define CYCLONE_MPMC_OFFSET 0x51D0
 #define CYCLONE_MPCS_OFFSET 0x51A8
 #define CYCLONE_TIMER_FREQ 100000000
-
+#define CYCLONE_TIMER_MASK (((u64)1<<40)-1) /* 40 bit mask */
 int use_cyclone =3D 0;
=20
 static u32* volatile cyclone_timer;	/* Cyclone MPMC0 register */
-static u32 last_cyclone_timer;
+static u32 last_cyclone_low;
+static u32 last_cyclone_high;
+static unsigned long long monotonic_base;
=20
 static void mark_offset_cyclone(void)
 {
 	int count;
+	unsigned long long this_offset, last_offset;
+	last_offset =3D ((unsigned long long)last_cyclone_high<<32)|last_cyclone_=
low;
+=09
 	spin_lock(&i8253_lock);
 	/* quickly read the cyclone timer */
-	if(cyclone_timer)
-		last_cyclone_timer =3D cyclone_timer[0];
+	do {=09
+		last_cyclone_high =3D cyclone_timer[1];
+		last_cyclone_low =3D cyclone_timer[0];
+	} while (last_cyclone_high !=3D cyclone_timer[1]);
=20
 	/* calculate delay_at_last_interrupt */
 	outb_p(0x00, 0x43);     /* latch the count ASAP */
@@ -50,6 +57,10 @@
=20
 	count =3D ((LATCH-1) - count) * TICK_SIZE;
 	delay_at_last_interrupt =3D (count + LATCH/2) / LATCH;
+
+	/* update the monotonic base value */
+	this_offset =3D ((unsigned long long)last_cyclone_high<<32)|last_cyclone_=
low;
+	monotonic_base +=3D (this_offset - last_offset) & CYCLONE_TIMER_MASK;
 }
=20
 static unsigned long get_offset_cyclone(void)
@@ -63,7 +74,7 @@
 	offset =3D cyclone_timer[0];
=20
 	/* .. relative to previous jiffy */
-	offset =3D offset - last_cyclone_timer;
+	offset =3D offset - last_cyclone_low;
=20
 	/* convert cyclone ticks to microseconds */=09
 	/* XXX slow, can we speed this up? */
@@ -73,6 +84,25 @@
 	return delay_at_last_interrupt + offset;
 }
=20
+static unsigned long long monotonic_clock_cyclone(void)
+{
+=09
+	u32 now_low, now_high;
+	unsigned long long last_offset, this_offset;
+	unsigned long long ret;
+
+	do {
+		now_high =3D cyclone_timer[1];
+		now_low =3D cyclone_timer[0];
+	} while (now_high !=3D cyclone_timer[1]);
+	last_offset =3D ((unsigned long long)last_cyclone_high<<32)|last_cyclone_=
low;
+	this_offset =3D ((unsigned long long)now_high<<32)|now_low;
+=09
+	ret =3D monotonic_base + ((this_offset - last_offset)&CYCLONE_TIMER_MASK)=
;
+	ret =3D ret * (1000000000 / CYCLONE_TIMER_FREQ);
+	return ret;
+}
+
 static int init_cyclone(void)
 {
 	u32* reg;=09
@@ -190,5 +220,6 @@
 	.init =3D init_cyclone,=20
 	.mark_offset =3D mark_offset_cyclone,=20
 	.get_offset =3D get_offset_cyclone,
+	.monotonic_clock =3D	monotonic_clock_cyclone,
 	.delay =3D delay_cyclone,
 };
diff -Nru a/arch/i386/kernel/timers/timer_none.c b/arch/i386/kernel/timers/=
timer_none.c
--- a/arch/i386/kernel/timers/timer_none.c	Fri Mar 28 14:31:18 2003
+++ b/arch/i386/kernel/timers/timer_none.c	Fri Mar 28 14:31:18 2003
@@ -15,6 +15,11 @@
 	return 0;
 }
=20
+static unsigned long long monotonic_clock_none(void)
+{
+	return 0;
+}
+
 static void delay_none(unsigned long loops)
 {
 	int d0;
@@ -33,5 +38,6 @@
 	.init =3D		init_none,=20
 	.mark_offset =3D	mark_offset_none,=20
 	.get_offset =3D	get_offset_none,
+	.monotonic_clock =3D	monotonic_clock_none,
 	.delay =3D delay_none,
 };
diff -Nru a/arch/i386/kernel/timers/timer_pit.c b/arch/i386/kernel/timers/t=
imer_pit.c
--- a/arch/i386/kernel/timers/timer_pit.c	Fri Mar 28 14:31:18 2003
+++ b/arch/i386/kernel/timers/timer_pit.c	Fri Mar 28 14:31:18 2003
@@ -27,6 +27,11 @@
 	/* nothing needed */
 }
=20
+static unsigned long long monotonic_clock_pit(void)
+{
+	return 0;
+}
+
 static void delay_pit(unsigned long loops)
 {
 	int d0;
@@ -141,5 +146,6 @@
 	.init =3D		init_pit,=20
 	.mark_offset =3D	mark_offset_pit,=20
 	.get_offset =3D	get_offset_pit,
+	.monotonic_clock =3D monotonic_clock_pit,
 	.delay =3D delay_pit,
 };
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/t=
imer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Fri Mar 28 14:31:18 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Fri Mar 28 14:31:18 2003
@@ -23,6 +23,38 @@
 static int delay_at_last_interrupt;
=20
 static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
+static unsigned long last_tsc_high; /* msb 32 bits of Time Stamp Counter *=
/
+static unsigned long long monotonic_base;
+
+
+/* convert from cycles(64bits) =3D> nanoseconds (64bits)
+ *  basic equation:
+ *		ns =3D cycles / (freq / ns_per_sec)
+ *		ns =3D cycles * (ns_per_sec / freq)
+ *		ns =3D cycles * (10^9 / (cpu_mhz * 10^6))
+ *		ns =3D cycles * (10^3 / cpu_mhz)
+ *
+ *	Then we use scaling math (suggested by george@mvista.com) to get:
+ *		ns =3D cycles * (10^3 * SC / cpu_mhz) / SC
+ *		ns =3D cycles * cyc2ns_scale / SC
+ *
+ *	And since SC is a constant power of two, we can convert the div
+ *  into a shift.  =20
+ *			-johnstul@us.ibm.com "math is hard, lets go shopping!"
+ */
+static unsigned long cyc2ns_scale;=20
+#define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
+
+static inline void set_cyc2ns_scale(unsigned long cpu_mhz)
+{
+	cyc2ns_scale =3D (1000 << CYC2NS_SCALE_FACTOR)/cpu_mhz;
+}
+
+static inline unsigned long long cycles_2_ns(unsigned long long cyc)
+{
+	return (cyc * cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;
+}
+
=20
 /* Cached *multiplier* to convert TSC counts to microseconds.
  * (see the equation below).
@@ -60,11 +92,25 @@
 	return delay_at_last_interrupt + edx;
 }
=20
+static unsigned long long monotonic_clock_tsc(void)
+{
+	unsigned long long last_offset, this_offset;
+	last_offset =3D ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
+
+	/* Read the Time Stamp Counter */
+	rdtscll(this_offset);
+
+	/* return the value in ns */
+	return  monotonic_base + cycles_2_ns(this_offset - last_offset);
+}
+
 static void mark_offset_tsc(void)
 {
 	int count;
 	int countmp;
 	static int count1=3D0, count2=3DLATCH;
+	unsigned long long this_offset, last_offset;
+	last_offset =3D ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	/*
 	 * It is important that these two operations happen almost at
 	 * the same time. We do the RDTSC stuff first, since it's
@@ -79,7 +125,7 @@
 =09
 	/* read Pentium cycle counter */
=20
-	rdtscl(last_tsc_low);
+	rdtsc(last_tsc_low, last_tsc_high);
=20
 	spin_lock(&i8253_lock);
 	outb_p(0x00, 0x43);     /* latch the count ASAP */
@@ -104,6 +150,11 @@
=20
 	count =3D ((LATCH-1) - count) * TICK_SIZE;
 	delay_at_last_interrupt =3D (count + LATCH/2) / LATCH;
+=09
+	/* update the monotonic base value */
+	this_offset =3D ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
+	monotonic_base +=3D cycles_2_ns(this_offset - last_offset);
+
 }
=20
 static void delay_tsc(unsigned long loops)
@@ -295,6 +346,7 @@
 	                	"0" (eax), "1" (edx));
 				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz =
% 1000);
 			}
+			set_cyc2ns_scale(cpu_khz/1000);
 			return 0;
 		}
 	}
@@ -328,5 +380,6 @@
 	.init =3D		init_tsc,
 	.mark_offset =3D	mark_offset_tsc,=20
 	.get_offset =3D	get_offset_tsc,
+	.monotonic_clock =3D	monotonic_clock_tsc,
 	.delay =3D delay_tsc,
 };
diff -Nru a/drivers/char/hangcheck-timer.c b/drivers/char/hangcheck-timer.c
--- a/drivers/char/hangcheck-timer.c	Fri Mar 28 14:31:18 2003
+++ b/drivers/char/hangcheck-timer.c	Fri Mar 28 14:31:18 2003
@@ -78,11 +78,13 @@
 static struct timer_list hangcheck_ticktock =3D
 		TIMER_INITIALIZER(hangcheck_fire, 0, 0);
=20
+extern unsigned long long monotonic_clock(void);
+
 static void hangcheck_fire(unsigned long data)
 {
 	unsigned long long cur_tsc, tsc_diff;
=20
-	cur_tsc =3D get_cycles();
+	cur_tsc =3D monotonic_clock();
=20
 	if (cur_tsc > hangcheck_tsc)
 		tsc_diff =3D cur_tsc - hangcheck_tsc;
@@ -98,7 +100,7 @@
 		}
 	}
 	mod_timer(&hangcheck_ticktock, jiffies + (hangcheck_tick*HZ));
-	hangcheck_tsc =3D get_cycles();
+	hangcheck_tsc =3D monotonic_clock();
 }
=20
=20
@@ -108,10 +110,10 @@
 	       VERSION_STR, hangcheck_tick, hangcheck_margin);
=20
 	hangcheck_tsc_margin =3D hangcheck_margin + hangcheck_tick;
-	hangcheck_tsc_margin *=3D HZ;
-	hangcheck_tsc_margin *=3D current_cpu_data.loops_per_jiffy;
+	hangcheck_tsc_margin *=3D 1000000000;
+
=20
-	hangcheck_tsc =3D get_cycles();
+	hangcheck_tsc =3D monotonic_clock();
 	mod_timer(&hangcheck_ticktock, jiffies + (hangcheck_tick*HZ));
=20
 	return 0;
diff -Nru a/include/asm-i386/timer.h b/include/asm-i386/timer.h
--- a/include/asm-i386/timer.h	Fri Mar 28 14:31:18 2003
+++ b/include/asm-i386/timer.h	Fri Mar 28 14:31:18 2003
@@ -14,6 +14,7 @@
 	int (*init)(void);
 	void (*mark_offset)(void);
 	unsigned long (*get_offset)(void);
+	unsigned long long (*monotonic_clock)(void);
 	void (*delay)(unsigned long);
 };
=20

--=-zW4Yv4UhRE3EYvpOHGIe--

--=-jdw/PJMMTAb/k40Dv42U
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA+hNLNMDAZ/OmgHwwRAluSAJ4j/QWpUAVWbwl0bCCjifJAzBwamgCbBcc+
kqB6sHt/1L0ewl1N1TeWCs0=
=IS5r
-----END PGP SIGNATURE-----

--=-jdw/PJMMTAb/k40Dv42U--

