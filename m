Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293602AbSCKDe6>; Sun, 10 Mar 2002 22:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293598AbSCKDem>; Sun, 10 Mar 2002 22:34:42 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:15685 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S293595AbSCKDe3>; Sun, 10 Mar 2002 22:34:29 -0500
Date: Mon, 11 Mar 2002 04:34:21 +0100
From: Kurt Garloff <garloff@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Cc: "S. Chandra Sekharan" <sekharan@us.ibm.com>
Subject: [PATCH] Support for assymmetric SMP
Message-ID: <20020311043421.D2346@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	"S. Chandra Sekharan" <sekharan@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vKFfOv5t3oGVpiF+"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vKFfOv5t3oGVpiF+
Content-Type: multipart/mixed; boundary="LSp5EJdfMPwZcMS1"
Content-Disposition: inline


--LSp5EJdfMPwZcMS1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

some time ago (2.4.2 time), I created a patch that allows using a
multiprocessor system with different speed ix86 CPUs and Linux.

The patch does the following:
* Make sure we got the flags right (in case they are different) before we
  enable XMM/FXSR/.... Right means common subset of supported features.
* Make cpu_khz a per CPU field and use it in the fast_get_timeofday(). The
  offset from last timer tick also must be per CPU.

The patch works fine, but it has a limited scope: It does not try to teach
the scheduler about the fact that the CPUs are different. So a process that
runs on the slower CPU does not get any bonus. It's just unlucky ...
(Some dynamic prio weighting with the cpu_khz should not be too hard in the
 goodness calc, but I wanted to keep things simple.)

I attach the patch against 2.4.16.

Chandra, this is what you've been looking for, right?

Enjoy!
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--LSp5EJdfMPwZcMS1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4.16-AMP-support.diff"
Content-Transfer-Encoding: quoted-printable

--- ./arch/i386/kernel/nmi.c.orig	Fri Jan 18 22:39:20 2002
+++ ./arch/i386/kernel/nmi.c	Sat Mar  9 15:10:30 2002
@@ -161,6 +161,8 @@
 {
 	int i;
 	unsigned int evntsel;
+	int cpu =3D smp_processor_id();
+	struct cpuinfo_x86 *c =3D &cpu_data[cpu];
=20
 	nmi_perfctr_msr =3D MSR_K7_PERFCTR0;
=20
@@ -175,8 +177,8 @@
 		| K7_NMI_EVENT;
=20
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
-	Dprintk("setting K7_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
-	wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/nmi_hz*1000), -1);
+	Dprintk("setting K7_PERFCTR0 to %08lx\n", -(c->cpu_khz/nmi_hz*1000));
+	wrmsr(MSR_K7_PERFCTR0, -(c->cpu_khz/nmi_hz*1000), -1);
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |=3D K7_EVNTSEL_ENABLE;
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
@@ -186,6 +188,8 @@
 {
 	int i;
 	unsigned int evntsel;
+	int cpu =3D smp_processor_id();
+	struct cpuinfo_x86 *c =3D &cpu_data[cpu];
=20
 	nmi_perfctr_msr =3D MSR_IA32_PERFCTR0;
=20
@@ -200,8 +204,8 @@
 		| P6_NMI_EVENT;
=20
 	wrmsr(MSR_IA32_EVNTSEL0, evntsel, 0);
-	Dprintk("setting IA32_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
-	wrmsr(MSR_IA32_PERFCTR0, -(cpu_khz/nmi_hz*1000), 0);
+	Dprintk("setting IA32_PERFCTR0 to %08lx\n", -(c->cpu_khz/nmi_hz*1000));
+	wrmsr(MSR_IA32_PERFCTR0, -(c->cpu_khz/nmi_hz*1000), 0);
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |=3D P6_EVNTSEL0_ENABLE;
 	wrmsr(MSR_IA32_EVNTSEL0, evntsel, 0);
@@ -267,6 +271,7 @@
 	 * the stack NMI-atomically, it's safe to use smp_processor_id().
 	 */
 	int sum, cpu =3D smp_processor_id();
+	struct cpuinfo_x86 *c =3D &cpu_data[cpu];
=20
 	sum =3D apic_timer_irqs[cpu];
=20
@@ -296,5 +301,5 @@
 		alert_counter[cpu] =3D 0;
 	}
 	if (nmi_perfctr_msr)
-		wrmsr(nmi_perfctr_msr, -(cpu_khz/nmi_hz*1000), -1);
+		wrmsr(nmi_perfctr_msr, -(c->cpu_khz/nmi_hz*1000), -1);
 }
--- ./arch/i386/kernel/i387.c.orig	Fri Feb 23 19:09:08 2001
+++ ./arch/i386/kernel/i387.c	Sat Mar  9 14:26:15 2002
@@ -28,7 +28,7 @@
  * The _current_ task is using the FPU for the first time
  * so initialize it and set the mxcsr to its default
  * value at reset if we support XMM instructions and then
- * remeber the current task has used the FPU.
+ * remember the current task has used the FPU.
  */
 void init_fpu(void)
 {
--- ./arch/i386/kernel/mpparse.c.orig	Fri Nov  9 23:58:18 2001
+++ ./arch/i386/kernel/mpparse.c	Sat Mar  9 14:30:33 2002
@@ -135,6 +135,8 @@
 static int mpc_record;=20
 static struct mpc_config_translation *translation_table[MAX_MPC_ENTRY] __i=
nitdata;
=20
+unsigned long mp_max_features =3D 0xffffffff;
+
 void __init MP_processor_info (struct mpc_config_processor *m)
 {
  	int ver, quad, logical_apicid;
@@ -215,6 +217,9 @@
 	}
=20
 	num_processors++;
+
+	/* Clear features that are not present on all CPUs */
+	mp_max_features &=3D m->mpc_featureflag;
=20
 	if (m->mpc_apicid > MAX_APICS) {
 		printk("Processor #%d INVALID. (Max ID: %d).\n",
--- ./arch/i386/kernel/setup.c.orig	Sat Dec 22 14:08:42 2001
+++ ./arch/i386/kernel/setup.c	Sat Mar  9 15:03:10 2002
@@ -121,6 +121,9 @@
 struct cpuinfo_x86 boot_cpu_data =3D { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
=20
 unsigned long mmu_cr4_features;
+#ifdef CONFIG_SMP
+extern unsigned long mp_max_features;
+#endif
=20
 /*
  * Bus types ..
@@ -160,6 +163,7 @@
=20
 static int disable_x86_serial_nr __initdata =3D 1;
 static int disable_x86_fxsr __initdata =3D 0;
+static int disable_x86_xmm __initdata =3D 0;
=20
 extern int blk_nohighio;
=20
@@ -2372,6 +2376,11 @@
 }
 __setup("nofxsr", x86_fxsr_setup);
=20
+int __init x86_xmm_setup(char* s)
+{	disable_x86_xmm =3D 1;
+	return 1;
+}
+__setup("noxmm", x86_xmm_setup);
=20
 /* Standard macro to see if a specific flag is changeable */
 static inline int flag_is_changeable_p(u32 flag)
@@ -2479,6 +2488,8 @@
 	return have_cpuid_p();	/* Check to see if CPUID now enabled? */
 }
=20
+
+extern void time_init_cpu(struct cpuinfo_x86 *);
 /*
  * This does the hard work of actually picking apart the CPU stuff...
  */
@@ -2626,6 +2637,10 @@
 		clear_bit(X86_FEATURE_XMM, &c->x86_capability);
 	}
=20
+	/* XMM/SSE disabled? */
+	if (disable_x86_xmm)
+		clear_bit(X86_FEATURE_XMM, &c->x86_capability);
+=09
 	/* Disable the PN if appropriate */
 	squash_the_stupid_serial_number(c);
=20
@@ -2659,7 +2674,12 @@
 		/* AND the already accumulated flags with these */
 		for ( i =3D 0 ; i < NCAPINTS ; i++ )
 			boot_cpu_data.x86_capability[i] &=3D c->x86_capability[i];
+		time_init_cpu (c);
 	}
+#if 0 //def CONFIG_SMP
+	else
+		c->x86_capability[0] &=3D mp_max_features;
+#endif
=20
 	printk(KERN_DEBUG "CPU:             Common caps: %08x %08x %08x %08x\n",
 	       boot_cpu_data.x86_capability[0],
@@ -2772,7 +2792,7 @@
=20
 	if ( test_bit(X86_FEATURE_TSC, &c->x86_capability) ) {
 		seq_printf(m, "cpu MHz\t\t: %lu.%03lu\n",
-			cpu_khz / 1000, (cpu_khz % 1000));
+			c->cpu_khz / 1000, (c->cpu_khz % 1000));
 	}
=20
 	/* Cache size */
--- ./arch/i386/kernel/smpboot.c.orig	Fri Jan 18 22:39:20 2002
+++ ./arch/i386/kernel/smpboot.c	Sat Mar  9 14:41:03 2002
@@ -30,6 +30,7 @@
  *		Tigran Aivazian	:	fixed "0.00 in /proc/uptime on SMP" bug.
  *	Maciej W. Rozycki	:	Bits for genuine 82489DX APICs
  *		Martin J. Bligh	: 	Added support for multi-quad systems
+ *		Kurt Garloff	:	Support for SMP with non-identical CPUs
  */
=20
 #include <linux/config.h>
@@ -46,6 +47,7 @@
 #include <asm/mtrr.h>
 #include <asm/pgalloc.h>
 #include <asm/smpboot.h>
+#include <asm/bugs.h>
=20
 /* Set if we find a B stepping CPU			*/
 static int smp_b_stepping;
@@ -195,7 +197,7 @@
=20
 #define NR_LOOPS 5
=20
-extern unsigned long fast_gettimeoffset_quotient;
+//extern unsigned long fast_gettimeoffset_quotient;
=20
 /*
  * accurate 64-bit/32-bit division, expanded to 32-bit divisions and 64-bit
@@ -236,7 +238,7 @@
=20
 	printk("checking TSC synchronization across CPUs: ");
=20
-	one_usec =3D ((1<<30)/fast_gettimeoffset_quotient)*(1<<2);
+	one_usec =3D ((1<<30)/current_cpu_data.fast_gettimeoffset_quotient)*(1<<2=
);
=20
 	atomic_set(&tsc_start_flag, 1);
 	wmb();
@@ -339,6 +341,38 @@
 }
 #undef NR_LOOPS
=20
+/* Note: cpu_boot_data caps on SMP machines is filled in as follows:
+ * (1) Initialized with the boot CPU's caps (head.S)
+ * (2) AND with the common caps from the MP table (identify_cpu())
+ * (3) AND with the caps from the started CPUs (identify_cpu())
+ * (4) Finally calculated and overwritten here (smp_make_common_caps())
+ * Step 2 is actually disabled, as the info is not very reliable.
+ * Step 4 should not be needed then, actually.
+ * KG <garloff@suse.de>, 2001-03-21
+ */
+
+/* Store common subset of capabilities in boot_cpu_data */
+void smp_make_common_caps(void)
+{
+	int cpu, c;
+	unsigned long x86cap[NCAPINTS];
+	for (c =3D 0; c < NCAPINTS; c++)
+		x86cap[c] =3D 0xffffffff;
+	for (cpu =3D 0; cpu < NR_CPUS; cpu++) {
+		if (!(cpu_online_map & (1<<cpu)))
+			continue;
+		for (c =3D 0; c < NCAPINTS; c++)
+			x86cap[c] &=3D cpu_data[cpu].x86_capability[c];
+	}
+	for (c =3D 0; c < NCAPINTS; c++)
+		boot_cpu_data.x86_capability[c] =3D x86cap[c];
+	printk("CPU: Common caps: %08x %08x %08x %08x\n",
+	       boot_cpu_data.x86_capability[0],
+	       boot_cpu_data.x86_capability[1],
+	       boot_cpu_data.x86_capability[2],
+	       boot_cpu_data.x86_capability[3]);
+}
+
 extern void calibrate_delay(void);
=20
 static atomic_t init_deasserted;
@@ -925,6 +959,7 @@
 {
 	unsigned long cachesize;       /* kB   */
 	unsigned long bandwidth =3D 350; /* MB/s */
+	unsigned long cpu_khz	=3D boot_cpu_data.cpu_khz;
 	/*
 	 * Rough estimation for SMP scheduling, this is the number of
 	 * cycles it takes for a fully memory-limited process to flush
@@ -981,6 +1016,12 @@
                         (u_long) xquad_portio, (u_long) XQUAD_PORTIO_LEN);
         }
=20
+	/* Pieces from check_bugs() ... */
+	identify_cpu(&boot_cpu_data);
+	printk("Boot CPU: ");
+	print_cpu_info(&boot_cpu_data);
+	check_config();
+=09
 #ifdef CONFIG_MTRR
 	/*  Must be done before other processors booted  */
 	mtrr_init_boot_cpu ();
@@ -1181,5 +1222,6 @@
 		synchronize_tsc_bp();
=20
 smp_done:
+	smp_make_common_caps ();
 	zap_low_mappings();
 }
--- ./arch/i386/kernel/time.c.orig	Sun Nov 11 19:20:21 2001
+++ ./arch/i386/kernel/time.c	Sat Mar  9 14:26:15 2002
@@ -64,19 +64,19 @@
 #include <linux/irq.h>
=20
=20
-unsigned long cpu_khz;	/* Detected as we calibrate the TSC */
+//unsigned long cpu_khz;	/* Detected as we calibrate the TSC */
=20
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
=20
-static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
+//static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter =
*/
=20
 /* Cached *multiplier* to convert TSC counts to microseconds.
  * (see the equation below).
  * Equal to 2^32 * (1 / (clocks per usec) ).
  * Initialized in time_init.
  */
-unsigned long fast_gettimeoffset_quotient;
+//unsigned long fast_gettimeoffset_quotient;
=20
 extern rwlock_t xtime_lock;
 extern unsigned long wall_jiffies;
@@ -92,7 +92,7 @@
 	rdtsc(eax,edx);
=20
 	/* .. relative to previous jiffy (32 bits is enough) */
-	eax -=3D last_tsc_low;	/* tsc_low delta */
+	eax -=3D current_cpu_data.last_tsc_low;	/* tsc_low delta */
=20
 	/*
          * Time offset =3D (tsc_low delta) * fast_gettimeoffset_quotient
@@ -105,7 +105,7 @@
=20
 	__asm__("mull %2"
 		:"=3Da" (eax), "=3Dd" (edx)
-		:"rm" (fast_gettimeoffset_quotient),
+		:"rm" (current_cpu_data.fast_gettimeoffset_quotient),
 		 "0" (eax));
=20
 	/* our adjusted time offset in microseconds */
@@ -275,8 +275,8 @@
 		if (lost)
 			usec +=3D lost * (1000000 / HZ);
 	}
-	sec =3D xtime.tv_sec;
-	usec +=3D xtime.tv_usec;
+	sec =3D current_cpu_data.xtime.tv_sec;
+	usec +=3D current_cpu_data.xtime.tv_usec;
 	read_unlock_irqrestore(&xtime_lock, flags);
=20
 	while (usec >=3D 1000000) {
@@ -440,6 +440,7 @@
 		else
 			last_rtc_update =3D xtime.tv_sec - 600; /* do it again in 60 s */
 	}
+	current_cpu_data.xtime =3D xtime;
 	   =20
 #ifdef CONFIG_MCA
 	if( MCA_bus ) {
@@ -494,7 +495,7 @@
 =09
 		/* read Pentium cycle counter */
=20
-		rdtscl(last_tsc_low);
+		rdtscl(current_cpu_data.last_tsc_low);
=20
 		spin_lock(&i8253_lock);
 		outb_p(0x00, 0x43);     /* latch the count ASAP */
@@ -597,7 +598,7 @@
 		} while ((inb(0x61) & 0x20) =3D=3D 0);
 		rdtsc(endlow,endhigh);
=20
-		last_tsc_low =3D endlow;
+		current_cpu_data.last_tsc_low =3D endlow;
=20
 		/* Error: ECTCNEVERSET */
 		if (count <=3D 1)
@@ -634,7 +635,8 @@
 	return 0;
 }
=20
-void __init time_init(void)
+
+void __init time_init_cpu(struct cpuinfo_x86 *c)
 {
 	extern int x86_udelay_tsc;
 =09
@@ -671,7 +673,8 @@
 	if (cpu_has_tsc) {
 		unsigned long tsc_quotient =3D calibrate_tsc();
 		if (tsc_quotient) {
-			fast_gettimeoffset_quotient =3D tsc_quotient;
+			unsigned long cpu_khz;
+			c->fast_gettimeoffset_quotient =3D tsc_quotient;
 			use_tsc =3D 1;
 			/*
 			 *	We could be more selective here I suspect
@@ -694,6 +697,7 @@
 	                	"0" (eax), "1" (edx));
 				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz =
% 1000);
 			}
+			c->cpu_khz =3D cpu_khz;
 		}
 	}
=20
@@ -714,4 +718,11 @@
 #else
 	setup_irq(0, &irq0);
 #endif
+}
+
+extern struct cpuinfo_x86 boot_cpu_data;
+
+void inline __init time_init (void)
+{
+	time_init_cpu (&boot_cpu_data);
 }
--- ./init/main.c.orig	Fri Jan 18 22:39:20 2002
+++ ./init/main.c	Sat Mar  9 14:42:03 2002
@@ -608,7 +608,6 @@
 #if defined(CONFIG_SYSVIPC)
 	ipc_init();
 #endif
-	check_bugs();
=20
 	/*
 	 *      We count on the initial thread going ok
@@ -616,6 +615,7 @@
 	 *      make syscalls (and thus be locked).
 	 */
 	smp_init();
+	check_bugs();
=20
 	/*
 	 * Finally, we wait for all other CPU's, and initialize this
--- ./include/asm-i386/bugs.h.orig	Mon Mar  4 00:43:34 2002
+++ ./include/asm-i386/bugs.h	Sat Mar  9 14:47:09 2002
@@ -21,6 +21,7 @@
  */
=20
 #include <linux/config.h>
+#include <linux/utsname.h>
 #include <asm/processor.h>
 #include <asm/i387.h>
 #include <asm/msr.h>
@@ -204,12 +205,16 @@
=20
 static void __init check_bugs(void)
 {
-	identify_cpu(&boot_cpu_data);
+	/* identify_cpu(&boot_cpu_data)  and
+	 * check_config()
+	 * are called in smp_boot_cpus() on SMP kernels
+	 */
 #ifndef CONFIG_SMP
+	identify_cpu(&boot_cpu_data);
 	printk("CPU: ");
 	print_cpu_info(&boot_cpu_data);
-#endif
 	check_config();
+#endif
 	check_fpu();
 	check_hlt();
 	check_popad();
--- ./include/asm-i386/processor.h.orig	Mon Mar  4 00:43:33 2002
+++ ./include/asm-i386/processor.h	Sat Mar  9 14:28:55 2002
@@ -17,6 +17,7 @@
 #include <linux/cache.h>
 #include <linux/config.h>
 #include <linux/threads.h>
+#include <linux/time.h>
=20
 /*
  * Default implementation of macro that returns current
@@ -53,6 +54,10 @@
 	unsigned long *pmd_quick;
 	unsigned long *pte_quick;
 	unsigned long pgtable_cache_sz;
+	unsigned long cpu_khz;
+	unsigned long fast_gettimeoffset_quotient;
+	unsigned long last_tsc_low;
+	struct timeval xtime;
 } __attribute__((__aligned__(SMP_CACHE_BYTES)));
=20
 #define X86_VENDOR_INTEL 0
--- ./include/asm-i386/timex.h.orig	Fri Jan 18 23:05:37 2002
+++ ./include/asm-i386/timex.h	Sat Mar  9 14:42:47 2002
@@ -45,6 +45,6 @@
 #endif
 }
=20
-extern unsigned long cpu_khz;
+//extern unsigned long cpu_khz;
=20
 #endif

--LSp5EJdfMPwZcMS1--

--vKFfOv5t3oGVpiF+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8jCW8xmLh6hyYd04RAkXaAKDC5QffE85HgffxJMfsn0jlbe5f0ACgi3hL
e7XYZKwtCPpTQPRxJerRmh0=
=3441
-----END PGP SIGNATURE-----

--vKFfOv5t3oGVpiF+--
