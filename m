Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315878AbSEWDTD>; Wed, 22 May 2002 23:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315919AbSEWDTC>; Wed, 22 May 2002 23:19:02 -0400
Received: from sepp-host209.dsl.visi.com ([209.98.241.209]:29852 "EHLO
	crash.reric.net") by vger.kernel.org with ESMTP id <S315878AbSEWDS7>;
	Wed, 22 May 2002 23:18:59 -0400
Date: Wed, 22 May 2002 22:18:59 -0500
From: Eric Seppanen <eds@reric.net>
To: linux-kernel@vger.kernel.org
Subject: via timer/clock problem workaround
Message-ID: <20020522221859.A24041@reric.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've noticed a handful of messages in recent months regarding the problems 
with the via chipset timer.  It would appear that the timer fails every 
so often and this causes gettimeofday to start returning weird values.

This has the following symptoms that I've noticed:
- clock often jumps forward 71 minutes, then back
- screensaver kicks on unexpectedly
- video playback programs freeze or start stuttering
- PS/2 mouse flies up to upper right corner under X
... I'm sure there's more; odd timeofday values cause lots of strange 
things.

There are a few patches floating around that fix this in some cases, but 
not all.  I've looked into this further and created a patch that I think 
does a much better job, though it may not be perfect yet.

In 2.4.18, whenever the code sees the microsecond offset start to grow too 
large, it guesses that there's a timer problem and smacks the timer.  This 
seems to work, but I think the code is in the wrong place.

This workaround only happens if CONFIG_X86_TSC is not set. 
Athlon-optimized kenels seem likely to have CONFIG_X86_TSC set (the 
redhat athlon kernel does), so it seems wrong to put the workaround there.

Additionally, there's a while loop in do_gettimeofday() that will loop 
millions of times if an unreasonable offset is returned from 
do_gettimeoffset().  This can be avoided by doing division instead.

I've worked over the code a bit, and I have a new patch that moves the 
timer-smack into the part of the code that executes whether the TSC is 
being used or not.  If you don't like the amount of code I've moved 
around, fear not: most of the code shuffling is just to make the debugging 
printk print the data I want.  It should be straightforward to make a 
smaller patch that does the same thing.

In my testing (using CONFIG_X86_TSC) this improves the situation quite a 
bit: before, the timer would stay messed up and the machine would act 
crazy until the next reboot.  Now, there may be a single bad value 
returned but the system goes back to normal after that.  Maybe not 
perfect, but certainly better.

I'd appreciate it if anyone experiencing odd behavior on Via chipsets 
could give it a try.  The problem usually only occurs under heavy loads; I 
have reproduced it often by creating massive images (5000x5000 pixels) in 
The Gimp or playing MPEG files while copying huge files around.

The patch works well today, but there are still a few outstanding 
questions I have:

1. Why does this (bogus offset) happen?  Has the timer died?  Is there 
another way to prevent this from happening in the first place?
2. Is it possible to resurrect what the correct offset should be at this 
point?
3. If not, what's the best value to use as an offset here?  I'm still 
using the bogus value to calculate the timeofday returned.  Is there a 
better way?
4. What does the code (which I've named smack_timer) do?  It is correct or 
just lucky?  I kept the workaround code that was already in 2.4.18, but I 
don't understand what it's doing.

Patch attached applies against 2.4.18 and the redhat 7.3 kernels.  I'll 
keep my latest version here:
http://www.reric.net/linux/viatimer/

Eric

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="eds_timer1.patch"

--- time.c.orig	Wed May 22 12:01:24 2002
+++ linux/arch/i386/kernel/time.c	Wed May 22 20:38:29 2002
@@ -118,6 +118,14 @@
 
 extern spinlock_t i8259A_lock;
 
+static void smack_timer(void)
+{
+	outb_p(0x34, 0x43);
+	outb_p(LATCH & 0xff, 0x40);
+	outb(LATCH >> 8, 0x40);
+}
+
+
 #ifndef CONFIG_X86_TSC
 
 /* This function must be called with interrupts disabled 
@@ -179,14 +187,6 @@
 
 	count |= inb_p(0x40) << 8;
 	
-        /* VIA686a test code... reset the latch if count > max + 1 */
-        if (count > LATCH) {
-                outb_p(0x34, 0x43);
-                outb_p(LATCH & 0xff, 0x40);
-                outb(LATCH >> 8, 0x40);
-                count = LATCH - 1;
-        }
-	
 	spin_unlock(&i8253_lock);
 
 	/*
@@ -267,23 +267,49 @@
 {
 	unsigned long flags;
 	unsigned long usec, sec;
+	unsigned long usec_overflow=0;
+	unsigned long lost;
 
 	read_lock_irqsave(&xtime_lock, flags);
 	usec = do_gettimeoffset();
-	{
-		unsigned long lost = jiffies - wall_jiffies;
-		if (lost)
-			usec += lost * (1000000 / HZ);
-	}
 	sec = xtime.tv_sec;
 	usec += xtime.tv_usec;
 	read_unlock_irqrestore(&xtime_lock, flags);
+	lost = jiffies - wall_jiffies;
 
-	while (usec >= 1000000) {
-		usec -= 1000000;
-		sec++;
+	/* if usec is overflowing calculate by how much */
+	if (usec >= 1000000) {
+		usec_overflow = usec / 1000000;
 	}
 
+	/* xtime.tv_usec could bring us almost to 1, so if we go over 2,
+           were're overflowing by over a second. */
+	if (usec_overflow > 2) {
+#ifdef CONFIG_X86_TSC
+		printk("gettimeofday bug(TSC): offset=0x%lx, sec=%lu, lost=%lu\n", usec, sec, lost);
+#else
+		printk("gettimeofday bug: offset=0x%lx, sec=%lu, lost=%lu\n", usec, sec, lost);
+#endif
+		smack_timer();
+	}
+
+	if (usec_overflow) {
+		usec = usec % 1000000;
+	}
+
+	if (lost) {
+		usec += lost * (1000000 / HZ);
+	}
+
+	/* this is a little redundant but now includes lost jiffies,
+           which I didn't want to count in the bug test above */
+	if (usec >= 1000000) {
+		usec_overflow += usec / 1000000;
+		usec = usec % 1000000;
+	}
+
+	sec+= usec_overflow;
+
 	tv->tv_sec = sec;
 	tv->tv_usec = usec;
 }

--y0ulUmNC+osPPQO6--
