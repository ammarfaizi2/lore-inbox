Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWATJ5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWATJ5K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 04:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWATJ5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 04:57:10 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:60609 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750780AbWATJ5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 04:57:02 -0500
Date: Fri, 20 Jan 2006 12:55:48 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: kus Kusche Klaus <kus@keba.com>
Cc: John Ronciak <john.ronciak@gmail.com>, Adrian Bunk <bunk@stusta.de>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       john.ronciak@intel.com, ganesh.venkatesan@intel.com,
       jesse.brandeburg@intel.com, netdev@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: My vote against eepro* removal
Message-ID: <20060120095548.GA16000@2ka.mipt.ru>
References: <AAD6DA242BC63C488511C611BD51F367323324@MAILIT.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323324@MAILIT.keba.co.at>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 20 Jan 2006 12:55:49 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 10:37:43AM +0100, kus Kusche Klaus (kus@keba.com) wrote:
> > From: John Ronciak
> > During the watchdog the e100 driver reads all of the status registers
> > from the actual hardware.  There are 26 (worst case) register reads. 
> > There is also a spin lock for another check in the watchdog.  It would
> > still surprise me that all of this would take 500 usec.  If you are
> > seeing this delay, you can comment out the scheduling of the watchdog
> > to see if this goes away.  We'll need to narrow down exactly what in
> > the watchdog is causing the delay
> 
> Retested it.

...

> Effect of the e100 driver:
> * There is no measurable effect when my test program is running
>   at prio 2 - 99.
> * For prio 1, I get an interval of 500-650 us every 2 seconds,
>   which indicates a scheduling latency of 380-530 us.
> Hence, some piece of code is running for ~500 us at rt prio 1.
> 
> Analysis of e100:
> * If I comment out the whole body of e100_watchdog except for the
>   timer re-registration, the delays are gone (so it is really the
>   body of e100_watchdog). However, this makes eth0 non-functional.
> * Commenting out parts of it, I found out that most of the time
>   goes into its first half: The code from mii_ethtool_gset to
>   mii_check_link (including) makes the big difference, as far as
>   I can tell especially mii_ethtool_gset.

Each MDIO read can take upto 2 msecs (!) and at least 20 usecs in e100,
and this runs in timer handler.
Concider attaching (only compile tested) patch which moves e100 watchdog
into workqueue.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

diff --git a/drivers/net/e100.c b/drivers/net/e100.c
index 22cd045..e884578 100644
--- a/drivers/net/e100.c
+++ b/drivers/net/e100.c
@@ -549,7 +549,7 @@ struct nic {
 	enum phy phy;
 	struct params params;
 	struct net_device_stats net_stats;
-	struct timer_list watchdog;
+	struct work_struct watchdog;
 	struct timer_list blink_timer;
 	struct mii_if_info mii;
 	struct work_struct tx_timeout_task;
@@ -1495,7 +1495,7 @@ static void e100_adjust_adaptive_ifs(str
 	}
 }
 
-static void e100_watchdog(unsigned long data)
+static void e100_watchdog(void *data)
 {
 	struct nic *nic = (struct nic *)data;
 	struct ethtool_cmd cmd;
@@ -1539,7 +1539,7 @@ static void e100_watchdog(unsigned long 
 	else
 		nic->flags &= ~ich_10h_workaround;
 
-	mod_timer(&nic->watchdog, jiffies + E100_WATCHDOG_PERIOD);
+	schedule_delayed_work(&nic->watchdog, E100_WATCHDOG_PERIOD);
 }
 
 static inline void e100_xmit_prepare(struct nic *nic, struct cb *cb,
@@ -2004,7 +2004,7 @@ static int e100_up(struct nic *nic)
 		goto err_clean_cbs;
 	e100_set_multicast_list(nic->netdev);
 	e100_start_receiver(nic, NULL);
-	mod_timer(&nic->watchdog, jiffies);
+	schedule_work(&nic->watchdog);
 	if((err = request_irq(nic->pdev->irq, e100_intr, SA_SHIRQ,
 		nic->netdev->name, nic->netdev)))
 		goto err_no_irq;
@@ -2016,7 +2016,7 @@ static int e100_up(struct nic *nic)
 	return 0;
 
 err_no_irq:
-	del_timer_sync(&nic->watchdog);
+	cancel_rearming_delayed_work(&nic->watchdog);
 err_clean_cbs:
 	e100_clean_cbs(nic);
 err_rx_clean_list:
@@ -2031,7 +2031,7 @@ static void e100_down(struct nic *nic)
 	netif_stop_queue(nic->netdev);
 	e100_hw_reset(nic);
 	free_irq(nic->pdev->irq, nic->netdev);
-	del_timer_sync(&nic->watchdog);
+	flush_scheduled_work();
 	netif_carrier_off(nic->netdev);
 	e100_clean_cbs(nic);
 	e100_rx_clean_list(nic);
@@ -2570,9 +2570,7 @@ static int __devinit e100_probe(struct p
 
 	pci_set_master(pdev);
 
-	init_timer(&nic->watchdog);
-	nic->watchdog.function = e100_watchdog;
-	nic->watchdog.data = (unsigned long)nic;
+	INIT_WORK(&nic->watchdog, e100_watchdog, nic);
 	init_timer(&nic->blink_timer);
 	nic->blink_timer.function = e100_blink_led;
 	nic->blink_timer.data = (unsigned long)nic;

> -- 
> Klaus Kusche                 (Software Development - Control Systems)
> KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
> Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
> E-Mail: kus@keba.com                                WWW: www.keba.com

-- 
	Evgeniy Polyakov
