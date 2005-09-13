Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbVIMS2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbVIMS2H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 14:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbVIMS2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 14:28:07 -0400
Received: from mf00.sitadelle.com ([212.94.174.67]:39536 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S964958AbVIMS2G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 14:28:06 -0400
Message-ID: <43271A28.9090301@cosmosbay.com>
Date: Tue, 13 Sep 2005 20:27:52 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, bharata@in.ibm.com, shai@scalex86.org,
       Rusty Russell <rusty@rustcorp.com.au>, netdev@vger.kernel.org,
       davem@davemloft.net
Subject: Re: [patch 7/11] net: Use bigrefs for net_device.refcount
References: <20050913155112.GB3570@localhost.localdomain> <20050913161012.GI3570@localhost.localdomain>
In-Reply-To: <20050913161012.GI3570@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai a écrit :
> The net_device has a refcnt used to keep track of it's uses.
> This is used at the time of unregistering the network device
> (module unloading ..) (see netdev_wait_allrefs) .
> For loopback_dev , this refcnt increment/decrement  is causing
> unnecessary traffic on the interlink for NUMA system
> affecting it's performance.  This patch improves tbench numbers by 6% on a
> 8way x86 Xeon (x445).
  ===================================================================
> --- alloc_percpu-2.6.13.orig/include/linux/netdevice.h	2005-08-28 16:41:01.000000000 -0700
> +++ alloc_percpu-2.6.13/include/linux/netdevice.h	2005-09-12 11:54:21.000000000 -0700
> @@ -37,6 +37,7 @@
>  #include <linux/config.h>
>  #include <linux/device.h>
>  #include <linux/percpu.h>
> +#include <linux/bigref.h>
>  
>  struct divert_blk;
>  struct vlan_group;
> @@ -377,7 +378,7 @@
>  	/* device queue lock */
>  	spinlock_t		queue_lock;
>  	/* Number of references to this device */
> -	atomic_t		refcnt;
> +	struct bigref	        netdev_refcnt;	
>  	/* delayed register/unregister */
>  	struct list_head	todo_list;
>  	/* device name hash chain */
> @@ -677,11 +678,11 @@

Hum...

Did you tried to place refcnt/netdev_refcnt in a separate cache line than 
queue_lock ? I got good results too...

 >  	/* device queue lock */
 >  	spinlock_t		queue_lock;
 >  	/* Number of references to this device */
 > -	atomic_t		refcnt;
 > +	struct bigref	        netdev_refcnt ____cacheline_aligned_in_smp ;	
 >  	/* delayed register/unregister */
 >  	struct list_head	todo_list;
 >  	/* device name hash chain */

Every time a cpu take the queue_lock spinlock, it exclusively gets one cache 
line. If another cpu try to access netdev_refcnt, it has to grab this cache 
line (even if properely per_cpu designed, there is still one shared field). In 
fact the whole struct net_device should be re-ordered for SMP/NUMA performance.

Eric
