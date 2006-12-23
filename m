Return-Path: <linux-kernel-owner+w=401wt.eu-S1753493AbWLWCZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbWLWCZR (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 21:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753526AbWLWCZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 21:25:17 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:58721 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493AbWLWCZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 21:25:14 -0500
Message-ID: <458C9386.7090507@in.ibm.com>
Date: Fri, 22 Dec 2006 18:25:10 -0800
From: Suzuki <suzuki@in.ibm.com>
Organization: IBM Linux Technology Center
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060413 Red Hat/1.7.13-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Kara <jack@suse.cz>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       linux-ext4@vger.kernel.org, cmm@us.ibm.com, amit <amitarora@in.ibm.com>
Subject: Re: [RFC] [PATCH] Fix kmalloc flags used in ext3 with an active	journal
 handle
References: <458898B4.5010805@in.ibm.com>	<20061219180358.bfda00f0.akpm@osdl.org> <45889E4B.7050406@in.ibm.com>	<20061220203520.ccbbffd9.akpm@osdl.org> <20061222114403.GA13920@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20061222114403.GA13920@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara wrote:
>>On Tue, 19 Dec 2006 18:22:03 -0800
>>Suzuki <suzuki@in.ibm.com> wrote:
>>
>>
>>>Andrew Morton wrote:
>>>
>>>>On Tue, 19 Dec 2006 17:58:12 -0800
>>>>Suzuki <suzuki@in.ibm.com> wrote:
>>>>
>>>>
>>>>
>>>>>* Fix the kmalloc flags used from within ext3, when we have an active journal handle
>>>>>
>>>>>	If we do a kmalloc with GFP_KERNEL on system running low on memory, with an active journal handle, we might end up in cleaning up the fs cache flushing dirty inodes for some other filesystem. This would cause hitting a J_ASSERT() in :
>>>>
>>>>
>>>>The change might be needed (haven't looked at it yet).  But I'd like to see
>>>>the full BUG trace, please.  To see the callchain.
>>>
>>>Here is the call trace which was hit by one of our test teams. This was
>>>from fs/ext3/xattr.c. While looking for similar calls I found the others
>>>described in the patch.
>>>
>>>Assertion failure in journal_start() at fs/jbd/transaction.c:274: "handle-
>>> >h_transaction->t_journal == journal"
>>>kernel BUG at fs/jbd/transaction.c:274!
>>>illegal operation: 0001 [#1]
>>>CPU:    0    Not tainted (2.6.5-7.282-s390x SLES9_SP3_BRANCH-20061031152356)
>>>Process dbench (pid: 14070, task: 00000000025617f0, ksp: 0000000001057630)
>>>Krnl PSW : 0700000180000000 0000000008837b38 (journal_start+0x90/0x15c
>>>[jbd])
>>>Krnl GPRS: 0000000000000000 0000000000507fc0 000000000000002b
>>>0000000001056d80
>>>            0000000008837b36 0000000000002885 0000000008841da6
>>>0000000000000000
>>>            00000000001bfaa0 0000000003483d08 0000000000000002
>>>0000000007a8bda0
>>>            0000000008833000 00000000088a7d08 0000000008837b36
>>>0000000001056e80
>>>Krnl Code: 00 00 58 10 b0 0c a7 1a 00 01 b9 04 00 2b 50 10 b0 0c e3 40
>>>Call Trace:
>>>  [<00000000088a30fc>] ext3_journal_start+0x8c/0xa4 [ext3]
>>>  [<0000000008896822>] ext3_dirty_inode+0x3a/0xe0 [ext3]
>>>  [<00000000001ca362>] __mark_inode_dirty+0x1ae/0x1c8
>>>  [<00000000001bfaa0>] iput+0xbc/0xf0
>>>  [<00000000001bdcca>] prune_dcache+0x29e/0x584
>>>  [<00000000001bdfe4>] shrink_dcache_memory+0x34/0x54
>>>  [<000000000017b100>] shrink_slab+0x15c/0x250
>>>  [<000000000017b6e4>] try_to_free_pages+0x1c0/0x2a4
>>>  [<0000000000170276>] __alloc_pages+0x2ba/0x4e0
>>>  [<000000000017059a>] __get_free_pages+0x4e/0x8c
>>>  [<0000000000174ea2>] cache_alloc_refill+0x2a6/0x868
>>>  [<0000000000175540>] __kmalloc+0xdc/0xe0
>>>  [<00000000088a4e62>] ext3_xattr_set_handle+0x114a/0x174c [ext3]
>>>  [<00000000088a54e4>] ext3_xattr_set+0x80/0xd0 [ext3]
>>>  [<00000000088a6312>] ext3_xattr_user_set+0xce/0xe4 [ext3]
>>>  [<00000000088a5f1e>] ext3_setxattr+0x17e/0x18c [ext3]
>>>  [<00000000001c88e6>] setxattr+0x14a/0x234
>>>  [<00000000001c8a80>] sys_fsetxattr+0xb0/0x110
>>>  [<000000000011fc10>] sysc_noemu+0x10/0x16
>>
>>How did we get from iput() into __mark_inode_dirty()?  I can't see it in
>>mainline, nor in 2.6.5 which you appear to be using...
> 
>   Hmm, I think it could happen at least via quota code (but then I would expect
> to see some entry in the backtrace about it).

You are right. I hit the problem on SuSE kernel.

void iput(struct inode *inode)
{
         if (inode) {
                 struct super_operations *op = inode->i_sb->s_op;

                 if (inode->i_state == I_CLEAR)
                         BUG();

                 if (inode->i_state & I_DIRTY_DELAYED)
                         mark_inode_dirty_sync(inode); <---

I jumped in too early :(. Sorry for that.


Thanks
-Suzuki

> 
> 									Honza
> --
> Jan Kara <jack@suse.cz>
> SuSE CR Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ext4" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

