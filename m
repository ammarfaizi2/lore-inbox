Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWCLW3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWCLW3l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 17:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWCLW3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 17:29:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8918 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751100AbWCLW3k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 17:29:40 -0500
Date: Sun, 12 Mar 2006 14:26:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, Mingming Cao <cmm@us.ibm.com>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [discuss] Re: 2.6.16-rc5-mm3: spinlock bad magic on CPU#0 on
 AMD64
Message-Id: <20060312142654.650b90fb.akpm@osdl.org>
In-Reply-To: <200603121349.32374.rjw@sisk.pl>
References: <200603120024.04938.rjw@sisk.pl>
	<20060311153618.2e4b113d.akpm@osdl.org>
	<200603121127.28657.rjw@sisk.pl>
	<200603121349.32374.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
>  Done, and now it looks like this:

Helps a lot, thanks.

>  BUG: spinlock bad magic on CPU#0, soffice.bin/5192
>   lock: ffff81005f79ae28, .magic: 000001ff, .owner: 1..1..|1. |1.|1..|1.___1..|1..1. 1./-1,
>  .owner_cpu: -2141838208
> 
>  Call Trace: <ffffffff80210383>{__alloc_pages+99} <ffffffff802156c3>{spin_bug+195}
>         <ffffffff802077dc>{_raw_spin_lock+44} <ffffffff80270a4e>{_spin_lock+30}
>         <ffffffff8033712d>{journal_extend+77} <ffffffff80327255>{ext3_get_block+165}
>         <ffffffff8022c2f9>{do_mpage_readpage+425} <ffffffff80270cc4>{_write_unlock_irq+20}
>         <ffffffff8020cce2>{add_to_page_cache+162} <ffffffff8023fdee>{mpage_readpages+254}
>         <ffffffff803271b0>{ext3_get_block+0} <ffffffff803271b0>{ext3_get_block+0}
>         <ffffffff803146df>{get_cnode+95} <ffffffff8020a3bb>{get_page_from_freelist+619}
>         <ffffffff80210383>{__alloc_pages+99} <ffffffff80323c1a>{ext3_readpages+26}
>         <ffffffff80214030>{__do_page_cache_readahead+416} <ffffffff80213c12>{poison_obj+66}
>         <ffffffff80232058>{wake_up_bit+40} <ffffffff80243152>{unlock_buffer+18}
>         <ffffffff80315bb8>{reiserfs_prepare_for_journal+104}
>         <ffffffff802b6ab4>{do_page_cache_readahead+100} <ffffffff80215942>{filemap_nopage+322}
>         <ffffffff80208b2c>{__handle_mm_fault+1004} <ffffffff80270e7d>{_spin_unlock_irqrestore+29}
>         <ffffffff8020ae99>{do_page_fault+1257} <ffffffff8026af8d>{error_exit+0}
>         <ffffffff802ffb40>{reiserfs_copy_from_user_to_file_region+80}
>         <ffffffff80302446>{reiserfs_file_write+6102} <ffffffff802f8f4e>{reiserfs_add_entry+1054}
>         <ffffffff8033c1ff>{journal_cancel_revoke+351} <ffffffff80213c12>{poison_obj+66}
>         <ffffffff80236d27>{cache_free_debugcheck+711} <ffffffff80335734>{journal_stop+772}
>         <ffffffff80270f30>{_spin_unlock+16} <ffffffff802193a2>{vfs_write+226}
>         <ffffffff80219c80>{sys_write+80} <ffffffff8026d234>{cstar_do_call+27}
>  BUG: spinlock lockup on CPU#0, soffice.bin/5192, ffff81005f79ae28

It's a pretty vile backtrace.  I supposed you have CONFIG_FRAME_POINTER=n.

Still.  It seems that what's happened is that we took a pagefault while
reiserfs had a transaction open.  The fault is against a mmapped ext3 file
and we ended up in the recently-reworked ext3_get_block() which tests
journal_current_handle() to work out whether we're in a write or a read. 
oops.  The presence of reiserfs journal_info makes it decide it's a write,
not a read so it starts treating a reiserfs journal_info as an ext3 one.

The code used to work OK because it was only for direct-IO, which doesn't
get recurred into like this.  But it got used for regular I/O in -mm.

This should fix:

--- devel/fs/ext3/inode.c~ext3-get-blocks-maping-multiple-blocks-at-a-once-journal-reentry-fix	2006-03-12 14:25:04.000000000 -0800
+++ devel-akpm/fs/ext3/inode.c	2006-03-12 14:25:04.000000000 -0800
@@ -830,7 +830,7 @@ ext3_direct_io_get_blocks(struct inode *
 	handle_t *handle = journal_current_handle();
 	int ret = 0;
 
-	if (!handle)
+	if (!create)
 		goto get_block;		/* A read */
 
 	if (max_blocks == 1)
_

