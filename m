Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131584AbRCUP6w>; Wed, 21 Mar 2001 10:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131594AbRCUP6e>; Wed, 21 Mar 2001 10:58:34 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:54085 "EHLO
	amsmta05-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S131584AbRCUP60>; Wed, 21 Mar 2001 10:58:26 -0500
Date: Wed, 21 Mar 2001 16:55:41 +0100
From: Kurt Garloff <garloff@suse.de>
To: Ingo Molnar <mingo@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: SMP on assym. x86
Message-ID: <20010321165541.H3514@garloff.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="WHz+neNWvhIGAO8A"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WHz+neNWvhIGAO8A
Content-Type: multipart/mixed; boundary="MP5ln1Rcf9Bvi+ZW"
Content-Disposition: inline


--MP5ln1Rcf9Bvi+ZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

recently upgrading one of my two CPUs, I found kernel-2.4.2 to be unable to
handle the situation with 2 different CPUs (AMP =3D Assymmetric
multiprocessing ;-) correctly.
Some details on my system:
Dual BX board (DFI P2XBL/D), iPII 350 (Deschutes) + iPIII 850 (Coppermine)
Note: The difference in features is the XMM (SSE) flag.

The problems are twofold
(a) Determination of the correct common features (=3D: COMCAP), i.e.
    boot_cpu_data.x86_capaility[0] at the correct time
(b) TSC stuff

Ad (a):
There is code in identify_cpu() to make sure the common subset of features
is stored in the COMCAP, however this does not work at all, as the freshly
booted CPUs just overwrite it in head.S.

Fixed this, so the system basically worked, if the iPII was the boot CPU.

With iPIII as boot CPU, it rebooted after (captured via serial console):
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.

The problem is that the C/FPU gets initialized to use XMM instructions,
before the other CPUs are even started and checked for capabilities.
Booting with nofxsr (or noxmm which I added) helps.
However, the kernel should be able to find out himself.

To find out about the COMCAP earlier, one has two choices
* boot the secondary CPUs earlier (before initialiying usage of FXSR/XMM)
* try to find out without booting the 2ndary CPUs
The only way I found to do the latter is to use the results of the MPtable
parsing. However, this information may not be reliable. I did implement
this, but on my system, a lot of features were not reported at all ...

So I chose to do smp_init() earlier. It's a good idea to have this info
available before we get to do RAID5 init anyway.
I chose to move smp_init()/smp_boot_cpus() [which now calls identify_cpu()
and check_config() for the boot_cpu and later identify_cpu() on the seconda=
ry
CPUs and sets COMCAP correctly], then check_bugs() [which does not do the
identify_cpu() on SMP anymore) before bdev_init().

Problem solved. It does certainly solve XMM/SSE and FXSR issues. PSE36
differences, e.g., may still cause problems on 64GB kernels ...

Ad (b):
The fast_gettimeoffset() does return nonsense, if it runs on the wrong CPU.
There are two reasons: On the one hand, the TSC speed is only calculated for
one CPU, which does not fit the other. On the other hand, xtime gets updated
and the low TSC bits are saved. If gettimeofday() is run on the other CPU,
you compare the TSC of this CPU with the saved one from the other, which
will return nonsense. I've even seen negative numbers.
This behaviour screws up timing information. xntp did not work any more and
the glx module crashed the AGP/PCI bus for my MGA G400.
notsc could work around this of course.

I decided to fix this problem as well.
Therefore, cpu_khz, fast_gettimeoffset_quotient, last_tsc_low have been
moved to, and xtime duplicated in the cpuinfo_x86 struct.
identify_cpu() now calls time_init_cpu() for the secondary CPUs, which
initializes cpu_khz and the quotient.
The timer irq now stores the last_tsc_low in the CPU specific struct.
It also copies the xtime to the current CPU's struct.
gettimeofday() just uses this CPU specific info.

It works.

Find here some evidence:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 6
cpu MHz		: 851.946
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 mmx fxsr sse
bogomips	: 1701.88

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 2
cpu MHz		: 350.800
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 mmx fxsr
bogomips	: 701.54

ntpq> pe
     remote           refid      st t when poll reach   delay   offset  jit=
ter
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
 LOCAL(0)        LOCAL(0)        10 l   15   64  377    0.000    0.000   0.=
000
*casa.casa-etp.n ntp2.ptb.de      2 u   15   64  377    0.365    1.453   5.=
000

boot_cpu_data (COMCAP) contains:
Intel Pentium III (Coppermine) caps: 0183fbff fpu vme de pse tsc msr pae mce
 cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr stepping 02

Patch against 2.4.2 is attached.

Feedback is welcome. I think the patch is safe, but I could imagine that the
earlier SMP initialization might cause problems for some people or other ar=
chs.
I would like this patch to go into the mainstream kernel, if no problem can
be found.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations  <K.Garloff@Phys.TUE.NL>  [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>   [SuSE Nuernberg, FRG]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--MP5ln1Rcf9Bvi+ZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux242.amp-support.diff"
Content-Transfer-Encoding: quoted-printable

diff -uNr linux-2.4.2.sym/arch/i386/kernel/head.S linux-2.4.2.amp/arch/i386=
/kernel/head.S
--- linux-2.4.2.sym/arch/i386/kernel/head.S	Sat Feb 17 00:53:08 2001
+++ linux-2.4.2.amp/arch/i386/kernel/head.S	Wed Mar 21 03:22:49 2001
@@ -229,6 +229,12 @@
 	movb %al,X86_MODEL
 	andb $0x0f,%cl		# mask mask revision
 	movb %cl,X86_MASK
+	/* prevent overwriting of corrected cpu_boot_data.x86_capabilty[0] */
+#ifdef CONFIG_SMP=20
+	movb ready,%cl
+	cmpb $0,%cl
+	jne is486
+#endif
 	movl %edx,X86_CAPABILITY
=20
 is486:
diff -uNr linux-2.4.2.sym/arch/i386/kernel/i387.c linux-2.4.2.amp/arch/i386=
/kernel/i387.c
--- linux-2.4.2.sym/arch/i386/kernel/i387.c	Sat Feb  3 21:09:34 2001
+++ linux-2.4.2.amp/arch/i386/kernel/i387.c	Wed Mar 21 02:54:27 2001
@@ -28,7 +28,7 @@
  * The _current_ task is using the FPU for the first time
  * so initialize it and set the mxcsr to its default
  * value at reset if we support XMM instructions and then
- * remeber the current task has used the FPU.
+ * remember the current task has used the FPU.
  */
 void init_fpu(void)
 {
diff -uNr linux-2.4.2.sym/arch/i386/kernel/mpparse.c linux-2.4.2.amp/arch/i=
386/kernel/mpparse.c
--- linux-2.4.2.sym/arch/i386/kernel/mpparse.c	Wed Nov 15 06:25:34 2000
+++ linux-2.4.2.amp/arch/i386/kernel/mpparse.c	Wed Mar 21 14:51:17 2001
@@ -106,6 +106,8 @@
 	return n;
 }
=20
+unsigned long mp_max_features =3D 0xffffffff;
+
 static void __init MP_processor_info (struct mpc_config_processor *m)
 {
 	int ver;
@@ -171,6 +173,9 @@
 		boot_cpu_id =3D m->mpc_apicid;
 	}
 	num_processors++;
+
+	/* Clear features that are not present on all CPUs */
+	mp_max_features &=3D m->mpc_featureflag;
=20
 	if (m->mpc_apicid > MAX_APICS) {
 		printk("Processor #%d INVALID. (Max ID: %d).\n",
diff -uNr linux-2.4.2.sym/arch/i386/kernel/setup.c linux-2.4.2.amp/arch/i38=
6/kernel/setup.c
--- linux-2.4.2.sym/arch/i386/kernel/setup.c	Sat Feb 17 01:02:37 2001
+++ linux-2.4.2.amp/arch/i386/kernel/setup.c	Wed Mar 21 14:52:58 2001
@@ -106,6 +106,9 @@
 struct cpuinfo_x86 boot_cpu_data =3D { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
=20
 unsigned long mmu_cr4_features;
+#ifdef CONFIG_SMP
+extern unsigned long mp_max_features;
+#endif
=20
 /*
  * Bus types ..
@@ -144,10 +147,11 @@
=20
 extern int root_mountflags;
 extern char _text, _etext, _edata, _end;
-extern unsigned long cpu_khz;
+//extern unsigned long cpu_khz;
=20
 static int disable_x86_serial_nr __initdata =3D 1;
 static int disable_x86_fxsr __initdata =3D 0;
+static int disable_x86_xmm __initdata =3D 0;
=20
 /*
  * This is set up by the setup-routine at boot-time
@@ -1805,6 +1809,11 @@
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
@@ -1912,6 +1921,8 @@
 	return have_cpuid_p();	/* Check to see if CPUID now enabled? */
 }
=20
+
+extern void time_init_cpu(struct cpuinfo_x86 *);
 /*
  * This does the hard work of actually picking apart the CPU stuff...
  */
@@ -2046,6 +2057,10 @@
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
@@ -2079,7 +2094,12 @@
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
 	printk("CPU: Common caps: %08x %08x %08x %08x\n",
 	       boot_cpu_data.x86_capability[0],
@@ -2196,7 +2216,7 @@
=20
 		if ( test_bit(X86_FEATURE_TSC, &c->x86_capability) ) {
 			p +=3D sprintf(p, "cpu MHz\t\t: %lu.%03lu\n",
-				cpu_khz / 1000, (cpu_khz % 1000));
+				c->cpu_khz / 1000, (c->cpu_khz % 1000));
 		}
=20
 		/* Cache size */
diff -uNr linux-2.4.2.sym/arch/i386/kernel/smpboot.c linux-2.4.2.amp/arch/i=
386/kernel/smpboot.c
--- linux-2.4.2.sym/arch/i386/kernel/smpboot.c	Tue Feb 13 23:13:43 2001
+++ linux-2.4.2.amp/arch/i386/kernel/smpboot.c	Wed Mar 21 15:04:03 2001
@@ -29,6 +29,7 @@
  *		Ingo Molnar	:	various cleanups and rewrites
  *		Tigran Aivazian	:	fixed "0.00 in /proc/uptime on SMP" bug.
  *	Maciej W. Rozycki	:	Bits for genuine 82489DX APICs
+ *		Kurt Garloff	:	Support for SMP with non-identical CPUs
  */
=20
 #include <linux/config.h>
@@ -44,6 +45,7 @@
 #include <linux/mc146818rtc.h>
 #include <asm/mtrr.h>
 #include <asm/pgalloc.h>
+#include <asm/bugs.h>
=20
 /* Set if we find a B stepping CPU			*/
 static int smp_b_stepping;
@@ -198,7 +200,7 @@
=20
 #define NR_LOOPS 5
=20
-extern unsigned long fast_gettimeoffset_quotient;
+//extern unsigned long fast_gettimeoffset_quotient;
=20
 /*
  * accurate 64-bit/32-bit division, expanded to 32-bit divisions and 64-bit
@@ -239,7 +241,7 @@
=20
 	printk("checking TSC synchronization across CPUs: ");
=20
-	one_usec =3D ((1<<30)/fast_gettimeoffset_quotient)*(1<<2);
+	one_usec =3D ((1<<30)/current_cpu_data.fast_gettimeoffset_quotient)*(1<<2=
);
=20
 	atomic_set(&tsc_start_flag, 1);
 	wmb();
@@ -342,6 +344,38 @@
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
@@ -780,12 +814,13 @@
 }
=20
 cycles_t cacheflush_time;
-extern unsigned long cpu_khz;
+//extern unsigned long cpu_khz;
=20
 static void smp_tune_scheduling (void)
 {
 	unsigned long cachesize;       /* kB   */
 	unsigned long bandwidth =3D 350; /* MB/s */
+	unsigned long cpu_khz =3D boot_cpu_data.cpu_khz;
 	/*
 	 * Rough estimation for SMP scheduling, this is the number of
 	 * cycles it takes for a fully memory-limited process to flush
@@ -831,6 +866,12 @@
 {
 	int apicid, cpu;
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
@@ -1019,6 +1060,7 @@
 		synchronize_tsc_bp();
=20
 smp_done:
+	smp_make_common_caps ();
 	zap_low_mappings();
 }
=20
diff -uNr linux-2.4.2.sym/arch/i386/kernel/time.c linux-2.4.2.amp/arch/i386=
/kernel/time.c
--- linux-2.4.2.sym/arch/i386/kernel/time.c	Fri Dec 29 23:07:57 2000
+++ linux-2.4.2.amp/arch/i386/kernel/time.c	Wed Mar 21 02:15:42 2001
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
@@ -266,8 +266,8 @@
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
@@ -431,6 +431,7 @@
 		else
 			last_rtc_update =3D xtime.tv_sec - 600; /* do it again in 60 s */
 	}
+	current_cpu_data.xtime =3D xtime;
 	   =20
 #ifdef CONFIG_MCA
 	if( MCA_bus ) {
@@ -485,7 +486,7 @@
 =09
 		/* read Pentium cycle counter */
=20
-		rdtscl(last_tsc_low);
+		rdtscl(current_cpu_data.last_tsc_low);
=20
 		spin_lock(&i8253_lock);
 		outb_p(0x00, 0x43);     /* latch the count ASAP */
@@ -586,7 +587,7 @@
 		} while ((inb(0x61) & 0x20) =3D=3D 0);
 		rdtsc(endlow,endhigh);
=20
-		last_tsc_low =3D endlow;
+		current_cpu_data.last_tsc_low =3D endlow;
=20
 		/* Error: ECTCNEVERSET */
 		if (count <=3D 1)
@@ -623,7 +624,8 @@
 	return 0;
 }
=20
-void __init time_init(void)
+
+void __init time_init_cpu(struct cpuinfo_x86 *c)
 {
 	extern int x86_udelay_tsc;
 =09
@@ -660,7 +662,8 @@
 	if (cpu_has_tsc) {
 		unsigned long tsc_quotient =3D calibrate_tsc();
 		if (tsc_quotient) {
-			fast_gettimeoffset_quotient =3D tsc_quotient;
+			unsigned long cpu_khz;
+			c->fast_gettimeoffset_quotient =3D tsc_quotient;
 			use_tsc =3D 1;
 			/*
 			 *	We could be more selective here I suspect
@@ -683,6 +686,7 @@
 	                	"0" (eax), "1" (edx));
 				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz =
% 1000);
 			}
+			c->cpu_khz =3D cpu_khz;
 		}
 	}
=20
@@ -703,4 +707,11 @@
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
diff -uNr linux-2.4.2.sym/include/asm-i386/bugs.h linux-2.4.2.amp/include/a=
sm-i386/bugs.h
--- linux-2.4.2.sym/include/asm-i386/bugs.h	Wed Mar 21 02:14:22 2001
+++ linux-2.4.2.amp/include/asm-i386/bugs.h	Wed Mar 21 14:47:23 2001
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
diff -uNr linux-2.4.2.sym/include/asm-i386/processor.h linux-2.4.2.amp/incl=
ude/asm-i386/processor.h
--- linux-2.4.2.sym/include/asm-i386/processor.h	Tue Mar  6 23:25:52 2001
+++ linux-2.4.2.amp/include/asm-i386/processor.h	Wed Mar 21 02:10:14 2001
@@ -16,6 +16,7 @@
 #include <asm/cpufeature.h>
 #include <linux/config.h>
 #include <linux/threads.h>
+#include <linux/time.h>
=20
 /*
  * Default implementation of macro that returns current
@@ -52,6 +53,10 @@
 	unsigned long *pmd_quick;
 	unsigned long *pte_quick;
 	unsigned long pgtable_cache_sz;
+	unsigned long cpu_khz;
+	unsigned long fast_gettimeoffset_quotient;
+	unsigned long last_tsc_low;
+	struct timeval xtime;
 };
=20
 #define X86_VENDOR_INTEL 0
diff -uNr linux-2.4.2.sym/init/main.c linux-2.4.2.amp/init/main.c
--- linux-2.4.2.sym/init/main.c	Thu Mar  1 16:44:10 2001
+++ linux-2.4.2.amp/init/main.c	Wed Mar 21 14:39:32 2001
@@ -592,6 +592,12 @@
 	page_cache_init(mempages);
 	kiobuf_setup();
 	signals_init();
+	/* Moved smp_init() up, as bdev_init(), i.e. RAID5, may depend on the CPU=
 features
+	 * being present, which is unfortunately only known after all CPUs have b=
een booted
+	 * check_bugs() follows next to take care of FPU ...
+	 * KG <garloff@suse.de>, 2001-01-21 */
+	smp_init();
+	check_bugs();
 	bdev_init();
 	inode_init(mempages);
 #if defined(CONFIG_SYSVIPC)
@@ -600,7 +606,6 @@
 #if defined(CONFIG_QUOTA)
 	dquot_init_hash();
 #endif
-	check_bugs();
 	printk("POSIX conformance testing by UNIFIX\n");
=20
 	/*=20
@@ -608,7 +613,6 @@
 	 *	Like idlers init is an unlocked kernel thread, which will
 	 *	make syscalls (and thus be locked).
 	 */
-	smp_init();
 	kernel_thread(init, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
 	unlock_kernel();
 	current->need_resched =3D 1;

--MP5ln1Rcf9Bvi+ZW--

--WHz+neNWvhIGAO8A
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6uM78xmLh6hyYd04RAtWZAKDC/wbWWZYTfOlRljl3nP5zTzAYJQCgxeQZ
w7Px1Ji2QIQHbjTB1Kpy2dQ=
=mm0k
-----END PGP SIGNATURE-----

--WHz+neNWvhIGAO8A--
