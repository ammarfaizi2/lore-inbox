Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbTIZX7f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 19:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbTIZX7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 19:59:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:23744 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261733AbTIZX7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 19:59:33 -0400
Subject: Re: slab corruption on AIO 2.6.0-test5-mm4
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <1064596018.1950.10.camel@ibm-c.pdx.osdl.net>
References: <1064596018.1950.10.camel@ibm-c.pdx.osdl.net>
Content-Type: text/plain
Organization: 
Message-Id: <1064620762.2115.29.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Sep 2003 16:59:23 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I re-ran an aio test using O_DIRECT to copy a file to an already
allocated file.  The kernel is 2.6.0-test5-mm4 with
CONFIG_DEBUG_PAGEALLOC enabled.
             
# Files before test:
$ ls -l
-rw-rw-r--    1 daniel   daniel   88289280 Sep 26 11:18 ff2
-rw-------    1 daniel   daniel   88289280 Jun  9 16:54 glibc-2.3.2.tar

# Test program doing 8k O_DIRECT aio with only 1 outstanding i/o
# at a time.
$ time aiocp -b 8k -n 1 -f O_DIRECT glibc-2.3.2.tar ff2

#
# Kernel Message
                                                                     
Unable to handle kernel paging request at virtual address ddb1df60
 printing eip:
c0148440
*pde = 00076063
*pte = 1db1d000
Oops: 0002 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
CPU:    0
EIP:    0060:[<c0148440>]    Not tainted VLI
EFLAGS: 00210287
EIP is at __generic_file_aio_write_nolock+0xa01/0xce2
eax: 00002000   ebx: 05433000   ecx: ddb1df60   edx: 00000000
esi: 00000000   edi: ccf0fe74   ebp: d2c4de54   esp: d2c4dd60
ds: 007b   es: 007b   ss: 0068
Process aiocp (pid: 1966, threadinfo=d2c4c000 task=dbf009b0)
Stack: 00000001 ddb1df28 d2c4de80 00000000 00000000 00000001 00000001 00000000
       d2d00f28 ccf11e74 d2c4debc 00000000 00000000 00000001 00000009 00002000
       00000000 df2f9df8 fffffff4 de852df8 ffffffff 00000000 c14a3c88 00002000
Call Trace:
 [<c012022c>] kernel_map_pages+0x28/0x5d
 [<c014f381>] cache_init_objs+0xe2/0x1d5
 [<c01489f9>] generic_file_aio_write+0x97/0x163
 [<c01aa04f>] ext3_file_write+0x3f/0xcc
 [<c0194844>] aio_pwrite+0x42/0xb3
 [<c01939f5>] aio_run_iocb+0xb2/0x20e
 [<c0192fbe>] __aio_get_req+0x27/0x180
 [<c0194802>] aio_pwrite+0x0/0xb3
 [<c0194c7c>] io_submit_one+0x1fa/0x2d3
 [<c0194e32>] sys_io_submit+0xdd/0x143
 [<c03c4423>] syscall_call+0x7/0xb
                                                                                
Code: ff ff 7c 18 7f 08 39 9d 48 ff ff ff 76 0e 8b 85 6c ff ff ff 85 c0
0f 84 c1 00 00 00 8b 85 48 ff ff ff 8b 95 4c ff ff ff 8b 4d 14 <89> 01
89 51 04 8b 85 68 ff ff ff 85 c0 78 22 8b 5d 84 f6 43 19
 <7>exit_aio:ioctx still alive: 2 1 0



Looking at the disassembly it looks like it blew up on
mm/filemap.c line 1848:

	*ppos = end;

generic_file_aio_write() calls __generic_file_aio_write_nolock() 
with these parameters:

ret = __generic_file_aio_write_nolock(iocb, &local_iov, 1,
                                                &iocb->ki_pos);

So it looks like the *ppos is writing to iocb->ki_pos, but the
iocb has somehow already been freed.  Well, that's my guess for
now.  I'm still looking at the code.

Daniel


