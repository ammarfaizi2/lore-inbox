Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162119AbWLAWdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162119AbWLAWdM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 17:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162121AbWLAWdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 17:33:12 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34573 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1162119AbWLAWdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 17:33:10 -0500
Date: Fri, 1 Dec 2006 23:33:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: tim@cyberelk.net
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] paride: remove parport #ifdef's
Message-ID: <20061201223315.GJ11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PARIDE depends on CONFIG_PARPORT_PC, so there's no reason for 
these #ifdef's.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/block/paride/bpck6.c  |   13 -------------
 drivers/block/paride/paride.c |   33 ---------------------------------
 2 files changed, 46 deletions(-)

--- linux-2.6.19-rc6-mm2/drivers/block/paride/bpck6.c.old	2006-12-01 23:14:49.000000000 +0100
+++ linux-2.6.19-rc6-mm2/drivers/block/paride/bpck6.c	2006-12-01 23:15:09.000000000 +0100
@@ -31,10 +31,7 @@ static int verbose; /* set this to 1 to 
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <asm/io.h>
-
-#if defined(CONFIG_PARPORT_MODULE)||defined(CONFIG_PARPORT)
 #include <linux/parport.h>
-#endif
 
 #include "ppc6lnx.c"
 #include "paride.h"
@@ -139,11 +136,6 @@ static int bpck6_test_port ( PIA *pi )  
 	PPCSTRUCT(pi)->ppc_id=pi->unit;
 	PPCSTRUCT(pi)->lpt_addr=pi->port;
 
-#ifdef CONFIG_PARPORT_PC_MODULE
-#define CONFIG_PARPORT_PC
-#endif
-
-#ifdef CONFIG_PARPORT_PC
 	/* look at the parport device to see if what modes we can use */
 	if(((struct pardevice *)(pi->pardev))->port->modes & 
 		(PARPORT_MODE_EPP)
@@ -161,11 +153,6 @@ static int bpck6_test_port ( PIA *pi )  
 	{
 		return 1;
 	}
-#else
-	/* there is no way of knowing what kind of port we have
-	   default to the highest mode possible */
-	return 5;
-#endif
 }
 
 static int bpck6_probe_unit ( PIA *pi )
--- linux-2.6.19-rc6-mm2/drivers/block/paride/paride.c.old	2006-12-01 23:15:18.000000000 +0100
+++ linux-2.6.19-rc6-mm2/drivers/block/paride/paride.c	2006-12-01 23:16:12.000000000 +0100
@@ -29,14 +29,7 @@
 #include <linux/spinlock.h>
 #include <linux/wait.h>
 #include <linux/sched.h>	/* TASK_* */
-
-#ifdef CONFIG_PARPORT_MODULE
-#define CONFIG_PARPORT
-#endif
-
-#ifdef CONFIG_PARPORT
 #include <linux/parport.h>
-#endif
 
 #include "paride.h"
 
@@ -76,8 +69,6 @@ void pi_read_block(PIA * pi, char *buf, 
 
 EXPORT_SYMBOL(pi_read_block);
 
-#ifdef CONFIG_PARPORT
-
 static void pi_wake_up(void *p)
 {
 	PIA *pi = (PIA *) p;
@@ -100,11 +91,8 @@ static void pi_wake_up(void *p)
 		cont();
 }
 
-#endif
-
 int pi_schedule_claimed(PIA * pi, void (*cont) (void))
 {
-#ifdef CONFIG_PARPORT
 	unsigned long flags;
 
 	spin_lock_irqsave(&pi_spinlock, flags);
@@ -115,7 +103,6 @@ int pi_schedule_claimed(PIA * pi, void (
 	}
 	pi->claimed = 1;
 	spin_unlock_irqrestore(&pi_spinlock, flags);
-#endif
 	return 1;
 }
 EXPORT_SYMBOL(pi_schedule_claimed);
@@ -133,20 +120,16 @@ static void pi_claim(PIA * pi)
 	if (pi->claimed)
 		return;
 	pi->claimed = 1;
-#ifdef CONFIG_PARPORT
 	if (pi->pardev)
 		wait_event(pi->parq,
 			   !parport_claim((struct pardevice *) pi->pardev));
-#endif
 }
 
 static void pi_unclaim(PIA * pi)
 {
 	pi->claimed = 0;
-#ifdef CONFIG_PARPORT
 	if (pi->pardev)
 		parport_release((struct pardevice *) (pi->pardev));
-#endif
 }
 
 void pi_connect(PIA * pi)
@@ -167,21 +150,15 @@ EXPORT_SYMBOL(pi_disconnect);
 
 static void pi_unregister_parport(PIA * pi)
 {
-#ifdef CONFIG_PARPORT
 	if (pi->pardev) {
 		parport_unregister_device((struct pardevice *) (pi->pardev));
 		pi->pardev = NULL;
 	}
-#endif
 }
 
 void pi_release(PIA * pi)
 {
 	pi_unregister_parport(pi);
-#ifndef CONFIG_PARPORT
-	if (pi->reserved)
-		release_region(pi->port, pi->reserved);
-#endif				/* !CONFIG_PARPORT */
 	if (pi->proto->release_proto)
 		pi->proto->release_proto(pi);
 	module_put(pi->proto->owner);
@@ -269,8 +246,6 @@ EXPORT_SYMBOL(paride_unregister);
 
 static int pi_register_parport(PIA * pi, int verbose)
 {
-#ifdef CONFIG_PARPORT
-
 	struct parport *port;
 
 	port = parport_find_base(pi->port);
@@ -290,7 +265,6 @@ static int pi_register_parport(PIA * pi,
 		printk("%s: 0x%x is %s\n", pi->device, pi->port, port->name);
 
 	pi->parname = (char *) port->name;
-#endif
 
 	return 1;
 }
@@ -447,13 +421,6 @@ int pi_init(PIA * pi, int autoprobe, int
 			printk("%s: Adapter not found\n", device);
 		return 0;
 	}
-#ifndef CONFIG_PARPORT
-	if (!request_region(pi->port, pi->reserved, pi->device)) {
-		printk(KERN_WARNING "paride: Unable to request region 0x%x\n",
-		       pi->port);
-		return 0;
-	}
-#endif				/* !CONFIG_PARPORT */
 
 	if (pi->parname)
 		printk("%s: Sharing %s at 0x%x\n", pi->device,

