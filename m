Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265943AbUHNFUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbUHNFUG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 01:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbUHNFUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 01:20:06 -0400
Received: from out012pub.verizon.net ([206.46.170.137]:12189 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S265943AbUHNFT7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 01:19:59 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Sat, 14 Aug 2004 01:19:56 -0400
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
Message-Id: <200408140119.57019.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [151.205.57.32] at Sat, 14 Aug 2004 00:19:58 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 August 2004 22:18, Marcelo Tosatti wrote:
>On Fri, Aug 13, 2004 at 12:27:24AM -0400, Gene Heskett wrote:
>> On Wednesday 11 August 2004 00:59, Linus Torvalds wrote:
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
Marcelo;  I've put in the patch that disables the prefetch, and thats 
been running ok so far, but uptime is still pretty short, in hours.  
But if it eventually does an Oops on me, the reboot will bring this 
one in too, its building right now.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
