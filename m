Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281027AbRKLV7N>; Mon, 12 Nov 2001 16:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281028AbRKLV6y>; Mon, 12 Nov 2001 16:58:54 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:34833 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S281027AbRKLV6t>; Mon, 12 Nov 2001 16:58:49 -0500
Date: Mon, 12 Nov 2001 22:58:32 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Neale Banks <neale@lowendale.com.au>,
        Jeronimo Pellegrini <pellegrini@mpcnet.com.br>,
        Nils Philippsen <nils@wombat.dialup.fht-esslingen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VIA timer fix was removed?
Message-ID: <20011112225832.A19107@suse.cz>
In-Reply-To: <Pine.LNX.4.05.10111130821580.3768-200000@marina.lowendale.com.au> <E163Og3-0007Aw-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E163Og3-0007Aw-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Nov 12, 2001 at 09:31:35PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 12, 2001 at 09:31:35PM +0000, Alan Cox wrote:

> > Attached (untested) patch against 21.2.20 (which still has the $SUBJECT
> > code) should implement timer=no-via686a option to disable this.  Hopefully
> > I'll get it tested in the next day or two.
> 
> This isnt the real problem - we are seeing it triggered by cases we dont
> underatand that seem to be software. We need to find those

I don't think it's software. At least it's definitely not locking. It's
happening on machines where none of the drivers missing the locks are
used (only ftape and analog joystick).

I think it's the old Neptune bug biting us again. I'd like to verify
this theory - do you have any list of people who've seen the VIA bugfix
triggered on non-VIA hardware? Some might be willing to test
experimental patches ...

... like the one attached. It doesn't add anything that already hasn't
been there, but:

	1) Should be safe for machines that have
	   a different bug than VIA. It'll print a message
	   but won't reset the timer if the > LATCH reading
	   isn't persistent.

	2) Should printk enough data to shed some light
	   on what is triggering the VIA check.

Patch against 2.4.15-pre4.

-- 
Vojtech Pavlik
SuSE Labs

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="new-via-check.diff"

diff -urN linux-2.4.15-pre4/arch/i386/kernel/time.c linux/arch/i386/kernel/time.c
--- linux-2.4.15-pre4/arch/i386/kernel/time.c	Mon Nov 12 22:31:52 2001
+++ linux/arch/i386/kernel/time.c	Mon Nov 12 22:52:25 2001
@@ -112,6 +112,50 @@
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
+			printk(KERN_WARNING "timer.c VIA bug really present. "
+				"Resetting PIT timer.\n");
+			new_whine = jiffies + HZ;
+		}
+		outb_p(0x34, 0x43);
+		outb_p(LATCH & 0xff, 0x40);
+		outb(LATCH >> 8, 0x40);
+		*count = LATCH - 1;
+	}
+
+	last_whine = new_whine;
+}
+
 #define TICK_SIZE tick
 
 spinlock_t i8253_lock = SPIN_LOCK_UNLOCKED;
@@ -180,12 +224,8 @@
 	count |= inb_p(0x40) << 8;
 	
         /* VIA686a test code... reset the latch if count > max + 1 */
-        if (count > LATCH) {
-                outb_p(0x34, 0x43);
-                outb_p(LATCH & 0xff, 0x40);
-                outb(LATCH >> 8, 0x40);
-                count = LATCH - 1;
-        }
+        if (count > LATCH) 
+		via_reset_and_whine(&count);
 	
 	spin_unlock(&i8253_lock);
 
@@ -501,6 +541,10 @@
 
 		count = inb_p(0x40);    /* read the latched count */
 		count |= inb(0x40) << 8;
+
+		if (count > LATCH)
+			via_reset_and_whine(&count);
+
 		spin_unlock(&i8253_lock);
 
 		count = ((LATCH-1) - count) * TICK_SIZE;

--u3/rZRmxL6MmkK24--
