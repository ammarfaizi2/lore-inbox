Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUHNIR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUHNIR2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 04:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbUHNIR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 04:17:27 -0400
Received: from out009pub.verizon.net ([206.46.170.131]:5581 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S262328AbUHNIRW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 04:17:22 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Sat, 14 Aug 2004 04:17:20 -0400
User-Agent: KMail/1.6.82
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408130027.24470.gene.heskett@verizon.net> <20040814021809.GD30627@logos.cnet>
In-Reply-To: <20040814021809.GD30627@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408140417.20539.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.58.109] at Sat, 14 Aug 2004 03:17:21 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 August 2004 22:18, Marcelo Tosatti wrote:
>On Fri, Aug 13, 2004 at 12:27:24AM -0400, Gene Heskett wrote:
>> On Wednesday 11 August 2004 00:59, Linus Torvalds wrote:
>> >I wrote:
>> >> Notably, the output of "/proc/meminfo" and "/proc/slabinfo".
>> >> "ps axv" helps too.
[...]
>
>Hi fellows,
>
>I've taken some time to look at this oopses, and I truly believe we
>are facing real corruption.
>
>The symptom is that an inode's (blockdev) i_mapping->private_list
> gets corrupted, one of its buffer_head's contains a b_assoc_mapping
> list_head with NULL pointers.
>
>And this is not an SMP race, because Gene is not running SMP.
>
>Gene's oops happens when remove_inode_buffers calls 
> __remove_assoc_queue(bh)
>
>Ingo's oops happens while remove_inode_buffers does
>
> struct buffer_head *bh = BH_ENTRY(list->next);
>
>which is
>
>	mov ffffffd8(%ecx), (%somewhere)
>
>%ecx is zero, so...
>
>There is a bug somewhere.
>
>--- a/fs/buffer.c.original	2004-08-14 00:19:55.000000000 -0300
>+++ b/fs/buffer.c	2004-08-14 00:34:57.000000000 -0300
>@@ -802,6 +802,8 @@
>  */
> static inline void __remove_assoc_queue(struct buffer_head *bh)
> {
>+	BUG_ON(bh->b_assoc_buffers.next == NULL);
>+	BUG_ON(bh->b_assoc_buffers.prev == NULL);
> 	list_del_init(&bh->b_assoc_buffers);
> }
>
>@@ -1073,6 +1075,7 @@
>
> 		spin_lock(&buffer_mapping->private_lock);
> 		while (!list_empty(list)) {
>+			BUG_ON(list->next == NULL);
> 			struct buffer_head *bh = BH_ENTRY(list->next);
> 			if (buffer_dirty(bh)) {
> 				ret = 0;
>
Just for grins I occasionally do the up-arrow bit and re-run that 
slabinfo sorter line Linus gave me, watching the size of the 
dentry_cache line in particular.  I believe I just saw a first, the 
size was reported as being slightly smaller that the last run an hour 
ago.  Previously it had done nothing but grow.  This is a kernel with 
two patches from -rc4, one being the list_del thing, the other being 
the one liner that presumably forces the fetch, not depending on the 
prefetch in this chip which conjecture says it might not be working 
100%.

Also, top is showing a relatively large amount of free memory even 
though a small amount is now in the swap.  /proc/meminfo:
MemTotal:      1035852 kB
MemFree:        130452 kB
Buffers:         70664 kB
Cached:         420512 kB
SwapCached:        400 kB
Active:         384008 kB
Inactive:       271184 kB
HighTotal:      131008 kB
HighFree:          308 kB
LowTotal:       904844 kB
LowFree:        130144 kB
SwapTotal:     3857104 kB
SwapFree:      3856452 kB
Dirty:             136 kB
Writeback:           0 kB
Mapped:         222000 kB
Slab:           239816 kB
Committed_AS:   302408 kB
PageTables:       3232 kB
VmallocTotal:   114680 kB
VmallocUsed:     19900 kB
VmallocChunk:    94604 kB

This with an uptime approaching 18 hours.  With only the list_del 
patch, by now I would be down to 3-5 megs free, and 20-100 megs in 
swap.

The 4am stuff just started, this was the killer yesterday morning.
No probs at the 15 minute mark, looks good.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
