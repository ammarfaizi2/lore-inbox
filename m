Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267601AbUIJQya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267601AbUIJQya (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 12:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267646AbUIJQrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 12:47:16 -0400
Received: from asplinux.ru ([195.133.213.194]:45070 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S267557AbUIJQpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 12:45:25 -0400
Message-ID: <4141DCCD.9040605@sw.ru>
Date: Fri, 10 Sep 2004 20:56:45 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adding per sb inode list to make invalidate_inodes()
 faster
References: <4140791F.8050207@sw.ru> <Pine.LNX.4.58.0409090844410.5912@ppc970.osdl.org> <414166BA.3020804@sw.ru> <Pine.LNX.4.58.0409100713570.5912@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409100713570.5912@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
 > On Fri, 10 Sep 2004, Kirill Korotaev wrote:

 >>>Hmm.. I don't mind the approach per se, but I get very nervous about
 >>>the fact that I don't see any initialization of "inode->i_sb_list".
 >>
 >>inode->i_sb_list is a link list_head, not real list head (real list head
 >>is sb->s_inodes and it's initialized). i.e. it doesn't require
 >>initialization.
 >
 > It _does_ require initialization. And no, there is no difference 
between a
 > "real" head and a entry "link" in the list. They both need to be
 > initialized.
 >
 >>all the operations I perform on i_sb_list are
 >>- list_add(&inode->i_sb_list, ...);
 >
 > This one is ok without initialzing the entry, since it will do so itself.
 >
 >>- list_del(&inode->i_sb_list);
 >
 > This one is NOT ok. If list_del() is ever done on a link entry that 
hasn't
 > been initialized, you crash. If "list_del()" is ever done twice on an
 > entry, you will crash and/or corrupt memory elsewhere.
We never do list_del twice, nor we do list_del on unitialized inodes!

 >>1. struct inode is allocated only in one place!
 >>it's alloc_inode(). Next alloc_inode() is static and is called from 3
 >>places:
 >>new_inode(), get_new_inode() and get_new_inode_fast().
 >>
 >>All 3 above functions do list_add(&inode->i_sb_list, &sb->s_inodes);
 >>i.e. newly allocated inodes are always in super block list.

 > Good. _This_ is what I was after.
 >
 >
 >>2. list_del(&inode->i_sb_list) doesn't leave super block list invalid!
 >
 > No, but it leaves _itself_ invalid. There had better not be anything 
that
 > touches it ever after without an initialization. That wasn't obvious...
ok. But now I hope I proved that it's ok?
no one does list_del() twice and no one does list_del() on unitialized 
inodes.

If you want i_sb_list to be really ALWAYS initialized than we can 
replace list_del with list_del_init and insert INIT_LIST_HEAD(i_sb_list) 
in inode_init_once().
But I don't think it's a good idea.
Moreover, I think that list_del_init() and other initialization 
functions of link list_heads in such places usually only hide the 
problems, not solve them.

Kirill

