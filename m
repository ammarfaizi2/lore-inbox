Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbTFTGLP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 02:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbTFTGLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 02:11:14 -0400
Received: from [203.145.184.221] ([203.145.184.221]:57353 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S262403AbTFTGLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 02:11:06 -0400
Subject: [PATCH 2.4.21][FIX] use mod_timer
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: Marcelo Tosatti <marcelo@hera.kernel.org>
Cc: netdev@oss.sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       Alan Cox <alan@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Jun 2003 12:06:40 +0530
Message-Id: <1056091000.1200.23.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch makes use of mod_timer instead of {del,add}_timer.

Most of the patches already in -ac series since 2.4.21-rc2 and few of
the networking fixes in 2.5.69

The following files are affected:

arch/ia64/sn/kernel/irq.c
arch/ia64/sn/kernel/mca.c
drivers/block/floppy.c
drivers/net/wan/sdla_chdlc.c
drivers/net/wan/sdla_fr.c
drivers/net/wan/sdla_x25.c
net/core/dst.c
net/sched/sch_cbq.c
net/sched/sch_csz.c
net/sched/sch_htb.c


diff -urN linux-2.4.21/arch/ia64/sn/kernel/irq.c linux-2.4.21-nvk/arch/ia64/sn/kernel/irq.c
--- linux-2.4.21/arch/ia64/sn/kernel/irq.c	2003-06-14 10:09:52.000000000 +0530
+++ linux-2.4.21-nvk/arch/ia64/sn/kernel/irq.c	2003-06-20 10:38:47.000000000 +0530
@@ -303,9 +303,7 @@
 			bridge->b_force_always[intr_test_registered[i].slot].intr = 1;
 		}
 	}
-	del_timer(&intr_test_timer);
-	intr_test_timer.expires = jiffies + HZ/100;
-	add_timer(&intr_test_timer);
+	mod_timer(&intr_test_timer, jiffies + HZ/100);
 }
 
 void
diff -urN linux-2.4.21/arch/ia64/sn/kernel/mca.c linux-2.4.21-nvk/arch/ia64/sn/kernel/mca.c
--- linux-2.4.21/arch/ia64/sn/kernel/mca.c	2003-06-14 10:09:52.000000000 +0530
+++ linux-2.4.21-nvk/arch/ia64/sn/kernel/mca.c	2003-06-20 11:00:11.000000000 +0530
@@ -123,9 +123,7 @@
 static void
 sn_cpei_timer_handler(unsigned long dummy) {
 	sn_cpei_handler(-1, NULL, NULL);
-	del_timer(&sn_cpei_timer);
-	sn_cpei_timer.expires = jiffies + CPEI_INTERVAL;
-        add_timer(&sn_cpei_timer);
+	mod_timer(&sn_cpei_timer, jiffies + CPEI_INTERVAL);
 }
 
 void
@@ -147,9 +145,7 @@
 	unsigned long *pi_ce_error_inject_reg = 0xc00000092fffff00;
 
 	*pi_ce_error_inject_reg = 0x0000000000000100;
-	del_timer(&sn_ce_timer);
-	sn_ce_timer.expires = jiffies + CPEI_INTERVAL;
-        add_timer(&sn_ce_timer);
+	mod_timer(&sn_ce_timer, jiffies + CPEI_INTERVAL);
 }
 
 sn_init_ce_timer() {
diff -urN linux-2.4.21/drivers/net/wan/sdla_chdlc.c linux-2.4.21-nvk/drivers/net/wan/sdla_chdlc.c
--- linux-2.4.21/drivers/net/wan/sdla_chdlc.c	2003-06-14 10:03:17.000000000 +0530
+++ linux-2.4.21-nvk/drivers/net/wan/sdla_chdlc.c	2003-06-20 10:38:40.000000000 +0530
@@ -1089,13 +1089,11 @@
 	
 	set_bit(0,&chdlc_priv_area->config_chdlc);
 	chdlc_priv_area->config_chdlc_timeout=jiffies;
-	del_timer(&chdlc_priv_area->poll_delay_timer);
 
 	/* Start the CHDLC configuration after 1sec delay.
 	 * This will give the interface initilization time
 	 * to finish its configuration */
-	chdlc_priv_area->poll_delay_timer.expires=jiffies+HZ;
-	add_timer(&chdlc_priv_area->poll_delay_timer);
+	mod_timer(&chdlc_priv_area->poll_delay_timer, jiffies + HZ);
 	return err;
 }
 
diff -urN linux-2.4.21/drivers/net/wan/sdla_fr.c linux-2.4.21-nvk/drivers/net/wan/sdla_fr.c
--- linux-2.4.21/drivers/net/wan/sdla_fr.c	2003-06-14 10:03:17.000000000 +0530
+++ linux-2.4.21-nvk/drivers/net/wan/sdla_fr.c	2003-06-20 10:38:31.000000000 +0530
@@ -4541,9 +4541,7 @@
 {
 	fr_channel_t* chan = dev->priv;
 
-	del_timer(&chan->fr_arp_timer);
-	chan->fr_arp_timer.expires = jiffies + (chan->inarp_interval * HZ);
-	add_timer(&chan->fr_arp_timer);
+	mod_timer(&chan->fr_arp_timer, jiffies + chan->inarp_interval * HZ);
 	return;
 }
 
diff -urN linux-2.4.21/drivers/net/wan/sdla_ppp.c linux-2.4.21-nvk/drivers/net/wan/sdla_ppp.c
--- linux-2.4.21/drivers/net/wan/sdla_ppp.c	2003-06-14 10:03:17.000000000 +0530
+++ linux-2.4.21-nvk/drivers/net/wan/sdla_ppp.c	2003-06-20 10:34:06.000000000 +0530
@@ -841,9 +841,7 @@
 	/* Start the PPP configuration after 1sec delay.
 	 * This will give the interface initilization time
 	 * to finish its configuration */
-	del_timer(&ppp_priv_area->poll_delay_timer);
-	ppp_priv_area->poll_delay_timer.expires = jiffies+HZ;
-	add_timer(&ppp_priv_area->poll_delay_timer);
+	mod_timer(&ppp_priv_area->poll_delay_timer, jiffies + HZ);
 	return 0;
 }
 
diff -urN linux-2.4.21/drivers/net/wan/sdla_x25.c linux-2.4.21-nvk/drivers/net/wan/sdla_x25.c
--- linux-2.4.21/drivers/net/wan/sdla_x25.c	2003-06-14 10:10:14.000000000 +0530
+++ linux-2.4.21-nvk/drivers/net/wan/sdla_x25.c	2003-06-20 10:33:30.000000000 +0530
@@ -1267,9 +1267,7 @@
 			connect(card);
 			S508_S514_unlock(card, &smp_flags);
 
-			del_timer(&card->u.x.x25_timer);
-			card->u.x.x25_timer.expires=jiffies+HZ;
-			add_timer(&card->u.x.x25_timer);
+			mod_timer(&card->u.x.x25_timer, jiffies + HZ);
 		}
 	}
 	/* Device is not up until the we are in connected state */
diff -urN linux-2.4.21/net/core/dst.c linux-2.4.21-nvk/net/core/dst.c
--- linux-2.4.21/net/core/dst.c	2003-06-14 10:03:10.000000000 +0530
+++ linux-2.4.21-nvk/net/core/dst.c	2003-06-20 10:33:16.000000000 +0530
@@ -131,11 +131,9 @@
 	dst->next = dst_garbage_list;
 	dst_garbage_list = dst;
 	if (dst_gc_timer_inc > DST_GC_INC) {
-		del_timer(&dst_gc_timer);
 		dst_gc_timer_inc = DST_GC_INC;
 		dst_gc_timer_expires = DST_GC_MIN;
-		dst_gc_timer.expires = jiffies + dst_gc_timer_expires;
-		add_timer(&dst_gc_timer);
+		mod_timer(&dst_gc_timer, jiffies + dst_gc_timer_expires);
 	}
 
 	spin_unlock_bh(&dst_lock);
diff -urN linux-2.4.21/net/sched/sch_cbq.c linux-2.4.21-nvk/net/sched/sch_cbq.c
--- linux-2.4.21/net/sched/sch_cbq.c	2003-06-14 10:03:13.000000000 +0530
+++ linux-2.4.21-nvk/net/sched/sch_cbq.c	2003-06-20 10:38:53.000000000 +0530
@@ -1056,11 +1056,9 @@
 		sch->stats.overlimits++;
 		if (q->wd_expires && !netif_queue_stopped(sch->dev)) {
 			long delay = PSCHED_US2JIFFIE(q->wd_expires);
-			del_timer(&q->wd_timer);
 			if (delay <= 0)
 				delay = 1;
-			q->wd_timer.expires = jiffies + delay;
-			add_timer(&q->wd_timer);
+			mod_timer(&q->wd_timer, jiffies + delay);
 			sch->flags |= TCQ_F_THROTTLED;
 		}
 	}
diff -urN linux-2.4.21/net/sched/sch_csz.c linux-2.4.21-nvk/net/sched/sch_csz.c
--- linux-2.4.21/net/sched/sch_csz.c	2003-06-14 10:10:35.000000000 +0530
+++ linux-2.4.21-nvk/net/sched/sch_csz.c	2003-06-20 10:38:59.000000000 +0530
@@ -708,11 +708,9 @@
 	 */
 	if (q->wd_expires) {
 		unsigned long delay = PSCHED_US2JIFFIE(q->wd_expires);
-		del_timer(&q->wd_timer);
 		if (delay == 0)
 			delay = 1;
-		q->wd_timer.expires = jiffies + delay;
-		add_timer(&q->wd_timer);
+		mod_timer(&q->wd_timer, jiffies + delay);
 		sch->stats.overlimits++;
 	}
 #endif
diff -urN linux-2.4.21/net/sched/sch_htb.c linux-2.4.21-nvk/net/sched/sch_htb.c
--- linux-2.4.21/net/sched/sch_htb.c	2003-06-14 10:10:35.000000000 +0530
+++ linux-2.4.21-nvk/net/sched/sch_htb.c	2003-06-20 10:39:05.000000000 +0530
@@ -986,9 +986,7 @@
 			printk(KERN_INFO "HTB delay %ld > 5sec\n", delay);
 		delay = 5*HZ;
 	}
-	del_timer(&q->timer);
-	q->timer.expires = jiffies + delay;
-	add_timer(&q->timer);
+	mod_timer(&q->timer, jiffies + delay);
 	sch->flags |= TCQ_F_THROTTLED;
 	sch->stats.overlimits++;
 	HTB_DBG(3,1,"htb_deq t_delay=%ld\n",delay);
diff -urN linux-2.4.21/drivers/block/floppy.c linux-2.4.21-nvk/drivers/block/floppy.c
--- linux-2.4.21/drivers/block/floppy.c	2003-06-14 10:03:23.000000000 +0530
+++ linux-2.4.21-nvk/drivers/block/floppy.c	2003-06-20 10:44:28.000000000 +0530
@@ -652,15 +652,16 @@
 
 static void reschedule_timeout(int drive, const char *message, int marg)
 {
+	unsigned long delay;
+	
 	if (drive == CURRENTD)
 		drive = current_drive;
-	del_timer(&fd_timeout);
 	if (drive < 0 || drive > N_DRIVE) {
-		fd_timeout.expires = jiffies + 20UL*HZ;
+		delay = 20UL*HZ;
 		drive=0;
 	} else
-		fd_timeout.expires = jiffies + UDP->timeout;
-	add_timer(&fd_timeout);
+		delay =  UDP->timeout;
+	mod_timer(&fd_timeout, delay + jiffies);
 	if (UDP->flags & FD_DEBUG){
 		DPRINT("reschedule timeout ");
 		printk(message, marg);




