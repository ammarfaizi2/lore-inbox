Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264753AbTF0T4o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 15:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264754AbTF0T4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 15:56:44 -0400
Received: from franka.aracnet.com ([216.99.193.44]:2021 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264753AbTF0T4j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 15:56:39 -0400
Date: Fri, 27 Jun 2003 13:10:44 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 856] New: File Sysyem based AIO hangs on 2.5.73-mm1
Message-ID: <44280000.1056744644@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: File Sysyem based AIO hangs on 2.5.73-mm1
    Kernel Version: 2.5.73-mm1
            Status: NEW
          Severity: high
             Owner: akpm@digeo.com
         Submitter: slpratt@us.ibm.com


Distribution:SLES8.0 + 2.5.73-mm1

Hardware Environment:8way 900Mhz 4xIBM Servraid 80 disks

Problem Description:
Multithreaded file system based AIO results in defunct processes.

Steps to reproduce:
Get rawread from
http://www-124.ibm.com/developerworks/opensource/linuxperf/rawread/rawread.html

rawread -t12 -p160 -m20 -d6 -s 65536 -n4096 -f 

Test passed for block sizes 1k, 2k, 4k, 8k, 16k, 32k, before dying on 64k block
size.

Trace of one of the defunct threads follows:

rawread       D 00000001 18960  18891         18963 18959 (NOTLB)
f33cbbd0 00000086 c0517660 00000001 000000ff f7abde00 f7378b60 f7abde00 
       f7abde00 f6d0b6a0 f7abde00 f6d0b6a0 e42906f0 c0517660 f6d0b6a0 c0577680 
       f33cbbdc c011dbf6 f33cbc0c d54c4420 c0158be5 f6d0b6a0 f33cbc04 00000000 
Call Trace:
 [<c011dbf6>] io_schedule+0x26/0x30
 [<c0158be5>] __wait_on_buffer_wq+0xf5/0x100
 [<c011eb40>] autoremove_wake_function+0x0/0x50
 [<c011eb40>] autoremove_wake_function+0x0/0x50
 [<c011eb40>] autoremove_wake_function+0x0/0x50
 [<c015a05c>] __bread_slow_wq+0x3c/0x100
 [<c015a3d0>] __bread_wq+0x40/0x50
 [<c01ac66c>] ext2_get_branch_wq+0x7c/0x160
 [<c01acaea>] ext2_get_block_wq+0x8a/0x440
 [<c0306c55>] as_set_request+0x25/0x80
 [<c0305bde>] as_update_arq+0x2e/0x80
 [<c01acf0f>] ext2_get_block+0x2f/0x40
 [<c0179881>] do_mpage_readpage+0x3c1/0x3d0
 [<c01391e1>] add_to_page_cache+0x71/0x110
 [<c01799ee>] mpage_readpages+0x15e/0x1b0
 [<c01acee0>] ext2_get_block+0x0/0x40
 [<c013d200>] __rmqueue+0xf0/0x160
 [<c013fa6c>] read_pages+0x15c/0x170
 [<c01acee0>] ext2_get_block+0x0/0x40
 [<c013d6df>] __alloc_pages+0x14f/0x330
 [<c013fbd6>] do_page_cache_readahead+0x156/0x1d0
 [<c013fcc5>] page_cache_readahead+0x75/0x190
 [<c017d34d>] aio_setup_iocb+0x14d/0x1c0
 [<c017d58f>] io_submit_one+0x18f/0x220
 [<c017d6dc>] sys_io_submit+0xbc/0x140
 [<c010b03f>] syscall_call+0x7/0xb


