Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbTDWXXy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 19:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264309AbTDWXXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 19:23:54 -0400
Received: from [212.45.9.156] ([212.45.9.156]:35714 "EHLO null.ru")
	by vger.kernel.org with ESMTP id S264308AbTDWXXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 19:23:48 -0400
Message-ID: <3EA72347.2020002@yahoo.com>
Date: Thu, 24 Apr 2003 03:35:35 +0400
From: Stas Sergeev <stssppnn@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030312
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] kernel hooks for PC-Speaker driver
Content-Type: multipart/mixed;
 boundary="------------000803020204060700050802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000803020204060700050802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

As some of you know, I am maintaining a
driver for pc-speaker, which can be
downloaded here:
http://www.geocities.com/stssppnn/pcsp.html

I've been asked several times to if not
get the driver included into the mainstream
kernel, then at least make it fully modular.
For this I need a couple of small hooks
to be included into the kernel.
The patch that adds all the necessary
hooks is attached. It doesn't (intended to)
change any existing functionality so it
must be absolutely harmless.
It is against 2.4.20 but it can be applied
to anything up to 2.4.21-rc1-ac1 with some
offsets.

Detailed explanation of the patch follows:
- use_speaker_beep variable controls
whether the kd_mksound() can produce a
beeps. By default is set to 1.
- Added SA_FIRST flag to add the irq handlers
to the head of the chain. Kernel's timer
irq handler produces a big latency so
that if the pcsp handler is executed
after it, the sound is horribly distorted.
- pit_counter0_offset is the variable
that gets added to the value got from
PIT counter. pscp driver alters the
counter so the correction is necessary.
Introduced read_pit_counter0() for that
purpose.
- handle_timer_irq variable controls
whether the kernel's timer handler is
to be executed or not. 1 by default.
- use SA_SHIRQ flag for the kernel's timer
irq handler to allow the driver to handle
that irq as well.

I think this patch is trivial and probably
can be applied to some testing tree in
order to get the pc-speaker driver a chance
for surviving :-)
Let me know if you feel the patch needs
more work.

--------------000803020204060700050802
Content-Type: text/plain;
 name="pcsp-kernel-2.4.20.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcsp-kernel-2.4.20.diff"

diff -urN linux-2.4.20-no-pcsp/arch/i386/kernel/i386_ksyms.c linux/arch/i386/kernel/i386_ksyms.c
--- linux-2.4.20-no-pcsp/arch/i386/kernel/i386_ksyms.c	Sun Aug  4 03:44:30 2002
+++ linux/arch/i386/kernel/i386_ksyms.c	Sat Mar 15 16:29:38 2003
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/tty.h>
+#include <linux/kd.h>
 
 #include <asm/semaphore.h>
 #include <asm/processor.h>
@@ -156,6 +157,7 @@
 
 #ifdef CONFIG_VT
 EXPORT_SYMBOL(screen_info);
+EXPORT_SYMBOL(use_speaker_beep);
 #endif
 
 EXPORT_SYMBOL(get_wchan);
diff -urN linux-2.4.20-no-pcsp/arch/i386/kernel/irq.c linux/arch/i386/kernel/irq.c
--- linux-2.4.20-no-pcsp/arch/i386/kernel/irq.c	Thu Dec 12 21:10:00 2002
+++ linux/arch/i386/kernel/irq.c	Sat Mar 15 20:30:10 2003
@@ -1023,11 +1023,16 @@
 			return -EBUSY;
 		}
 
-		/* add new interrupt at end of irq queue */
-		do {
-			p = &old->next;
-			old = *p;
-		} while (old);
+		if (!(new->flags & SA_FIRST)) {
+			/* add new interrupt at end of irq queue */
+			do {
+				p = &old->next;
+				old = *p;
+			} while (old);
+		} else {
+			/* add new interrupt at front of irq queue */
+			new->next = old;
+		}
 		shared = 1;
 	}
 
diff -urN linux-2.4.20-no-pcsp/arch/i386/kernel/time.c linux/arch/i386/kernel/time.c
--- linux-2.4.20-no-pcsp/arch/i386/kernel/time.c	Thu Dec 12 21:10:00 2002
+++ linux/arch/i386/kernel/time.c	Sat Mar 22 21:11:02 2003
@@ -84,6 +84,11 @@
 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
 
+volatile int pit_counter0_offset = 0;
+volatile int handle_timer_irq = 1;
+EXPORT_SYMBOL(pit_counter0_offset);
+EXPORT_SYMBOL(handle_timer_irq);
+
 static inline unsigned long do_fast_gettimeoffset(void)
 {
 	register unsigned long eax, edx;
@@ -121,6 +126,38 @@
 
 extern spinlock_t i8259A_lock;
 
+int read_pit_counter0(void)
+{
+	int count;
+	/* gets recalled with irq locally disabled */
+	spin_lock(&i8253_lock);
+	/* timer count may underflow right here */
+	outb_p(0x00, 0x43);	/* latch the count ASAP */
+
+	count = inb_p(0x40);	/* read the latched count */
+
+	count |= inb_p(0x40) << 8;
+
+        /* VIA686a test code... reset the latch if count > max + 1 */
+        if (count > LATCH) {
+                outb_p(0x34, 0x43);
+                outb_p(LATCH & 0xff, 0x40);
+                outb(LATCH >> 8, 0x40);
+                count = LATCH - 1;
+        }
+	
+	spin_unlock(&i8253_lock);
+
+       /*
+        * when using PCSP, we must add the accumulated
+        * clockticks from the PCSP driver
+        */
+	count += pit_counter0_offset;
+
+	return count;
+}
+EXPORT_SYMBOL(read_pit_counter0);
+
 #ifndef CONFIG_X86_TSC
 
 /* This function must be called with interrupts disabled 
@@ -167,31 +204,9 @@
 	 */
 	unsigned long jiffies_t;
 
-	/* gets recalled with irq locally disabled */
-	spin_lock(&i8253_lock);
-	/* timer count may underflow right here */
-	outb_p(0x00, 0x43);	/* latch the count ASAP */
-
-	count = inb_p(0x40);	/* read the latched count */
-
-	/*
-	 * We do this guaranteed double memory access instead of a _p 
-	 * postfix in the previous port access. Wheee, hackady hack
-	 */
+	count = read_pit_counter0();
  	jiffies_t = jiffies;
 
-	count |= inb_p(0x40) << 8;
-	
-        /* VIA686a test code... reset the latch if count > max + 1 */
-        if (count > LATCH) {
-                outb_p(0x34, 0x43);
-                outb_p(LATCH & 0xff, 0x40);
-                outb(LATCH >> 8, 0x40);
-                count = LATCH - 1;
-        }
-	
-	spin_unlock(&i8253_lock);
-
 	/*
 	 * avoiding timer inconsistencies (they are rare, but they happen)...
 	 * there are two kinds of problems that must be avoided here:
@@ -472,6 +487,10 @@
 {
 	int count;
 
+	/* This is used by PCSP driver only */
+	if (!handle_timer_irq)
+		return;
+
 	/*
 	 * Here we are in the timer irq handler. We just have irqs locally
 	 * disabled but we don't know if the timer_bh is running on the other
@@ -558,7 +577,8 @@
 	return mktime(year, mon, day, hour, min, sec);
 }
 
-static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, 0, "timer", NULL, NULL};
+static char dev_id;	/* dummy var for ID */
+static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT | SA_SHIRQ, 0, "timer", &dev_id, NULL};
 
 /* ------ Calibrate the TSC ------- 
  * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
diff -urN linux-2.4.20-no-pcsp/drivers/char/joystick/analog.c linux/drivers/char/joystick/analog.c
--- linux-2.4.20-no-pcsp/drivers/char/joystick/analog.c	Thu Dec 12 21:10:09 2002
+++ linux/drivers/char/joystick/analog.c	Sat Mar 15 13:30:51 2003
@@ -137,7 +137,7 @@
  */
 
 #ifdef __i386__
-#define GET_TIME(x)	do { if (cpu_has_tsc) rdtscl(x); else { outb(0, 0x43); x = inb(0x40); x |= inb(0x40) << 8; } } while (0)
+#define GET_TIME(x)	do { if (cpu_has_tsc) rdtscl(x); else { x = read_pit_counter0(); } } while (0)
 #define DELTA(x,y)	(cpu_has_tsc?((y)-(x)):((x)-(y)+((x)<(y)?1193180L/HZ:0)))
 #define TIME_NAME	(cpu_has_tsc?"TSC":"PIT")
 #elif __x86_64__
diff -urN linux-2.4.20-no-pcsp/drivers/char/joystick/gameport.c linux/drivers/char/joystick/gameport.c
--- linux-2.4.20-no-pcsp/drivers/char/joystick/gameport.c	Sat Sep 15 01:40:00 2001
+++ linux/drivers/char/joystick/gameport.c	Sat Mar 15 13:31:48 2003
@@ -39,6 +39,7 @@
 #include <linux/isapnp.h>
 #include <linux/stddef.h>
 #include <linux/delay.h>
+#include <linux/timex.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_LICENSE("GPL");
@@ -64,7 +65,7 @@
 {
 #if defined(__i386__) || defined(__x86_64__)
 
-#define GET_TIME(x)     do { outb(0, 0x43); x = inb(0x40); x |= inb(0x40) << 8; } while (0)
+#define GET_TIME(x)     do { x = read_pit_counter0(); } while (0)
 #define DELTA(x,y)      ((y)-(x)+((y)<(x)?1193180L/HZ:0))
 
 	unsigned int i, t, t1, t2, t3, tx;
diff -urN linux-2.4.20-no-pcsp/drivers/char/vt.c linux/drivers/char/vt.c
--- linux-2.4.20-no-pcsp/drivers/char/vt.c	Thu Dec 12 21:10:09 2002
+++ linux/drivers/char/vt.c	Sat Mar 15 17:05:34 2003
@@ -38,6 +38,7 @@
 #endif /* CONFIG_FB_COMPAT_XPMAC */
 
 char vt_dont_switch;
+int volatile use_speaker_beep = 1;
 extern struct tty_driver console_driver;
 
 #define VT_IS_IN_USE(i)	(console_driver.table[i] && console_driver.table[i]->count)
@@ -98,6 +99,9 @@
 static void
 kd_nosound(unsigned long ignored)
 {
+       if (!use_speaker_beep)
+               return;
+
 	/* disable counter 2 */
 	outb(inb_p(0x61)&0xFC, 0x61);
 	return;
@@ -110,6 +114,9 @@
 	unsigned int count = 0;
 	unsigned long flags;
 
+       if (!use_speaker_beep)
+               return;
+
 	if (hz > 20 && hz < 32767)
 		count = 1193180 / hz;
 	
diff -urN linux-2.4.20-no-pcsp/include/asm-i386/signal.h linux/include/asm-i386/signal.h
--- linux-2.4.20-no-pcsp/include/asm-i386/signal.h	Thu Nov 22 22:46:18 2001
+++ linux/include/asm-i386/signal.h	Sat Mar 15 20:34:43 2003
@@ -119,6 +119,7 @@
 #define SA_PROBE		SA_ONESHOT
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
+#define SA_FIRST		0x02000000
 #endif
 
 #define SIG_BLOCK          0	/* for blocking signals */
diff -urN linux-2.4.20-no-pcsp/include/asm-i386/timex.h linux/include/asm-i386/timex.h
--- linux-2.4.20-no-pcsp/include/asm-i386/timex.h	Thu Dec 12 21:10:25 2002
+++ linux/include/asm-i386/timex.h	Sat Mar 15 17:04:32 2003
@@ -50,8 +50,13 @@
 #endif
 }
 
+extern int read_pit_counter0(void);
+
 extern unsigned long cpu_khz;
 
+extern volatile int pit_counter0_offset;
+extern volatile int handle_timer_irq;
+
 #define vxtime_lock()		do {} while (0)
 #define vxtime_unlock()		do {} while (0)
 
diff -urN linux-2.4.20-no-pcsp/include/linux/kd.h linux/include/linux/kd.h
--- linux-2.4.20-no-pcsp/include/linux/kd.h	Sun Aug  4 03:45:09 2002
+++ linux/include/linux/kd.h	Sat Mar 15 17:05:02 2003
@@ -22,6 +22,7 @@
 
 #define KIOCSOUND	0x4B2F	/* start sound generation (0 for off) */
 #define KDMKTONE	0x4B30	/* generate tone */
+extern volatile int use_speaker_beep;
 
 #define KDGETLED	0x4B31	/* return current led state */
 #define KDSETLED	0x4B32	/* set led state [lights, not flags] */

--------------000803020204060700050802--

