Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314829AbSGIMlf>; Tue, 9 Jul 2002 08:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314835AbSGIMlf>; Tue, 9 Jul 2002 08:41:35 -0400
Received: from gw.lowendale.com.au ([203.26.242.120]:32080 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S314829AbSGIMlb>; Tue, 9 Jul 2002 08:41:31 -0400
Date: Tue, 9 Jul 2002 22:46:31 +1000 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: linux-kernel@vger.kernel.org
Subject: timer bug check on Toshi Sat 1800
Message-ID: <Pine.LNX.4.05.10207092242500.7749-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I'm not paranoid - just convinced that this bug hates me ;-)

My nice new Toshi Satellite 1800 (ALi chipset?[1]) with 2.2.21+patches
(relevant one appended[2]) keeps reporting "VIA bug check triggered".

Grepping through kern.log, I noticed that the values reported for
"read" and "re-read" occured over an apparently narrow range.  Using
my good friends grep, sed, sort and uniq I get the following summary
of occurences of each pair of read & re-read values (time-frame is
Jul  7 07:48:59 through Jul  9 20:22:21 - i.e. ~2.5 days):

      1 11934  11880 
      7 11934  11882 
      1 11968  11864 
      1 11968  11865 
      2 12000  11866 
      2 12008  11864 
      3 12008  11865 
     10 12008  11866 
     16 12024  11865 
     41 12024  11866 
      9 12030  11865 
     21 12030  11866

Any suggestions as to if the range of values is significant?

Also, I never get the second half of the "VIA bug check" routine
logging anything - is this because something's doing its job here?

BTW, where can I read up on the workings of this timer and the asociated
ioports etc?

Thanks,
Neale.

[1] snippage from lspci -v:

00:00.0 Host bridge: Acer Laboratories Inc. [ALi]: Unknown device 1644 (rev 01)
        Flags: bus master, medium devsel, latency 0
        Memory at f0000000 (32-bit, prefetchable)
        Capabilities: [b0] AGP version 2.0
        Capabilities: [a4] Power Management version 1

00:08.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Flags: medium devsel

[2] diff of my patched linux/arch/i386/kernel/time.c (hacked version
of Vojtech's patch):

--- linux-2.2.21-orig/arch/i386/kernel/time.c	Mon Mar 26 02:37:30 2001
+++ linux-2.2.21-ntb1/arch/i386/kernel/time.c	Sat Jul  6 00:55:53 2002
@@ -81,6 +81,8 @@
 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
 
+static int		via686a_hacks = 1; /* default to enabled */
+
 static inline unsigned long do_fast_gettimeoffset(void)
 {
 	register unsigned long eax asm("ax");
@@ -111,6 +113,57 @@
 	return delay_at_last_interrupt + edx;
 }
 
+/*
+ * VIA hardware bug workaround with check if it is really needed and
+ * a printk that could tell us what's exactly happening on machines which
+ * trigger the check, but are not VIA-based.
+ *
+ * Must be called with the i8253_spinlock held.
+ */
+
+static void via_reset_and_whine(int *count)
+{
+	static unsigned long last_whine = 0;
+	unsigned long new_whine;
+	int count2;
+
+	new_whine = last_whine;
+
+	outb_p(0x00, 0x43);		/* Re-read the timer */
+	count2 = inb_p(0x40);
+	count2 |= inb(0x40) << 8;
+
+	if (time_after(jiffies, last_whine)) {
+		printk(KERN_WARNING "timer.c: VIA bug check triggered. "
+			"Value read %d [%#x], re-read %d [%#x]\n",
+			*count, *count, count2, count2);
+		new_whine = jiffies + HZ;
+	}
+
+	*count = count2;
+
+	if (count2 > LATCH) {		/* Still bad */
+		if (time_after(jiffies, last_whine)) {
+			if (via686a_hacks) {
+				printk(KERN_WARNING "timer.c VIA bug really present. ");
+				printk(KERN_WARNING "Resetting PIT timer.\n");
+			} else {
+				printk(KERN_WARNING "timer.c VIA bug apparently present. ");
+				printk(KERN_WARNING "But VIA hacks disabled.\n");
+			}
+			new_whine = jiffies + HZ;
+		}
+		if (via686a_hacks) {
+			outb_p(0x34, 0x43);
+			outb_p(LATCH & 0xff, 0x40);
+			outb(LATCH >> 8, 0x40);
+		}
+		*count = LATCH - 1;
+	}
+
+	last_whine = new_whine;
+}
+
 #define TICK_SIZE tick
 
 #ifndef CONFIG_X86_TSC
@@ -177,12 +230,8 @@
 	count |= inb_p(0x40) << 8;
 
 	/* VIA686a test code... reset the latch if count > max */
- 	if (count > LATCH-1) {
-		outb_p(0x34, 0x43);
-		outb_p(LATCH & 0xff, 0x40);
-		outb(LATCH >> 8, 0x40);
-		count = LATCH - 1;
-	}	
+	if (count > LATCH)
+		via_reset_and_whine(&count);
 	
 	/*
 	 * avoiding timer inconsistencies (they are rare, but they happen)...
@@ -478,19 +527,8 @@
 		count |= inb(0x40) << 8;
 
 		/* VIA686a test code... reset the latch if count > max */
-		if (count > LATCH-1) {
-			static int last_whine;
-			outb_p(0x34, 0x43);
-			outb_p(LATCH & 0xff, 0x40);
-			outb(LATCH >> 8, 0x40);
-			count = LATCH - 1;
-			if(time_after(jiffies, last_whine))
-			{
-				printk(KERN_WARNING "probable hardware bug: clock timer configuration lost - probably a VIA686a.\n");
-				printk(KERN_WARNING "probable hardware bug: restoring chip configuration.\n");
-				last_whine = jiffies + HZ;
-			}			
-		}	
+		if (count > LATCH)
+			via_reset_and_whine(&count);
 
 #if 0
 		spin_unlock(&i8253_lock);
@@ -737,3 +775,25 @@
 	setup_x86_irq(0, &irq0);
 #endif
 }
+
+static int __init timer_setup(char *str)
+{
+	int	invert;
+
+	while ((str != NULL) && (*str != '\0')) {
+		invert = (strncmp(str, "no-", 3) == 0);
+		if (invert)
+			str += 3;
+		if (strncmp(str, "via686a", 7) == 0) {
+			via686a_hacks = !invert;
+			if (invert)
+				printk(KERN_INFO "timer: VIA686a workaround disabled.\n");
+		}
+		str = strchr(str, ',');
+		if (str != NULL)
+			str += strspn(str, ", \t");
+	}
+	return 1;
+}
+
+__setup("timer=", timer_setup);

