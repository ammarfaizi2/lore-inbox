Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262966AbSJBErB>; Wed, 2 Oct 2002 00:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262967AbSJBErA>; Wed, 2 Oct 2002 00:47:00 -0400
Received: from starcraft.mweb.co.za ([196.2.45.78]:38636 "EHLO
	starcraft.mweb.co.za") by vger.kernel.org with ESMTP
	id <S262966AbSJBEq6>; Wed, 2 Oct 2002 00:46:58 -0400
Subject: [PATCH] 2.5.40 Plip Compilation error
From: Bongani <bonganilinux@mweb.co.za>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-3mdk 
Date: 02 Oct 2002 06:55:42 +0200
Message-Id: <1033534543.2117.29.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I got this compilation error wile compiling 2.5.40. The patch below
fixes the problem.

make[2]: Entering directory `/usr/src/linux-2.5/drivers/net'
  gcc -Wp,-MD,./.plip.o.d -D__KERNEL__ -I/usr/src/linux-2.5/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -I/usr/src/linux-2.5/arch/i386/mach-generic -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=plip   -c -o plip.o plip.c
drivers/net/plip.c: In function `plip_kick_bh':
drivers/net/plip.c:382: warning: implicit declaration of function
`queue_task'
drivers/net/plip.c:382: `tq_immediate' undeclared (first use in this
function)
drivers/net/plip.c:382: (Each undeclared identifier is reported only
once
drivers/net/plip.c:382: for each function it appears in.)
drivers/net/plip.c:383: warning: implicit declaration of function
`mark_bh'
drivers/net/plip.c:383: `IMMEDIATE_BH' undeclared (first use in this
function)
drivers/net/plip.c: In function `plip_bh':
drivers/net/plip.c:435: `tq_timer' undeclared (first use in this
function)
drivers/net/plip.c: In function `plip_timer_bh':
drivers/net/plip.c:447: `tq_timer' undeclared (first use in this
function)
drivers/net/plip.c: In function `plip_receive_packet':
drivers/net/plip.c:668: `tq_timer' undeclared (first use in this
function)
drivers/net/plip.c:743: `tq_immediate' undeclared (first use in this
function)
drivers/net/plip.c:744: `IMMEDIATE_BH' undeclared (first use in this
function)
drivers/net/plip.c: In function `plip_send_packet':
drivers/net/plip.c:912: `tq_timer' undeclared (first use in this
function)
drivers/net/plip.c: In function `plip_error':
drivers/net/plip.c:956: `tq_timer' undeclared (first use in this
function)
drivers/net/plip.c: In function `plip_interrupt':
drivers/net/plip.c:1000: `tq_immediate' undeclared (first use in this
function)
drivers/net/plip.c:1001: `IMMEDIATE_BH' undeclared (first use in this
function)
drivers/net/plip.c: In function `plip_tx_packet':
drivers/net/plip.c:1054: `tq_immediate' undeclared (first use in this
function)
drivers/net/plip.c:1055: `IMMEDIATE_BH' undeclared (first use in this
function)
drivers/net/plip.c: In function `plip_open':
drivers/net/plip.c:1134: `tq_timer' undeclared (first use in this
function)
   ld -m elf_i386  -r -o built-in.o plip.o Space.o setup.o net_init.o
loopback.o ppp_generic.o slhc.o ppp_async.o ppp_synctty.o ppp_deflate.o
bsd_comp.o slip.o dummy.o
ld: cannot open plip.o: No such file or directory
make[2]: *** [built-in.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5/drivers/net'
make[1]: *** [net] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5/drivers'
make: *** [drivers] Error 2



And the Patch

diff -uNr linux-2.5/drivers/net/plip.c.old linux-2.5/drivers/net/plip.c
--- linux-2.5/drivers/net/plip.c.old	2002-10-02 06:47:23.000000000 +0200
+++ linux-2.5/drivers/net/plip.c	2002-10-02 06:49:40.000000000 +0200
@@ -379,8 +379,7 @@
 	struct net_local *nl = (struct net_local *)dev->priv;
 
 	if (nl->is_deferred) {
-		queue_task(&nl->immediate, &tq_immediate);
-		mark_bh(IMMEDIATE_BH);
+		schedule_task(&nl->immediate);
 	}
 }
 
@@ -432,7 +431,7 @@
 	if ((r = (*f)(dev, nl, snd, rcv)) != OK
 	    && (r = plip_bh_timeout_error(dev, nl, snd, rcv, r)) != OK) {
 		nl->is_deferred = 1;
-		queue_task(&nl->deferred, &tq_timer);
+		schedule_task(&nl->deferred);
 	}
 }
 
@@ -444,7 +443,7 @@
 	if (!(atomic_read (&nl->kill_timer))) {
 		plip_interrupt (-1, dev, NULL);
 
-		queue_task (&nl->timer, &tq_timer);
+		schedule_task(&nl->timer);
 	}
 	else {
 		up (&nl->killed_timer_sem);
@@ -665,7 +664,7 @@
 				rcv->state = PLIP_PK_DONE;
 				nl->is_deferred = 1;
 				nl->connection = PLIP_CN_SEND;
-				queue_task(&nl->deferred, &tq_timer);
+				schedule_task(&nl->deferred);
 				enable_parport_interrupts (dev);
 				ENABLE(dev->irq);
 				return OK;
@@ -740,8 +739,7 @@
 		if (snd->state != PLIP_PK_DONE) {
 			nl->connection = PLIP_CN_SEND;
 			spin_unlock_irq(&nl->lock);
-			queue_task(&nl->immediate, &tq_immediate);
-			mark_bh(IMMEDIATE_BH);
+			schedule_task(&nl->immediate);
 			enable_parport_interrupts (dev);
 			ENABLE(dev->irq);
 			return OK;
@@ -909,7 +907,7 @@
 			printk(KERN_DEBUG "%s: send end\n", dev->name);
 		nl->connection = PLIP_CN_CLOSING;
 		nl->is_deferred = 1;
-		queue_task(&nl->deferred, &tq_timer);
+		schedule_task(&nl->deferred);
 		enable_parport_interrupts (dev);
 		ENABLE(dev->irq);
 		return OK;
@@ -953,7 +951,7 @@
 		netif_wake_queue (dev);
 	} else {
 		nl->is_deferred = 1;
-		queue_task(&nl->deferred, &tq_timer);
+		schedule_task(&nl->deferred);
 	}
 
 	return OK;
@@ -997,8 +995,7 @@
 		rcv->state = PLIP_PK_TRIGGER;
 		nl->connection = PLIP_CN_RECEIVE;
 		nl->timeout_count = 0;
-		queue_task(&nl->immediate, &tq_immediate);
-		mark_bh(IMMEDIATE_BH);
+		schedule_task(&nl->immediate);
 		break;
 
 	case PLIP_CN_RECEIVE:
@@ -1051,8 +1048,7 @@
 		nl->connection = PLIP_CN_SEND;
 		nl->timeout_count = 0;
 	}
-	queue_task(&nl->immediate, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&nl->immediate);
 	spin_unlock_irq(&nl->lock);
 	
 	return 0;
@@ -1131,7 +1127,7 @@
 	if (dev->irq == -1)
 	{
 		atomic_set (&nl->kill_timer, 0);
-		queue_task (&nl->timer, &tq_timer);
+		schedule_task (&nl->timer);
 	}
 
 	/* Initialize the state machine. */



