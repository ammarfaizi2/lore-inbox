Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266908AbUBMKqp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 05:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266911AbUBMKqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 05:46:45 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:59520 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S266908AbUBMKqn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 05:46:43 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16428.43792.582229.53954@laputa.namesys.com>
Date: Fri, 13 Feb 2004 13:46:40 +0300
To: Andrew Morton <akpm@osdl.org>
Cc: lepton <lepton@mail.goldenhope.com.cn>, linux-kernel@vger.kernel.org
Subject: Re: [BUG]kmalloc memory in reiserfs code failed on a dual amd64/4G
 linux 2.6.2 box
In-Reply-To: <20040212223139.61c3c349.akpm@osdl.org>
References: <20040213031653.GA25623@lepton.goldenhope.com.cn>
	<20040212223139.61c3c349.akpm@osdl.org>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > lepton <lepton@mail.goldenhope.com.cn> wrote:
 > >
 > >  I seen such dmesg in mu dual amd64/4G memory box.
 > > 
 > >  I am running kernel 2.6.2
 > > 
 > >  This is the second time I saw some problems about __alloc_pages on this
 > >  amd 64 box...
 > > 
 > > 
 > >  sort: page allocation failure. order:1, mode:0x20
 > > 
 > >  Call Trace:<ffffffff8014e5f0>{__alloc_pages+816} <ffffffff8014e65e>{__get_free_pages+78} 
 > >         <ffffffff80151921>{cache_grow+177} <ffffffff80151e78>{cache_alloc_refill+440} 
 > >         <ffffffff801521c6>{__kmalloc+102} <ffffffff801b44f6>{get_mem_for_virtual_node+102} 
 > >         <ffffffff801b49a8>{fix_nodes+232} <ffffffff801c08c5>{reiserfs_insert_item+149} 
 > >         <ffffffff801acf2c>{reiserfs_new_inode+892} <ffffffff801bd6a8>{pathrelse+40} 
 > >         <ffffffff801a834b>{reiserfs_create+171} <ffffffff8017690c>{vfs_create+140} 
 > >         <ffffffff80176ca8>{open_namei+424} <ffffffff801675a7>{filp_open+39} 
 > >         <ffffffff801210a8>{sys32_open+56} <ffffffff8011e25e>{ia32_do_syscall+30}
 > 
 > Nikita, why cannot get_mem_for_virtual_node() use GFP_KERNEL?

Some stage in reiserfs balancing (fix_nodes() function) has to be
performed without ever scheduling. If it schedules, it has to be
restarted. As we don't want to restart often, we first try to do atomic
allocation, and if it fails, GFP_NOFS allocation is done, and
fix_nodes() restarted.

All we need is to suppress warning.

Nikita.
----------------------------------------------------------------------
===== fs/reiserfs/fix_node.c 1.30 vs edited =====
--- 1.30/fs/reiserfs/fix_node.c	Tue Jul 15 21:01:30 2003
+++ edited/fs/reiserfs/fix_node.c	Fri Feb 13 13:39:25 2004
@@ -2037,7 +2037,7 @@
 	tb->vn_buf_size = size;
 
 	/* get memory for virtual item */
-	buf = reiserfs_kmalloc(size, GFP_ATOMIC, tb->tb_sb);
+	buf = reiserfs_kmalloc(size, GFP_ATOMIC | __GFP_NOWARN, tb->tb_sb);
 	if ( ! buf ) {
 	    /* getting memory with GFP_KERNEL priority may involve
                balancing now (due to indirect_to_direct conversion on
----------------------------------------------------------------------
