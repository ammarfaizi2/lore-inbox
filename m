Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267423AbUIJOYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267423AbUIJOYN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 10:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267424AbUIJOYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 10:24:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:16084 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267423AbUIJOYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 10:24:08 -0400
Date: Fri, 10 Sep 2004 07:22:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adding per sb inode list to make invalidate_inodes()
 faster
In-Reply-To: <414166BA.3020804@sw.ru>
Message-ID: <Pine.LNX.4.58.0409100713570.5912@ppc970.osdl.org>
References: <4140791F.8050207@sw.ru> <Pine.LNX.4.58.0409090844410.5912@ppc970.osdl.org>
 <414166BA.3020804@sw.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Sep 2004, Kirill Korotaev wrote:
> > 
> > Hmm.. I don't mind the approach per se, but I get very nervous about
> > the fact that I don't see any initialization of "inode->i_sb_list".
>
> inode->i_sb_list is a link list_head, not real list head (real list head
> is sb->s_inodes and it's initialized). i.e. it doesn't require
> initialization.

It _does_ require initialization. And no, there is no difference between a 
"real" head and a entry "link" in the list. They both need to be 
initialized.

> all the operations I perform on i_sb_list are
> - list_add(&inode->i_sb_list, ...);

This one is ok without initialzing the entry, since it will do so itself.

> - list_del(&inode->i_sb_list);

This one is NOT ok. If list_del() is ever done on a link entry that hasn't 
been initialized, you crash. If "list_del()" is ever done twice on an 
entry, you will crash and/or corrupt memory elsewhere. 

> So it's all safe.

It's not "all safe". You had better explain _why_ it's safe. You do so 
later:

> 1. struct inode is allocated only in one place!
> it's alloc_inode(). Next alloc_inode() is static and is called from 3 
> places:
> new_inode(), get_new_inode() and get_new_inode_fast().
> 
> All 3 above functions do list_add(&inode->i_sb_list, &sb->s_inodes);
> i.e. newly allocated inodes are always in super block list.

Good. _This_ is what I was after.

> 2. list_del(&inode->i_sb_list) doesn't leave super block list invalid!

No, but it leaves _itself_ invalid. There had better not be anything that 
touches it ever after without an initialization. That wasn't obvious...

		Linus
