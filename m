Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268939AbUHMCDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268939AbUHMCDw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 22:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268940AbUHMCDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 22:03:52 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:21938 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S268939AbUHMCDr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 22:03:47 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Thu, 12 Aug 2004 22:03:45 -0400
User-Agent: KMail/1.6.82
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>,
       Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <20040812180033.62b389db@laptop.delusion.de> <Pine.LNX.4.58.0408121813190.1839@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408121813190.1839@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408122203.45259.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [151.205.57.32] at Thu, 12 Aug 2004 21:03:46 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 August 2004 21:31, Linus Torvalds wrote:
>On Thu, 12 Aug 2004, Udo A. Steinberg wrote:
>> After nearly 2 days of running 2.6.8-rc4 with above patch backed
>> out, the machine has gone back into heavy swapping, being rather
>> unresponsive for several minutes. At that time the only bigger
>> applications running were X and my mailer, as can be seen in the
>> ps output below.
>
>Your slab usage seems to be:
>
>	cumulative	     usage	name
>	=========	    ======	====
>		.....
>	  2,021,428	   151,552	pgd
>	  2,182,804	   161,376	size-96
>	  2,367,124	   184,320	biovec-(256)
>	  2,559,124	   192,000	biovec-128
>	  2,751,124	   192,000	biovec-64
>	  2,997,076	   245,952	ext3_inode_cache
>	  3,255,124	   258,048	size-1024
>	  3,545,940	   290,816	size-512
>	  3,843,468	   297,528	radix_tree_node
>	  4,153,932	   310,464	inode_cache
>	  4,494,972	   341,040	dentry_cache
>	  4,994,684	   499,712	size-8192
>	  5,912,188	   917,504	size-32768
>	105,397,820	99,485,632	size-64
>
>Something pretty much stands out.
>
>What the _heck_ is doing 64-byte allocations and leaking them?
>
>Can you figure out what triggers it for you? If nothing obvious
> comes to mind, could you do something really silly like this
>
>	--- 1.141/mm/slab.c     2004-07-11 01:52:48 -07:00
>	+++ edited/mm/slab.c    2004-08-12 18:30:00 -07:00
>	@@ -2360,6 +2360,11 @@
>	                 */
>	                BUG_ON(csizep->cs_cachep == NULL);
>	 #endif
>	+               if (csizep->cs_size == 64) {
>	+                       static unsigned count;
>	+                       if (!(4095 & ++count))
>	+                               dump_stack();
>	+               }
>	                return __cache_alloc(flags & GFP_DMA ?
>	                         csizep->cs_dmacachep : csizep->cs_cachep,
> flags); }
>
>(totally whitespace-damaged) which should just print out a stack
> dump every four thoudand allocations, which should give a good clue
> (somebody else might also be allocating those 64-byte things, but
> _likely_ we'll see at least one of the leakers.. Maybe.)
>
>
>			Linus

I'm not seeing any of that here Linus.  Let me snip just the alloc sizes
of my current, up a bit over 24 hours, /proc/slabinfo

size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             1      1  65536    1   16 : tunables    8    4    0 : slabdata      1      1      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             7      7  16384    1    4 : tunables    8    4    0 : slabdata      7      7      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192             10     10   8192    1    2 : tunables    8    4    0 : slabdata     10     10      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096            182    182   4096    1    1 : tunables   24   12    0 : slabdata    182    182      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048            170    198   2048    2    1 : tunables   24   12    0 : slabdata     99     99      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024            124    124   1024    4    1 : tunables   54   27    0 : slabdata     31     31      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
size-512             184    448    512    8    1 : tunables   54   27    0 : slabdata     56     56      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256             165    450    256   15    1 : tunables  120   60    0 : slabdata     30     30      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    0 : slabdata      0      0      0
size-192             100    100    192   20    1 : tunables  120   60    0 : slabdata      5      5      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
size-128            1205   1271    128   31    1 : tunables  120   60    0 : slabdata     41     41      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
size-64             1850   2745     64   61    1 : tunables  120   60    0 : slabdata     45     45      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    0 : slabdata      0      0      0
size-32             1369   1428     32  119    1 : tunables  120   60    0 : slabdata     12     12      0
kmem_cache           124    124    128   31    1 : tunables  120   60    0 : slabdata      4      4      0

And I'm doing my usual activities here, browseing the web with mozilla,
handling the email with kmail from kde3.3-beta2, and watching a little
tv with tvtime or playing solitaire.

So far (knock on wood) its purring right along at about 80% of what
its normal speed would be, nothing unusual in the logs or in the top
display.  And it did 8 seti units in the last 24 before its 6am update,
part of which was on the unpatched kernel.  5 since 6am, its 22:00
here now.

Apparently Udo has something running I don't, and its a leaker.  Lets
hope your snooper patch will show it.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
