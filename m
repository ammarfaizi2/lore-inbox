Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266185AbUHTKOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266185AbUHTKOy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 06:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266195AbUHTKOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 06:14:53 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:55228 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S266185AbUHTKKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 06:10:49 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       len.brown@intel.com
Subject: [PATCH] Oops and panic while unloading holder of pm_idle
Date: Thu, 19 Aug 2004 18:31:22 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200408171728.06262.blaisorblade_spam@yahoo.it>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_mXNJBb+/6H9HyDb"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_mXNJBb+/6H9HyDb
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(CC me on replies as I'm not subscribed).

A short description, with my hypothesis about how the panic() happened:

My 2.6.7 preemptible kernel oopsed because when I unloaded the "processor" 
module (driver/acpi/processor.c), the pm_idle(see arch/i386/kernel/process.c) 
function he provided was called after the module being unloaded (notice that 
the "processor" module is not listed below).

I.e., cpu_idle did "idle = pm_idle", it was probably preempted (I run with 
CONFIG_PREEMPT=y), the processor module was unloaded, and then it called 
"(*idle)();". In fact it does not happen always (I just got again this panic 
by unloading the same module, and checked that the address was from the 
"processor", but I cannot get it again; don't ask me why it can be obtained 
only the first time it is unloaded, but not after reloading and re-unloading 
it).

This could happen as well on SMP, so we need a spinlock for accessing 
pm_idle. We could maybe as well use a semaphore (since we will always be in 
process context), but IMHO there is too much overhead. And it does not make 
sense for the idle thread to sleep while holding a semaphore (I don't know if 
it's a bug). So I attach spinlock-protect-pm_idle.patch (which corrects some 
more things on some archs). With this patch applied, I cannot reproduce the 
problem any more.

But that does not suffice: saying

static void (*pm_idle_save)(void);
pm_idle_save = pm_idle;
pm_idle = my_own_pm_idle; 

does not work if you stack more modules onto it. Say, if module1 and module2 
both install their pm_idle and then I unload module1 and after I unload 
module2: module2 will restore module1_pm_idle, so we get Oopses. I.e. we need 
a stack of pm_idle functions + some register_pm_idle() APIs. Do you agree?

This may be a bit overkill given that only APM and ACPI, and, on SPARC, 
arch/sparc/kernel/{apc,pmc}.c, define their pm_idle function. So, as an 
alternative, see this code (which assumes pm_idle is renamed to _pm_idle and 
unexported, to force changes in all drivers):

int install_pm_idle(void (*idle)(void))
{
	if (_pm_idle == NULL) {
		_pm_idle = idle;
		return 1;
	} else
		return 0;
}
EXPORT_SYMBOL(install_pm_idle);

Also, in my case, I don't think we have this kind of panic, because pm_idle is 
just defined by APM and ACPI (CONFIG_APM=y, and APM is not supported by my 
laptop). I also checked, when getting again the same panic, that the faulty 
EIP was actually inside the processor module (from /proc/modules).

And also, it PANICKED, but CONTINUED TO RUN: notice the last 3 lines:
<0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
 <6>ACPI: Processor [CPU0] (supports C1 C2)
The third one comes from reloading the "processor" module.

For reference, I attach the Oops output and the cpu_idle disassemble, so that 
you can check the EIP value. However I checked that it was actually calling 
pm_idle.

Unable to handle kernel paging request at virtual address e0e8a238
 printing eip:
e0e8a238
*pde = 1e1e1067
*pte = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: fan button battery non_fatal ac binfmt_misc snd_seq_oss 
snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_intel8x0 
snd_ac97_codec snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart 
snd_rawmidi snd_seq_device snd soundcore af_packet ipv6 ds yenta_socket 
pcmcia_core eth1394 tg3 ohci1394 ieee1394 nls_iso8859_15 nls_cp850 vfat fat 
psmouse amd64_agp agpgart ide_cd cdrom sd_mod usb_storage scsi_mod tsdev 
evdev dm_mod usbhid usbmouse ehci_hcd ohci_hcd usbcore rtc
CPU:    0
EIP:    0060:[<e0e8a238>]    Not tainted
EFLAGS: 00010212   (2.6.7)
EIP is at 0xe0e8a238
eax: 00f6b2a4   ebx: 00008008   ecx: 00f6a78f   edx: 00008008
esi: c15666b0   edi: c03d41c0   ebp: c1566600   esp: c03adfc8
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03ac000 task=c0330a40)
Stack: 00099100 00099100 c03ac000 00099100 c03d41c0 00426007 c01020cd c03ac000
       c03ae61d 00000012 c03ae370 c03d3fc0 00000800 c010019f
Call Trace:
 [<c01020cd>] cpu_idle+0x2d/0x40
 [<c03ae61d>] start_kernel+0x14d/0x170
 [<c03ae370>] unknown_bootoption+0x0/0x120

Code:  Bad EIP value.
 <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
 <6>ACPI: Processor [CPU0] (supports C1 C2)

(gdb) disassemble cpu_idle
Dump of assembler code for function cpu_idle:
0xc01020a0 <cpu_idle+0>:        push   %ebx
0xc01020a1 <cpu_idle+1>:        mov    $0xffffe000,%ebx
0xc01020a6 <cpu_idle+6>:        and    %esp,%ebx
0xc01020a8 <cpu_idle+8>:        jmp    0xc01020cd <cpu_idle+45>
0xc01020aa <cpu_idle+10>:       lea    0x0(%esi),%esi
0xc01020b0 <cpu_idle+16>:       mov    0xc03d3504,%eax
0xc01020b5 <cpu_idle+21>:       mov    $0xc0102030,%edx
0xc01020ba <cpu_idle+26>:       test   %eax,%eax
0xc01020bc <cpu_idle+28>:       cmove  %edx,%eax
0xc01020bf <cpu_idle+31>:       mov    0xc0331e40,%edx
0xc01020c5 <cpu_idle+37>:       mov    %edx,0xc03e8e84
0xc01020cb <cpu_idle+43>:       call   *%eax
0xc01020cd <cpu_idle+45>:       mov    0x8(%ebx),%eax
0xc01020d0 <cpu_idle+48>:       test   $0x8,%al
0xc01020d2 <cpu_idle+50>:       je     0xc01020b0 <cpu_idle+16>
0xc01020d4 <cpu_idle+52>:       call   0xc02d9200 <schedule>
0xc01020d9 <cpu_idle+57>:       jmp    0xc01020cd <cpu_idle+45>
0xc01020db <cpu_idle+59>:       nop
0xc01020dc <cpu_idle+60>:       lea    0x0(%esi,1),%esi

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729









--Boundary-00=_mXNJBb+/6H9HyDb
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="spinlock-protect-pm_idle.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="spinlock-protect-pm_idle.patch"



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.7-SKAS-paolo/arch/arm/kernel/process.c        |    9 +++++-
 vanilla-linux-2.6.7-SKAS-paolo/arch/arm26/kernel/armksyms.c     |    1 
 vanilla-linux-2.6.7-SKAS-paolo/arch/arm26/kernel/process.c      |    7 ++++-
 vanilla-linux-2.6.7-SKAS-paolo/arch/cris/kernel/crisksyms.c     |    2 +
 vanilla-linux-2.6.7-SKAS-paolo/arch/cris/kernel/process.c       |    7 ++++-
 vanilla-linux-2.6.7-SKAS-paolo/arch/i386/kernel/apm.c           |    4 ++
 vanilla-linux-2.6.7-SKAS-paolo/arch/i386/kernel/i386_ksyms.c    |    1 
 vanilla-linux-2.6.7-SKAS-paolo/arch/i386/kernel/process.c       |    7 ++++-
 vanilla-linux-2.6.7-SKAS-paolo/arch/ia64/kernel/acpi.c          |    2 +
 vanilla-linux-2.6.7-SKAS-paolo/arch/ia64/kernel/process.c       |    5 ++-
 vanilla-linux-2.6.7-SKAS-paolo/arch/sparc/kernel/apc.c          |    5 ++-
 vanilla-linux-2.6.7-SKAS-paolo/arch/sparc/kernel/pmc.c          |    2 +
 vanilla-linux-2.6.7-SKAS-paolo/arch/sparc/kernel/process.c      |    9 +++++-
 vanilla-linux-2.6.7-SKAS-paolo/arch/sparc/kernel/sparc_ksyms.c  |    1 
 vanilla-linux-2.6.7-SKAS-paolo/arch/x86_64/kernel/process.c     |   13 ++++++---
 vanilla-linux-2.6.7-SKAS-paolo/arch/x86_64/kernel/x8664_ksyms.c |    1 
 vanilla-linux-2.6.7-SKAS-paolo/drivers/acpi/processor.c         |    7 ++++-
 vanilla-linux-2.6.7-SKAS-paolo/include/linux/pm.h               |   14 ++++++++++
 18 files changed, 84 insertions(+), 13 deletions(-)

diff -puN arch/arm/kernel/process.c~spinlock-protect-pm_idle arch/arm/kernel/process.c
--- vanilla-linux-2.6.7-SKAS/arch/arm/kernel/process.c~spinlock-protect-pm_idle	2004-08-17 20:21:20.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/arch/arm/kernel/process.c	2004-08-18 21:12:23.113797464 +0200
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/kallsyms.h>
 #include <linux/init.h>
+#include <linux/pm.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -78,6 +79,9 @@ EXPORT_SYMBOL(pm_idle);
 void (*pm_power_off)(void);
 EXPORT_SYMBOL(pm_power_off);
 
+spinlock_t pm_idle_lock = SPIN_LOCK_UNLOCKED;
+EXPORT_SYMBOL(pm_idle_lock);
+
 /*
  * This is our default idle handler.  We need to disable
  * interrupts here to ensure we don't miss a wakeup call.
@@ -99,7 +103,9 @@ void cpu_idle(void)
 {
 	/* endless idle loop with no priority at all */
 	while (1) {
-		void (*idle)(void) = pm_idle;
+		void (*idle)(void);
+		lock_pm_idle();
+		idle = pm_idle;
 		if (!idle)
 			idle = default_idle;
 		preempt_disable();
@@ -108,6 +114,7 @@ void cpu_idle(void)
 			idle();
 		leds_event(led_idle_end);
 		preempt_enable();
+		unlock_pm_idle();
 		schedule();
 	}
 }
diff -puN arch/i386/kernel/process.c~spinlock-protect-pm_idle arch/i386/kernel/process.c
--- vanilla-linux-2.6.7-SKAS/arch/i386/kernel/process.c~spinlock-protect-pm_idle	2004-08-17 20:21:20.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/arch/i386/kernel/process.c	2004-08-17 21:04:06.000000000 +0200
@@ -36,6 +36,7 @@
 #include <linux/module.h>
 #include <linux/kallsyms.h>
 #include <linux/ptrace.h>
+#include <linux/pm.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -69,6 +70,7 @@ unsigned long thread_saved_pc(struct tas
  * Powermanagement idle function, if any..
  */
 void (*pm_idle)(void);
+spinlock_t pm_idle_lock = SPIN_LOCK_UNLOCKED;
 
 void disable_hlt(void)
 {
@@ -142,13 +144,16 @@ void cpu_idle (void)
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
-			void (*idle)(void) = pm_idle;
+			void (*idle)(void);
+			lock_pm_idle();
+			idle = pm_idle;
 
 			if (!idle)
 				idle = default_idle;
 
 			irq_stat[smp_processor_id()].idle_timestamp = jiffies;
 			idle();
+			unlock_pm_idle();
 		}
 		schedule();
 	}
diff -puN arch/cris/kernel/process.c~spinlock-protect-pm_idle arch/cris/kernel/process.c
--- vanilla-linux-2.6.7-SKAS/arch/cris/kernel/process.c~spinlock-protect-pm_idle	2004-08-17 20:21:20.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/arch/cris/kernel/process.c	2004-08-17 21:06:28.000000000 +0200
@@ -112,6 +112,7 @@
 #include <linux/fs.h>
 #include <linux/user.h>
 #include <linux/elfcore.h>
+#include <linux/pm.h>
 
 //#define DEBUG
 
@@ -179,6 +180,7 @@ EXPORT_SYMBOL(enable_hlt);
  * The following aren't currently used.
  */
 void (*pm_idle)(void);
+spinlock_t pm_idle_lock = SPIN_LOCK_UNLOCKED;
 
 extern void default_idle(void);
 
@@ -193,12 +195,15 @@ void cpu_idle (void)
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
-			void (*idle)(void) = pm_idle;
+			void (*idle)(void);
+			lock_pm_idle();
+			idle = pm_idle;
 
 			if (!idle)
 				idle = default_idle;
 
 			idle();
+			unlock_pm_idle();
 		}
 		schedule();
 	}
diff -puN arch/ia64/kernel/process.c~spinlock-protect-pm_idle arch/ia64/kernel/process.c
--- vanilla-linux-2.6.7-SKAS/arch/ia64/kernel/process.c~spinlock-protect-pm_idle	2004-08-17 20:21:20.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/arch/ia64/kernel/process.c	2004-08-17 20:57:07.000000000 +0200
@@ -228,7 +228,9 @@ cpu_idle (void *unused)
 
 	/* endless idle loop with no priority at all */
 	while (1) {
-		void (*idle)(void) = pm_idle;
+		void (*idle)(void);
+		lock_pm_idle();
+		idle = pm_idle;
 		if (!idle)
 			idle = default_idle;
 
@@ -241,6 +243,7 @@ cpu_idle (void *unused)
 				(*mark_idle)(1);
 			(*idle)();
 		}
+		unlock_pm_idle();
 
 		if (mark_idle)
 			(*mark_idle)(0);
diff -puN arch/arm26/kernel/process.c~spinlock-protect-pm_idle arch/arm26/kernel/process.c
--- vanilla-linux-2.6.7-SKAS/arch/arm26/kernel/process.c~spinlock-protect-pm_idle	2004-08-17 20:21:20.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/arch/arm26/kernel/process.c	2004-08-17 21:04:06.000000000 +0200
@@ -26,6 +26,7 @@
 #include <linux/reboot.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/pm.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -72,6 +73,7 @@ __setup("hlt", hlt_setup);
  */
 void (*pm_idle)(void);
 void (*pm_power_off)(void);
+spinlock_t pm_idle_lock = SPIN_LOCK_UNLOCKED;
 
 /*
  * This is our default idle handler.  We need to disable
@@ -94,12 +96,15 @@ void cpu_idle(void)
 	/* endless idle loop with no priority at all */
 	preempt_disable();
 	while (1) {
-		void (*idle)(void) = pm_idle;
+		void (*idle)(void);
+		lock_pm_idle();
+		idle = pm_idle;
 		if (!idle)
 			idle = default_idle;
 		leds_event(led_idle_start);
 		while (!need_resched())
 			idle();
+		unlock_pm_idle();
 		leds_event(led_idle_end);
 		schedule();
 	}
diff -puN arch/sparc/kernel/process.c~spinlock-protect-pm_idle arch/sparc/kernel/process.c
--- vanilla-linux-2.6.7-SKAS/arch/sparc/kernel/process.c~spinlock-protect-pm_idle	2004-08-17 20:21:20.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/arch/sparc/kernel/process.c	2004-08-17 21:04:06.000000000 +0200
@@ -48,6 +48,7 @@
  * Set in pm platform drivers
  */
 void (*pm_idle)(void);
+spinlock_t pm_idle_lock = SPIN_LOCK_UNLOCKED;
 
 /* 
  * Power-off handler instantiation for pm.h compliance
@@ -90,6 +91,7 @@ int cpu_idle(void)
 
 	/* endless idle loop with no priority at all */
 	for (;;) {
+		void (*idle)(void);
 		if (ARCH_SUN4C_SUN4) {
 			static int count = HZ;
 			static unsigned long last_jiffies;
@@ -121,9 +123,12 @@ int cpu_idle(void)
 			local_irq_restore(flags);
 		}
 
-		while((!need_resched()) && pm_idle) {
-			(*pm_idle)();		/* XXX Huh? On sparc?! */
+		lock_pm_idle();
+		idle = pm_idle;
+		while((!need_resched()) && idle) {
+			(*idle)();		/* XXX Huh? On sparc?! */
 		}
+		unlock_pm_idle();
 
 		schedule();
 		check_pgt_cache();
diff -puN arch/x86_64/kernel/process.c~spinlock-protect-pm_idle arch/x86_64/kernel/process.c
--- vanilla-linux-2.6.7-SKAS/arch/x86_64/kernel/process.c~spinlock-protect-pm_idle	2004-08-17 20:21:20.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/arch/x86_64/kernel/process.c	2004-08-17 21:04:06.000000000 +0200
@@ -33,6 +33,7 @@
 #include <linux/irq.h>
 #include <linux/ptrace.h>
 #include <linux/version.h>
+#include <linux/pm.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -58,6 +59,7 @@ atomic_t hlt_counter = ATOMIC_INIT(0);
  * Powermanagement idle function, if any..
  */
 void (*pm_idle)(void);
+spinlock_t pm_idle_lock = SPIN_LOCK_UNLOCKED;
 
 void disable_hlt(void)
 {
@@ -130,11 +132,14 @@ void cpu_idle (void)
 {
 	/* endless idle loop with no priority at all */
 	while (1) {
-		void (*idle)(void) = pm_idle;
+		void (*idle)(void);
+		lock_pm_idle();
+		idle = pm_idle;
 		if (!idle)
 			idle = default_idle;
 		while (!need_resched())
 			idle();
+		unlock_pm_idle();
 		schedule();
 	}
 }
@@ -170,8 +175,9 @@ void __init select_idle_routine(const st
 		 * Skip, if setup has overridden idle.
 		 * Also, take care of system with asymmetric CPUs.
 		 * Use, mwait_idle only if all cpus support it.
-		 * If not, we fallback to default_idle()
+		 * If not, we fallback to default_idle() in cpu_idle().
 		 */
+		lock_pm_idle();
 		if (!pm_idle) {
 			if (!printed) {
 				printk("using mwait in idle threads.\n");
@@ -179,10 +185,9 @@ void __init select_idle_routine(const st
 			}
 			pm_idle = mwait_idle;
 		}
+		unlock_pm_idle();
 		return;
 	}
-	pm_idle = default_idle;
-	return;
 }
 
 static int __init idle_setup (char *str)
diff -puN arch/ia64/kernel/acpi.c~spinlock-protect-pm_idle arch/ia64/kernel/acpi.c
--- vanilla-linux-2.6.7-SKAS/arch/ia64/kernel/acpi.c~spinlock-protect-pm_idle	2004-08-17 20:21:20.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/arch/ia64/kernel/acpi.c	2004-08-17 20:35:54.000000000 +0200
@@ -61,6 +61,8 @@
 void (*pm_idle) (void);
 EXPORT_SYMBOL(pm_idle);
 void (*pm_power_off) (void);
+spinlock_t pm_idle_lock = SPIN_LOCK_UNLOCKED;
+EXPORT_SYMBOL(pm_idle_lock);
 
 unsigned char acpi_kbd_controller_present = 1;
 unsigned char acpi_legacy_devices;
diff -puN arch/i386/kernel/apm.c~spinlock-protect-pm_idle arch/i386/kernel/apm.c
--- vanilla-linux-2.6.7-SKAS/arch/i386/kernel/apm.c~spinlock-protect-pm_idle	2004-08-17 20:21:20.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/arch/i386/kernel/apm.c	2004-08-17 20:57:07.000000000 +0200
@@ -2032,8 +2032,10 @@ static int __init apm_init(void)
 	if (HZ != 100)
 		idle_period = (idle_period * HZ) / 100;
 	if (idle_threshold < 100) {
+		lock_pm_idle();
 		original_pm_idle = pm_idle;
 		pm_idle  = apm_cpu_idle;
+		unlock_pm_idle();
 		set_pm_idle = 1;
 	}
 
@@ -2044,8 +2046,10 @@ static void __exit apm_exit(void)
 {
 	int	error;
 
+	lock_pm_idle();
 	if (set_pm_idle)
 		pm_idle = original_pm_idle;
+	unlock_pm_idle();
 	if (((apm_info.bios.flags & APM_BIOS_DISENGAGED) == 0)
 	    && (apm_info.connection_version > 0x0100)) {
 		error = apm_engage_power_management(APM_DEVICE_ALL, 0);
diff -puN drivers/acpi/processor.c~spinlock-protect-pm_idle drivers/acpi/processor.c
--- vanilla-linux-2.6.7-SKAS/drivers/acpi/processor.c~spinlock-protect-pm_idle	2004-08-17 20:21:20.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/drivers/acpi/processor.c	2004-08-17 20:57:07.000000000 +0200
@@ -2334,8 +2334,10 @@ acpi_processor_add (
 	 * platforms that only support C1.
 	 */
 	if ((pr->id == 0) && (pr->flags.power)) {
+		lock_pm_idle();
 		pm_idle_save = pm_idle;
 		pm_idle = acpi_processor_idle;
+		unlock_pm_idle();
 	}
 	
 	printk(KERN_INFO PREFIX "%s [%s] (supports",
@@ -2373,8 +2375,11 @@ acpi_processor_remove (
 	pr = (struct acpi_processor *) acpi_driver_data(device);
 
 	/* Unregister the idle handler when processor #0 is removed. */
-	if (pr->id == 0)
+	if (pr->id == 0) {
+		lock_pm_idle();
 		pm_idle = pm_idle_save;
+		unlock_pm_idle();
+	}
 
 	status = acpi_remove_notify_handler(pr->handle, ACPI_DEVICE_NOTIFY, 
 		acpi_processor_notify);
diff -puN include/linux/pm.h~spinlock-protect-pm_idle include/linux/pm.h
--- vanilla-linux-2.6.7-SKAS/include/linux/pm.h~spinlock-protect-pm_idle	2004-08-17 20:22:20.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/include/linux/pm.h	2004-08-17 20:28:42.000000000 +0200
@@ -25,6 +25,7 @@
 
 #include <linux/config.h>
 #include <linux/list.h>
+#include <linux/spinlock.h>
 #include <asm/atomic.h>
 
 /*
@@ -193,6 +194,19 @@ static inline void pm_dev_idle(struct pm
 extern void (*pm_idle)(void);
 extern void (*pm_power_off)(void);
 
+extern spinlock_t pm_idle_lock;
+
+/*Not sure if this should be a semaphore...*/
+static inline int lock_pm_idle(void)
+{
+	spin_lock(&pm_idle_lock);
+	return 0;
+}
+static inline void unlock_pm_idle(void)
+{
+	spin_unlock(&pm_idle_lock);
+}
+
 enum {
 	PM_SUSPEND_ON,
 	PM_SUSPEND_STANDBY,
diff -puN arch/i386/kernel/i386_ksyms.c~spinlock-protect-pm_idle arch/i386/kernel/i386_ksyms.c
--- vanilla-linux-2.6.7-SKAS/arch/i386/kernel/i386_ksyms.c~spinlock-protect-pm_idle	2004-08-17 21:00:33.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/arch/i386/kernel/i386_ksyms.c	2004-08-17 21:04:06.000000000 +0200
@@ -84,6 +84,7 @@ EXPORT_SYMBOL(probe_irq_mask);
 EXPORT_SYMBOL(kernel_thread);
 EXPORT_SYMBOL(pm_idle);
 EXPORT_SYMBOL(pm_power_off);
+EXPORT_SYMBOL(pm_idle_lock);
 EXPORT_SYMBOL(get_cmos_time);
 EXPORT_SYMBOL(cpu_khz);
 EXPORT_SYMBOL(apm_info);
diff -puN arch/arm26/kernel/armksyms.c~spinlock-protect-pm_idle arch/arm26/kernel/armksyms.c
--- vanilla-linux-2.6.7-SKAS/arch/arm26/kernel/armksyms.c~spinlock-protect-pm_idle	2004-08-17 21:00:33.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/arch/arm26/kernel/armksyms.c	2004-08-17 21:04:06.000000000 +0200
@@ -115,6 +115,7 @@ EXPORT_SYMBOL(disable_irq);
 EXPORT_SYMBOL(set_irq_type);
 EXPORT_SYMBOL(pm_idle);
 EXPORT_SYMBOL(pm_power_off);
+EXPORT_SYMBOL(pm_idle_lock);
 
 	/* processor dependencies */
 EXPORT_SYMBOL(__machine_arch_type);
diff -puN arch/sparc/kernel/sparc_ksyms.c~spinlock-protect-pm_idle arch/sparc/kernel/sparc_ksyms.c
--- vanilla-linux-2.6.7-SKAS/arch/sparc/kernel/sparc_ksyms.c~spinlock-protect-pm_idle	2004-08-17 21:00:34.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/arch/sparc/kernel/sparc_ksyms.c	2004-08-17 21:04:06.000000000 +0200
@@ -323,3 +323,4 @@ EXPORT_SYMBOL(do_BUG);
 
 /* Sun Power Management Idle Handler */
 EXPORT_SYMBOL(pm_idle);
+EXPORT_SYMBOL(pm_idle_lock);
diff -puN arch/x86_64/kernel/x8664_ksyms.c~spinlock-protect-pm_idle arch/x86_64/kernel/x8664_ksyms.c
--- vanilla-linux-2.6.7-SKAS/arch/x86_64/kernel/x8664_ksyms.c~spinlock-protect-pm_idle	2004-08-17 21:00:34.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/arch/x86_64/kernel/x8664_ksyms.c	2004-08-17 21:04:06.000000000 +0200
@@ -61,6 +61,7 @@ EXPORT_SYMBOL(probe_irq_mask);
 EXPORT_SYMBOL(kernel_thread);
 EXPORT_SYMBOL(pm_idle);
 EXPORT_SYMBOL(pm_power_off);
+EXPORT_SYMBOL(pm_idle_lock);
 EXPORT_SYMBOL(get_cmos_time);
 
 EXPORT_SYMBOL_NOVERS(__down_failed);
diff -puN arch/sparc/kernel/pmc.c~spinlock-protect-pm_idle arch/sparc/kernel/pmc.c
--- vanilla-linux-2.6.7-SKAS/arch/sparc/kernel/pmc.c~spinlock-protect-pm_idle	2004-08-17 21:00:34.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/arch/sparc/kernel/pmc.c	2004-08-17 21:04:06.000000000 +0200
@@ -85,7 +85,9 @@ sbus_done:
 
 #ifndef PMC_NO_IDLE
 	/* Assign power management IDLE handler */
+	lock_pm_idle();
 	pm_idle = pmc_swift_idle;	
+	unlock_pm_idle();
 #endif
 
 	printk(KERN_INFO "%s: power management initialized\n", PMC_DEVNAME);
diff -puN arch/sparc/kernel/apc.c~spinlock-protect-pm_idle arch/sparc/kernel/apc.c
--- vanilla-linux-2.6.7-SKAS/arch/sparc/kernel/apc.c~spinlock-protect-pm_idle	2004-08-17 21:00:34.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/arch/sparc/kernel/apc.c	2004-08-17 21:04:06.000000000 +0200
@@ -170,8 +170,11 @@ sbus_done:
 	}
 
 	/* Assign power management IDLE handler */
-	if(!apc_no_idle)
+	if(!apc_no_idle) {
+		lock_pm_idle();
 		pm_idle = apc_swift_idle;	
+		unlock_pm_idle();
+	}
 
 	printk(KERN_INFO "%s: power management initialized%s\n", 
 		APC_DEVNAME, apc_no_idle ? " (CPU idle disabled)" : "");
diff -puN arch/cris/kernel/crisksyms.c~spinlock-protect-pm_idle arch/cris/kernel/crisksyms.c
--- vanilla-linux-2.6.7-SKAS/arch/cris/kernel/crisksyms.c~spinlock-protect-pm_idle	2004-08-17 21:05:13.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/arch/cris/kernel/crisksyms.c	2004-08-17 21:06:28.000000000 +0200
@@ -38,6 +38,8 @@ EXPORT_SYMBOL(disable_irq);
 EXPORT_SYMBOL(kernel_thread);
 EXPORT_SYMBOL(get_cmos_time);
 EXPORT_SYMBOL(loops_per_usec);
+EXPORT_SYMBOL(pm_idle);
+EXPORT_SYMBOL(pm_idle_lock);
 
 /* String functions */
 EXPORT_SYMBOL(memcmp);
_

--Boundary-00=_mXNJBb+/6H9HyDb--

