Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbRGOA4p>; Sat, 14 Jul 2001 20:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265408AbRGOA4f>; Sat, 14 Jul 2001 20:56:35 -0400
Received: from james.kalifornia.com ([208.179.59.2]:29482 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S265402AbRGOA41>; Sat, 14 Jul 2001 20:56:27 -0400
Message-ID: <3B50EA33.1010900@blue-labs.org>
Date: Sat, 14 Jul 2001 20:56:19 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010713
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ross Biro <bir7@leland.stanford.edu>
Subject: [PATCH] Re: 2.4.5+ hangs on boot
In-Reply-To: <3B50AE0D.80002@blue-labs.org> <3B50C391.3050804@blue-labs.org>
Content-Type: multipart/mixed;
 boundary="------------040702080305010709090106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040702080305010709090106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ok, since net_dev_init() is called from genhd.c:53, I figured it'd work 
just fine if I removed it from net/core/dev.c in register_netdev(). 
 Since I'm not as well steeped in this code, those who know better are 
invited to correct me.

--- linux-2.4.6.orig/net/core/dev.c     Sat Jul 14 17:48:57 2001
+++ linux-2.4.6/net/core/dev.c  Wed Jun 20 21:00:55 2001
@@ -2405,6 +2401,9 @@
 #ifdef CONFIG_NET_FASTROUTE
        dev->fastpath_lock=RW_LOCK_UNLOCKED;
 #endif
-
-       if (dev_boot_phase)
-               net_dev_init();
 
 #ifdef CONFIG_NET_DIVERT
        ret = alloc_divert_blk(dev);

David

David Ford wrote:

> Ok, the problem is this.  I have TEQL packet scheduling in my config, 
> the kernel runs through this sequence on boot:
>
> net_dev_init()
>    pktsched_init()
>        teql_init()    [starts a lock with rtnl_lock()]
>            register_netdevice()
>                net_dev_init()
>                    pktsched_init()
>                        teql_init() [hangs here...]
>
> Here is the problem.  We enter teql_init() again with a rtnl_lock() 
> already being held.  Do any of the authors of these functions want to 
> jump in here?
>
> David
>
> David Ford wrote:
>
>> [...]
>> I2O LAN OSM (C) 1999 University of Helsinki.
>> early initialization of device teql0 is deferred
>> loop: loaded (max 8 devices)
>> Linux Tulip driver version 0.9.15-pre3 (June 1, 2001)
>> PCI: Found IRQ 5 for device 00:10.0
>>
>> Any comments or suggestions?  2.4.5-ac19 is the last kernel I have 
>> that works.
>


--------------040702080305010709090106
Content-Type: text/plain;
 name="dev.c-diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dev.c-diff"

--- linux-2.4.6.orig/net/core/dev.c	Sat Jul 14 17:48:57 2001
+++ linux-2.4.6/net/core/dev.c	Wed Jun 20 21:00:55 2001
@@ -2405,6 +2401,9 @@
 #ifdef CONFIG_NET_FASTROUTE
 	dev->fastpath_lock=RW_LOCK_UNLOCKED;
 #endif
-
-	if (dev_boot_phase)
-		net_dev_init();
 
 #ifdef CONFIG_NET_DIVERT
 	ret = alloc_divert_blk(dev);

--------------040702080305010709090106--

