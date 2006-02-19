Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbWBSXoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWBSXoj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 18:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWBSXoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 18:44:39 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20656 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932448AbWBSXoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 18:44:37 -0500
Date: Mon, 20 Feb 2006 00:42:12 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Matthias Hensler <matthias@wspse.de>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: suspend2 review [was Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)]
Message-ID: <20060219234212.GA1762@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060211104130.GA28282@kobayashi-maru.wspse.de> <20060218142610.GT3490@openzaurus.ucw.cz> <200602200709.17955.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602200709.17955.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > > The only con I see is the complexity of the code, but then again, Nigel
> >
> > ..but thats a big con.
> 
> It's fud. Hopefully as I post more suspend2 patches to LKML, people will see 
> that Suspend2 is simpler than what you are planning.

Well, good luck with that. But since you claimed I'm spreading FUD, I
think I'll have to go through your patch.

Ouch, it is 500KB, 19K lines. How can you claim it is not complex?!

Lets see what can be done in userspace from that big patch.

diff -ruN linux-2.6.15-1/arch/arm/kernel/signal.c build-2.6.15.1/arch/arm/kernel/signal.c
--- linux-2.6.15-1/arch/arm/kernel/signal.c	2006-01-03 15:08:24.000000000 +1000
+++ build-2.6.15.1/arch/arm/kernel/signal.c	2006-01-23 21:38:28.000000000 +1000
@@ -637,7 +637,7 @@
 	if (!user_mode(regs))
 		return 0;
 
-	if (try_to_freeze())
+	if (try_todo_list())
 		goto no_signal;
 
 	if (current->ptrace & PT_SINGLESTEP)

Unrelated to suspend2; either push it or drop it. [There are more such
changes, even for architectures you do not support suspend on... or do
you support suspend on h8300?]

diff -ruN linux-2.6.15-1/arch/frv/kernel/signal.c build-2.6.15.1/arch/frv/kernel/signal.c
diff -ruN linux-2.6.15-1/arch/h8300/kernel/signal.c build-2.6.15.1/arch/h8300/kernel/signal.c
diff -ruN linux-2.6.15-1/arch/i386/kernel/io_apic.c build-2.6.15.1/arch/i386/kernel/io_apic.c
diff -ruN linux-2.6.15-1/arch/i386/kernel/signal.c build-2.6.15.1/arch/i386/kernel/signal.c

Same here.

diff -ruN linux-2.6.15-1/arch/arm/mm/init.c build-2.6.15.1/arch/arm/mm/init.c

Ok, so you support arm.

diff -ruN linux-2.6.15-1/arch/i386/kernel/time.c build-2.6.15.1/arch/i386/kernel/time.c
--- linux-2.6.15-1/arch/i386/kernel/time.c	2006-01-03 15:08:25.000000000 +1000
+++ build-2.6.15.1/arch/i386/kernel/time.c	2006-01-23 21:38:28.000000000 +1000
@@ -372,7 +372,8 @@
 	mod_timer(&sync_cmos_timer, jiffies + 1);
 }
 
-static long clock_cmos_diff, sleep_start;
+static long clock_cmos_diff;
+static unsigned long sleep_start;
 
 static struct timer_opts *last_timer;
 static int timer_suspend(struct sys_device *dev, pm_message_t state)
@@ -380,9 +381,11 @@
 	/*
 	 * Estimate time zone so that set_time can update the clock
 	 */
-	clock_cmos_diff = -get_cmos_time();
+	long cmos_time = __get_cmos_time();
+	
+	clock_cmos_diff = -cmos_time;
 	clock_cmos_diff += get_seconds();
-	sleep_start = get_cmos_time();
+	sleep_start = cmos_time;
 	last_timer = cur_timer;
 	cur_timer = &timer_none;
 	if (last_timer->suspend)
@@ -395,14 +398,16 @@
 	unsigned long flags;
 	unsigned long sec;
 	unsigned long sleep_length;
+	unsigned long cmos_time;
 
 #ifdef CONFIG_HPET_TIMER
 	if (is_hpet_enabled())
 		hpet_reenable();
 #endif
+	cmos_time = get_cmos_time();
+	sec = cmos_time + clock_cmos_diff;
+	sleep_length = (cmos_time - sleep_start) * HZ;
 	setup_pit_timer();
-	sec = get_cmos_time() + clock_cmos_diff;
-	sleep_length = (get_cmos_time() - sleep_start) * HZ;
 	write_seqlock_irqsave(&xtime_lock, flags);
 	xtime.tv_sec = sec;
 	xtime.tv_nsec = 0;

What problem does it solve? Do you want it in mainline? Unrelated to
suspend2.

diff -ruN linux-2.6.15-1/arch/i386/mm/init.c build-2.6.15.1/arch/i386/mm/init.c
diff -ruN linux-2.6.15-1/arch/m32r/kernel/signal.c build-2.6.15.1/arch/m32r/kernel/signal.c
diff -ruN linux-2.6.15-1/arch/mips/kernel/irixsig.c build-2.6.15.1/arch/mips/kernel/irixsig.c
diff -ruN linux-2.6.15-1/arch/mips/kernel/signal32.c build-2.6.15.1/arch/mips/kernel/signal32.c
diff -ruN linux-2.6.15-1/arch/powerpc/kernel/signal_32.c build-2.6.15.1/arch/powerpc/kernel/signal_32.c
diff -ruN linux-2.6.15-1/arch/ppc/mm/init.c build-2.6.15.1/arch/ppc/mm/init.c
diff -ruN linux-2.6.15-1/arch/ppc/platforms/pmac_feature.c build-2.6.15.1/arch/ppc/platforms/pmac_feature.c
diff -ruN linux-2.6.15-1/arch/sh/kernel/signal.c build-2.6.15.1/arch/sh/kernel/signal.c
diff -ruN linux-2.6.15-1/arch/sh64/kernel/signal.c build-2.6.15.1/arch/sh64/kernel/signal.c
diff -ruN linux-2.6.15-1/arch/x86_64/kernel/asm-offsets.c build-2.6.15.1/arch/x86_64/kernel/asm-offsets.c
--- linux-2.6.15-1/arch/x86_64/kernel/asm-offsets.c	2006-01-03 15:08:25.000000000 +1000
+++ build-2.6.15.1/arch/x86_64/kernel/asm-offsets.c	2006-01-23 21:38:28.000000000 +1000
@@ -61,8 +61,10 @@
 	       offsetof (struct rt_sigframe32, uc.uc_mcontext));
 	BLANK();
 #endif
+#ifdef CONFIG_PM
 	DEFINE(pbe_address, offsetof(struct pbe, address));
 	DEFINE(pbe_orig_address, offsetof(struct pbe, orig_address));
 	DEFINE(pbe_next, offsetof(struct pbe, next));
+#endif
 	return 0;
 }

Do we want this in mailine?

diff -ruN linux-2.6.15-1/arch/x86_64/kernel/e820.c build-2.6.15.1/arch/x86_64/kernel/e820.c
diff -ruN linux-2.6.15-1/arch/x86_64/kernel/signal.c build-2.6.15.1/arch/x86_64/kernel/signal.c

diff -ruN linux-2.6.15-1/arch/x86_64/kernel/suspend.c build-2.6.15.1/arch/x86_64/kernel/suspend.c

With uswsusp, you are using existing code...

--- linux-2.6.15-1/arch/x86_64/kernel/suspend.c	2006-01-03 15:08:25.000000000 +1000
+++ build-2.6.15.1/arch/x86_64/kernel/suspend.c	2006-01-23 21:38:28.000000000 +1000
@@ -141,7 +144,7 @@
 
 }
 
-#ifdef CONFIG_SOFTWARE_SUSPEND
+#if defined(CONFIG_SOFTWARE_SUSPEND)
 /* Defined in arch/x86_64/kernel/suspend_asm.S */
 extern int restore_image(void);
 
@@ -220,4 +223,5 @@
 	restore_image();
 	return 0;
 }
+
 #endif /* CONFIG_SOFTWARE_SUSPEND */

Why such spurious changes?

diff -ruN linux-2.6.15-1/arch/x86_64/kernel/time.c build-2.6.15.1/arch/x86_64/kernel/time.c
--- linux-2.6.15-1/arch/x86_64/kernel/time.c	2006-01-03 15:08:25.000000000 +1000
+++ build-2.6.15.1/arch/x86_64/kernel/time.c	2006-01-23 21:38:28.000000000 +1000
@@ -509,11 +509,56 @@
 	return cycles_2_ns(a);
 }
 
+unsigned long __get_cmos_time(void)
+{
+	unsigned int year, mon, day, hour, min, sec;
+
+	/*
+	 * Do we need the spinlock in here too?
+	 *
+	 * If we're called directly (not via get_cmos_time),
+	 * we're in the middle of a sysdev suspend/resume
+	 * and interrupts are disabled, so this 
+	 * should be safe without any locking.
+	 * 				-- NC
+	 */
+
+	do {
+		sec = CMOS_READ(RTC_SECONDS);
+		min = CMOS_READ(RTC_MINUTES);
+		hour = CMOS_READ(RTC_HOURS);
+		day = CMOS_READ(RTC_DAY_OF_MONTH);
+		mon = CMOS_READ(RTC_MONTH);
+		year = CMOS_READ(RTC_YEAR);
+	} while (sec != CMOS_READ(RTC_SECONDS));
+
+	/*
+	 * We know that x86-64 always uses BCD format, no need to check the config
+	 * register.
+	 */
+
+	BCD_TO_BIN(sec);
+	BCD_TO_BIN(min);
+	BCD_TO_BIN(hour);
+	BCD_TO_BIN(day);
+	BCD_TO_BIN(mon);
+	BCD_TO_BIN(year);
+
+	/*
+	 * This will work up to Dec 31, 2069.
+	 */
+
+	if ((year += 1900) < 1970)
+		year += 100;
+
+	return mktime(year, mon, day, hour, min, sec);
+}
+
 unsigned long get_cmos_time(void)
 {
-	unsigned int timeout, year, mon, day, hour, min, sec;
+	unsigned int timeout;
 	unsigned char last, this;
-	unsigned long flags;
+	unsigned long flags, result;
 
 /*
  * The Linux interpretation of the CMOS clock register contents: When the
@@ -534,39 +579,10 @@
 		timeout--;
 	}
 
-/*
- * Here we are safe to assume the registers won't change for a whole second, so
- * we just go ahead and read them.
-	 */
-
-		sec = CMOS_READ(RTC_SECONDS);
-		min = CMOS_READ(RTC_MINUTES);
-		hour = CMOS_READ(RTC_HOURS);
-		day = CMOS_READ(RTC_DAY_OF_MONTH);
-		mon = CMOS_READ(RTC_MONTH);
-		year = CMOS_READ(RTC_YEAR);
-
+	result =  __get_cmos_time();
 	spin_unlock_irqrestore(&rtc_lock, flags);
 
-/*
- * We know that x86-64 always uses BCD format, no need to check the config
- * register.
- */
-
-	    BCD_TO_BIN(sec);
-	    BCD_TO_BIN(min);
-	    BCD_TO_BIN(hour);
-	    BCD_TO_BIN(day);
-	    BCD_TO_BIN(mon);
-	    BCD_TO_BIN(year);
-
-/*
- * x86-64 systems only exists since 2002.
- * This will work up to Dec 31, 2100
- */
-	year += 2000;
-
-	return mktime(year, mon, day, hour, min, sec);
+	return result;
 }
 
 #ifdef CONFIG_CPU_FREQ
@@ -1004,7 +1020,7 @@
 	/*
 	 * Estimate time zone so that set_time can update the clock
 	 */
-	long cmos_time =  get_cmos_time();
+	long cmos_time =  __get_cmos_time();
 
 	clock_cmos_diff = -cmos_time;
 	clock_cmos_diff += get_seconds();

What does this do? Seems independend from rest of suspend2.

diff -ruN linux-2.6.15-1/arch/x86_64/mm/init.c build-2.6.15.1/arch/x86_64/mm/init.c
diff -ruN linux-2.6.15-1/block/ll_rw_blk.c build-2.6.15.1/block/ll_rw_blk.c
diff -ruN linux-2.6.15-1/crypto/deflate.c build-2.6.15.1/crypto/deflate.c
--- linux-2.6.15-1/crypto/deflate.c	2006-01-03 15:08:25.000000000 +1000
+++ build-2.6.15.1/crypto/deflate.c	2006-01-23 21:38:28.000000000 +1000
@@ -143,8 +143,15 @@
 
 	ret = zlib_deflate(stream, Z_FINISH);
 	if (ret != Z_STREAM_END) {
-		ret = -EINVAL;
-		goto out;
+	    	if (!(ret == Z_OK && !stream->avail_in && !stream->avail_out)) {
+			ret = -EINVAL;
+			goto out;
+		} else {
+			u8 zerostuff = 0;
+			stream->next_out = &zerostuff;
+			stream->avail_out = 1; 
+			ret = zlib_deflate(stream, Z_FINISH);
+		}
 	}
 	ret = 0;
 	*dlen = stream->total_out;

WTF is this?

diff -ruN linux-2.6.15-1/crypto/Kconfig build-2.6.15.1/crypto/Kconfig
--- linux-2.6.15-1/crypto/Kconfig	2006-01-03 15:08:25.000000000 +1000
+++ build-2.6.15.1/crypto/Kconfig	2006-01-23 21:38:28.000000000 +1000
@@ -285,6 +285,13 @@
 	  
 	  You will most probably want this if using IPSec.
 
+config CRYPTO_LZF
+	tristate "LZF compression algorithm"
+	depends on CRYPTO
+	help
+	  This is the LZF algorithm. It is especially useful for Suspend2,
+	  because it achieves good compression quickly.
+
 config CRYPTO_MICHAEL_MIC
 	tristate "Michael MIC keyed digest algorithm"
 	depends on CRYPTO
diff -ruN linux-2.6.15-1/crypto/lzf.c build-2.6.15.1/crypto/lzf.c
diff -ruN linux-2.6.15-1/crypto/Makefile build-2.6.15.1/crypto/Makefile

With uswsusp, LZF can stay in userspace.

diff -ruN linux-2.6.15-1/Documentation/kernel-parameters.txt build-2.6.15.1/Documentation/kernel-parameters.txt
--- linux-2.6.15-1/Documentation/kernel-parameters.txt	2006-01-03 15:08:24.000000000 +1000
+++ build-2.6.15.1/Documentation/kernel-parameters.txt	2006-01-23 21:38:28.000000000 +1000
@@ -71,6 +71,7 @@
 	SERIAL	Serial support is enabled.
 	SMP	The kernel is an SMP kernel.
 	SPARC	Sparc architecture is enabled.
+	SUSPEND2 Suspend2 is enabled.
 	SWSUSP	Software suspend is enabled.
 	TS	Appropriate touchscreen support is enabled.
 	USB	USB support is enabled.
@@ -966,6 +967,8 @@
 	noresume	[SWSUSP] Disables resume and restores original swap
 			space.
 
+	noresume2	[SUSPEND2] Disables resuming and restores original swap signature.
+ 
 	no-scroll	[VGA] Disables scrollback.
 			This is required for the Braillex ib80-piezo Braille
 			reader made by F.H. Papenmeier (Germany).

...and kernel parameters do not need to change...
diff -ruN linux-2.6.15-1/Documentation/power/internals.txt build-2.6.15.1/Documentation/power/internals.txt
--- linux-2.6.15-1/Documentation/power/internals.txt	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/Documentation/power/internals.txt	2006-01-23 21:38:28.000000000 +1000
+    Plugins are linked together in pipeline fashion. There may be zero or more
+    page transformers in a pipeline, and there is always exactly one writer.
+    The pipeline follows this pattern:
+
+		---------------------------------
+		|          Suspend2 Core        
+		---------------------------------

Notice missing '|'

+				|
+				|
+		---------------------------------
+		|	Page transformer 1	|
+		---------------------------------
+				|
+				|
+		---------------------------------
+		|	Page transformer 2	|
+		---------------------------------
+				|
+				|
+		---------------------------------
+		|            Writer		|
+		---------------------------------

Also notice that with uswsusp, this pipeline can stay in userspace.

diff -ruN linux-2.6.15-1/Documentation/power/kernel_threads.txt build-2.6.15.1/Documentation/power/kernel_threads.txt
diff -ruN linux-2.6.15-1/Documentation/power/suspend2.txt build-2.6.15.1/Documentation/power/suspend2.txt

...and extensive documentation can stay with userspace tools.

diff -ruN linux-2.6.15-1/Documentation/power/swsusp.txt build-2.6.15.1/Documentation/power/swsusp.txt
diff -ruN linux-2.6.15-1/drivers/acpi/osl.c build-2.6.15.1/drivers/acpi/osl.c
--- linux-2.6.15-1/drivers/acpi/osl.c	2006-01-03 15:08:26.000000000 +1000
+++ build-2.6.15.1/drivers/acpi/osl.c	2006-01-23 21:38:28.000000000 +1000
@@ -91,7 +91,7 @@
 		       "Access to PCI configuration space unavailable\n");
 		return AE_NULL_ENTRY;
 	}
-	kacpid_wq = create_singlethread_workqueue("kacpid");
+	kacpid_wq = create_nofreeze_singlethread_workqueue("kacpid");
 	BUG_ON(!kacpid_wq);
 
 	return AE_OK;

Big search and replace all over the tree. Changes the default to
unsafe one. Do you ever listen to comments?

diff -ruN linux-2.6.15-1/drivers/acpi/sleep/proc.c build-2.6.15.1/drivers/acpi/sleep/proc.c
diff -ruN linux-2.6.15-1/drivers/base/power/resume.c build-2.6.15.1/drivers/base/power/resume.c
--- linux-2.6.15-1/drivers/base/power/resume.c	2006-01-03 15:08:26.000000000 +1000
+++ build-2.6.15.1/drivers/base/power/resume.c	2006-01-23 21:38:28.000000000 +1000
@@ -101,6 +101,11 @@
 		list_del_init(entry);
 		list_add_tail(entry, &dpm_active);
 		resume_device(dev);
+		if (!irqs_disabled()) {
+			printk("WARNING: Interrupts reenabled while resuming sysdev driver %s.\n",
+			kobject_name(&dev->kobj));
+			local_irq_disable();
+		}
 		put_device(dev);
 	}
 }

Nothing to do with suspend2. Either it is good idea or it is not, and
I think I saw mails telling you it is not.

diff -ruN linux-2.6.15-1/drivers/base/power/suspend.c build-2.6.15.1/drivers/base/power/suspend.c
diff -ruN linux-2.6.15-1/drivers/base/sys.c build-2.6.15.1/drivers/base/sys.c

...but you still keep the bad patches in your tree.

diff -ruN linux-2.6.15-1/drivers/block/pktcdvd.c build-2.6.15.1/drivers/block/pktcdvd.c

diff -ruN linux-2.6.15-1/drivers/char/agp/agp_suspend.h build-2.6.15.1/drivers/char/agp/agp_suspend.h
diff -ruN linux-2.6.15-1/drivers/char/agp/ati-agp.c build-2.6.15.1/drivers/char/agp/ati-agp.c
diff -ruN linux-2.6.15-1/drivers/char/agp/nvidia-agp.c build-2.6.15.1/drivers/char/agp/nvidia-agp.c

AGP stuff is independed with rest of code. Ahha, it was probably
included in latest trees, but your diff is still against 2.6.15.

diff -ruN linux-2.6.15-1/drivers/char/hvc_console.c build-2.6.15.1/drivers/char/hvc_console.c
diff -ruN linux-2.6.15-1/drivers/char/hvcs.c build-2.6.15.1/drivers/char/hvcs.c
diff -ruN linux-2.6.15-1/drivers/ieee1394/ieee1394_core.c build-2.6.15.1/drivers/ieee1394/ieee1394_core.c
diff -ruN linux-2.6.15-1/drivers/ieee1394/nodemgr.c build-2.6.15.1/drivers/ieee1394/nodemgr.c
diff -ruN linux-2.6.15-1/drivers/input/gameport/gameport.c build-2.6.15.1/drivers/input/gameport/gameport.c
diff -ruN linux-2.6.15-1/drivers/input/serio/serio.c build-2.6.15.1/drivers/input/serio/serio.c
--- linux-2.6.15-1/drivers/input/serio/serio.c	2006-01-03 15:08:26.000000000 +1000
+++ build-2.6.15.1/drivers/input/serio/serio.c	2006-01-23 21:38:28.000000000 +1000
@@ -314,6 +314,12 @@
 
 		serio_remove_duplicate_events(event);
 		serio_free_event(event);
+
+		if (unlikely(todo_list_active())) {
+  			up(&serio_sem);
+			try_todo_list();
+  			down(&serio_sem);
+		}
 	}
 
 	up(&serio_sem);

What is this?

diff -ruN linux-2.6.15-1/drivers/macintosh/Kconfig build-2.6.15.1/drivers/macintosh/Kconfig
--- linux-2.6.15-1/drivers/macintosh/Kconfig	2006-01-03 15:08:26.000000000 +1000
+++ build-2.6.15.1/drivers/macintosh/Kconfig	2006-01-23 21:38:28.000000000 +1000
@@ -192,4 +192,8 @@
 	tristate "Support for ANS LCD display"
 	depends on ADB_CUDA && PPC_PMAC
 
+config SOFTWARE_REPLACE_SLEEP
+	bool "Using Software suspend replace broken sleep function"
+	depends on SUSPEND2
+
 endmenu

If sleep function is broken, why would you ever want it enabled? Why
does this need to be configurable?

diff -ruN linux-2.6.15-1/drivers/macintosh/therm_adt746x.c build-2.6.15.1/drivers/macintosh/therm_adt746x.c
diff -ruN linux-2.6.15-1/drivers/macintosh/via-pmu.c build-2.6.15.1/drivers/macintosh/via-pmu.c
diff -ruN linux-2.6.15-1/drivers/md/dm-crypt.c build-2.6.15.1/drivers/md/dm-crypt.c
diff -ruN linux-2.6.15-1/drivers/md/md.c build-2.6.15.1/drivers/md/md.c
diff -ruN linux-2.6.15-1/drivers/media/dvb/dvb-core/dvb_frontend.c build-2.6.15.1/drivers/media/dvb/dvb-core/dvb_frontend.c
diff -ruN linux-2.6.15-1/drivers/media/video/msp3400.c build-2.6.15.1/drivers/media/video/msp3400.c
diff -ruN linux-2.6.15-1/drivers/media/video/tvaudio.c build-2.6.15.1/drivers/media/video/tvaudio.c
diff -ruN linux-2.6.15-1/drivers/media/video/video-buf-dvb.c build-2.6.15.1/drivers/media/video/video-buf-dvb.c
diff -ruN linux-2.6.15-1/drivers/net/8139too.c build-2.6.15.1/drivers/net/8139too.c
diff -ruN linux-2.6.15-1/drivers/net/irda/sir_kthread.c build-2.6.15.1/drivers/net/irda/sir_kthread.c
--- linux-2.6.15-1/drivers/net/irda/sir_kthread.c	2006-01-03 15:08:29.000000000 +1000
+++ build-2.6.15.1/drivers/net/irda/sir_kthread.c	2006-01-23 21:38:28.000000000 +1000
@@ -112,6 +112,7 @@
 	DECLARE_WAITQUEUE(wait, current);
 
 	daemonize("kIrDAd");
+	current->flags |= PF_NOFREEZE;
 
 	irda_rq_queue.thread = current;
 
@@ -134,9 +135,6 @@
 			__set_task_state(current, TASK_RUNNING);
 		remove_wait_queue(&irda_rq_queue.kick, &wait);
 
-		/* make swsusp happy with our thread */
-		try_to_freeze();
-
 		run_irda_queue();
 	}
 

Why do you need irda threads running during suspend?

diff -ruN linux-2.6.15-1/drivers/net/irda/stir4200.c build-2.6.15.1/drivers/net/irda/stir4200.c
diff -ruN linux-2.6.15-1/drivers/net/wireless/airo.c build-2.6.15.1/drivers/net/wireless/airo.c
diff -ruN linux-2.6.15-1/drivers/pcmcia/cs.c build-2.6.15.1/drivers/pcmcia/cs.c
diff -ruN linux-2.6.15-1/drivers/pnp/pnpbios/core.c build-2.6.15.1/drivers/pnp/pnpbios/core.c
diff -ruN linux-2.6.15-1/drivers/scsi/hosts.c build-2.6.15.1/drivers/scsi/hosts.c
diff -ruN linux-2.6.15-1/drivers/scsi/lpfc/lpfc_init.c build-2.6.15.1/drivers/scsi/lpfc/lpfc_init.c
diff -ruN linux-2.6.15-1/drivers/usb/core/hub.c build-2.6.15.1/drivers/usb/core/hub.c
diff -ruN linux-2.6.15-1/drivers/usb/gadget/file_storage.c build-2.6.15.1/drivers/usb/gadget/file_storage.c
diff -ruN linux-2.6.15-1/drivers/usb/net/pegasus.c build-2.6.15.1/drivers/usb/net/pegasus.c
diff -ruN linux-2.6.15-1/drivers/usb/storage/usb.c build-2.6.15.1/drivers/usb/storage/usb.c
diff -ruN linux-2.6.15-1/drivers/w1/w1.c build-2.6.15.1/drivers/w1/w1.c
diff -ruN linux-2.6.15-1/fs/afs/kafsasyncd.c build-2.6.15.1/fs/afs/kafsasyncd.c
diff -ruN linux-2.6.15-1/fs/afs/kafstimod.c build-2.6.15.1/fs/afs/kafstimod.c
diff -ruN linux-2.6.15-1/fs/jbd/journal.c build-2.6.15.1/fs/jbd/journal.c
diff -ruN linux-2.6.15-1/fs/jffs/intrep.c build-2.6.15.1/fs/jffs/intrep.c
diff -ruN linux-2.6.15-1/fs/jffs2/background.c build-2.6.15.1/fs/jffs2/background.c
diff -ruN linux-2.6.15-1/fs/jfs/jfs_logmgr.c build-2.6.15.1/fs/jfs/jfs_logmgr.c
diff -ruN linux-2.6.15-1/fs/jfs/jfs_txnmgr.c build-2.6.15.1/fs/jfs/jfs_txnmgr.c
diff -ruN linux-2.6.15-1/fs/lockd/clntlock.c build-2.6.15.1/fs/lockd/clntlock.c
diff -ruN linux-2.6.15-1/fs/lockd/clntproc.c build-2.6.15.1/fs/lockd/clntproc.c
diff -ruN linux-2.6.15-1/fs/lockd/svc.c build-2.6.15.1/fs/lockd/svc.c
diff -ruN linux-2.6.15-1/fs/xfs/linux-2.6/xfs_buf.c build-2.6.15.1/fs/xfs/linux-2.6/xfs_buf.c
diff -ruN linux-2.6.15-1/fs/xfs/linux-2.6/xfs_super.c build-2.6.15.1/fs/xfs/linux-2.6/xfs_super.c

So you run big search & replace all over the tree, making your diff
huge. Either drop them or merge them...

diff -ruN linux-2.6.15-1/include/asm-arm/hw_irq.h build-2.6.15.1/include/asm-arm/hw_irq.h
--- linux-2.6.15-1/include/asm-arm/hw_irq.h	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/include/asm-arm/hw_irq.h	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,4 @@
+#ifndef __ASM_HARDIRQ_H
+#define __ASM_HARDIRQ_H
+#include <asm/hardirq.h>
+#endif

What does this have to do with suspend2?

diff -ruN linux-2.6.15-1/include/asm-arm/suspend2.h build-2.6.15.1/include/asm-arm/suspend2.h
diff -ruN linux-2.6.15-1/include/asm-i386/mach-default/mach_time.h build-2.6.15.1/include/asm-i386/mach-default/mach_time.h
diff -ruN linux-2.6.15-1/include/asm-i386/suspend2.h build-2.6.15.1/include/asm-i386/suspend2.h
--- linux-2.6.15-1/include/asm-i386/suspend2.h	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/include/asm-i386/suspend2.h	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,288 @@
+ /*
+  * Copyright 2003-2005 Nigel Cunningham <nigel@suspend2.net>
+  * Based on code
+  * Copyright 2001-2002 Pavel Machek <pavel@suse.cz>
+  * Based on code
+  * Copyright 2001 Patrick Mochel <mochel@osdl.org>
+  */
+#include <linux/irq.h>
+#include <asm/desc.h>
+#include <asm/i387.h>
+#include <asm/tlbflush.h>
+#include <asm/desc.h>
+#include <asm/processor.h>
+
+/* image of the saved processor states */
+struct suspend2_saved_context {
+	u32 eax, ebx, ecx, edx;
+	u32 esp, ebp, esi, edi;
+	u16 es, fs, gs, ss;
+	u32 cr0, cr2, cr3, cr4;
+	u16 gdt_pad;
+	u16 gdt_limit;
+	u32 gdt_base;
+	u16 idt_pad;
+	u16 idt_limit;
+	u32 idt_base;
+	u16 ldt;
+	u16 tss;
+	u32 tr;
+	u32 safety;
+	u32 return_address;
+	u32 eflags;
+} __attribute__((packed));
+typedef struct suspend2_saved_context suspend2_saved_context_t;
+
+/* temporary storage */
+extern struct suspend2_saved_context suspend2_saved_context;
+
+/*
+ * save_processor_context
+ * 
+ * Save the state of the processor before we go to sleep.
+ *
+ * return_stack is the value of the stack pointer (%esp) as the caller sees it.
+ * A good way could not be found to obtain it from here (don't want to make
+ * _too_ many assumptions about the layout of the stack this far down.) Also,
+ * the handy little __builtin_frame_pointer(level) where level > 0, is blatantly
+ * buggy - it returns the value of the stack at the proper location, not the 
+ * location, like it should (as of gcc 2.91.66)
+ * 
+ * Note that the context and timing of this function is pretty critical.
+ * With a minimal amount of things going on in the caller and in here, gcc
+ * does a good job of being just a dumb compiler.  Watch the assembly output
+ * if anything changes, though, and make sure everything is going in the right
+ * place. 
+ */
+static inline void suspend2_arch_save_processor_context(void)
+{
+	kernel_fpu_begin();
+
+	/*
+	 * descriptor tables
+	 */
+	asm volatile ("sgdt (%0)" : "=m" (suspend2_saved_context.gdt_limit));
+	asm volatile ("sidt (%0)" : "=m" (suspend2_saved_context.idt_limit));
+	asm volatile ("sldt (%0)" : "=m" (suspend2_saved_context.ldt));
+	asm volatile ("str (%0)"  : "=m" (suspend2_saved_context.tr));
+
+	/*
+	 * save the general registers.
+	 * note that gcc has constructs to specify output of certain registers,
+	 * but they're not used here, because it assumes that you want to modify
+	 * those registers, so it tries to be smart and save them beforehand.
+	 * It's really not necessary, and kinda fishy (check the assembly output),
+	 * so it's avoided. 
+	 */
+	asm volatile ("movl %%esp, (%0)" : "=m" (suspend2_saved_context.esp));
+	asm volatile ("movl %%eax, (%0)" : "=m" (suspend2_saved_context.eax));
+	asm volatile ("movl %%ebx, (%0)" : "=m" (suspend2_saved_context.ebx));
+	asm volatile ("movl %%ecx, (%0)" : "=m" (suspend2_saved_context.ecx));
+	asm volatile ("movl %%edx, (%0)" : "=m" (suspend2_saved_context.edx));
+	asm volatile ("movl %%ebp, (%0)" : "=m" (suspend2_saved_context.ebp));
+	asm volatile ("movl %%esi, (%0)" : "=m" (suspend2_saved_context.esi));
+	asm volatile ("movl %%edi, (%0)" : "=m" (suspend2_saved_context.edi));
+
+	/*
+	 * segment registers
+	 */
+	asm volatile ("movw %%es, %0" : "=r" (suspend2_saved_context.es));
+	asm volatile ("movw %%fs, %0" : "=r" (suspend2_saved_context.fs));
+	asm volatile ("movw %%gs, %0" : "=r" (suspend2_saved_context.gs));
+	asm volatile ("movw %%ss, %0" : "=r" (suspend2_saved_context.ss));
+
+	/*
+	 * control registers 
+	 */
+	asm volatile ("movl %%cr0, %0" : "=r" (suspend2_saved_context.cr0));
+	asm volatile ("movl %%cr2, %0" : "=r" (suspend2_saved_context.cr2));
+	asm volatile ("movl %%cr3, %0" : "=r" (suspend2_saved_context.cr3));
+	asm volatile ("movl %%cr4, %0" : "=r" (suspend2_saved_context.cr4));
+
+	/*
+	 * eflags
+	 */
+	asm volatile ("pushfl ; popl (%0)" : "=m" (suspend2_saved_context.eflags));
+}

Can't you use existing suspend functions?

Same for the rest of file...

+static inline void suspend2_arch_flush_caches(void)
+{
+#ifdef CONFIG_SMP
+	cpu_clear(0, per_cpu(cpu_tlbstate,
+				0).active_mm->cpu_vm_mask);
+#endif
+	wbinvd();
+	__flush_tlb_all();
+	
+}
+
+static inline void suspend2_arch_post_copyback(void)
+{
+	BUG_ON(!irqs_disabled());
+
+	current_cpu_data.loops_per_jiffy =
+		c_loops_per_jiffy_ref;
+#ifndef CONFIG_SMP
+	loops_per_jiffy = c_loops_per_jiffy_ref;
+	cpu_khz = cpu_khz_ref;
+#endif
+}
+
+#endif

What is this? Is your method of dealing with SMP different from
mainline's?

diff -ruN linux-2.6.15-1/include/asm-ppc/cpu_context.h build-2.6.15.1/include/asm-ppc/cpu_context.h
diff -ruN linux-2.6.15-1/include/asm-x86_64/page.h build-2.6.15.1/include/asm-x86_64/page.h
diff -ruN linux-2.6.15-1/include/asm-x86_64/suspend2.h build-2.6.15.1/include/asm-x86_64/suspend2.h

Same here. You should be able to use mainline's snapshot
functionality. That's common piece between swsusp and suspend2, and
having your own copy helps noone.

diff -ruN linux-2.6.15-1/include/asm-x86_64/suspend.h build-2.6.15.1/include/asm-x86_64/suspend.h
diff -ruN linux-2.6.15-1/include/linux/bio.h build-2.6.15.1/include/linux/bio.h
--- linux-2.6.15-1/include/linux/bio.h	2006-01-03 15:08:44.000000000 +1000
+++ build-2.6.15.1/include/linux/bio.h	2006-01-23 21:38:28.000000000 +1000
@@ -124,6 +124,7 @@
 #define BIO_BOUNCED	5	/* bio is a bounce bio */
 #define BIO_USER_MAPPED 6	/* contains user pages */
 #define BIO_EOPNOTSUPP	7	/* not supported */
+#define BIO_SUSPEND2	8	/* Suspend2 bio - for corruption checking */
 #define bio_flagged(bio, flag)	((bio)->bi_flags & (1 << (flag)))
 
 /*

You just should not corrupt the data...

diff -ruN linux-2.6.15-1/include/linux/dyn_pageflags.h build-2.6.15.1/include/linux/dyn_pageflags.h
--- linux-2.6.15-1/include/linux/dyn_pageflags.h	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/include/linux/dyn_pageflags.h	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,66 @@
+
+typedef unsigned long *** dyn_pageflags_t;
+

Eh....

Could not you just use normal page flags like swsusp does?

diff -ruN linux-2.6.15-1/include/linux/freezer.h build-2.6.15.1/include/linux/freezer.h
--- linux-2.6.15-1/include/linux/freezer.h	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/include/linux/freezer.h	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,28 @@
+/* Freezer declarations */
+
+#define FREEZER_ON 0
+#define ABORT_FREEZING 1
+
+#define FREEZER_KERNEL_THREADS 0
+#define FREEZER_ALL_THREADS 1
+
+#ifdef CONFIG_PM
+extern unsigned long freezer_state;
+
+#define test_freezer_state(bit) test_bit(bit, &freezer_state)
+#define set_freezer_state(bit) set_bit(bit, &freezer_state)
+#define clear_freezer_state(bit) clear_bit(bit, &freezer_state)
+
+#define freezer_is_on() (test_freezer_state(FREEZER_ON))
+
+extern void do_freeze_process(struct notifier_block *nl);
+
+#else
+
+#define test_freezer_state(bit) (0)
+#define set_freezer_state(bit) do { } while(0)
+#define clear_freezer_state(bit) do { } while(0)
+
+#define freezer_is_on() (0)
+
+#endif

So you have your own freezer. Can you still reproduce some failures in
mainline's freezer? There's one nasty case with vfork() we do not have
solved...

diff -ruN linux-2.6.15-1/include/linux/kernel.h build-2.6.15.1/include/linux/kernel.h
--- linux-2.6.15-1/include/linux/kernel.h	2006-01-03 15:08:45.000000000 +1000
+++ build-2.6.15.1/include/linux/kernel.h	2006-01-23 21:38:28.000000000 +1000
@@ -103,6 +103,8 @@
 	__attribute__ ((format (printf, 2, 0)));
 extern int snprintf(char * buf, size_t size, const char * fmt, ...)
 	__attribute__ ((format (printf, 3, 4)));
+extern int snprintf_used(char *buffer, int buffer_size,
+		const char *fmt, ...);
 extern int vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
 	__attribute__ ((format (printf, 3, 0)));
 extern int scnprintf(char * buf, size_t size, const char * fmt, ...)


Why do you need to modify printf-like functions?!

diff -ruN linux-2.6.15-1/include/linux/kthread.h build-2.6.15.1/include/linux/kthread.h
diff -ruN linux-2.6.15-1/include/linux/netlink.h build-2.6.15.1/include/linux/netlink.h
--- linux-2.6.15-1/include/linux/netlink.h	2006-01-03 15:08:45.000000000 +1000
+++ build-2.6.15.1/include/linux/netlink.h	2006-01-23 21:38:28.000000000 +1000
@@ -21,6 +21,8 @@
 #define NETLINK_DNRTMSG		14	/* DECnet routing messages */
 #define NETLINK_KOBJECT_UEVENT	15	/* Kernel messages to userspace */
 #define NETLINK_GENERIC		16
+#define NETLINK_SUSPEND2_USERUI	17	/* For suspend2's userui */
+#define NETLINK_SUSPEND2_USM	18	/* For suspend2's userui */
 
 #define MAX_LINKS 32		
 

Yeh, and this is exactly why uswsusp is superior.

diff -ruN linux-2.6.15-1/include/linux/sched.h build-2.6.15.1/include/linux/sched.h
diff -ruN linux-2.6.15-1/include/linux/suspend2.h build-2.6.15.1/include/linux/suspend2.h
+
+/* Debug sections  - if debugging compiled in */
+enum {
+	SUSPEND_ANY_SECTION,
+	SUSPEND_FREEZER,
+	SUSPEND_EAT_MEMORY,
+	SUSPEND_PAGESETS,
+	SUSPEND_IO,
+	SUSPEND_BMAP,
+	SUSPEND_HEADER,
+	SUSPEND_WRITER,
+	SUSPEND_MEMORY,
+	SUSPEND_EXTENTS,
+	SUSPEND_SPINLOCKS,
+	SUSPEND_MEM_POOL,
+	SUSPEND_RANGE_PARANOIA,
+	SUSPEND_NOSAVE,
+	SUSPEND_INTEGRITY
+};
+
+/* debugging levels. */
+#define SUSPEND_STATUS		0
+#define SUSPEND_ERROR		2
+#define SUSPEND_LOW	 	3
+#define SUSPEND_MEDIUM	 	4
+#define SUSPEND_HIGH	  	5
+#define SUSPEND_VERBOSE		6
+
+/* second status register */
+enum {
+	SUSPEND_REBOOT,
+	SUSPEND_PAUSE,
+	SUSPEND_SLOW,
+	SUSPEND_NOPAGESET2,
+	SUSPEND_LOGALL,
+	SUSPEND_CAN_CANCEL,
+	SUSPEND_KEEP_IMAGE,
+	SUSPEND_FREEZER_TEST,
+	SUSPEND_FREEZER_TEST_SHOWALL,
+	SUSPEND_SINGLESTEP,
+	SUSPEND_PAUSE_NEAR_PAGESET_END,
+	SUSPEND_USE_ACPI_S4,
+	SUSPEND_TEST_FILTER_SPEED,
+	SUSPEND_FREEZE_TIMERS,
+	SUSPEND_DISABLE_SYSDEV_SUPPORT,
+	SUSPEND_VGA_POST,
+	SUSPEND_TEST_BIO,
+	SUSPEND_NO_PAGESET2,
+};
+

Not sure what this does, but I surely don't like it.

+extern void __suspend_message(unsigned long section, unsigned long level, int log_normally,
+		const char *fmt, ...);
+
+#ifdef CONFIG_PM_DEBUG
+#define suspend_message(sn, lev, log, fmt, a...) \
+do { \
+	if (test_debug_state(sn)) \
+		__suspend_message(sn, lev, log, fmt, ##a); \
+} while(0)
+#else /* CONFIG_PM_DEBUG */
+#define suspend_message(sn, lev, log, fmt, a...) \
+do { \
+	if (lev == 0) \
+		__suspend_message(sn, lev, log, fmt, ##a); \
+} while(0)
+#endif /* CONFIG_PM_DEBUG */
+  
+/* Suspend 2 */

Having your own debugging infrastructure means you are doing something
wrong.

+enum {
+	SUSPEND_DISABLED,
+	SUSPEND_RUNNING,
+	SUSPEND_RESUME_DEVICE_OK,
+	SUSPEND_NORESUME_SPECIFIED,
+	SUSPEND_COMMANDLINE_ERROR,
+	SUSPEND_IGNORE_IMAGE,
+	SUSPEND_SANITY_CHECK_PROMPT,
+	SUSPEND_FREEZER_ON,
+	SUSPEND_BLOCK_PAGE_ALLOCATIONS,
+	SUSPEND_USE_MEMORY_POOL,
+	SUSPEND_STAGE2_CONTINUE,
+	SUSPEND_FREEZE_SMP,
+	SUSPEND_PAGESET2_NOT_LOADED,
+	SUSPEND_CONTINUE_REQ,
+	SUSPEND_RESUMED_BEFORE,
+	SUSPEND_RUNNING_INITRD,
+	SUSPEND_RESUME_NOT_DONE,
+	SUSPEND_BOOT_TIME,
+	SUSPEND_NOW_RESUMING,
+	SUSPEND_SLAB_ALLOC_FALLBACK,
+	SUSPEND_IGNORE_LOGLEVEL,
+	SUSPEND_TIMER_FREEZER_ON,
+	SUSPEND_ACT_USED,
+	SUSPEND_DBG_USED,
+	SUSPEND_LVL_USED,
+	SUSPEND_TRYING_TO_RESUME,
+	SUSPEND_FORK_COPYBACK_THREAD,
+	SUSPEND_TRY_RESUME_RD,
+	SUSPEND_IGNORE_ROOTFS,
+};

What's this? DBG_USED? LVL_USED?

diff -ruN linux-2.6.15-1/include/linux/suspend.h build-2.6.15.1/include/linux/suspend.h
diff -ruN linux-2.6.15-1/include/linux/workqueue.h build-2.6.15.1/include/linux/workqueue.h
diff -ruN linux-2.6.15-1/init/do_mounts.c build-2.6.15.1/init/do_mounts.c
diff -ruN linux-2.6.15-1/init/do_mounts_initrd.c build-2.6.15.1/init/do_mounts_initrd.c
--- linux-2.6.15-1/init/do_mounts_initrd.c	2006-01-03 15:08:48.000000000 +1000
+++ build-2.6.15.1/init/do_mounts_initrd.c	2006-01-23 21:38:28.000000000 +1000
@@ -7,6 +7,7 @@
 #include <linux/romfs_fs.h>
 #include <linux/initrd.h>
 #include <linux/sched.h>
+#include <linux/suspend.h>
 
 #include "do_mounts.h"
 
@@ -58,10 +59,16 @@
 
 	pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
 	if (pid > 0) {
-		while (pid != sys_wait4(-1, NULL, 0, NULL))
+		while (pid != sys_wait4(-1, NULL, 0, NULL)) {
 			yield();
+			try_to_freeze();
+		}
 	}

Not run_todo_list? Do we want this in mainline?

diff -ruN linux-2.6.15-1/init/main.c build-2.6.15.1/init/main.c
diff -ruN linux-2.6.15-1/kernel/audit.c build-2.6.15.1/kernel/audit.c
diff -ruN linux-2.6.15-1/kernel/fork.c build-2.6.15.1/kernel/fork.c
--- linux-2.6.15-1/kernel/fork.c	2006-01-03 15:08:48.000000000 +1000
+++ build-2.6.15.1/kernel/fork.c	2006-01-23 21:38:28.000000000 +1000
@@ -165,7 +166,13 @@
 	if (!tsk)
 		return NULL;
 
-	ti = alloc_thread_info(tsk);
+	if (test_suspend_state(SUSPEND_FORK_COPYBACK_THREAD)) {
+		extern void * suspend2_get_nonconflicting_pages(int);
+		ti = suspend2_get_nonconflicting_pages(get_order(THREAD_SIZE));
+		printk("Starting a copyback thread %p\n", ti);
+	} else
+		ti = alloc_thread_info(tsk);
+
 	if (!ti) {
 		free_task_struct(tsk);
 		return NULL;

With code like this (in fork!) how can you claim it is not complex?
What does copyback do, anyway?

diff -ruN linux-2.6.15-1/kernel/kmod.c build-2.6.15.1/kernel/kmod.c
diff -ruN linux-2.6.15-1/kernel/kthread.c build-2.6.15.1/kernel/kthread.c
diff -ruN linux-2.6.15-1/kernel/power/atomic_copy.c build-2.6.15.1/kernel/power/atomic_copy.c
--- linux-2.6.15-1/kernel/power/atomic_copy.c	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/kernel/power/atomic_copy.c	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,473 @@
+/*
+ */
+
+#include <linux/suspend.h>
+#include <linux/highmem.h>
+#include <linux/kthread.h>
+#include <asm/setup.h>
+#include <asm/param.h>
+#include <asm/thread_info.h>
+#include "suspend2_common.h"
+#include "io.h"
+#include "power_off.h"
+#include "version.h"
+#include "ui.h"
+#include "plugins.h"
+#include "atomic_copy.h"
+#include "suspend2.h"
+#include "checksum.h"
+#include "pageflags.h"
+#include "debug_pagealloc.h"
+#include "storage.h"
+
+#include <asm/suspend2.h>
+
+volatile static int state1 __nosavedata = 0;
+volatile static int state2 __nosavedata = 0;
+volatile static int state3 __nosavedata = 0;
+volatile static int io_speed_save[2][2] __nosavedata;
+

Heh, nice... volatile probably means you got the locking wrong, and no
it is not nice to name variables like this.

Why can't you just use existing code for atomic copy?

(~400 lines of duplicated code skipped)

diff -ruN linux-2.6.15-1/kernel/power/atomic_copy.h build-2.6.15.1/kernel/power/atomic_copy.h
diff -ruN linux-2.6.15-1/kernel/power/block_io.h build-2.6.15.1/kernel/power/block_io.h
--- linux-2.6.15-1/kernel/power/block_io.h	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/kernel/power/block_io.h	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,76 @@
+/*
+ * block_io.h
+ *
+ * Copyright 2004-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * Distributed under GPLv2.
+ *
+ * This file contains declarations for functions exported from
+ * block_io.c, which contains low level io functions.
+ */
+
+#include <linux/buffer_head.h>
+#include "extent.h"
+
+/*
+ * submit_params
+ *
+ * The structure we use for tracking submitted I/O.
+ */
+struct submit_params {
+	swp_entry_t swap_address;
+	struct page *page;
+	struct block_device *dev;
+	sector_t block[MAX_BUF_PER_PAGE];
+	int readahead_index;
+	struct submit_params *next;
+	int printme;
+};
+
+struct suspend2_bdev_info {
+	struct block_device *bdev;
+	dev_t dev_t;
+	int bmap_shift;
+	int blocks_per_page;
+};
+
+/* 
+ * Our exported interface so the swapwriter and filewriter don't
+ * need these functions duplicated.
+ */
+struct suspend_bio_ops {
+	int (*submit_io) (int rw, 
+		struct submit_params *submit_info, int syncio);
+	int (*bdev_page_io) (int rw, struct block_device *bdev, long pos,
+			struct page *page);
+	int (*rw_page) (int rw, struct page *page, int readahead_index,
+			int sync);
+	void (*wait_on_readahead) (int readahead_index);
+	void (*check_io_stats) (void);
+	void (*reset_io_stats) (void);
+	void (*finish_all_io) (void);
+	int (*prepare_readahead) (int index);
+	void (*cleanup_readahead) (int index);
+	struct page ** readahead_pages;
+	int (*readahead_ready) (int readahead_index);
+	int *need_extra_next;
+	int (*forward_one_page) (void);
+	void (*set_devinfo) (struct suspend2_bdev_info *info);
+	int (*read_init) (int stream_number);
+	int (*read_chunk) (struct page *buffer_page, int sync);
+	int (*read_cleanup) (void);
+	int (*write_init) (int stream_number);
+	int (*write_chunk) (struct page *buffer_page);
+	int (*write_cleanup) (void);
+	int (*read_header_chunk) (char *buffer, int buffer_size);
+	int (*write_header_chunk) (char *buffer, int buffer_size);
+	int (*write_header_chunk_finish) (void);
+};

So you have your own disk operations... Nothing like that is needed
with uswsusp.

diff -ruN linux-2.6.15-1/kernel/power/checksum.h build-2.6.15.1/kernel/power/checksum.h
--- linux-2.6.15-1/kernel/power/checksum.h	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/kernel/power/checksum.h	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,11 @@
+#ifdef CONFIG_SUSPEND2_CHECKSUMS
+extern void suspend2_verify_checksums(void);
+extern void suspend2_checksum_calculate_checksums(void);
+extern void suspend2_checksum_print_differences(void);
+extern int suspend2_allocate_checksum_pages(void);
+#else
+static inline void suspend2_verify_checksums(void) { };
+static inline void suspend2_checksum_calculate_checksums(void) { };
+static inline void suspend2_checksum_print_differences(void) { };
+static inline int suspend2_allocate_checksum_pages(void) { return 0; };
+#endif

...and checksums can happily live in userspace.

diff -ruN linux-2.6.15-1/kernel/power/compression.c build-2.6.15.1/kernel/power/compression.c
--- linux-2.6.15-1/kernel/power/compression.c	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/kernel/power/compression.c	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,638 @@
+/*
+ * kernel/power/suspend2_core/compression.c

Wrong filename.

+ * Copyright (C) 2003-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * This file contains data compression routines for suspend,
+ * using LZH compression.

LZF?

Snipped 600 lines of code that can happily live in userspace.

diff -ruN linux-2.6.15-1/kernel/power/debug_pagealloc.c build-2.6.15.1/kernel/power/debug_pagealloc.c
--- linux-2.6.15-1/kernel/power/debug_pagealloc.c	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/kernel/power/debug_pagealloc.c	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,111 @@
+#include <linux/mm.h>
+#ifdef CONFIG_DEBUG_PAGEALLOC
+#include <linux/page-flags.h>
+#include <asm/pgtable.h>
+
+#include "pageflags.h"
+#include "suspend2.h"
+#include "pagedir.h"


What is this code doing?
diff -ruN linux-2.6.15-1/kernel/power/debug_pagealloc.h build-2.6.15.1/kernel/power/debug_pagealloc.h
diff -ruN linux-2.6.15-1/kernel/power/disk.c build-2.6.15.1/kernel/power/disk.c
diff -ruN linux-2.6.15-1/kernel/power/encryption.c build-2.6.15.1/kernel/power/encryption.c
--- linux-2.6.15-1/kernel/power/encryption.c	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/kernel/power/encryption.c	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,597 @@
+/*
+ * kernel/power/suspend2_core/encryption.c
+ *
+ * Copyright (C) 2003-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * This file contains data encryption routines for suspend,
+ * using cryptoapi transforms.
+ *
+ * ToDo:
+ * - Apply min/max_keysize the cipher changes.
+ * - Test.
+ */

Snipped 550 lines of code that can happily live in userspace.

diff -ruN linux-2.6.15-1/kernel/power/extent.c build-2.6.15.1/kernel/power/extent.c
--- linux-2.6.15-1/kernel/power/extent.c	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/kernel/power/extent.c	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,247 @@
+/* kernel/power/suspend2_core/extent.c
+ * 
+ * (C) 2003-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * Distributed under GPLv2.
+ * 
+ * These functions encapsulate the manipulation of storage metadata. For
+ * pageflags, we use dynamically allocated bitmaps.
+ */
+

I do not know why you want to use extents; existing code seems to work
well enough. Do you get .01% speedup or what?

diff -ruN linux-2.6.15-1/kernel/power/extent.h build-2.6.15.1/kernel/power/extent.h
+
+#define extent_state_eof(state) ((state)->num_chains < (state)->current_chain)
+
+#define extent_for_each(extent_chain, extentpointer, value) \
+if ((extent_chain)->first) \
+	for ((extentpointer) = (extent_chain)->first, (value) = \
+			(extentpointer)->minimum; \
+	     ((extentpointer) && ((extentpointer)->next || (value) <= \
+				 (extentpointer)->maximum)); \
+	     (((value) == (extentpointer)->maximum) ? \
+		((extentpointer) = (extentpointer)->next, (value) = \
+		 ((extentpointer) ? (extentpointer)->minimum : 0)) : \
+			(value)++))
+
+/*
+ * When using compression and expected_compression > 0,
+ * we allocate fewer swap entries, so GET_EXTENT_NEXT can
+ * validly run out of data to return.
+ */
+#define GET_EXTENT_NEXT(currentextent, currentval) \
+{ \
+	if (currentextent) { \
+		if ((currentval) == (currentextent)->maximum) { \
+			if ((currentextent)->next) { \
+				(currentextent) = (currentextent)->next; \
+				(currentval) = (currentextent)->minimum; \
+			} else { \
+				(currentextent) = NULL; \
+				(currentval) = 0; \
+			} \
+		} else \
+			currentval++; \
+	} \
+}

Not nice at all.

diff -ruN linux-2.6.15-1/kernel/power/io.c build-2.6.15.1/kernel/power/io.c
--- linux-2.6.15-1/kernel/power/io.c	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/kernel/power/io.c	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,1025 @@
+/*
+ * kernel/power/io.c
+ *
+ * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
+ * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2002-2003 Florent Chabaud <fchabaud@free.fr>
+ * Copyright (C) 2002-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * It contains high level IO routines for suspending.
+ *
+ */

Snipped 1000 lines that can happily live in userspace. Yes, I have
similar (but way simpler) code in kernel just now. Notice I want to
remove it.

diff -ruN linux-2.6.15-1/kernel/power/io.h build-2.6.15.1/kernel/power/io.h
diff -ruN linux-2.6.15-1/kernel/power/Kconfig build-2.6.15.1/kernel/power/Kconfig
--- linux-2.6.15-1/kernel/power/Kconfig	2006-01-03 15:08:48.000000000 +1000
+++ build-2.6.15.1/kernel/power/Kconfig	2006-01-23 21:38:28.000000000 +1000
@@ -98,3 +98,76 @@
 	bool
 	depends on HOTPLUG_CPU && X86 && PM
 	default y
+
+config SUSPEND_DEBUG_PAGEALLOC
+	bool
+	depends on DEBUG_PAGEALLOC && (SOFTWARE_SUSPEND || SUSPEND2)
+	default y
+
+config SUSPEND2_CRYPTO
+	bool
+	depends on SUSPEND2 && CRYPTO
+	default y
+
+menuconfig SUSPEND2
+	bool "Suspend2"
+	select DYN_PAGEFLAGS
+	depends on PM
+	select HOTPLUG_CPU if SMP
+	---help---
+	  Suspend2 is the 'new and improved' suspend support.
+	  
+	  See the Suspend2 home page (suspend2.net)
+	  for FAQs, HOWTOs and other documentation.
+
+	comment 'Image Storage (you need at least one writer)'
+		depends on SUSPEND2
+	
+	config SUSPEND2_FILEWRITER
+		bool '  File Writer'
+		depends on SUSPEND2
+		---help---
+		  This option enables support for storing an image in a
+		  simple file. This should be possible, but we're still
+		  testing it.
+
+	config SUSPEND2_SWAPWRITER
+		bool '  Swap Writer'
+		depends on SUSPEND2
+		select SWAP
+		---help---
+		  This option enables support for storing an image in your
+		  swap space.
+
+	comment 'General Options'
+		depends on SUSPEND2
+
+	config SUSPEND2_DEFAULT_RESUME2
+		string '  Default resume device name'
+		depends on SUSPEND2
+		---help---
+		  You normally need to add a resume2= parameter to your lilo.conf or
+		  equivalent. With this option properly set, the kernel has a value
+		  to default. No damage will be done if the value is invalid.
+
+	config SUSPEND2_CHECKSUMMING
+		bool '  Checksum images - developer option (SLOW!)'
+		depends on PM_DEBUG && SUSPEND2
+		---help---
+		  This option implements checksumming of images. It is not designed
+		  for everyone to use, but as a development tool.
+
+	config SUSPEND2_KEEP_IMAGE
+		bool '  Allow Keep Image Mode'
+		depends on SUSPEND2
+		---help---
+		  This option allows you to keep and image and reuse it. It is intended
+		  __ONLY__ for use with systems where all filesystems are mounted read-
+		  only (kiosks, for example). To use it, compile this option in and boot
+		  normally. Set the KEEP_IMAGE flag in /proc/suspend2 and suspend.
+		  When you resume, the image will not be removed. You will be unable to turn
+		  off swap partitions (assuming you are using the swap writer), but future
+		  suspends simply do a power-down. The image can be updated using the
+		  kernel command line parameter suspend_act= to turn off the keep image
+		  bit. Keep image mode is a little less user friendly on purpose - it
+		  should not be used without thought!

All this configuration can and should be done in userspace. That's 70
lines.

diff -ruN linux-2.6.15-1/kernel/power/main.c build-2.6.15.1/kernel/power/main.c
diff -ruN linux-2.6.15-1/kernel/power/Makefile build-2.6.15.1/kernel/power/Makefile
diff -ruN linux-2.6.15-1/kernel/power/netlink.c build-2.6.15.1/kernel/power/netlink.c
--- linux-2.6.15-1/kernel/power/netlink.c	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/kernel/power/netlink.c	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,365 @@
+/*
+ * netlink.c
+ *
+ * Functions for communicating with a userspace helper via netlink.
+ */

With Rafael's solution, you don't need to inform userspace of your
progress -- because userspace is controlling the suspend. Snip 300
unneeded lines.

+static int suspend2_nl_gen_rcv_msg(struct user_helper_data *uhd,
+		struct sk_buff *skb, struct nlmsghdr *nlh)
+{
+	int type;
+	int *data;
+	int err;
+
+	/* Let the more specific handler go first. It returns
+	 * 1 for valid messages that it doesn't know. */
+	if ((err = uhd->rcv_msg(skb, nlh)) != 1)
+		return err;


...some of them pretty cryptic.

+static int launch_userpace_program(struct user_helper_data *uhd)
+{
+	int retval;
+	static char *envp[] = {
+			"HOME=/",
+			"TERM=linux",
+			"PATH=/sbin:/usr/sbin:/bin:/usr/bin",
+			NULL };
+	static char *argv[] = { NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL };
+	char *channel = kmalloc(6, GFP_KERNEL);
+	int arg = 0, size;
+	char test_read[255];
+	char *orig_posn = uhd->program;
+
+	if (!strlen(orig_posn))
+		return 1;
+
+	while (arg < 7) {
+		sscanf(orig_posn, "%s", test_read);
+		size = strlen(test_read);
+		if (!(size))
+			break;
+		argv[arg] = kmalloc(size + 1, GFP_ATOMIC);
+		strcpy(argv[arg], test_read);
+		orig_posn += size + 1;
+		*test_read = 0;
+		arg++;
+	}
+	
+	sprintf(channel, "-c%d", uhd->netlink_id);
+	argv[arg] = channel;
+
+	retval = call_usermodehelper(argv[0], argv, envp, 0);

It is really better if userspace calls you...

diff -ruN linux-2.6.15-1/kernel/power/netlink.h build-2.6.15.1/kernel/power/netlink.h
diff -ruN linux-2.6.15-1/kernel/power/pagedir.c build-2.6.15.1/kernel/power/pagedir.c
--- linux-2.6.15-1/kernel/power/pagedir.c	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/kernel/power/pagedir.c	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,370 @@
+/*
+ * kernel/power/pagedir.c
+ *
+ * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
+ * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2002-2003 Florent Chabaud <fchabaud@free.fr>
+ * Copyright (C) 2002-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Routines for handling pagesets.
+ * Note that pbes aren't actually stored as such. They're stored as
+ * bitmaps and extents.
+ */

You should be able to use existing snapshotting...

+#include <linux/suspend.h>
+#include <linux/highmem.h>
+#include <linux/bootmem.h>
+#include <linux/hardirq.h>
+
+#include "pageflags.h"
+#include "ui.h"
+#include "pagedir.h"
+
+int extra_pagedir_pages_allocated = 0;

Do not zero-initialize static variables.

diff -ruN linux-2.6.15-1/kernel/power/pagedir.h build-2.6.15.1/kernel/power/pagedir.h
diff -ruN linux-2.6.15-1/kernel/power/pageflags.c build-2.6.15.1/kernel/power/pageflags.c
--- linux-2.6.15-1/kernel/power/pageflags.c	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/kernel/power/pageflags.c	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,139 @@
+/*
+ * kernel/power/suspend2_core/pageflags.c

Wrong name.

+ * Copyright (C) 2004-2005 Nigel Cunningham <ncunningham@cyclades.com>
+ * 
+ * This file is released under the GPLv2.
+ *
+ * Routines for dynamically allocating and releasing bitmaps
+ * used as pseudo-pageflags.
+ *
+ * Arrays are not contiguous. The first sizeof(void *) bytes are
+ * the pointer to the next page in the bitmap. This allows us to
+ * 1) work under low memory conditions where order 0 might be all
+ *    that's available
+ * 2) save the pages at suspend time, reload and relocate them as
+ *    necessary at resume time without breaking anything (cf
+ *    extent pages).
+ */

Why do you need this?

diff -ruN linux-2.6.15-1/kernel/power/pageflags.h build-2.6.15.1/kernel/power/pageflags.h
diff -ruN linux-2.6.15-1/kernel/power/plugins.c build-2.6.15.1/kernel/power/plugins.c
--- linux-2.6.15-1/kernel/power/plugins.c	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/kernel/power/plugins.c	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,312 @@
+/*
+ * kernel/power/plugins.c
+ *
+ * Copyright (C) 2004-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ */

Oh, my favourite.. These should really be in userspace. 300 lines +
180 lines in header.

diff -ruN linux-2.6.15-1/kernel/power/plugins.h build-2.6.15.1/kernel/power/plugins.h
diff -ruN linux-2.6.15-1/kernel/power/power.h build-2.6.15.1/kernel/power/power.h
 
 
 /* References to section boundaries */
-extern const void __nosave_begin, __nosave_end;
+//extern const void __nosave_begin, __nosave_end;
 
Delete it if you want it gone...

diff -ruN linux-2.6.15-1/kernel/power/power_off.c build-2.6.15.1/kernel/power/power_off.c
--- linux-2.6.15-1/kernel/power/power_off.c	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/kernel/power/power_off.c	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,79 @@
+/*
+ * kernel/power/suspend2_core/power_off.c

Wrong name.

+void suspend_power_down(void)
+{
+	if (test_action_state(SUSPEND_REBOOT)) {
+		suspend2_prepare_status(DONT_CLEAR_BAR, "Ready to reboot.");
+		kernel_restart(NULL);
+	}

And we do not want UI code in kernel.
diff -ruN linux-2.6.15-1/kernel/power/power_off.h build-2.6.15.1/kernel/power/power_off.h
diff -ruN linux-2.6.15-1/kernel/power/prepare_image.c build-2.6.15.1/kernel/power/prepare_image.c
--- linux-2.6.15-1/kernel/power/prepare_image.c	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/kernel/power/prepare_image.c	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,753 @@
+/*
+ * kernel/power/prepare_image.c
+ *
+ * Copyright (C) 2003-2005 Nigel Cunningham <nigel@suspend.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * We need to eat memory until we can:
+ * 1. Perform the save without changing anything (RAM_NEEDED < max_pfn)
+ * 2. Fit it all in available space (active_writer->available_space() >=
+ *    storage_needed())
+ * 3. Reload the pagedir and pageset1 to places that don't collide with their
+ *    final destinations, not knowing to what extent the resumed kernel will
+ *    overlap with the one loaded at boot time. I think the resumed kernel
+ *    should overlap completely, but I don't want to rely on this as it is 
+ *    an unproven assumption. We therefore assume there will be no overlap at
+ *    all (worse case).
+ * 4. Meet the user's requested limit (if any) on the size of the image.
+ *    The limit is in MB, so pages/256 (assuming 4K pages).
+ *
+ */

There's existing code in kernel to do this, no? 

diff -ruN linux-2.6.15-1/kernel/power/prepare_image.h build-2.6.15.1/kernel/power/prepare_image.h
diff -ruN linux-2.6.15-1/kernel/power/proc.c build-2.6.15.1/kernel/power/proc.c
--- linux-2.6.15-1/kernel/power/proc.c	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/kernel/power/proc.c	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,305 @@
+/*
+ * /kernel/power/proc.c

Spurious slash?

+ * Copyright (C) 2002-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * This file contains support for proc entries for tuning Suspend2.
+ *
+ * We have a generic handler that deals with the most common cases, and
+ * hooks for special handlers to use.
+ */

Well, we probably do not want more junk in /proc. And this would not
be neccessary if (surprise) userspace controlled suspend. 300 lines
unneeeded, and 70 lines in header.

diff -ruN linux-2.6.15-1/kernel/power/process.c build-2.6.15.1/kernel/power/process.c
diff -ruN linux-2.6.15-1/kernel/power/proc.h build-2.6.15.1/kernel/power/proc.h
diff -ruN linux-2.6.15-1/kernel/power/snapshot.c build-2.6.15.1/kernel/power/snapshot.c
diff -ruN linux-2.6.15-1/kernel/power/storage.c build-2.6.15.1/kernel/power/storage.c
--- linux-2.6.15-1/kernel/power/storage.c	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/kernel/power/storage.c	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,323 @@
+/*
+ * kernel/power/storage.c
+ *
+ * Copyright (C) 2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Routines for talking to a userspace program that manages storage.
+ *
+ * The kernel side:
+ * - starts the userspace program;
+ * - sends messages telling it when to open and close the connection;
+ * - tells it when to quit;
+ *
+ * The user space side:
+ * - passes messages regarding status;

Yep, if you do it all in userspace, this vanishes. 340 lines down.


diff -ruN linux-2.6.15-1/kernel/power/storage.h build-2.6.15.1/kernel/power/storage.h
diff -ruN linux-2.6.15-1/kernel/power/suspend2_common.h build-2.6.15.1/kernel/power/suspend2_common.h
diff -ruN linux-2.6.15-1/kernel/power/suspend2.h build-2.6.15.1/kernel/power/suspend2.h
--- linux-2.6.15-1/kernel/power/suspend2.h	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/kernel/power/suspend2.h	2006-01-23 21:38:28.000000000 +1000
+
+#define KB(x) ((x) << (PAGE_SHIFT - 10))
+#define MB(x) ((x) >> (20 - PAGE_SHIFT))
+

Eh, nice macros... this should be done for whole kernel or not t all.

diff -ruN linux-2.6.15-1/kernel/power/suspend_block_io.c build-2.6.15.1/kernel/power/suspend_block_io.c
--- linux-2.6.15-1/kernel/power/suspend_block_io.c	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/kernel/power/suspend_block_io.c	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,1086 @@
+/*
+ * block_io.c

Wrong name.

+ * Copyright 2004-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * Distributed under GPLv2.
+ * 
+ * This file contains block io functions for suspend2. These are
+ * used by the swapwriter and it is planned that they will also
+ * be used by the NFSwriter.
+ *
+ */

1080 lines that are not neccessary in uswsusp case, because we can
simply use existing read/write routines.

diff -ruN linux-2.6.15-1/kernel/power/suspend.c build-2.6.15.1/kernel/power/suspend.c
--- linux-2.6.15-1/kernel/power/suspend.c	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/kernel/power/suspend.c	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,1133 @@
+/*
+ * kernel/power/suspend2.c

Name?

+/* Compression ratio */
+__nosavedata unsigned long bytes_in = 0, bytes_out = 0;
+

Should not compression live in its own plugin?
diff -ruN linux-2.6.15-1/kernel/power/suspend_checksums.c build-2.6.15.1/kernel/power/suspend_checksums.c
--- linux-2.6.15-1/kernel/power/suspend_checksums.c	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/kernel/power/suspend_checksums.c	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,509 @@

Checksumming can live in userspace, 500 lines down.

diff -ruN linux-2.6.15-1/kernel/power/suspend_file.c build-2.6.15.1/kernel/power/suspend_file.c
--- linux-2.6.15-1/kernel/power/suspend_file.c	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/kernel/power/suspend_file.c	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,1077 @@
+/*
+ * Filewriter.c

Name?

Can happily live in userspace (using bmap), 1070 lines down.

diff -ruN linux-2.6.15-1/kernel/power/suspend.h build-2.6.15.1/kernel/power/suspend.h
diff -ruN linux-2.6.15-1/kernel/power/suspend_swap.c build-2.6.15.1/kernel/power/suspend_swap.c
--- linux-2.6.15-1/kernel/power/suspend_swap.c	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/kernel/power/suspend_swap.c	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,1213 @@
+/*
+ * Swapwriter.c
+ *
+ * Copyright 2004-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * Distributed under GPLv2.
+ * 
+ * This file encapsulates functions for usage of swap space as a
+ * backing store.
+ */

Should be possible to put into userspace, 1200 lines.

diff -ruN linux-2.6.15-1/kernel/power/swsusp.c build-2.6.15.1/kernel/power/swsusp.c
diff -ruN linux-2.6.15-1/kernel/power/swsusp.h build-2.6.15.1/kernel/power/swsusp.h
diff -ruN linux-2.6.15-1/kernel/power/ui.c build-2.6.15.1/kernel/power/ui.c
--- linux-2.6.15-1/kernel/power/ui.c	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15.1/kernel/power/ui.c	2006-01-23 21:38:28.000000000 +1000
@@ -0,0 +1,853 @@
+/*
+ * kernel/power/ui.c
+ *
+ * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
+ * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2002-2003 Florent Chabaud <fchabaud@free.fr>
+ * Copyright (C) 2002-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Routines for Suspend2's user interface.
+ *
+ * The user interface code talks to a userspace program via a
+ * netlink socket.
+ *
+ * The kernel side:
+ * - starts the userui program;
+ * - sends text messages and progress bar status;
+ *
+ * The user space side:
+ * - passes messages regarding user requests (abort, toggle reboot etc)
+ *
+ */

Userinterface in kernel. Great. Fortunately Rafael's code allows this
850 lines not to be needed.

+char suspend_wait_for_keypress(int timeout)
+{
+	int fd;
+	char key = '\0';
+	struct termios t, t_backup;
+
+	if (ui_helper_data.pid != -1) {
+		wait_for_key_via_userui();
+		key = ' ';
+		goto out;
+	}
+	
+	/* We should be guaranteed /dev/console exists after populate_rootfs() in
+	 * init/main.c
+	 */
+	if ((fd = sys_open("/dev/console", O_RDONLY, 0)) < 0) {
+		printk("Couldn't open /dev/console.\n");
+		goto out;
+	}

...and you still do user interface in kernel, despite having userland
helper.

+/* abort_suspend
+ *
+ * Description: Begin to abort a cycle. If this wasn't at the user's request
+ * 		(and we're displaying output), tell the user why and wait for
+ * 		them to acknowledge the message.
+ * Arguments:	A parameterised string (imagine this is printk) to display,
+ *	 	telling the user why we're aborting.
+ */
+
+void abort_suspend(const char *fmt, ...)
+{
+	va_list args;
+	int printed_len = 0;

And your own printk... sweeet.


+	if (!test_result_state(SUSPEND_ABORTED)) {
+		if (!test_result_state(SUSPEND_ABORT_REQUESTED)) {
+			va_start(args, fmt);
+			printed_len = vsnprintf(local_printf_buf, 
+					sizeof(local_printf_buf), fmt, args);
+			va_end(args);
+			if (ui_helper_data.pid != -1)
+				printed_len = sprintf(local_printf_buf + printed_len,
+					" (Press SPACE to continue)");
+			suspend2_prepare_status(CLEAR_BAR, local_printf_buf);

Even if you call userland for actuall printk(), this is still user
interface.

+#if defined(CONFIG_VT) || defined(CONFIG_SERIAL_CONSOLE)
+	console_loglevel = 7;
+
+	say("=== Suspend2 ===\n\n");
+	if (warning_reason) {
+		say("BIG FAT WARNING!! %s\n\n", local_printf_buf);
+		switch (message_detail) {
+		 case 0:
+			say("If you continue booting, note that any image WILL NOT BE REMOVED.\n");
+			say("Suspend is unable to do so because the appropriate modules aren't\n");
+			say("loaded. You should manually remove the image to avoid any\n");
+			say("possibility of corrupting your filesystem(s) later.\n");
+			break;
+		 case 1:
+			say("If you want to use the current suspend image, reboot and try\n");
+			say("again with the same kernel that you suspended from. If you want\n");
+			say("to forget that image, continue and the image will be erased.\n");
+			break;
+		}
+		say("Press SPACE to reboot or C to continue booting with this kernel\n\n");
+		say("Default action if you don't select one in %d seconds is: %s.\n",
+			message_timeout,
+			default_answer == SUSPEND_CONTINUE_REQ ?
+			"continue booting" : "reboot");
+	} else {
+		say("BIG FAT WARNING!!\n\n");
+		say("You have tried to resume from this image before.\n");
+		say("If it failed once, it may well fail again.\n");
+		say("Would you like to remove the image and boot normally?\n");
+		say("This will be equivalent to entering noresume2 on the\n");
+		say("kernel command line.\n\n");
+		say("Press SPACE to remove the image or C to continue resuming.\n\n");
+		say("Default action if you don't select one in %d seconds is: %s.\n",
+			message_timeout,
+			!!default_answer ?
+			"continue resuming" : "remove the image");
+	}

Wonderful. Did not we agree that this has no place in kernel?

+	{ .filename			= "userui_progress_granularity",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_INTEGER,
+	  .data = {
+		.integer = {
+			.variable	= &progress_granularity,
+			.minimum	= 1,
+			.maximum	= 2048,
+		}
+	  }
+	},

So even progress granularity is configurable?
diff -ruN linux-2.6.15-1/kernel/power/ui.h build-2.6.15.1/kernel/power/ui.h
diff -ruN linux-2.6.15-1/kernel/power/version.h build-2.6.15.1/kernel/power/version.h
diff -ruN linux-2.6.15-1/kernel/sched.c build-2.6.15.1/kernel/sched.c
diff -ruN linux-2.6.15-1/kernel/signal.c build-2.6.15.1/kernel/signal.c
diff -ruN linux-2.6.15-1/kernel/softirq.c build-2.6.15.1/kernel/softirq.c
diff -ruN linux-2.6.15-1/kernel/sys.c build-2.6.15.1/kernel/sys.c
--- linux-2.6.15-1/kernel/sys.c	2006-01-03 15:08:48.000000000 +1000
+++ build-2.6.15.1/kernel/sys.c	2006-01-23 21:38:28.000000000 +1000
@@ -173,15 +173,18 @@
 {
 	int ret=NOTIFY_DONE;
 	struct notifier_block *nb = *n;
+	struct notifier_block *next;
 
 	while(nb)
 	{
-		ret=nb->notifier_call(nb,val,v);
+		/* Determining next here allows the notifier to unregister itself */
+		next = nb->next;
+		ret = nb->notifier_call(nb,val,v);
 		if(ret&NOTIFY_STOP_MASK)
 		{
 			return ret;
 		}
-		nb=nb->next;
+		nb = next;
 	}
 	return ret;
 }

What is this?
diff -ruN linux-2.6.15-1/kernel/workqueue.c build-2.6.15.1/kernel/workqueue.c
diff -ruN linux-2.6.15-1/lib/dyn_pageflags.c build-2.6.15.1/lib/dyn_pageflags.c
diff -ruN linux-2.6.15-1/lib/Kconfig build-2.6.15.1/lib/Kconfig
diff -ruN linux-2.6.15-1/lib/Makefile build-2.6.15.1/lib/Makefile
diff -ruN linux-2.6.15-1/lib/vsprintf.c build-2.6.15.1/lib/vsprintf.c
diff -ruN linux-2.6.15-1/mm/bootmem.c build-2.6.15.1/mm/bootmem.c
diff -ruN linux-2.6.15-1/mm/memory.c build-2.6.15.1/mm/memory.c
--- linux-2.6.15-1/mm/memory.c	2006-01-03 15:08:49.000000000 +1000
+++ build-2.6.15.1/mm/memory.c	2006-01-23 21:38:28.000000000 +1000
@@ -950,6 +950,15 @@
 	return page;
 }
 
+/*
+ * We want the address of the page for Suspend2 to mark as being in pageset1. 
+ */
+
+struct page *suspend2_follow_page(struct mm_struct *mm, unsigned long address)
+{
+	return follow_page(mm->mmap, address, 0);
+}
+
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned long start, int len, int write, int force,
 		struct page **pages, struct vm_area_struct **vmas)


In mm/memory.c? It has a comment, unfortunately it does not say
anything.

diff -ruN linux-2.6.15-1/mm/page_alloc.c build-2.6.15.1/mm/page_alloc.c
--- linux-2.6.15-1/mm/page_alloc.c	2006-01-03 15:08:49.000000000 +1000
+++ build-2.6.15.1/mm/page_alloc.c	2006-01-23 21:38:28.000000000 +1000
@@ -920,8 +921,8 @@
 
 	/* This allocation should allow future memory freeing. */
 
-	if (((p->flags & PF_MEMALLOC) || unlikely(test_thread_flag(TIF_MEMDIE)))
-			&& !in_interrupt()) {
+	if ((((p->flags & PF_MEMALLOC) || unlikely(test_thread_flag(TIF_MEMDIE))) && 
+				!in_interrupt()) || (test_freezer_state(FREEZER_ON))) {
 		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
 nofail_alloc:
 			/* go through the zonelist yet again, ignoring mins */

You have just made memory allocation slower. Oops.

diff -ruN linux-2.6.15-1/mm/pdflush.c build-2.6.15.1/mm/pdflush.c
diff -ruN linux-2.6.15-1/mm/swapfile.c build-2.6.15.1/mm/swapfile.c
diff -ruN linux-2.6.15-1/mm/vmscan.c build-2.6.15.1/mm/vmscan.c
diff -ruN linux-2.6.15-1/net/rxrpc/krxiod.c build-2.6.15.1/net/rxrpc/krxiod.c
diff -ruN linux-2.6.15-1/net/rxrpc/krxsecd.c build-2.6.15.1/net/rxrpc/krxsecd.c
diff -ruN linux-2.6.15-1/net/rxrpc/krxtimod.c build-2.6.15.1/net/rxrpc/krxtimod.c
diff -ruN linux-2.6.15-1/net/sunrpc/sched.c build-2.6.15.1/net/sunrpc/sched.c
diff -ruN linux-2.6.15-1/net/sunrpc/svcsock.c build-2.6.15.1/net/sunrpc/svcsock.c

So... I'm spreading FUD and suspend2 is not intrusive? I'd not say so.

And you claimed that uswsusp can not solve anything? With above
analysis, at least 8040 lines can be moved into userspace. That's more
than half of your patch...

Do we do anything really fundamental in userspace? No. Do you do
anything fundamental in those 8040 lines? No. => userspace, please.

Now, suspend2 is quite a lot of old code, that does not properly use
existing kernel infrastructure. Rather than trying to prove suspend2
is not intrusive (*)... can you just start using Rafael's existing
code, and put that code into userspace?

								Pavel
(*) it is hard to prove something that is not true.

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
