Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261578AbTCKTel>; Tue, 11 Mar 2003 14:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261584AbTCKTel>; Tue, 11 Mar 2003 14:34:41 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:29691 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261578AbTCKTdi>;
	Tue, 11 Mar 2003 14:33:38 -0500
Subject: Re: [RFC][PATCH] linux-2.5.64_monotonic-clock_A1
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Joel.Becker@oracle.com, "Martin J. Bligh" <mbligh@aracnet.com>,
       wim.coekaerts@oracle.com
In-Reply-To: <1047411561.16614.684.camel@w-jstultz2.beaverton.ibm.com>
References: <1047411561.16614.684.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/cIAA/WftViIGFY0L4s9"
Organization: 
Message-Id: <1047411650.16613.687.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Mar 2003 11:40:50 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/cIAA/WftViIGFY0L4s9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

<sigh> Patch below.

thanks
-john


diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Tue Mar 11 11:24:04 2003
+++ b/arch/i386/kernel/time.c	Tue Mar 11 11:24:04 2003
@@ -138,6 +138,19 @@
 	clock_was_set();
 }
=20
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
--- a/arch/i386/kernel/timers/timer_cyclone.c	Tue Mar 11 11:24:04 2003
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Tue Mar 11 11:24:04 2003
@@ -27,19 +27,24 @@
 #define CYCLONE_MPMC_OFFSET 0x51D0
 #define CYCLONE_MPCS_OFFSET 0x51A8
 #define CYCLONE_TIMER_FREQ 100000000
-
+#define CYCLONE_TIMER_MASK (((u64)1<<40)-1) /*40 bit mask*/
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
+	last_cyclone_high =3D cyclone_timer[1];
+	last_cyclone_low =3D cyclone_timer[0];
=20
 	/* calculate delay_at_last_interrupt */
 	outb_p(0x00, 0x43);     /* latch the count ASAP */
@@ -50,6 +55,10 @@
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
@@ -63,7 +72,7 @@
 	offset =3D cyclone_timer[0];
=20
 	/* .. relative to previous jiffy */
-	offset =3D offset - last_cyclone_timer;
+	offset =3D offset - last_cyclone_low;
=20
 	/* convert cyclone ticks to microseconds */=09
 	/* XXX slow, can we speed this up? */
@@ -73,6 +82,21 @@
 	return delay_at_last_interrupt + offset;
 }
=20
+static unsigned long long monotonic_clock_cyclone(void)
+{
+=09
+	u32 now_low =3D cyclone_timer[0];
+	u32 now_high =3D cyclone_timer[1];
+	unsigned long long last_offset, this_offset;
+	unsigned long long ret;
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
@@ -190,5 +214,6 @@
 	.init =3D init_cyclone,=20
 	.mark_offset =3D mark_offset_cyclone,=20
 	.get_offset =3D get_offset_cyclone,
+	.monotonic_clock =3D	monotonic_clock_cyclone,
 	.delay =3D delay_cyclone,
 };
diff -Nru a/arch/i386/kernel/timers/timer_none.c b/arch/i386/kernel/timers/=
timer_none.c
--- a/arch/i386/kernel/timers/timer_none.c	Tue Mar 11 11:24:04 2003
+++ b/arch/i386/kernel/timers/timer_none.c	Tue Mar 11 11:24:04 2003
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
--- a/arch/i386/kernel/timers/timer_pit.c	Tue Mar 11 11:24:04 2003
+++ b/arch/i386/kernel/timers/timer_pit.c	Tue Mar 11 11:24:04 2003
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
--- a/arch/i386/kernel/timers/timer_tsc.c	Tue Mar 11 11:24:04 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Tue Mar 11 11:24:04 2003
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
+#define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen*/
+
+static inline set_cyc2ns_scale(unsigned long cpu_mhz)
+{
+	cyc2ns_scale =3D (1000 * (1<<CYC2NS_SCALE_FACTOR))/cpu_mhz;
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
@@ -293,6 +344,7 @@
 	                	"0" (eax), "1" (edx));
 				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz =
% 1000);
 			}
+			set_cyc2ns_scale(cpu_khz/1000);
 			return 0;
 		}
 	}
@@ -326,5 +378,6 @@
 	.init =3D		init_tsc,
 	.mark_offset =3D	mark_offset_tsc,=20
 	.get_offset =3D	get_offset_tsc,
+	.monotonic_clock =3D	monotonic_clock_tsc,
 	.delay =3D delay_tsc,
 };
diff -Nru a/drivers/char/hangcheck-timer.c b/drivers/char/hangcheck-timer.c
--- a/drivers/char/hangcheck-timer.c	Tue Mar 11 11:24:04 2003
+++ b/drivers/char/hangcheck-timer.c	Tue Mar 11 11:24:04 2003
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
--- a/include/asm-i386/timer.h	Tue Mar 11 11:24:04 2003
+++ b/include/asm-i386/timer.h	Tue Mar 11 11:24:04 2003
@@ -14,6 +14,7 @@
 	int (*init)(void);
 	void (*mark_offset)(void);
 	unsigned long (*get_offset)(void);
+	unsigned long long (*monotonic_clock)(void);
 	void (*delay)(unsigned long);
 };
=20





--=-/cIAA/WftViIGFY0L4s9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA+bjvCMDAZ/OmgHwwRAhBGAJ9IGEaLoiSpMsIj1UNk/+0fT5S+LwCcDmL+
pxIsKgLqUj/sMYjVVRBQRxk=
=uKmQ
-----END PGP SIGNATURE-----

--=-/cIAA/WftViIGFY0L4s9--

