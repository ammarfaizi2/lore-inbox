Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWCZBAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWCZBAU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 20:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWCZBAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 20:00:20 -0500
Received: from mail.parknet.jp ([210.171.160.80]:54026 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1751115AbWCZBAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 20:00:18 -0500
X-AuthUser: hirofumi@parknet.jp
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Don't pass boot parameters to argv_init[]
References: <87zmjeumus.fsf@duaron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 26 Mar 2006 10:00:12 +0900
In-Reply-To: <87zmjeumus.fsf@duaron.myhome.or.jp> (OGAWA Hirofumi's message of "Sun, 26 Mar 2006 08:27:07 +0900")
Message-ID: <87d5gauijn.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix my crappy description. Sorry.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



The boot cmdline is parsed in parse_early_param() and
parse_args(,unknown_bootoption).

And __setup() is used in obsolete_checksetup().

	start_kernel()
		-> parse_args()
			-> unknown_bootoption()
				-> obsolete_checksetup()

If __setup()'s callback (->setup_func()) returns 1 in obsolete_checksetup(),
obsolete_checksetup() thinks a parameter was handled.

If ->setup_func() returns 0, obsolete_checksetup() tries other
->setup_func(). If all ->setup_func() that matched a parameter returns 0,
a parameter is seted to argv_init[].

Then, when runing /sbin/init or init=app, argv_init[] is passed to the
app. If the app doesn't ignore those arguments, it will warning and exit.

This patch fixes a wrong usage of it, however fixes obvious one only.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 arch/alpha/kernel/core_marvel.c   |    2 +-
 arch/i386/kernel/apic.c           |    2 +-
 arch/i386/kernel/cpu/mcheck/mce.c |    4 ++--
 arch/i386/kernel/io_apic.c        |    2 +-
 arch/i386/kernel/traps.c          |    2 +-
 arch/powerpc/kernel/crash_dump.c  |    4 ++--
 arch/sh/kernel/cpu/init.c         |    2 +-
 arch/x86_64/kernel/apic.c         |   14 +++++++-------
 arch/x86_64/kernel/early_printk.c |    2 +-
 arch/x86_64/kernel/mce.c          |    4 ++--
 arch/x86_64/kernel/pmtimer.c      |    2 +-
 arch/x86_64/kernel/setup.c        |    2 +-
 arch/x86_64/kernel/setup64.c      |    4 ++--
 arch/x86_64/kernel/smpboot.c      |    2 +-
 arch/x86_64/kernel/time.c         |    4 ++--
 arch/x86_64/kernel/traps.c        |    4 ++--
 arch/x86_64/mm/fault.c            |    2 +-
 block/elevator.c                  |    2 +-
 drivers/acpi/ec.c                 |    4 ++--
 drivers/block/amiflop.c           |    1 +
 drivers/media/video/cpia_pp.c     |    2 +-
 drivers/net/netconsole.c          |    2 +-
 drivers/net/pcmcia/xirc2ps_cs.c   |    2 +-
 drivers/pcmcia/vrc4171_card.c     |   12 ++++++------
 drivers/pcmcia/vrc4173_cardu.c    |    8 ++++----
 drivers/scsi/ibmmca.c             |    2 +-
 drivers/video/console/fbcon.c     |   10 +++++-----
 drivers/video/console/sticore.c   |    4 ++--
 drivers/video/fbmem.c             |    2 +-
 drivers/video/stifb.c             |    4 ++--
 kernel/audit.c                    |    2 +-
 mm/memory.c                       |    2 +-
 32 files changed, 59 insertions(+), 58 deletions(-)

diff -puN arch/alpha/kernel/core_marvel.c~__setup-fixes arch/alpha/kernel/core_marvel.c
--- linux-2.6/arch/alpha/kernel/core_marvel.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/arch/alpha/kernel/core_marvel.c	2006-03-26 09:25:16.000000000 +0900
@@ -435,7 +435,7 @@ marvel_specify_io7(char *str)
 		str = pchar;
 	} while(*str);
 
-	return 0;
+	return 1;
 }
 __setup("io7=", marvel_specify_io7);
 
diff -puN arch/i386/kernel/apic.c~__setup-fixes arch/i386/kernel/apic.c
--- linux-2.6/arch/i386/kernel/apic.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/arch/i386/kernel/apic.c	2006-03-26 09:25:16.000000000 +0900
@@ -732,7 +732,7 @@ static int __init apic_set_verbosity(cha
 		printk(KERN_WARNING "APIC Verbosity level %s not recognised"
 				" use apic=verbose or apic=debug\n", str);
 
-	return 0;
+	return 1;
 }
 
 __setup("apic=", apic_set_verbosity);
diff -puN arch/i386/kernel/cpu/mcheck/mce.c~__setup-fixes arch/i386/kernel/cpu/mcheck/mce.c
--- linux-2.6/arch/i386/kernel/cpu/mcheck/mce.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/arch/i386/kernel/cpu/mcheck/mce.c	2006-03-26 09:25:16.000000000 +0900
@@ -64,13 +64,13 @@ void mcheck_init(struct cpuinfo_x86 *c)
 static int __init mcheck_disable(char *str)
 {
 	mce_disabled = 1;
-	return 0;
+	return 1;
 }
 
 static int __init mcheck_enable(char *str)
 {
 	mce_disabled = -1;
-	return 0;
+	return 1;
 }
 
 __setup("nomce", mcheck_disable);
diff -puN arch/i386/kernel/io_apic.c~__setup-fixes arch/i386/kernel/io_apic.c
--- linux-2.6/arch/i386/kernel/io_apic.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/arch/i386/kernel/io_apic.c	2006-03-26 09:25:16.000000000 +0900
@@ -644,7 +644,7 @@ failed:
 int __init irqbalance_disable(char *str)
 {
 	irqbalance_disabled = 1;
-	return 0;
+	return 1;
 }
 
 __setup("noirqbalance", irqbalance_disable);
diff -puN arch/i386/kernel/traps.c~__setup-fixes arch/i386/kernel/traps.c
--- linux-2.6/arch/i386/kernel/traps.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/arch/i386/kernel/traps.c	2006-03-26 09:25:16.000000000 +0900
@@ -1187,6 +1187,6 @@ void __init trap_init(void)
 static int __init kstack_setup(char *s)
 {
 	kstack_depth_to_print = simple_strtoul(s, NULL, 0);
-	return 0;
+	return 1;
 }
 __setup("kstack=", kstack_setup);
diff -puN arch/powerpc/kernel/crash_dump.c~__setup-fixes arch/powerpc/kernel/crash_dump.c
--- linux-2.6/arch/powerpc/kernel/crash_dump.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/arch/powerpc/kernel/crash_dump.c	2006-03-26 09:25:16.000000000 +0900
@@ -61,7 +61,7 @@ static int __init parse_elfcorehdr(char 
 	if (p)
 		elfcorehdr_addr = memparse(p, &p);
 
-	return 0;
+	return 1;
 }
 __setup("elfcorehdr=", parse_elfcorehdr);
 #endif
@@ -71,7 +71,7 @@ static int __init parse_savemaxmem(char 
 	if (p)
 		saved_max_pfn = (memparse(p, &p) >> PAGE_SHIFT) - 1;
 
-	return 0;
+	return 1;
 }
 __setup("savemaxmem=", parse_savemaxmem);
 
diff -puN arch/sh/kernel/cpu/init.c~__setup-fixes arch/sh/kernel/cpu/init.c
--- linux-2.6/arch/sh/kernel/cpu/init.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/arch/sh/kernel/cpu/init.c	2006-03-26 09:25:16.000000000 +0900
@@ -30,7 +30,7 @@ static int x##_disabled __initdata = 0;	
 static int __init x##_setup(char *opts)		\
 {						\
 	x##_disabled = 1;			\
-	return 0;				\
+	return 1;				\
 }						\
 __setup("no" __stringify(x), x##_setup);
 
diff -puN arch/x86_64/kernel/apic.c~__setup-fixes arch/x86_64/kernel/apic.c
--- linux-2.6/arch/x86_64/kernel/apic.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/arch/x86_64/kernel/apic.c	2006-03-26 09:25:16.000000000 +0900
@@ -595,7 +595,7 @@ static int __init apic_set_verbosity(cha
 		printk(KERN_WARNING "APIC Verbosity level %s not recognised"
 				" use apic=verbose or apic=debug", str);
 
-	return 0;
+	return 1;
 }
 
 __setup("apic=", apic_set_verbosity);
@@ -1117,35 +1117,35 @@ int __init APIC_init_uniprocessor (void)
 static __init int setup_disableapic(char *str) 
 { 
 	disable_apic = 1;
-	return 0;
+	return 1;
 } 
 
 static __init int setup_nolapic(char *str) 
 { 
 	disable_apic = 1;
-	return 0;
+	return 1;
 } 
 
 static __init int setup_noapictimer(char *str) 
 { 
 	if (str[0] != ' ' && str[0] != 0)
-		return -1;
+		return 0;
 	disable_apic_timer = 1;
-	return 0;
+	return 1;
 } 
 
 static __init int setup_apicmaintimer(char *str)
 {
 	apic_runs_main_timer = 1;
 	nohpet = 1;
-	return 0;
+	return 1;
 }
 __setup("apicmaintimer", setup_apicmaintimer);
 
 static __init int setup_noapicmaintimer(char *str)
 {
 	apic_runs_main_timer = -1;
-	return 0;
+	return 1;
 }
 __setup("noapicmaintimer", setup_noapicmaintimer);
 
diff -puN arch/x86_64/kernel/early_printk.c~__setup-fixes arch/x86_64/kernel/early_printk.c
--- linux-2.6/arch/x86_64/kernel/early_printk.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/arch/x86_64/kernel/early_printk.c	2006-03-26 09:25:16.000000000 +0900
@@ -221,7 +221,7 @@ int __init setup_early_printk(char *opt)
 	char buf[256];
 
 	if (early_console_initialized)
-		return -1;
+		return 1;
 
 	strlcpy(buf,opt,sizeof(buf));
 	space = strchr(buf, ' ');
diff -puN arch/x86_64/kernel/mce.c~__setup-fixes arch/x86_64/kernel/mce.c
--- linux-2.6/arch/x86_64/kernel/mce.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/arch/x86_64/kernel/mce.c	2006-03-26 09:25:16.000000000 +0900
@@ -501,7 +501,7 @@ static struct miscdevice mce_log_device 
 static int __init mcheck_disable(char *str)
 {
 	mce_dont_init = 1;
-	return 0;
+	return 1;
 }
 
 /* mce=off disables machine check. Note you can reenable it later
@@ -521,7 +521,7 @@ static int __init mcheck_enable(char *st
 		get_option(&str, &tolerant);
 	else
 		printk("mce= argument %s ignored. Please use /sys", str); 
-	return 0;
+	return 1;
 }
 
 __setup("nomce", mcheck_disable);
diff -puN arch/x86_64/kernel/pmtimer.c~__setup-fixes arch/x86_64/kernel/pmtimer.c
--- linux-2.6/arch/x86_64/kernel/pmtimer.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/arch/x86_64/kernel/pmtimer.c	2006-03-26 09:25:16.000000000 +0900
@@ -120,7 +120,7 @@ unsigned int do_gettimeoffset_pm(void)
 static int __init nopmtimer_setup(char *s)
 {
 	pmtmr_ioport = 0;
-	return 0;
+	return 1;
 }
 
 __setup("nopmtimer", nopmtimer_setup);
diff -puN arch/x86_64/kernel/setup.c~__setup-fixes arch/x86_64/kernel/setup.c
--- linux-2.6/arch/x86_64/kernel/setup.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/arch/x86_64/kernel/setup.c	2006-03-26 09:25:16.000000000 +0900
@@ -530,7 +530,7 @@ void __init alternative_instructions(voi
 static int __init noreplacement_setup(char *s)
 { 
      no_replacement = 1; 
-     return 0; 
+     return 1;
 } 
 
 __setup("noreplacement", noreplacement_setup); 
diff -puN arch/x86_64/kernel/setup64.c~__setup-fixes arch/x86_64/kernel/setup64.c
--- linux-2.6/arch/x86_64/kernel/setup64.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/arch/x86_64/kernel/setup64.c	2006-03-26 09:25:16.000000000 +0900
@@ -55,7 +55,7 @@ int __init nonx_setup(char *str)
 		do_not_nx = 1;
 		__supported_pte_mask &= ~_PAGE_NX;
         }
-	return 0;
+	return 1;
 } 
 __setup("noexec=", nonx_setup);	/* parsed early actually */
 
@@ -74,7 +74,7 @@ static int __init nonx32_setup(char *str
 		force_personality32 &= ~READ_IMPLIES_EXEC;
 	else if (!strcmp(str, "off"))
 		force_personality32 |= READ_IMPLIES_EXEC;
-	return 0;
+	return 1;
 }
 __setup("noexec32=", nonx32_setup);
 
diff -puN arch/x86_64/kernel/smpboot.c~__setup-fixes arch/x86_64/kernel/smpboot.c
--- linux-2.6/arch/x86_64/kernel/smpboot.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/arch/x86_64/kernel/smpboot.c	2006-03-26 09:25:16.000000000 +0900
@@ -350,7 +350,7 @@ static void __cpuinit tsc_sync_wait(void
 static __init int notscsync_setup(char *s)
 {
 	notscsync = 1;
-	return 0;
+	return 1;
 }
 __setup("notscsync", notscsync_setup);
 
diff -puN arch/x86_64/kernel/time.c~__setup-fixes arch/x86_64/kernel/time.c
--- linux-2.6/arch/x86_64/kernel/time.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/arch/x86_64/kernel/time.c	2006-03-26 09:25:16.000000000 +0900
@@ -1322,7 +1322,7 @@ irqreturn_t hpet_rtc_interrupt(int irq, 
 static int __init nohpet_setup(char *s) 
 { 
 	nohpet = 1;
-	return 0;
+	return 1;
 } 
 
 __setup("nohpet", nohpet_setup);
@@ -1330,7 +1330,7 @@ __setup("nohpet", nohpet_setup);
 int __init notsc_setup(char *s)
 {
 	notsc = 1;
-	return 0;
+	return 1;
 }
 
 __setup("notsc", notsc_setup);
diff -puN arch/x86_64/kernel/traps.c~__setup-fixes arch/x86_64/kernel/traps.c
--- linux-2.6/arch/x86_64/kernel/traps.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/arch/x86_64/kernel/traps.c	2006-03-26 09:25:16.000000000 +0900
@@ -974,14 +974,14 @@ void __init trap_init(void)
 static int __init oops_dummy(char *s)
 { 
 	panic_on_oops = 1;
-	return -1; 
+	return 1;
 } 
 __setup("oops=", oops_dummy); 
 
 static int __init kstack_setup(char *s)
 {
 	kstack_depth_to_print = simple_strtoul(s,NULL,0);
-	return 0;
+	return 1;
 }
 __setup("kstack=", kstack_setup);
 
diff -puN arch/x86_64/mm/fault.c~__setup-fixes arch/x86_64/mm/fault.c
--- linux-2.6/arch/x86_64/mm/fault.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/arch/x86_64/mm/fault.c	2006-03-26 09:25:16.000000000 +0900
@@ -574,6 +574,6 @@ do_sigbus:
 static int __init enable_pagefaulttrace(char *str)
 {
 	page_fault_trace = 1;
-	return 0;
+	return 1;
 }
 __setup("pagefaulttrace", enable_pagefaulttrace);
diff -puN block/elevator.c~__setup-fixes block/elevator.c
--- linux-2.6/block/elevator.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/block/elevator.c	2006-03-26 09:25:16.000000000 +0900
@@ -145,7 +145,7 @@ static int __init elevator_setup(char *s
 		strcpy(chosen_elevator, "anticipatory");
 	else
 		strncpy(chosen_elevator, str, sizeof(chosen_elevator) - 1);
-	return 0;
+	return 1;
 }
 
 __setup("elevator=", elevator_setup);
diff -puN drivers/acpi/ec.c~__setup-fixes drivers/acpi/ec.c
--- linux-2.6/drivers/acpi/ec.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/drivers/acpi/ec.c	2006-03-26 09:25:16.000000000 +0900
@@ -1572,7 +1572,7 @@ static void __exit acpi_ec_exit(void)
 static int __init acpi_fake_ecdt_setup(char *str)
 {
 	acpi_fake_ecdt_enabled = 1;
-	return 0;
+	return 1;
 }
 
 __setup("acpi_fake_ecdt", acpi_fake_ecdt_setup);
@@ -1591,7 +1591,7 @@ static int __init acpi_ec_set_intr_mode(
 		acpi_ec_driver.ops.add = acpi_ec_poll_add;
 	}
 	printk(KERN_INFO PREFIX "EC %s mode.\n", intr ? "interrupt" : "polling");
-	return 0;
+	return 1;
 }
 
 __setup("ec_intr=", acpi_ec_set_intr_mode);
diff -puN drivers/block/amiflop.c~__setup-fixes drivers/block/amiflop.c
--- linux-2.6/drivers/block/amiflop.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/drivers/block/amiflop.c	2006-03-26 09:25:16.000000000 +0900
@@ -1850,6 +1850,7 @@ static int __init amiga_floppy_setup (ch
 		return 0;
 	printk (KERN_INFO "amiflop: Setting default df0 to %x\n", n);
 	fd_def_df0 = n;
+	return 1;
 }
 
 __setup("floppy=", amiga_floppy_setup);
diff -puN drivers/media/video/cpia_pp.c~__setup-fixes drivers/media/video/cpia_pp.c
--- linux-2.6/drivers/media/video/cpia_pp.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/drivers/media/video/cpia_pp.c	2006-03-26 09:25:16.000000000 +0900
@@ -873,7 +873,7 @@ static int __init cpia_pp_setup(char *st
 		parport_nr[parport_ptr++] = PPCPIA_PARPORT_NONE;
 	}
 
-	return 0;
+	return 1;
 }
 
 __setup("cpia_pp=", cpia_pp_setup);
diff -puN drivers/net/netconsole.c~__setup-fixes drivers/net/netconsole.c
--- linux-2.6/drivers/net/netconsole.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/drivers/net/netconsole.c	2006-03-26 09:25:16.000000000 +0900
@@ -94,7 +94,7 @@ static struct console netconsole = {
 static int option_setup(char *opt)
 {
 	configured = !netpoll_parse_options(&np, opt);
-	return 0;
+	return 1;
 }
 
 __setup("netconsole=", option_setup);
diff -puN drivers/net/pcmcia/xirc2ps_cs.c~__setup-fixes drivers/net/pcmcia/xirc2ps_cs.c
--- linux-2.6/drivers/net/pcmcia/xirc2ps_cs.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/drivers/net/pcmcia/xirc2ps_cs.c	2006-03-26 09:25:16.000000000 +0900
@@ -1973,7 +1973,7 @@ static int __init setup_xirc2ps_cs(char 
 	MAYBE_SET(lockup_hack, 6);
 #undef  MAYBE_SET
 
-	return 0;
+	return 1;
 }
 
 __setup("xirc2ps_cs=", setup_xirc2ps_cs);
diff -puN drivers/pcmcia/vrc4171_card.c~__setup-fixes drivers/pcmcia/vrc4171_card.c
--- linux-2.6/drivers/pcmcia/vrc4171_card.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/drivers/pcmcia/vrc4171_card.c	2006-03-26 09:25:16.000000000 +0900
@@ -634,7 +634,7 @@ static void vrc4171_remove_sockets(void)
 static int __devinit vrc4171_card_setup(char *options)
 {
 	if (options == NULL || *options == '\0')
-		return 0;
+		return 1;
 
 	if (strncmp(options, "irq:", 4) == 0) {
 		int irq;
@@ -644,7 +644,7 @@ static int __devinit vrc4171_card_setup(
 			vrc4171_irq = irq;
 
 		if (*options != ',')
-			return 0;
+			return 1;
 		options++;
 	}
 
@@ -663,10 +663,10 @@ static int __devinit vrc4171_card_setup(
 			}
 
 			if (*options != ',')
-				return 0;
+				return 1;
 			options++;
 		} else
-			return 0;
+			return 1;
 
 	}
 
@@ -688,7 +688,7 @@ static int __devinit vrc4171_card_setup(
 			}
 
 			if (*options != ',')
-				return 0;
+				return 1;
 			options++;
 
 			if (strncmp(options, "memnoprobe", 10) == 0)
@@ -700,7 +700,7 @@ static int __devinit vrc4171_card_setup(
 		}
 	}
 
-	return 0;
+	return 1;
 }
 
 __setup("vrc4171_card=", vrc4171_card_setup);
diff -puN drivers/pcmcia/vrc4173_cardu.c~__setup-fixes drivers/pcmcia/vrc4173_cardu.c
--- linux-2.6/drivers/pcmcia/vrc4173_cardu.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/drivers/pcmcia/vrc4173_cardu.c	2006-03-26 09:25:16.000000000 +0900
@@ -516,7 +516,7 @@ static int __devinit vrc4173_cardu_probe
 static int __devinit vrc4173_cardu_setup(char *options)
 {
 	if (options == NULL || *options == '\0')
-		return 0;
+		return 1;
 
 	if (strncmp(options, "cardu1:", 7) == 0) {
 		options += 7;
@@ -527,9 +527,9 @@ static int __devinit vrc4173_cardu_setup
 			}
 
 			if (*options != ',')
-				return 0;
+				return 1;
 		} else
-			return 0;
+			return 1;
 	}
 
 	if (strncmp(options, "cardu2:", 7) == 0) {
@@ -538,7 +538,7 @@ static int __devinit vrc4173_cardu_setup
 			cardu_sockets[CARDU2].noprobe = 1;
 	}
 
-	return 0;
+	return 1;
 }
 
 __setup("vrc4173_cardu=", vrc4173_cardu_setup);
diff -puN drivers/scsi/ibmmca.c~__setup-fixes drivers/scsi/ibmmca.c
--- linux-2.6/drivers/scsi/ibmmca.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/drivers/scsi/ibmmca.c	2006-03-26 09:25:16.000000000 +0900
@@ -2488,7 +2488,7 @@ static int option_setup(char *str)
 	}
 	ints[0] = i - 1;
 	internal_ibmmca_scsi_setup(cur, ints);
-	return 0;
+	return 1;
 }
 
 __setup("ibmmcascsi=", option_setup);
diff -puN drivers/video/console/fbcon.c~__setup-fixes drivers/video/console/fbcon.c
--- linux-2.6/drivers/video/console/fbcon.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/drivers/video/console/fbcon.c	2006-03-26 09:25:16.000000000 +0900
@@ -466,7 +466,7 @@ static int __init fb_console_setup(char 
 	int i, j;
 
 	if (!this_opt || !*this_opt)
-		return 0;
+		return 1;
 
 	while ((options = strsep(&this_opt, ",")) != NULL) {
 		if (!strncmp(options, "font:", 5))
@@ -481,10 +481,10 @@ static int __init fb_console_setup(char 
 					options++;
 				}
 				if (*options != ',')
-					return 0;
+					return 1;
 				options++;
 			} else
-				return 0;
+				return 1;
 		}
 		
 		if (!strncmp(options, "map:", 4)) {
@@ -496,7 +496,7 @@ static int __init fb_console_setup(char 
 					con2fb_map_boot[i] =
 						(options[j++]-'0') % FB_MAX;
 				}
-			return 0;
+			return 1;
 		}
 
 		if (!strncmp(options, "vc:", 3)) {
@@ -518,7 +518,7 @@ static int __init fb_console_setup(char 
 				rotate = 0;
 		}
 	}
-	return 0;
+	return 1;
 }
 
 __setup("fbcon=", fb_console_setup);
diff -puN drivers/video/console/sticore.c~__setup-fixes drivers/video/console/sticore.c
--- linux-2.6/drivers/video/console/sticore.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/drivers/video/console/sticore.c	2006-03-26 09:25:16.000000000 +0900
@@ -275,7 +275,7 @@ static int __init sti_setup(char *str)
 	if (str)
 		strlcpy (default_sti_path, str, sizeof (default_sti_path));
 	
-	return 0;
+	return 1;
 }
 
 /*	Assuming the machine has multiple STI consoles (=graphic cards) which
@@ -321,7 +321,7 @@ static int __init sti_font_setup(char *s
 		i++;
 	}
 
-	return 0;
+	return 1;
 }
 
 /*	The optional linux kernel parameter "sti_font" defines which font
diff -puN drivers/video/fbmem.c~__setup-fixes drivers/video/fbmem.c
--- linux-2.6/drivers/video/fbmem.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/drivers/video/fbmem.c	2006-03-26 09:25:16.000000000 +0900
@@ -1585,7 +1585,7 @@ static int __init video_setup(char *opti
 		}
 	}
 
-	return 0;
+	return 1;
 }
 __setup("video=", video_setup);
 #endif
diff -puN drivers/video/stifb.c~__setup-fixes drivers/video/stifb.c
--- linux-2.6/drivers/video/stifb.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/drivers/video/stifb.c	2006-03-26 09:25:16.000000000 +0900
@@ -1457,7 +1457,7 @@ stifb_setup(char *options)
 	int i;
 	
 	if (!options || !*options)
-		return 0;
+		return 1;
 	
 	if (strncmp(options, "off", 3) == 0) {
 		stifb_disabled = 1;
@@ -1472,7 +1472,7 @@ stifb_setup(char *options)
 			stifb_bpp_pref[i] = simple_strtoul(options, &options, 10);
 		}
 	}
-	return 0;
+	return 1;
 }
 
 __setup("stifb=", stifb_setup);
diff -puN kernel/audit.c~__setup-fixes kernel/audit.c
--- linux-2.6/kernel/audit.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/kernel/audit.c	2006-03-26 09:25:16.000000000 +0900
@@ -538,7 +538,7 @@ static int __init audit_enable(char *str
 	       audit_initialized ? "" : " (after initialization)");
 	if (audit_initialized)
 		audit_enabled = audit_default;
-	return 0;
+	return 1;
 }
 
 __setup("audit=", audit_enable);
diff -puN mm/memory.c~__setup-fixes mm/memory.c
--- linux-2.6/mm/memory.c~__setup-fixes	2006-03-26 09:25:16.000000000 +0900
+++ linux-2.6-hirofumi/mm/memory.c	2006-03-26 09:25:16.000000000 +0900
@@ -87,7 +87,7 @@ int randomize_va_space __read_mostly = 1
 static int __init disable_randmaps(char *s)
 {
 	randomize_va_space = 0;
-	return 0;
+	return 1;
 }
 __setup("norandmaps", disable_randmaps);
 
_
