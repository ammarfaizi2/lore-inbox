Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266488AbUGPGVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266488AbUGPGVK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 02:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266290AbUGPGVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 02:21:10 -0400
Received: from ozlabs.org ([203.10.76.45]:12268 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266488AbUGPGUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 02:20:37 -0400
Date: Fri, 16 Jul 2004 16:10:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@lists.linuxppc.org, Paul Mackerras <paulus@samba.org>,
       Anton Blanchard <anton@samba.org>, Linas Vepstas <linas@us.ibm.com>
Subject: [PPC64, TRIVIAL] Rename confusing locks in ras.c, rtasd.c
Message-ID: <20040716061038.GD26044@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

Both arch/ppc64/kernel/ras.c and arch/ppc64/kernel/rtasd.c have a
spinlock variable declared static called "log_lock".  Since the code
in these files interact quit a lot, having two different locks with
identical names is manifestly confusing.  This patch renames both
locks to something a little clearer.  In the case of ras.c it also
renames the buffer protected by the lock to a more usefullly greppable
name.

Signed-off-by: David Gibson <dwg@au.ibm.com>

Index: working-2.6/arch/ppc64/kernel/ras.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/ras.c
+++ working-2.6/arch/ppc64/kernel/ras.c
@@ -109,8 +109,8 @@
 }
 __initcall(init_ras_IRQ);
 
-static struct rtas_error_log log_buf;
-static spinlock_t log_lock = SPIN_LOCK_UNLOCKED;
+static struct rtas_error_log ras_log_buf;
+static spinlock_t ras_log_buf_lock = SPIN_LOCK_UNLOCKED;
 
 /*
  * Handle power subsystem events (EPOW).
@@ -126,17 +126,17 @@
 	unsigned int size = sizeof(log_entry);
 	int status = 0xdeadbeef;
 
-	spin_lock(&log_lock);
+	spin_lock(&ras_log_buf_lock);
 
 	status = rtas_call(rtas_token("check-exception"), 6, 1, NULL, 
 			   0x500, irq, 
 			   RTAS_EPOW_WARNING | RTAS_POWERMGM_EVENTS, 
 			   1,  /* Time Critical */
-			   __pa(&log_buf), size);
+			   __pa(&ras_log_buf), size);
 
-	log_entry = log_buf;
+	log_entry = ras_log_buf;
 
-	spin_unlock(&log_lock);
+	spin_unlock(&ras_log_buf_lock);
 
 	udbg_printf("EPOW <0x%lx 0x%x>\n",
 		    *((unsigned long *)&log_entry), status); 
@@ -165,17 +165,17 @@
 	int status = 0xdeadbeef;
 	int fatal;
 
-	spin_lock(&log_lock);
+	spin_lock(&ras_log_buf_lock);
 
 	status = rtas_call(rtas_token("check-exception"), 6, 1, NULL, 
 			   0x500, irq, 
 			   RTAS_INTERNAL_ERROR, 
 			   1, /* Time Critical */
-			   __pa(&log_buf), size);
+			   __pa(&ras_log_buf), size);
 
-	log_entry = log_buf;
+	log_entry = ras_log_buf;
 
-	spin_unlock(&log_lock);
+	spin_unlock(&ras_log_buf_lock);
 
 	if ((status == 0) && (log_entry.severity >= SEVERITY_ERROR_SYNC)) 
 		fatal = 1;
Index: working-2.6/arch/ppc64/kernel/rtasd.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/rtasd.c
+++ working-2.6/arch/ppc64/kernel/rtasd.c
@@ -33,7 +33,7 @@
 #define DEBUG(A...)
 #endif
 
-static spinlock_t log_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t rtasd_log_lock = SPIN_LOCK_UNLOCKED;
 
 DECLARE_WAIT_QUEUE_HEAD(rtas_log_wait);
 
@@ -152,7 +152,7 @@
 	if (buf == NULL)
 		return;
 
-	spin_lock_irqsave(&log_lock, s);
+	spin_lock_irqsave(&rtasd_log_lock, s);
 
 	/* get length and increase count */
 	switch (err_type & ERR_TYPE_MASK) {
@@ -163,7 +163,7 @@
 		break;
 	case ERR_TYPE_KERNEL_PANIC:
 	default:
-		spin_unlock_irqrestore(&log_lock, s);
+		spin_unlock_irqrestore(&rtasd_log_lock, s);
 		return;
 	}
 
@@ -174,7 +174,7 @@
 	/* Check to see if we need to or have stopped logging */
 	if (fatal || no_more_logging) {
 		no_more_logging = 1;
-		spin_unlock_irqrestore(&log_lock, s);
+		spin_unlock_irqrestore(&rtasd_log_lock, s);
 		return;
 	}
 
@@ -199,12 +199,12 @@
 		else
 			rtas_log_start += 1;
 
-		spin_unlock_irqrestore(&log_lock, s);
+		spin_unlock_irqrestore(&rtasd_log_lock, s);
 		wake_up_interruptible(&rtas_log_wait);
 		break;
 	case ERR_TYPE_KERNEL_PANIC:
 	default:
-		spin_unlock_irqrestore(&log_lock, s);
+		spin_unlock_irqrestore(&rtasd_log_lock, s);
 		return;
 	}
 
@@ -247,24 +247,24 @@
 		return -ENOMEM;
 
 
-	spin_lock_irqsave(&log_lock, s);
+	spin_lock_irqsave(&rtasd_log_lock, s);
 	/* if it's 0, then we know we got the last one (the one in NVRAM) */
 	if (rtas_log_size == 0 && !no_more_logging)
 		nvram_clear_error_log();
-	spin_unlock_irqrestore(&log_lock, s);
+	spin_unlock_irqrestore(&rtasd_log_lock, s);
 
 
 	error = wait_event_interruptible(rtas_log_wait, rtas_log_size);
 	if (error)
 		goto out;
 
-	spin_lock_irqsave(&log_lock, s);
+	spin_lock_irqsave(&rtasd_log_lock, s);
 	offset = rtas_error_log_buffer_max * (rtas_log_start & LOG_NUMBER_MASK);
 	memcpy(tmp, &rtas_log_buf[offset], count);
 
 	rtas_log_start += 1;
 	rtas_log_size -= 1;
-	spin_unlock_irqrestore(&log_lock, s);
+	spin_unlock_irqrestore(&rtasd_log_lock, s);
 
 	error = copy_to_user(buf, tmp, count) ? -EFAULT : count;
 out:



-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
