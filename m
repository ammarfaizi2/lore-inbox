Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262891AbVDHRZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262891AbVDHRZD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 13:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262890AbVDHRZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 13:25:03 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:12450 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262889AbVDHRYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 13:24:25 -0400
Subject: Re: Problem in log_do_checkpoint()?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sct@redhat.com,
       jeffm@suse.com
In-Reply-To: <20050404090414.GB20219@atrey.karlin.mff.cuni.cz>
References: <20050404090414.GB20219@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1112980478.32606.236.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Apr 2005 10:14:39 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get OOPs  in log_do_checkpoint() while using ext3 quotas.
Is this anyway related to what you are working on ?

Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
801aeee1
*pde = 52b31001
Oops: 0002 [#1]
PREEMPT SMP 
Modules linked in:
CPU:    3
EIP:    0060:[<801aeee1>]    Not tainted VLI
EFLAGS: 00010213   (2.6.11-22) 
EIP is at log_do_checkpoint+0x91/0x220
eax: 00000002   ebx: b7d09e0c   ecx: 00000001   edx: e24a2000
esi: 00000000   edi: c4bac47c   ebp: cceb726c   esp: e24a2d18
ds: 007b   es: 007b   ss: 0068
Process rm (pid: 8694, threadinfo=e24a2000 task=f7b79040)
Stack: f7dc70e4 a1d60b3c e24a2d44 e24a2d3c e24a2d40 e24a2000 00004df4
a6062200 
       f7dc70e4 00000000 00000000 95447db0 95447e4c ec6c1d7c b52210e4
ec032b40 
       ec032b0c 936a5800 e5a262b8 95447cac eb4c4354 936a57cc 936a5798
ac0e93bc 
Call Trace:
 [<801ae94f>] __log_wait_for_space+0x9f/0xc0
 [<801a9b42>] start_this_handle+0x132/0x3f0
 [<8012f720>] autoremove_wake_function+0x0/0x60
 [<8012f720>] autoremove_wake_function+0x0/0x60
 [<801a9efd>] journal_start+0xad/0xe0
 [<801a68b1>] ext3_dquot_initialize+0x51/0x70
 [<801a2d0d>] ext3_rmdir+0x4d/0x1c0
 [<8031df76>] _spin_lock+0x16/0x90
 [<80168aa9>] vfs_rmdir+0x189/0x230
 [<80168be9>] sys_rmdir+0x99/0xf0
 [<8010272f>] syscall_call+0x7/0xb
Code: 8b 54 24 1c 89 5c 24 28 8b 40 04 89 44 24 18 8b 5a 28 8b 6b 2c 89
df 8d 76 00 89 fb b8 01 00 00 00 8b 7f 28 8b 33 e8 cf 76 f6 ff <f0> 0f
ba 2e 13 19 c0 85 c0 0f 85 3f 01 00 00 89 5c 24 04 8d 44 

Thanks,
Badari



On Mon, 2005-04-04 at 02:04, Jan Kara wrote:
>   Hello,
> 
>   I've been looking through the JBD code when trying to understand the
> assertion failure in log_do_checkpoint() (it was on old SUSE 2.6.5 kernel
> though the reporter claims to be able to get the failure even with the
> Stephen's patch fixing a race with journal_put_journal_head()) and I've
> spotted one place where I think could be a race (the code around there
> seems to be the same in latest kernels):
>   In log_do_checkpoint() we go through the t_checkpoint_list of a
> transaction and call __flush_buffer() on each buffer. Suppose there is
> just one buffer on the list and it is dirty. __flush_buffer() sees it and
> puts it to an array of buffers for flushing. Then the loop finishes,
> retry=0, drop_count=0, batch_count=1. So __flush_batch() is called - we
> drop all locks and sleep. While we are sleeping somebody else comes and
> makes the buffer dirty again (OK, that is not probable, but I think it
> could be possible). Now we wake up and call __cleanup_transaction().
> It's not able to do anything and returns 0. And we fail on the assertion
> J_ASSERT(drop_count != 0 || cleanup_ret != 0).
>   Am I missing something? In my opinion we should set retry=1 after we
> call __flush_batch() even if we call it outside of the "__flush_buffer-loop"...
> 
> 								Honza

