Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWFOFVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWFOFVv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 01:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWFOFVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 01:21:51 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:49571 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932156AbWFOFVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 01:21:50 -0400
Date: Thu, 15 Jun 2006 15:21:31 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: cfq_update_io_seektime oops
Message-ID: <20060615152131.A898607@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

Just booting and testing on 2.6.17-rc5 I tripped over what looks
like a divide by zero - I guess its at block/cfq-iosched.c, line
~1657 since that do_div in there looks like the only divide...

divide error: 0000 [#1]
SMP 
CPU:    3
EIP:    0060:[<c02eb80e>]    Not tainted VLI
EFLAGS: 00010046   (2.6.17-2.6-ndebug-qa #1) 
EIP is at cfq_update_io_seektime+0xee/0x150
eax: 0044c32d   ebx: 1ec9b7c8   ecx: 0044c32d   edx: 00000000
esi: 00000000   edi: 00000000   ebp: f74a9920   esp: f74a9904
ds: 007b   es: 007b   ss: 0068
Process rc (pid: 1638, threadinfo=f74a8000 task=f645d530)
Stack: 1ec9b7c8 0044c32d b7ee784c b7fa36c0 f64f0ebc f72c0934 f7c67c00 f74a9940 
       c02ebb8c f7c67c00 f64f0ebc f72c0934 f7c67c00 f72c0934 f760eebc f74a9964 
       c02ebc8e f7c67c00 f760eebc f72c0934 f7c67c00 f74e602c f6e32964 00000003 
Call Trace:
 <c0103dba> show_stack_log_lvl+0x9a/0xc0  <c0103ff2> show_registers+0x1a2/0x210
 <c0104238> die+0x128/0x250  <c0104415> do_trap+0xb5/0xc0
 <c01044dc> do_divide_error+0xbc/0xd0  <c01039c3> error_code+0x4f/0x54
 <c02ebb8c> cfq_crq_enqueued+0xac/0x150  <c02ebc8e> cfq_insert_request+0x5e/0xb0
 <c02dd0f6> elv_insert+0x156/0x230  <c02dd257> __elv_add_request+0x87/0xc0
 <c02e191e> __make_request+0x10e/0x510  <c02e1f28> generic_make_request+0x178/0x310
 <c02e2121> submit_bio+0x61/0x100  <c017d8a4> mpage_bio_submit+0x24/0x40
 <c017e057> mpage_readpages+0x127/0x170  <c02b2698> xfs_vm_readpages+0x28/0x30
 <c0140356> read_pages+0xf6/0x100  <c0140452> __do_page_cache_readahead+0xf2/0x160
 <c0140603> blockable_page_cache_readahead+0x53/0xd0  <c0140877> page_cache_readahead+0x127/0x1d0
 <c0139603> do_generic_mapping_read+0x4b3/0x4c0  <c01398df> __generic_file_aio_read+0x1ef/0x230
 <c02b6c95> xfs_read+0x145/0x340  <c02b29ae> xfs_file_aio_read+0x8e/0xa0
 <c0158102> do_sync_read+0xb2/0x100  <c0158206> vfs_read+0xb6/0x190
 <c0163a5a> kernel_read+0x4a/0x60  <c016459a> prepare_binprm+0xca/0xf0
 <c01648e9> do_execve+0xf9/0x210  <c0101b12> sys_execve+0x42/0xa0
 <c0102ec3> syscall_call+0x7/0xb 
Code: c1 eb 03 89 4a 40 89 5a 44 89 75 e4 01 4d e4 c7 45 e8 00 00 00 00 8b 45 e4 11 5d e8 8b 55 e8 85 d2 89 d1 89 c3 74 08 89 d0 31 d2 <f7> f7 89 c1 89 d8 f7 f7 89 ca 89 d3 89 c1 8b 55 0c 89 4a 48 89 
EIP: [<c02eb80e>] cfq_update_io_seektime+0xee/0x150 SS:ESP 0068:f74a9904

Entering kdb (current=0xf645d530, pid 1638) on processor 3 Oops: divide error
due to oops @ 0xc02eb80e


This was fairly late in bootup.  Lemme know if more info needed, I
have booted this kernel several times without problem today, so it
may not be easily reproducible.

cheers.

-- 
Nathan
