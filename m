Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265211AbUGZLnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUGZLnb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 07:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbUGZLnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 07:43:31 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:41119 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265211AbUGZLn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 07:43:28 -0400
Message-ID: <4104EE5C.406@yahoo.com.au>
Date: Mon, 26 Jul 2004 21:43:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Jan-Frode Myklebust <janfrode@parallab.uib.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: OOM-killer going crazy.
References: <20040725094605.GA18324@zombie.inka.de> <41045EBE.8080708@comcast.net> <20040726091004.GA32403@ii.uib.no> <4104E307.1070004@yahoo.com.au> <20040726111032.GA2067@ii.uib.no>
In-Reply-To: <20040726111032.GA2067@ii.uib.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Frode Myklebust wrote:
> On Mon, Jul 26, 2004 at 08:55:03PM +1000, Nick Piggin wrote:
> 
>>Can you just check you CONFIG_SWAP is on and /proc/sys/vm/laptop_mode is 0,
>>and that you have some swap enabled.
> 
> 
> # grep CONFIG_SWAP .config
> CONFIG_SWAP=y
> # cat /proc/sys/vm/laptop_mode
> 0
> # free
>              total       used       free     shared    buffers     cached
> Mem:       2074708    1223324     851384          0        296     258376
> -/+ buffers/cache:     964652    1110056
> Swap:      2040244          0    2040244
> 

Good. Just making sure.

> 
> 
>>If the problem persists, can you send a copy each of 
>>/proc/sys/fs/dentry-state,
>>/proc/slabinfo and /proc/vmstat before and after you run dsmc until it goes
>>OOM please?
> 
> 
> I turned of a option (MEMORYEFFICIENTBACKUP) in 'dsmc', and then it uses a bit 
> more memory, and crashes quicker.
> 

Thanks. Let's see.

dentry-state before
> 644923  572300  45      0       0       0
after
 > 570734  495922  45      0       0       0

slabinfo before
> # name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
> xfs_inode         927591 980848    368   11    1 : tunables   54   27    8 : slabdata  89168  89168      0
> linvfs_icache     927591 980810    384   10    1 : tunables   54   27    8 : slabdata  98081  98081      0
> dentry_cache      645063 703566    144   27    1 : tunables  120   60    8 : slabdata  26058  26058      0
after
 > xfs_inode         828633 980507    368   11    1 : tunables   54   27    8 : slabdata  89137  89137    216
 > linvfs_icache     828629 980220    384   10    1 : tunables   54   27    8 : slabdata  98022  98022    216
 > dentry_cache      571383 703458    144   27    1 : tunables  120   60    8 : slabdata  26054  26054    480

So you're basically drowning in mostly reclaimable slab here. These three entries
are consuming over 800MB of zone_normal alone.

vmstat before
> pginodesteal 36508
> slabs_scanned 56099472
> kswapd_inodesteal 317433
after
> pginodesteal 36536
> slabs_scanned 56443602
> kswapd_inodesteal 317433

The things are being slowly scanned and freed, but it is being pretty lethargic.

Can you try echo 10000 > /proc/sys/vm/vfs_cache_pressure, and see how that goes?
