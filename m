Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265232AbUETS4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbUETS4I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 14:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265246AbUETS4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 14:56:08 -0400
Received: from mx2.elte.hu ([157.181.151.9]:36052 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265232AbUETS4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 14:56:02 -0400
Date: Thu, 20 May 2004 20:57:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: overlaping printk
Message-ID: <20040520185745.GA7706@elte.hu>
References: <1XBEP-Mc-49@gated-at.bofh.it> <1XBXw-13D-3@gated-at.bofh.it> <1XWpp-zy-9@gated-at.bofh.it> <m3lljnnoa0.fsf@averell.firstfloor.org> <20040520151939.GA3562@elte.hu> <20040520155323.GA4750@elte.hu> <20040520161901.GD13601@hexapodia.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20040520161901.GD13601@hexapodia.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Andy Isaacson <adi@hexapodia.org> wrote:

> It looks like this will cause problems if the user experiences an oops
> during boot, runs for a few hours, and then has another oops.  Won't
> the second oops fail to break the lock, and end up just deadlocking?

i've attached a new patch that does what Andi suggested too - 
timestamping of the oopses. This way we will zap no sooner than 10 
seconds after the first oops.

	Ingo

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bust-spinlocks-fix-2.6.6-A1"

--- linux/kernel/printk.c.orig	
+++ linux/kernel/printk.c	
@@ -55,6 +55,9 @@ EXPORT_SYMBOL(console_printk);
 
 int oops_in_progress;
 
+/* zap spinlocks only once: */
+unsigned long oops_timestamp;
+
 /*
  * console_sem protects the console_drivers list, and also
  * provides serialisation for access to the entire console
@@ -472,6 +475,23 @@ static void emit_log_char(char c)
 }
 
 /*
+ * Zap console related locks when oopsing. Only zap at most once
+ * every 10 seconds, to leave time for slow consoles to print a
+ * full oops.
+ */
+static inline void zap_locks(void)
+{
+	if (!time_after(jiffies, oops_timestamp + 10*HZ))
+		return;
+	oops_timestamp = jiffies;
+
+	/* If a crash is occurring, make sure we can't deadlock */
+	spin_lock_init(&logbuf_lock);
+	/* And make sure that we print immediately */
+	init_MUTEX(&console_sem);
+}
+
+/*
  * This is printk.  It can be called from any context.  We want it to work.
  * 
  * We try to grab the console_sem.  If we succeed, it's easy - we log the output and
@@ -493,12 +513,8 @@ asmlinkage int printk(const char *fmt, .
 	static char printk_buf[1024];
 	static int log_level_unknown = 1;
 
-	if (oops_in_progress) {
-		/* If a crash is occurring, make sure we can't deadlock */
-		spin_lock_init(&logbuf_lock);
-		/* And make sure that we print immediately */
-		init_MUTEX(&console_sem);
-	}
+	if (unlikely(oops_in_progress))
+		zap_locks();
 
 	/* This stops the holder of console_sem just where we want him */
 	spin_lock_irqsave(&logbuf_lock, flags);

--ew6BAiZeqk4r7MaW--
