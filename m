Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267555AbUG3DxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267555AbUG3DxZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 23:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264911AbUG3DxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 23:53:25 -0400
Received: from ozlabs.org ([203.10.76.45]:26594 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267584AbUG3Dwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 23:52:42 -0400
Date: Fri, 30 Jul 2004 13:44:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: paulus@samba.org, anton@samba.org, nfont@austin.ibm.com,
       linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64 Fix RAS irq handlers
Message-ID: <20040730034440.GD22225@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, paulus@samba.org, anton@samba.org,
	nfont@austin.ibm.com, linuxppc64-dev@lists.linuxppc.org,
	linux-kernel@vger.kernel.org
References: <16641.35625.461106.646666@cargo.ozlabs.ibm.com> <20040726181638.52e6c6c9.akpm@osdl.org> <20040727042803.GB12732@zax> <20040726220115.5605d98c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040726220115.5605d98c.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 10:01:15PM -0700, Andrew Morton wrote:
> David Gibson <david@gibson.dropbear.id.au> wrote:
> >
> > > Your patch conflicts hopelessly with David's, below.
> >  > 
> >  > What's a girl to do?
> > 
> >  Paul's is probably more important.  Mine's just a search-and-replace,
> >  so I can recreate it easily after the other changes go in.
> 
> OK, I'll drop yours, add Paul's.  Thanks.

Now that Paul's patch has gone in, here is mine again suitably
updated.  Please apply:

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
--- working-2.6.orig/arch/ppc64/kernel/ras.c	2004-07-30 10:27:06.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/ras.c	2004-07-30 13:50:27.873849536 +1000
@@ -52,8 +52,8 @@
 #include <asm/rtas.h>
 #include <asm/ppcdebug.h>
 
-static unsigned char log_buf[RTAS_ERROR_LOG_MAX];
-static spinlock_t log_lock = SPIN_LOCK_UNLOCKED;
+static unsigned char ras_log_buf[RTAS_ERROR_LOG_MAX];
+static spinlock_t ras_log_buf_lock = SPIN_LOCK_UNLOCKED;
 
 static int ras_get_sensor_state_token;
 static int ras_check_exception_token;
@@ -155,23 +155,23 @@
 	else
 		critical = 0;
 
-	spin_lock(&log_lock);
+	spin_lock(&ras_log_buf_lock);
 
 	status = rtas_call(ras_check_exception_token, 6, 1, NULL,
 			   RAS_VECTOR_OFFSET,
 			   virt_irq_to_real(irq_offset_down(irq)),
 			   RTAS_EPOW_WARNING | RTAS_POWERMGM_EVENTS,
-			   critical, __pa(&log_buf), RTAS_ERROR_LOG_MAX);
+			   critical, __pa(&ras_log_buf), RTAS_ERROR_LOG_MAX);
 
 	udbg_printf("EPOW <0x%lx 0x%x 0x%x>\n",
-		    *((unsigned long *)&log_buf), status, state);
+		    *((unsigned long *)&ras_log_buf), status, state);
 	printk(KERN_WARNING "EPOW <0x%lx 0x%x 0x%x>\n",
-	       *((unsigned long *)&log_buf), status, state);
+	       *((unsigned long *)&ras_log_buf), status, state);
 
 	/* format and print the extended information */
-	log_error(log_buf, ERR_TYPE_RTAS_LOG, 0);
+	log_error(ras_log_buf, ERR_TYPE_RTAS_LOG, 0);
 
-	spin_unlock(&log_lock);
+	spin_unlock(&ras_log_buf_lock);
 	return IRQ_HANDLED;
 }
 
@@ -190,15 +190,15 @@
 	int status = 0xdeadbeef;
 	int fatal;
 
-	spin_lock(&log_lock);
+	spin_lock(&ras_log_buf_lock);
 
 	status = rtas_call(ras_check_exception_token, 6, 1, NULL,
 			   RAS_VECTOR_OFFSET,
 			   virt_irq_to_real(irq_offset_down(irq)),
 			   RTAS_INTERNAL_ERROR, 1 /*Time Critical */,
-			   __pa(&log_buf), RTAS_ERROR_LOG_MAX);
+			   __pa(&ras_log_buf), RTAS_ERROR_LOG_MAX);
 
-	rtas_elog = (struct rtas_error_log *)log_buf;
+	rtas_elog = (struct rtas_error_log *)ras_log_buf;
 
 	if ((status == 0) && (rtas_elog->severity >= SEVERITY_ERROR_SYNC))
 		fatal = 1;
@@ -206,13 +206,13 @@
 		fatal = 0;
 
 	/* format and print the extended information */
-	log_error(log_buf, ERR_TYPE_RTAS_LOG, fatal);
+	log_error(ras_log_buf, ERR_TYPE_RTAS_LOG, fatal);
 
 	if (fatal) {
 		udbg_printf("Fatal HW Error <0x%lx 0x%x>\n",
-			    *((unsigned long *)&log_buf), status);
+			    *((unsigned long *)&ras_log_buf), status);
 		printk(KERN_EMERG "Error: Fatal hardware error <0x%lx 0x%x>\n",
-		       *((unsigned long *)&log_buf), status);
+		       *((unsigned long *)&ras_log_buf), status);
 
 #ifndef DEBUG
 		/* Don't actually power off when debugging so we can test
@@ -223,12 +223,12 @@
 #endif
 	} else {
 		udbg_printf("Recoverable HW Error <0x%lx 0x%x>\n",
-			    *((unsigned long *)&log_buf), status);
+			    *((unsigned long *)&ras_log_buf), status);
 		printk(KERN_WARNING
 		       "Warning: Recoverable hardware error <0x%lx 0x%x>\n",
-		       *((unsigned long *)&log_buf), status);
+		       *((unsigned long *)&ras_log_buf), status);
 	}
 
-	spin_unlock(&log_lock);
+	spin_unlock(&ras_log_buf_lock);
 	return IRQ_HANDLED;
 }
Index: working-2.6/arch/ppc64/kernel/rtasd.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/rtasd.c	2004-07-27 17:02:56.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/rtasd.c	2004-07-30 13:49:08.302831296 +1000
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
