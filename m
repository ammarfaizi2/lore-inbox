Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313561AbSDHF46>; Mon, 8 Apr 2002 01:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313560AbSDHF45>; Mon, 8 Apr 2002 01:56:57 -0400
Received: from gw.lowendale.com.au ([203.26.242.120]:12400 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S313060AbSDHF44>; Mon, 8 Apr 2002 01:56:56 -0400
Date: Mon, 8 Apr 2002 16:33:49 +1000 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VIA timer fix was removed?
In-Reply-To: <20011119182927.A19179@suse.cz>
Message-ID: <Pine.LNX.4.05.10204081626560.1445-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

Appended patch:

(a) merges your patch of November 2001 into 2.2.21rc3
(b) adds a boot-time option to explicitly disable the via-timer hacks.

I've been using this patch for a while, but haven't subjected it to more
thorough testing than that it boots OK and doesn't appear to complicate
anything (I might be able to trigger the relevant condition by running the
battery right down on my (old) AcerNote-950, but one of the last times
this happened I also got some pretty nasty file system corruption - so I'm
not too keen to try that one again :-| ).

Anyway, does this patch and my merge of it look correct?

Thanks,
Neale.

--- linux-2.2.21-rc3-orig/arch/i386/kernel/time.c	Mon Mar 26 02:37:30 2001
+++ linux-2.2.21-rc3-ntb/arch/i386/kernel/time.c	Fri Apr  5 23:04:13 2002
@@ -81,6 +81,8 @@
 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
 
+static int		via686a_hacks = 1; /* default to enabled */
+
 static inline unsigned long do_fast_gettimeoffset(void)
 {
 	register unsigned long eax asm("ax");
@@ -111,6 +113,54 @@
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
+			printk(KERN_WARNING "timer.c VIA bug really present. ");
+			new_whine = jiffies + HZ;
+		}
+		if (via686a_hacks) {
+			printk(KERN_WARNING "Resetting PIT timer.\n");
+			outb_p(0x34, 0x43);
+			outb_p(LATCH & 0xff, 0x40);
+			outb(LATCH >> 8, 0x40);
+		} else {
+			printk(KERN_WARNING "But VIA hacks disabled.\n");
+		}
+		*count = LATCH - 1;
+	}
+
+	last_whine = new_whine;
+}
+
 #define TICK_SIZE tick
 
 #ifndef CONFIG_X86_TSC
@@ -177,12 +227,8 @@
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
@@ -478,19 +524,8 @@
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
@@ -737,3 +772,25 @@
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

