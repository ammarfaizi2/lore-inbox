Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267230AbUIJIVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267230AbUIJIVw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 04:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267232AbUIJIVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 04:21:51 -0400
Received: from asplinux.ru ([195.133.213.194]:48901 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S267230AbUIJIVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 04:21:42 -0400
Message-ID: <414166BA.3020804@sw.ru>
Date: Fri, 10 Sep 2004 12:32:58 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adding per sb inode list to make invalidate_inodes()
 faster
References: <4140791F.8050207@sw.ru> <Pine.LNX.4.58.0409090844410.5912@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409090844410.5912@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 9 Sep 2004, Kirill Korotaev wrote:
> 
>>This patch fixes the problem that huge inode cache
>>can make invalidate_inodes() calls very long. Meanwhile
>>lock_kernel() and inode_lock are being held and the system
>>can freeze for seconds.
> 
> 
> Hmm.. I don't mind the approach per se, but I get very nervous about the 
> fact that I don't see any initialization of "inode->i_sb_list".
inode->i_sb_list is a link list_head, not real list head (real list head 
is sb->s_inodes and it's initialized). i.e. it doesn't require 
initialization.

all the operations I perform on i_sb_list are
- list_add(&inode->i_sb_list, ...);
- list_del(&inode->i_sb_list);

So it's all safe.

> Yes, you do a
> 	list_add(&inode->i_sb_list, &sb->s_inodes);
> 
> in new_inode(), but there are a ton of users that allocate inodes other 
> ways, and more importantly, even if this was the only allocation function, 
> you do various "list_del(&inode->i_sb_list)" things which leaves the inode 
> around but with an invalid superblock list.
1. struct inode is allocated only in one place!
it's alloc_inode(). Next alloc_inode() is static and is called from 3 
places:
new_inode(), get_new_inode() and get_new_inode_fast().

All 3 above functions do list_add(&inode->i_sb_list, &sb->s_inodes);
i.e. newly allocated inodes are always in super block list.

2. list_del(&inode->i_sb_list) doesn't leave super block list invalid!

I state that I remove inodes from sb list only and only when usual 
inode->i_list is removed and inode can't be found after that moment 
neither in my per sb list nor in any other list (unused_inodes, 
inodes_in_use, sb->s_io, etc.)

See the details below.

> So at the very _least_, you should document why all of this is safe very 
> carefully (I get nervous about fundamental FS infrastructure changes), and 
> it should be left to simmer in -mm for a longish time to make sure it 
> really works..
Ok. This patch is safe because the use of new inode->i_sb_list list is 
fully symmetric to the use of inode->i_list. i.e.

- when inode is created it's added by inode->i_list to one of std lists 
(inodes_in_use, unused_inodes, sb->s_io). It lives in one of this lists 
during whole lifetime. So in places where inode is created I've just 
added list_add(&inode->i_sb_list, &sb->s_inodes). There are 3 such 
places: new_inode(), get_new_inode() and get_new_inode_fast()

- when inode is about to be destroyed it's usually removed from std 
lists (and sometimes is moved to 'freeable' list). It's the places where 
inode is removed from the hash as well. In such places I've just 
inserted list_del(&inode->i_sb_list). These places are in 
generic_forget_inode(), generic_delete_inode(), invalidate_list(), 
prune_icache(), hugetlbfs_delete_inode(), hugetlbfs_forget_inode().

So as you can see from the description the lifetime of inode in 
sb->s_inodes list is the same as in hash and other std lists.
And these new per-sb list is protected by the same inode_lock.

To be sure that there are no other places where i_list field is used 
somehow in other ways I've just grepped it.

Kirill

