Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272588AbTHEJIs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 05:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272590AbTHEJIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 05:08:24 -0400
Received: from zeus.kernel.org ([204.152.189.113]:60827 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272588AbTHEJIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 05:08:19 -0400
Date: Tue, 5 Aug 2003 10:53:57 +0200 (MEST)
From: Javier Achirica <achirica@telefonica.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] airo driver: fix races, oops, etc..
In-Reply-To: <1059483772.8545.13.camel@gaston>
Message-ID: <Pine.SOL.4.30.0308051048130.2746-100000@tudela.mad.ttd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've integrated this patch in my code. I've done a major change: Instead
of using schedule_delayed_work(), I create a new workqueue and use
queue_work() on that queue. As all tasks sleep in the same lock, I can
queue them there and make them sleep instead of requeueing them.

I haven't sent them to Jeff yet, as I want to do more testing. If you want
to help testing them, please tell me.

Javier Achirica

On 29 Jul 2003, Benjamin Herrenschmidt wrote:

> Hi !
>
> Here's a patch against Linus current airo.c, it adds back some fixes I
> did during OLS on the previous version of this driver. I couldn't test
> this new 'fixed' version though as I don't have the airo card anymore:
>
>  - Initialize the work_struct structures used by the driver
>  - Change most of schedule_work() to schedule_delayed_work(). The
>    problem with schedule_work() is that the worker_thread will never
>    schedule() if the work keeps getting added back to the list by the
>    callback, which typically happened with this driver when the xmit
>    work gets scheduled while the semaphore was used by a pending
>    command. Note that -ac tree has a modified version of this driver
>    that gets rid of this "over-smart" work queue stuff and uses normal
>    spinlock instead, probably at the expense of some latency...
>  - Fix a small signed vs. unsigned char issue
>  - Remove bogus pci_module_init(), use pci_register_driver() instead and
>    add missing pci_unregister_driver() so the module can now be removed
>    without leaving stale references (and thus avoid an oops next time
>    the driver list is walked by the device core).
>
> Jeff, if you are ok with these, please send to Linus,
>
> Ben
>
>
> diff -urN linux-2.5/drivers/net/wireless/airo.c linuxppc-2.5-benh/drivers/net/wireless/airo.c
> --- linux-2.5/drivers/net/wireless/airo.c	2003-07-29 08:51:06.000000000 -0400
> +++ linuxppc-2.5-benh/drivers/net/wireless/airo.c	2003-07-29 08:54:26.000000000 -0400
> @@ -633,7 +633,7 @@
>  	u16 SSIDlen;
>  	char SSID[32];
>  	char apName[16];
> -	char bssid[4][ETH_ALEN];
> +	unsigned char bssid[4][ETH_ALEN];
>  	u16 beaconPeriod;
>  	u16 dimPeriod;
>  	u16 atimDuration;
> @@ -1031,7 +1031,7 @@
>  	struct work_struct promisc_task;
>  	struct {
>  		struct sk_buff *skb;
> -		int fid;
> +		int fid, hardirq;
>  		struct work_struct task;
>  	} xmit, xmit11;
>  	struct net_device *wifidev;
> @@ -1348,7 +1348,12 @@
>  		netif_stop_queue(dev);
>  		priv->xmit.task.func = (void (*)(void *))airo_do_xmit;
>  		priv->xmit.task.data = (void *)dev;
> -		schedule_work(&priv->xmit.task);
> +		if (priv->xmit.hardirq) {
> +			priv->xmit.hardirq = 0;
> +			schedule_work(&priv->xmit.task);
> +			return;
> +		}
> +		schedule_delayed_work(&priv->xmit.task, 1);
>  		return;
>  	}
>  	status = transmit_802_3_packet (priv, fids[fid], skb->data);
> @@ -1393,6 +1398,7 @@
>  		fids[i] |= (len << 16);
>  		priv->xmit.skb = skb;
>  		priv->xmit.fid = i;
> +		priv->xmit.hardirq = 1;
>  		airo_do_xmit(dev);
>  	}
>  	return 0;
> @@ -1410,7 +1416,12 @@
>  		netif_stop_queue(dev);
>  		priv->xmit11.task.func = (void (*)(void *))airo_do_xmit11;
>  		priv->xmit11.task.data = (void *)dev;
> -		schedule_work(&priv->xmit11.task);
> +		if (priv->xmit11.hardirq) {
> +			priv->xmit11.hardirq = 0;
> +			schedule_work(&priv->xmit11.task);
> +			return;
> +		}
> +		schedule_delayed_work(&priv->xmit11.task, 1);
>  		return;
>  	}
>  	status = transmit_802_11_packet (priv, fids[fid], skb->data);
> @@ -1485,7 +1496,7 @@
>  	} else {
>  		ai->stats_task.func = (void (*)(void *))airo_read_stats;
>  		ai->stats_task.data = (void *)ai;
> -		schedule_work(&ai->stats_task);
> +		schedule_delayed_work(&ai->stats_task, 1);
>  	}
>  }
>
> @@ -1508,7 +1519,7 @@
>  	} else {
>  		ai->promisc_task.func = (void (*)(void *))airo_end_promisc;
>  		ai->promisc_task.data = (void *)ai;
> -		schedule_work(&ai->promisc_task);
> +		schedule_delayed_work(&ai->promisc_task, 1);
>  	}
>  }
>
> @@ -1524,7 +1535,7 @@
>  	} else {
>  		ai->promisc_task.func = (void (*)(void *))airo_set_promisc;
>  		ai->promisc_task.data = (void *)ai;
> -		schedule_work(&ai->promisc_task);
> +		schedule_delayed_work(&ai->promisc_task, 1);
>  	}
>  }
>
> @@ -1710,6 +1721,14 @@
>  	sema_init(&ai->sem, 1);
>  	ai->need_commit = 0;
>  	ai->config.len = 0;
> +	INIT_WORK(&ai->stats_task, NULL, NULL);
> +	INIT_WORK(&ai->promisc_task, NULL, NULL);
> +	INIT_WORK(&ai->xmit.task, NULL, NULL);
> +	INIT_WORK(&ai->xmit11.task, NULL, NULL);
> +	INIT_WORK(&ai->mic_task, NULL, NULL);
> +#ifdef WIRELESS_EXT
> +	INIT_WORK(&ai->event_task, NULL, NULL);
> +#endif
>  	rc = add_airo_dev( dev );
>  	if (rc)
>  		goto err_out_free;
> @@ -1859,7 +1878,7 @@
>  	} else {
>  		ai->event_task.func = (void (*)(void *))airo_send_event;
>  		ai->event_task.data = (void *)dev;
> -		schedule_work(&ai->event_task);
> +		schedule_delayed_work(&ai->event_task, 1);
>  	}
>  }
>  #endif
> @@ -1876,7 +1895,7 @@
>  	} else {
>  		ai->mic_task.func = (void (*)(void *))airo_read_mic;
>  		ai->mic_task.data = (void *)ai;
> -		schedule_work(&ai->mic_task);
> +		schedule_delayed_work(&ai->mic_task, 1);
>  	}
>  }
>
> @@ -4090,7 +4109,7 @@
>
>  #ifdef CONFIG_PCI
>  	printk( KERN_INFO "airo:  Probing for PCI adapters\n" );
> -	rc = pci_module_init(&airo_driver);
> +	rc = pci_register_driver(&airo_driver);
>  	printk( KERN_INFO "airo:  Finished probing for PCI adapters\n" );
>  #endif
>
> @@ -4102,6 +4121,7 @@
>
>  static void __exit airo_cleanup_module( void )
>  {
> +	pci_unregister_driver(&airo_driver);
>  	while( airo_devices ) {
>  		printk( KERN_INFO "airo: Unregistering %s\n", airo_devices->dev->name );
>  		stop_airo_card( airo_devices->dev, 1 );
> @@ -5160,7 +5180,7 @@
>  			      & status_rid.bssid[i][2]
>  			      & status_rid.bssid[i][3]
>  			      & status_rid.bssid[i][4]
> -			      & status_rid.bssid[i][5])!=-1 &&
> +			      & status_rid.bssid[i][5])!=0xff &&
>  			     (status_rid.bssid[i][0]
>  			      | status_rid.bssid[i][1]
>  			      | status_rid.bssid[i][2]
>
>
>

