Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTGOE2A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 00:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTGOE2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 00:28:00 -0400
Received: from fmr06.intel.com ([134.134.136.7]:64996 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261566AbTGOE15 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 00:27:57 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [patch] e1000 TSO parameter
Date: Mon, 14 Jul 2003 21:42:40 -0700
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E0102229169@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] e1000 TSO parameter
Thread-Index: AcNKZ+mReyrU+xYURTSavf3gjrZ7aQAHMc8w
From: "Feldman, Scott" <scott.feldman@intel.com>
To: <davidm@hpl.hp.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
X-OriginalArrivalTime: 15 Jul 2003 04:42:41.0290 (UTC) FILETIME=[866FF6A0:01C34A8B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Moving over to netdev]

> Hi Scott,
> 
> Would you mind applying the attached patch for the e1000 
> driver?  The patch adds a "TSO" option which lets you disable 
> TSO at boot-time/module-insertion time.  This is useful for 
> experimentation and, on fast machines, you can actually get 
> better netperf numbers with TSO disabled. ;-)

This is interesting.  I assume you're trying to get the best throughput
regardless of CPU utilization.  Why are we getting lower throughput
rates?  It's an open question for netdev.  Do you have any data to
share?
 
> Note that I had to move the e1000_check_options() call to a 
> slighly earlier place.  You may want to double-check that 
> it's really OK.

I'm not too keen on adding another module parameter.  Maybe a
CONFIG_E1000_TSO option?

> The patch is relative to 2.5.75.
> 
> Thanks,
> 
> 	--david
> 
> # This is a BitKeeper generated patch for the following 
> project: # Project Name: Linux kernel tree # This patch 
> format is intended for GNU patch command version 2.5 or 
> higher. # This patch includes the following deltas:
> #	           ChangeSet	1.1379  -> 1.1380 
> #	drivers/net/e1000/e1000.h	1.33    -> 1.34   
> #	drivers/net/e1000/e1000_main.c	1.77    -> 1.78   
> #	drivers/net/e1000/e1000_param.c	1.21    -> 1.22   
> #
> # The following is the BitKeeper ChangeSet Log
> # --------------------------------------------
> # 03/07/14	davidm@tiger.hpl.hp.com	1.1380
> # Make it possible to disable TSO at module-load time (or 
> boot-time). # This is controlled via the TSO parameter (e.g., 
> modprobe e1000 TSO=0,0,0,0 # will disable TSO on the first 4 
> e1000 NICs). # --------------------------------------------
> #
> diff -Nru a/drivers/net/e1000/e1000.h b/drivers/net/e1000/e1000.h
> --- a/drivers/net/e1000/e1000.h	Mon Jul 14 17:29:30 2003
> +++ b/drivers/net/e1000/e1000.h	Mon Jul 14 17:29:30 2003
> @@ -194,6 +194,7 @@
>  	uint32_t tx_head_addr;
>  	uint32_t tx_fifo_size;
>  	atomic_t tx_fifo_stall;
> +	boolean_t tso;
>  
>  	/* RX */
>  	struct e1000_desc_ring rx_ring;
> diff -Nru a/drivers/net/e1000/e1000_main.c 
> b/drivers/net/e1000/e1000_main.c
> --- a/drivers/net/e1000/e1000_main.c	Mon Jul 14 17:29:30 2003
> +++ b/drivers/net/e1000/e1000_main.c	Mon Jul 14 17:29:30 2003
> @@ -417,9 +417,12 @@
>  		netdev->features = NETIF_F_SG;
>  	}
>  
> +	e1000_check_options(adapter);
> +
>  #ifdef NETIF_F_TSO
>  	if((adapter->hw.mac_type >= e1000_82544) &&
> -	   (adapter->hw.mac_type != e1000_82547))
> +	   (adapter->hw.mac_type != e1000_82547) &&
> +	   adapter->tso)
>  		netdev->features |= NETIF_F_TSO;
>  #endif
>  
> @@ -469,7 +472,6 @@
>  
>  	printk(KERN_INFO "%s: Intel(R) PRO/1000 Network Connection\n",
>  	       netdev->name);
> -	e1000_check_options(adapter);
>  
>  	/* Initial Wake on LAN setting
>  	 * If APM wake is enabled in the EEPROM,
> diff -Nru a/drivers/net/e1000/e1000_param.c 
> b/drivers/net/e1000/e1000_param.c
> --- a/drivers/net/e1000/e1000_param.c	Mon Jul 14 17:29:30 2003
> +++ b/drivers/net/e1000/e1000_param.c	Mon Jul 14 17:29:30 2003
> @@ -192,6 +192,16 @@
>  
>  E1000_PARAM(InterruptThrottleRate, "Interrupt Throttling Rate");
>  
> +/* Enable TSO - TCP Segmentation Offload Enable/Disable
> + *
> + * Valid Range: 0, 1
> + *  - 0 - disables TSO
> + *  - 1 - enables TSO on NICs that are TSO capable
> + *
> + * Default Value: 1
> + */
> +E1000_PARAM(TSO, "Disable or enable TSO");
> +
>  #define AUTONEG_ADV_DEFAULT  0x2F
>  #define AUTONEG_ADV_MASK     0x2F
>  #define FLOW_CONTROL_DEFAULT FLOW_CONTROL_FULL
> @@ -454,6 +464,18 @@
>  		} else {
>  			e1000_validate_option(&adapter->itr, &opt);
>  		}
> +	}
> +	{ /* TSO Enable/Disable */
> +		struct e1000_option opt = {
> +			.type = enable_option,
> +			.name = "TSO",
> +			.err  = "defaulting to Enabled",
> +			.def  = OPTION_ENABLED
> +		};
> +
> +		int tso = TSO[bd];
> +		e1000_validate_option(&tso, &opt);
> +		adapter->tso = tso;
>  	}
>  
>  	switch(adapter->hw.media_type) {
> 
