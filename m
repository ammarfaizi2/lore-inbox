Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUCEBdJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 20:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbUCEBdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 20:33:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:53910 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262153AbUCEBbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 20:31:45 -0500
Subject: [PATCH 2.6.3-mm4] direct_io_worker-aio_complete patch (fixes AIO
	Oops)
From: Daniel McNeil <daniel@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Cc: Tobias Diedrich <ranma@gmx.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
In-Reply-To: <200403020954.44886.pbadari@us.ibm.com>
References: <20040228024815.GA2835@melchior.yamamaya.is-a-geek.org>
	 <200403020954.44886.pbadari@us.ibm.com>
Content-Type: multipart/mixed; boundary="=-pcGLSyDicBCTpomiKa7z"
Organization: 
Message-Id: <1078450281.1773.4.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Mar 2004 17:31:22 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pcGLSyDicBCTpomiKa7z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

Here is the fix to this AIO oops.  An AIO O_DIRECT request was extending
the file so it was done synchronously.  However, the request got an
EFAULT and direct_io_worker() was calling aio_complete() on the iocb and
returning the EFAULT.  When io_submit_one() got the EFAULT return,
it assume it had to call aio_complete() since the i/o never got
queued.

The fix is for direct_io_worker() to only call aio_complete() when
the upper layer is going to return -EIOCBQUEUED and not when getting
errors that are being return to the submit path.

This also applies to 2.6.4-rc1-mm2.

Daniel

On Tue, 2004-03-02 at 09:54, Badari Pulavarty wrote: 
> Hi,
> 
> I found the problem.. But no fix yet !!
> 
> Here is whats happening..
> 
> io_submit_one() :
> 
> 	gets iocb with 2 refs
> 	calls file->f_op->aio_write() which returns EFAULT... 
> 		This calls aio_complete() with EFAULT. aio_complete() drops a ref.
> 	calls  aio_put_req() which drops a ref - since the count is 
> 			zero it frees iocb.
> 	Since we got EFAULT, io_submit_one() calls aio_complete() 
> 			with freed up iocb - so we get OOPS.
> 
> The problem here is we are calling aio_complete() twice.
> 
> Daneil, didn't you fix this earlier ?
> 
> int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
> {
> 
> 	...
> 	 req = aio_get_req(ctx);         /* returns with 2 references to req */	
> 	..
> 	case IOCB_CMD_PWRITE: 
> 		...
> 		ret = file->f_op->aio_write(req, buf,
>                                         iocb->aio_nbytes, req->ki_pos);
> 	...
> 	aio_put_req(req);       /* drop extra ref to req */
>         if (likely(-EIOCBQUEUED == ret))
>                 return 0;
>         aio_complete(req, ret, 0);      /* will drop i/o ref to req */
>         return 0;
> 	....
> 
> }
> 	
> 			
> 	
> Thanks,
> Badari
> 
> On Friday 27 February 2004 06:48 pm, Tobias Diedrich wrote:
> > Hi,
> >
> > When trying to use async IO I'm getting the following Oops
> > on 2.6.3-mm3 with debugging options enabled:
> >
> > Feb 28 03:41:14 melchior kernel: Unable to handle kernel paging request at
> > virtual address d680df68 Feb 28 03:41:14 melchior kernel:  printing eip:
> > Feb 28 03:41:14 melchior kernel: c0188068
> > Feb 28 03:41:14 melchior kernel: *pde = 00057063
> > Feb 28 03:41:14 melchior kernel: *pte = 1680d000
> > Feb 28 03:41:14 melchior kernel: Oops: 0000 [#1]
> > Feb 28 03:41:14 melchior kernel: DEBUG_PAGEALLOC
> > Feb 28 03:41:14 melchior kernel: CPU:    0
> > Feb 28 03:41:14 melchior kernel: EIP:    0060:[<c0188068>]    Not tainted
> > VLI Feb 28 03:41:14 melchior kernel: EFLAGS: 00010286
> > Feb 28 03:41:14 melchior kernel: EIP is at aio_complete+0x12/0x309
> > Feb 28 03:41:14 melchior kernel: eax: d680df58   ebx: fffffff2   ecx:
> > 00000000   edx: fffffff2 Feb 28 03:41:14 melchior kernel: esi: 00020000  
> > edi: 00000000   ebp: d67dff28   esp: d67dff00 Feb 28 03:41:14 melchior
> > kernel: ds: 007b   es: 007b   ss: 0068
> > Feb 28 03:41:14 melchior kernel: Process odirect (pid: 1692,
> > threadinfo=d67de000 task=d680b9d0) Feb 28 03:41:14 melchior kernel: Stack:
> > d6856ef8 00000000 d67dff18 c0187ad0 00000000 fffffff2 d680df58 fffffff2 Feb
> > 28 03:41:14 melchior kernel:        00020000 00000000 d67dff58 c0188c21
> > c040f960 d67dff6c 00020000 00000000 Feb 28 03:41:14 melchior kernel:       
> > d680df58 d6873f54 bfffd880 d6856ef8 bfffd880 00000000 d67dffbc c0188d37 Feb
> > 28 03:41:14 melchior kernel: Call Trace:
> > Feb 28 03:41:14 melchior kernel:  [<c0187ad0>] __aio_put_req+0x1d9/0x208
> > Feb 28 03:41:14 melchior kernel:  [<c0188c21>] io_submit_one+0x272/0x290
> > Feb 28 03:41:14 melchior kernel:  [<c0188d37>] sys_io_submit+0xf8/0x143
> > Feb 28 03:41:14 melchior kernel:  [<c0390c8b>] syscall_call+0x7/0xb
> > Feb 28 03:41:14 melchior kernel:
> > Feb 28 03:41:14 melchior kernel: Code: 65 f4 8d 83 b4 00 00 00 5b 5e 5f c9
> > e9 8a a0 fa ff 8d 65 f4 5b 5e 5f c9 c3 55 89 e5 57 56 53 83 ec 1c 89 4d e8
> > 89 55 ec 89 45 f0 <83> 78 10 ff 8b 78 18 0f 85 18 01 00 00 8b 4d f0 89 d0
> > 99 83 79 Feb 28 03:41:14 melchior kernel:  <7>exit_aio:ioctx still alive: 2
> > 1 0 Feb 28 03:41:21 melchior kernel: Unable to handle kernel paging request
> > at virtual address d682af68 Feb 28 03:41:21 melchior kernel:  printing eip:
> > Feb 28 03:41:21 melchior kernel: c0188068
> > Feb 28 03:41:21 melchior kernel: *pde = 00057063
> > Feb 28 03:41:21 melchior kernel: *pte = 1682a000
> > Feb 28 03:41:21 melchior kernel: Oops: 0000 [#2]
> > Feb 28 03:41:21 melchior kernel: DEBUG_PAGEALLOC
> > Feb 28 03:41:21 melchior kernel: CPU:    0
> > Feb 28 03:41:21 melchior kernel: EIP:    0060:[<c0188068>]    Not tainted
> > VLI Feb 28 03:41:21 melchior kernel: EFLAGS: 00010286
> > Feb 28 03:41:21 melchior kernel: EIP is at aio_complete+0x12/0x309
> > Feb 28 03:41:21 melchior kernel: eax: d682af58   ebx: fffffff2   ecx:
> > 00000000   edx: fffffff2 Feb 28 03:41:21 melchior kernel: esi: 00020000  
> > edi: 00000000   ebp: d91e7f28   esp: d91e7f00 Feb 28 03:41:21 melchior
> > kernel: ds: 007b   es: 007b   ss: 0068
> > Feb 28 03:41:21 melchior kernel: Process odirect (pid: 1766,
> > threadinfo=d91e6000 task=d92249d0) Feb 28 03:41:21 melchior kernel: Stack:
> > d67c4ef8 00000000 d91e7f18 c0187ad0 00000000 fffffff2 d682af58 fffffff2 Feb
> > 28 03:41:21 melchior kernel:        00020000 00000000 d91e7f58 c0188c21
> > c040f960 d91e7f6c 00020000 00000000 Feb 28 03:41:21 melchior kernel:       
> > d682af58 d67e2f54 bfffd880 d67c4ef8 bfffd880 00000000 d91e7fbc c0188d37 Feb
> > 28 03:41:21 melchior kernel: Call Trace:
> > Feb 28 03:41:21 melchior kernel:  [<c0187ad0>] __aio_put_req+0x1d9/0x208
> > Feb 28 03:41:21 melchior kernel:  [<c0188c21>] io_submit_one+0x272/0x290
> > Feb 28 03:41:21 melchior kernel:  [<c0188d37>] sys_io_submit+0xf8/0x143
> > Feb 28 03:41:21 melchior kernel:  [<c0390c8b>] syscall_call+0x7/0xb
> > Feb 28 03:41:21 melchior kernel:
> > Feb 28 03:41:21 melchior kernel: Code: 65 f4 8d 83 b4 00 00 00 5b 5e 5f c9
> > e9 8a a0 fa ff 8d 65 f4 5b 5e 5f c9 c3 55 89 e5 57 56 53 83 ec 1c 89 4d e8
> > 89 55 ec 89 45 f0 <83> 78 10 ff 8b 78 18 0f 85 18 01 00 00 8b 4d f0 89 d0
> > 99 83 79 Feb 28 03:41:21 melchior kernel:  <7>exit_aio:ioctx still alive: 2
> > 1 0
> >
> >
> >
> > Without debugging options I got this one (Tainted due to vmware modules):
> >
> > Feb 28 01:50:00 melchior kernel: --[ cut here ]--
> > Feb 28 01:50:00 melchior kernel: kernel BUG at fs/nfs/inode.c:154!
> > Feb 28 01:50:00 melchior kernel: invalid operand: 0000 [#1]
> > Feb 28 01:50:00 melchior kernel: PREEMPT
> > Feb 28 01:50:00 melchior kernel: CPU:    0
> > Feb 28 01:50:00 melchior kernel: EIP:    0060:[<c0192d01>]    Tainted: P  
> > VLI Feb 28 01:50:00 melchior kernel: EFLAGS: 00010202
> > Feb 28 01:50:00 melchior kernel: EIP is at nfs_clear_inode+0x2f/0x39
> > Feb 28 01:50:00 melchior kernel: eax: 0000000b   ebx: d7e62a80   ecx:
> > 00000001   edx: dfd0f4d4 Feb 28 01:50:00 melchior kernel: esi: c0192c8d  
> > edi: d4174c80   ebp: d7e62b7c   esp: cf265f60 Feb 28 01:50:00 melchior
> > kernel: ds: 007b   es: 007b   ss: 0068
> > Feb 28 01:50:00 melchior kernel: Process rm (pid: 3170, threadinfo=cf264000
> > task=cf2677c0) Feb 28 01:50:00 melchior kernel: Stack: d7e62b7c c0156266
> > d7e62b7c c0156e4a 00000000 d4ea2000 c015706f c014ebb5 Feb 28 01:50:00
> > melchior kernel:        d4184300 dffe0180 d4ea200c 00000003 0024db2a
> > 00000010 00000000 c0150940 Feb 28 01:50:00 melchior kernel:        d7f73b8c
> > 00000000 bffffbf4 00000004 bffffbf4 bffffbf4 08050858 cf264000 Feb 28
> > 01:50:00 melchior kernel: Call Trace:
> > Feb 28 01:50:00 melchior kernel:  [<c0156266>] clear_inode+0x5a/0x86
> > Feb 28 01:50:00 melchior kernel:  [<c0156e4a>]
> > generic_delete_inode+0x82/0xeb Feb 28 01:50:00 melchior kernel: 
> > [<c015706f>] iput_final+0x20/0x21 Feb 28 01:50:00 melchior kernel: 
> > [<c014ebb5>] sys_unlink+0xc6/0xf3 Feb 28 01:50:00 melchior kernel: 
> > [<c0150940>] sys_ioctl+0x232/0x23e Feb 28 01:50:00 melchior kernel: 
> > [<c03086ab>] syscall_call+0x7/0xb Feb 28 01:50:00 melchior kernel:
> > Feb 28 01:50:00 melchior kernel: Code: ff ff ff 8b 83 f0 00 00 00 85 c0 74
> > 05 e8 91 bf 16 00 8b 83 b4 00 00 00 85 c0 74 05 e8 82 bf 16 00 8b 83 ac 00
> > 00 00 85 c0 74 08 <0f> 0b 9a 00 9f c2 32 c0 5b c3 53 8b 98 6c 01 00 00 8b
> > 03 85 c0 Feb 28 03:11:44 melchior kernel:  <1>Unable to handle kernel NULL
> > pointer dereference at virtual address 0000003c Feb 28 03:11:44 melchior
> > kernel:  printing eip:
> > Feb 28 03:11:44 melchior kernel: c015f0a9
> > Feb 28 03:11:44 melchior kernel: *pde = 00000000
> > Feb 28 03:11:44 melchior kernel: Oops: 0000 [#2]
> > Feb 28 03:11:44 melchior kernel: PREEMPT
> > Feb 28 03:11:44 melchior kernel: CPU:    0
> > Feb 28 03:11:44 melchior kernel: EIP:    0060:[<c015f0a9>]    Tainted: P  
> > VLI Feb 28 03:11:44 melchior kernel: EFLAGS: 00010002
> > Feb 28 03:11:44 melchior kernel: EIP is at aio_complete+0x8e/0x188
> > Feb 28 03:11:44 melchior kernel: eax: c777fa40   ebx: d9776000   ecx:
> > 00000000   edx: 00000034 Feb 28 03:11:44 melchior kernel: esi: 00000000  
> > edi: c1000000   ebp: c777fa40   esp: d9777f00 Feb 28 03:11:44 melchior
> > kernel: ds: 007b   es: 007b   ss: 0068
> > Feb 28 03:11:44 melchior kernel: Process odirect (pid: 24408,
> > threadinfo=d9776000 task=c4183390) Feb 28 03:11:44 melchior kernel: Stack:
> > c777fa64 c46ccbc0 d9776000 00000213 00000034 00000000 fffffff2 fffffff2 Feb
> > 28 03:11:44 melchior kernel:        00b50000 00000000 c777fa40 c015f8d2
> > 00000000 000028b4 c037fe40 000004bb Feb 28 03:11:44 melchior kernel:       
> > 00b50000 00000000 c41d8d40 bffff720 c46ccbc0 bffff720 00000000 fffffff2 Feb
> > 28 03:11:44 melchior kernel: Call Trace:
> > Feb 28 03:11:44 melchior kernel:  [<c015f8d2>] io_submit_one+0x26c/0x288
> > Feb 28 03:11:44 melchior kernel:  [<c015f9d7>] sys_io_submit+0xe9/0x137
> > Feb 28 03:11:44 melchior kernel:  [<c03086ab>] syscall_call+0x7/0xb
> > Feb 28 03:11:44 melchior kernel:
> > Feb 28 03:11:44 melchior kernel: Code: e8 0c 69 fb ff e9 11 01 00 00 8d 56
> > 34 89 54 24 10 9c 8f 44 24 0c fa bb 00 e0 ff ff 21 e3 89 5c 24 08 ff 43 14
> > 8b 3d d0 2a 45 c0 <8b> 4a 08 8b 19 29 fb c1 fb 03 69 db cd cc cc cc c1 e3
> > 0c 81 eb Feb 28 03:11:44 melchior kernel:  <6>note: odirect[24408] exited
> > with preempt_count 1 Feb 28 03:11:44 melchior kernel: exit_aio:ioctx still
> > alive: 2 1 0 Feb 28 03:11:44 melchior kernel: bad: scheduling while atomic!
> > Feb 28 03:11:44 melchior kernel: Call Trace:
> > Feb 28 03:11:44 melchior kernel:  [<c0116174>] schedule+0x3c/0x4d7
> > Feb 28 03:11:44 melchior kernel:  [<c0136910>] zap_pmd_range+0x41/0x4b
> > Feb 28 03:11:44 melchior kernel:  [<c0136952>] unmap_page_range+0x38/0x52
> > Feb 28 03:11:44 melchior kernel:  [<c0136aab>] unmap_vmas+0x13f/0x1ba
> > Feb 28 03:11:44 melchior kernel:  [<c0139d91>] exit_mmap+0x54/0x126
> > Feb 28 03:11:44 melchior kernel:  [<c0117c33>] mmput+0x73/0x87
> > Feb 28 03:11:44 melchior kernel:  [<c011b114>] do_exit+0x175/0x348
> > Feb 28 03:11:44 melchior kernel:  [<c010a88c>] do_divide_error+0x0/0xaa
> > Feb 28 03:11:44 melchior kernel:  [<c0114d84>] do_page_fault+0x31b/0x45b
> > Feb 28 03:11:44 melchior kernel:  [<c01ed91c>] opost_block+0x18a/0x197
> > Feb 28 03:11:44 melchior kernel:  [<c01f01a2>] pty_write+0x168/0x175
> > Feb 28 03:11:44 melchior kernel:  [<c0114a69>] do_page_fault+0x0/0x45b
> > Feb 28 03:11:44 melchior kernel:  [<c0308857>] error_code+0x2f/0x38
> > Feb 28 03:11:44 melchior kernel:  [<c015f0a9>] aio_complete+0x8e/0x188
> > Feb 28 03:11:44 melchior kernel:  [<c015f8d2>] io_submit_one+0x26c/0x288
> > Feb 28 03:11:44 melchior kernel:  [<c015f9d7>] sys_io_submit+0xe9/0x137
> > Feb 28 03:11:44 melchior kernel:  [<c03086ab>] syscall_call+0x7/0xb
> > Feb 28 03:11:44 melchior kernel:
> > Feb 28 03:13:44 melchior kernel: Unable to handle kernel NULL pointer
> > dereference at virtual address 0000003c Feb 28 03:13:44 melchior kernel: 
> > printing eip:
> > Feb 28 03:13:44 melchior kernel: c015f0a9
> > Feb 28 03:13:44 melchior kernel: *pde = 00000000
> > Feb 28 03:13:44 melchior kernel: Oops: 0000 [#3]
> > Feb 28 03:13:44 melchior kernel: PREEMPT
> > Feb 28 03:13:44 melchior kernel: CPU:    0
> > Feb 28 03:13:44 melchior kernel: EIP:    0060:[<c015f0a9>]    Tainted: P  
> > VLI Feb 28 03:13:44 melchior kernel: EFLAGS: 00010002
> > Feb 28 03:13:44 melchior kernel: EIP is at aio_complete+0x8e/0x188
> > Feb 28 03:13:44 melchior kernel: eax: d8d2d480   ebx: d92e2000   ecx:
> > 00000000   edx: 00000034 Feb 28 03:13:44 melchior kernel: esi: 00000000  
> > edi: c1000000   ebp: d8d2d480   esp: d92e3f00 Feb 28 03:13:44 melchior
> > kernel: ds: 007b   es: 007b   ss: 0068
> > Feb 28 03:13:44 melchior kernel: Process odirect (pid: 25625,
> > threadinfo=d92e2000 task=c4182830) Feb 28 03:13:44 melchior kernel: Stack:
> > d8d2d4a4 c46ccc80 d92e2000 00000213 00000034 00000000 fffffff2 fffffff2 Feb
> > 28 03:13:44 melchior kernel:        0a2f0000 00000000 d8d2d480 c015f8d2
> > 00000000 c70a2c40 c037fe40 40018000 Feb 28 03:13:44 melchior kernel:       
> > 0a2f0000 00000000 c429e0c0 bffff8e0 c46ccc80 bffff8e0 00000000 fffffff2 Feb
> > 28 03:13:44 melchior kernel: Call Trace:
> > Feb 28 03:13:44 melchior kernel:  [<c015f8d2>] io_submit_one+0x26c/0x288
> > Feb 28 03:13:44 melchior kernel:  [<c015f9d7>] sys_io_submit+0xe9/0x137
> > Feb 28 03:13:44 melchior kernel:  [<c03086ab>] syscall_call+0x7/0xb
> > Feb 28 03:13:44 melchior kernel:
> > Feb 28 03:13:44 melchior kernel: Code: e8 0c 69 fb ff e9 11 01 00 00 8d 56
> > 34 89 54 24 10 9c 8f 44 24 0c fa bb 00 e0 ff ff 21 e3 89 5c 24 08 ff 43 14
> > 8b 3d d0 2a 45 c0 <8b> 4a 08 8b 19 29 fb c1 fb 03 69 db cd cc cc cc c1 e3
> > 0c 81 eb Feb 28 03:13:44 melchior kernel:  <6>note: odirect[25625] exited
> > with preempt_count 1 Feb 28 03:13:44 melchior kernel: exit_aio:ioctx still
> > alive: 2 1 0 Feb 28 03:13:44 melchior kernel: bad: scheduling while atomic!
> > Feb 28 03:13:44 melchior kernel: Call Trace:
> > Feb 28 03:13:44 melchior kernel:  [<c0116174>] schedule+0x3c/0x4d7
> > Feb 28 03:13:44 melchior kernel:  [<c0136910>] zap_pmd_range+0x41/0x4b
> > Feb 28 03:13:44 melchior kernel:  [<c0136952>] unmap_page_range+0x38/0x52
> > Feb 28 03:13:44 melchior kernel:  [<c0136aab>] unmap_vmas+0x13f/0x1ba
> > Feb 28 03:13:44 melchior kernel:  [<c0139d91>] exit_mmap+0x54/0x126
> > Feb 28 03:13:44 melchior kernel:  [<c0117c33>] mmput+0x73/0x87
> > Feb 28 03:13:44 melchior kernel:  [<c011b114>] do_exit+0x175/0x348
> > Feb 28 03:13:44 melchior kernel:  [<c010a88c>] do_divide_error+0x0/0xaa
> > Feb 28 03:13:44 melchior kernel:  [<c0114d84>] do_page_fault+0x31b/0x45b
> > Feb 28 03:13:44 melchior kernel:  [<c010b6ac>] do_IRQ+0xad/0xf7
> > Feb 28 03:13:44 melchior kernel:  [<c0308818>] common_interrupt+0x18/0x20
> > Feb 28 03:13:44 melchior kernel:  [<c0114a69>] do_page_fault+0x0/0x45b
> > Feb 28 03:13:44 melchior kernel:  [<c0308857>] error_code+0x2f/0x38
> > Feb 28 03:13:44 melchior kernel:  [<c015f0a9>] aio_complete+0x8e/0x188
> > Feb 28 03:13:44 melchior kernel:  [<c015f8d2>] io_submit_one+0x26c/0x288
> > Feb 28 03:13:44 melchior kernel:  [<c015f9d7>] sys_io_submit+0xe9/0x137
> > Feb 28 03:13:44 melchior kernel:  [<c03086ab>] syscall_call+0x7/0xb
> > Feb 28 03:13:44 melchior kernel:
> > Feb 28 03:15:39 melchior kernel: Unable to handle kernel NULL pointer
> > dereference at virtual address 0000003c Feb 28 03:15:39 melchior kernel: 
> > printing eip:
> > Feb 28 03:15:39 melchior kernel: c015f0a9
> > Feb 28 03:15:39 melchior kernel: *pde = 00000000
> > Feb 28 03:15:39 melchior kernel: Oops: 0000 [#4]
> > Feb 28 03:15:39 melchior kernel: PREEMPT
> > Feb 28 03:15:39 melchior kernel: CPU:    0
> > Feb 28 03:15:39 melchior kernel: EIP:    0060:[<c015f0a9>]    Tainted: P  
> > VLI Feb 28 03:15:39 melchior kernel: EFLAGS: 00010002
> > Feb 28 03:15:39 melchior kernel: EIP is at aio_complete+0x8e/0x188
> > Feb 28 03:15:39 melchior kernel: eax: d8cbeb00   ebx: d8cb4000   ecx:
> > 00000000   edx: 00000034 Feb 28 03:15:39 melchior kernel: esi: 00000000  
> > edi: c1000000   ebp: d8cbeb00   esp: d8cb5f00 Feb 28 03:15:39 melchior
> > kernel: ds: 007b   es: 007b   ss: 0068
> > Feb 28 03:15:39 melchior kernel: Process odirect (pid: 26940,
> > threadinfo=d8cb4000 task=c78872d0) Feb 28 03:15:39 melchior kernel: Stack:
> > d8cbeb24 c46ccd40 d8cb4000 00000213 00000034 00000000 fffffff2 fffffff2 Feb
> > 28 03:15:39 melchior kernel:        0a2f0000 00000000 d8cbeb00 c015f8d2
> > 00000000 c70a2c40 c037fe40 40018000 Feb 28 03:15:39 melchior kernel:       
> > 0a2f0000 00000000 c41d8ec0 bffff9a0 c46ccd40 bffff9a0 00000000 fffffff2 Feb
> > 28 03:15:39 melchior kernel: Call Trace:
> > Feb 28 03:15:39 melchior kernel:  [<c015f8d2>] io_submit_one+0x26c/0x288
> > Feb 28 03:15:39 melchior kernel:  [<c015f9d7>] sys_io_submit+0xe9/0x137
> > Feb 28 03:15:39 melchior kernel:  [<c03086ab>] syscall_call+0x7/0xb
> > Feb 28 03:15:39 melchior kernel:
> > Feb 28 03:15:39 melchior kernel: Code: e8 0c 69 fb ff e9 11 01 00 00 8d 56
> > 34 89 54 24 10 9c 8f 44 24 0c fa bb 00 e0 ff ff 21 e3 89 5c 24 08 ff 43 14
> > 8b 3d d0 2a 45 c0 <8b> 4a 08 8b 19 29 fb c1 fb 03 69 db cd cc cc cc c1 e3
> > 0c 81 eb Feb 28 03:15:39 melchior kernel:  <6>note: odirect[26940] exited
> > with preempt_count 1 Feb 28 03:15:39 melchior kernel: exit_aio:ioctx still
> > alive: 2 1 0 Feb 28 03:15:39 melchior kernel: bad: scheduling while atomic!
> > Feb 28 03:15:39 melchior kernel: Call Trace:
> > Feb 28 03:15:39 melchior kernel:  [<c0116174>] schedule+0x3c/0x4d7
> > Feb 28 03:15:39 melchior kernel:  [<c0136910>] zap_pmd_range+0x41/0x4b
> > Feb 28 03:15:39 melchior kernel:  [<c0136952>] unmap_page_range+0x38/0x52
> > Feb 28 03:15:39 melchior kernel:  [<c0136aab>] unmap_vmas+0x13f/0x1ba
> > Feb 28 03:15:39 melchior kernel:  [<c0139d91>] exit_mmap+0x54/0x126
> > Feb 28 03:15:39 melchior kernel:  [<c0117c33>] mmput+0x73/0x87
> > Feb 28 03:15:39 melchior kernel:  [<c011b114>] do_exit+0x175/0x348
> > Feb 28 03:15:39 melchior kernel:  [<c010a88c>] do_divide_error+0x0/0xaa
> > Feb 28 03:15:39 melchior kernel:  [<c0114d84>] do_page_fault+0x31b/0x45b
> > Feb 28 03:15:39 melchior kernel:  [<c026e379>] stall_callback+0x139/0x141
> > Feb 28 03:15:39 melchior kernel:  [<c010b6e2>] do_IRQ+0xe3/0xf7
> > Feb 28 03:15:39 melchior kernel:  [<c0308818>] common_interrupt+0x18/0x20
> > Feb 28 03:15:39 melchior kernel:  [<c0114a69>] do_page_fault+0x0/0x45b
> > Feb 28 03:15:39 melchior kernel:  [<c0308857>] error_code+0x2f/0x38
> > Feb 28 03:15:39 melchior kernel:  [<c015f0a9>] aio_complete+0x8e/0x188
> > Feb 28 03:15:39 melchior kernel:  [<c015f8d2>] io_submit_one+0x26c/0x288
> > Feb 28 03:15:39 melchior kernel:  [<c015f9d7>] sys_io_submit+0xe9/0x137
> > Feb 28 03:15:39 melchior kernel:  [<c03086ab>] syscall_call+0x7/0xb
> >
> >
> >
> > This is the test program:
> >
> > #define _GNU_SOURCE
> > #include <unistd.h>
> > #include <fcntl.h>
> > #include <errno.h>
> > #include <linux/aio_abi.h>
> > #include <sys/syscall.h>
> >
> > _syscall2(int, io_setup, int, maxevents, aio_context_t *, ctxp);
> > _syscall3(int, io_submit, aio_context_t, ctx, long, nr, struct iocb **,
> > iocbs); _syscall5(int, io_getevents, aio_context_t, ctx, long, min_nr,
> > long, nr, struct io_event *, events, struct timespec *, timeout);
> >
> > #define QUEUELEN	128
> >
> > struct aio_info {
> > 	void *buf;
> > 	int inuse;
> > };
> >
> > int main(int argc, char **argv)
> > {
> > 	char *buf;
> > 	int fd;
> > 	int order, buflen, pagesize = getpagesize();
> > 	aio_context_t aio_ctx = 0;
> > 	struct iocb iocb[QUEUELEN];
> > 	struct aio_info info[QUEUELEN];
> > 	int i;
> > 	off_t filepos = 0;
> >
> > 	order = 0;
> >
> > 	if (argc != 3) {
> > 		printf("Usage: %s <file> <order>\n", argv[0]);
> > 		exit(1);
> > 	}
> >
> > 	fd = open(argv[1], O_WRONLY | O_CREAT | O_DIRECT, 0644);
> > 	if (fd < 0) {
> > 		perror("open");
> > 		exit(1);
> > 	}
> > 	sscanf(argv[2], "%d", &order);
> > 	buflen = pagesize << order;
> > 	buflen *= QUEUELEN;
> > 	printf("Pagesize: %d, order %d, buflen %d\n", pagesize, order, buflen);
> >
> > 	if (posix_memalign((void **)&buf, pagesize, pagesize) != 0) {
> > 		perror("posix_memalign");
> > 		exit(1);
> > 	}
> >
> > 	if (io_setup(QUEUELEN, &aio_ctx) != 0) {
> > 		perror("io_setup");
> > 		exit(1);
> > 	}
> > 	printf("aio_ctx=%d\n", aio_ctx);
> >
> > 	memset(&iocb, 0, sizeof(iocb));
> > 	for (i=0; i<QUEUELEN; i++) {
> > 		iocb[i].aio_fildes = fd;
> > 		iocb[i].aio_lio_opcode = IOCB_CMD_PWRITE;
> > 		iocb[i].aio_reqprio = 0;
> > 		iocb[i].aio_data = i;
> > 		iocb[i].aio_nbytes = pagesize << order;
> > 		info[i].inuse = 0;
> > 		info[i].buf = buf + (pagesize << order)*i;
> > 	}
> >
> > 	while (1) {
> > 		struct iocb *piocb;
> > 		struct io_event ioev;
> > 		int ret;
> >
> > 		i = 0;
> > 		while (i<QUEUELEN) {
> > 			for (i=0; i<QUEUELEN && info[i].inuse != 0; i++);
> >
> > 			if (i<QUEUELEN) {
> > 				info[i].inuse = 1;
> > 				iocb[i].aio_buf = (unsigned long)info[i].buf;
> > 				iocb[i].aio_offset = filepos;
> > 				piocb = &iocb[i];
> > 				if (io_submit(aio_ctx, 1, &piocb) != 1) {
> > 					perror("io_submit");
> > 					exit(1);
> > 				}
> > 				printf("submitted iocb %d, filepos %d\n", i, filepos);
> > 				filepos += iocb[i].aio_nbytes;
> > 			};
> > 		}
> >
> > 		ret = io_getevents(aio_ctx, 1, 1, &ioev, NULL);
> > 		if (ret < 0) {
> > 			perror("io_getevents");
> > 			exit(1);
> > 		}
> > 		if (ret == 1) {
> > 			printf("iocb %d completed with status %d\n", ioev.data, ioev.res);
> > 			info[ioev.data].inuse = 0;
> > 		}
> > 	}
> >
> > 	return 0;
> > }
> >
> >
> > And my kernel config:
> > #
> > # Automatically generated make config: don't edit
> > #
> > CONFIG_X86=y
> > CONFIG_MMU=y
> > CONFIG_UID16=y
> > CONFIG_GENERIC_ISA_DMA=y
> >
> > #
> > # Code maturity level options
> > #
> > CONFIG_EXPERIMENTAL=y
> > CONFIG_CLEAN_COMPILE=y
> > CONFIG_STANDALONE=y
> > CONFIG_BROKEN_ON_SMP=y
> >
> > #
> > # General setup
> > #
> > CONFIG_SWAP=y
> > CONFIG_SYSVIPC=y
> > # CONFIG_BSD_PROCESS_ACCT is not set
> > CONFIG_SYSCTL=y
> > CONFIG_LOG_BUF_SHIFT=14
> > # CONFIG_HOTPLUG is not set
> > CONFIG_IKCONFIG=y
> > CONFIG_IKCONFIG_PROC=y
> > CONFIG_EMBEDDED=y
> > CONFIG_KALLSYMS=y
> > CONFIG_FUTEX=y
> > CONFIG_EPOLL=y
> > CONFIG_IOSCHED_NOOP=y
> > CONFIG_IOSCHED_AS=y
> > CONFIG_IOSCHED_DEADLINE=y
> > CONFIG_IOSCHED_CFQ=y
> > CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> >
> > #
> > # Loadable module support
> > #
> > CONFIG_MODULES=y
> > CONFIG_MODULE_UNLOAD=y
> > CONFIG_MODULE_FORCE_UNLOAD=y
> > CONFIG_OBSOLETE_MODPARM=y
> > # CONFIG_MODVERSIONS is not set
> > CONFIG_KMOD=y
> >
> > #
> > # Processor type and features
> > #
> > CONFIG_X86_PC=y
> > # CONFIG_X86_ELAN is not set
> > # CONFIG_X86_VOYAGER is not set
> > # CONFIG_X86_NUMAQ is not set
> > # CONFIG_X86_SUMMIT is not set
> > # CONFIG_X86_BIGSMP is not set
> > # CONFIG_X86_VISWS is not set
> > # CONFIG_X86_GENERICARCH is not set
> > # CONFIG_X86_ES7000 is not set
> > # CONFIG_M386 is not set
> > # CONFIG_M486 is not set
> > # CONFIG_M586 is not set
> > # CONFIG_M586TSC is not set
> > # CONFIG_M586MMX is not set
> > # CONFIG_M686 is not set
> > # CONFIG_MPENTIUMII is not set
> > # CONFIG_MPENTIUMIII is not set
> > # CONFIG_MPENTIUMM is not set
> > # CONFIG_MPENTIUM4 is not set
> > # CONFIG_MK6 is not set
> > CONFIG_MK7=y
> > # CONFIG_MK8 is not set
> > # CONFIG_MELAN is not set
> > # CONFIG_MCRUSOE is not set
> > # CONFIG_MWINCHIPC6 is not set
> > # CONFIG_MWINCHIP2 is not set
> > # CONFIG_MWINCHIP3D is not set
> > # CONFIG_MCYRIXIII is not set
> > # CONFIG_MVIAC3_2 is not set
> > # CONFIG_X86_GENERIC is not set
> > CONFIG_X86_CMPXCHG=y
> > CONFIG_X86_XADD=y
> > CONFIG_X86_L1_CACHE_SHIFT=6
> > CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> > CONFIG_X86_WP_WORKS_OK=y
> > CONFIG_X86_INVLPG=y
> > CONFIG_X86_BSWAP=y
> > CONFIG_X86_POPAD_OK=y
> > CONFIG_X86_GOOD_APIC=y
> > CONFIG_X86_INTEL_USERCOPY=y
> > CONFIG_X86_USE_PPRO_CHECKSUM=y
> > CONFIG_X86_USE_3DNOW=y
> > # CONFIG_X86_4G is not set
> > # CONFIG_X86_SWITCH_PAGETABLES is not set
> > # CONFIG_X86_4G_VM_LAYOUT is not set
> > # CONFIG_X86_UACCESS_INDIRECT is not set
> > # CONFIG_X86_HIGH_ENTRY is not set
> > # CONFIG_HPET_TIMER is not set
> > # CONFIG_HPET_EMULATE_RTC is not set
> > # CONFIG_SMP is not set
> > # CONFIG_PREEMPT is not set
> > # CONFIG_X86_UP_APIC is not set
> > CONFIG_X86_TSC=y
> > CONFIG_X86_MCE=y
> > CONFIG_X86_MCE_NONFATAL=y
> > # CONFIG_TOSHIBA is not set
> > # CONFIG_I8K is not set
> > # CONFIG_MICROCODE is not set
> > # CONFIG_X86_MSR is not set
> > # CONFIG_X86_CPUID is not set
> > # CONFIG_EDD is not set
> > CONFIG_NOHIGHMEM=y
> > # CONFIG_HIGHMEM4G is not set
> > # CONFIG_HIGHMEM64G is not set
> > # CONFIG_MATH_EMULATION is not set
> > CONFIG_MTRR=y
> > CONFIG_REGPARM=y
> >
> > #
> > # Power management options (ACPI, APM)
> > #
> > CONFIG_PM=y
> > # CONFIG_SOFTWARE_SUSPEND is not set
> > # CONFIG_PM_DISK is not set
> >
> > #
> > # ACPI (Advanced Configuration and Power Interface) Support
> > #
> > # CONFIG_ACPI is not set
> > CONFIG_ACPI_BOOT=y
> >
> > #
> > # APM (Advanced Power Management) BIOS Support
> > #
> > CONFIG_APM=y
> > # CONFIG_APM_IGNORE_USER_SUSPEND is not set
> > # CONFIG_APM_DO_ENABLE is not set
> > # CONFIG_APM_CPU_IDLE is not set
> > # CONFIG_APM_DISPLAY_BLANK is not set
> > # CONFIG_APM_RTC_IS_GMT is not set
> > # CONFIG_APM_ALLOW_INTS is not set
> > # CONFIG_APM_REAL_MODE_POWER_OFF is not set
> >
> > #
> > # CPU Frequency scaling
> > #
> > # CONFIG_CPU_FREQ is not set
> >
> > #
> > # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
> > #
> > CONFIG_PCI=y
> > # CONFIG_PCI_GOBIOS is not set
> > # CONFIG_PCI_GOMMCONFIG is not set
> > # CONFIG_PCI_GODIRECT is not set
> > CONFIG_PCI_GOANY=y
> > CONFIG_PCI_BIOS=y
> > CONFIG_PCI_DIRECT=y
> > CONFIG_PCI_MMCONFIG=y
> > CONFIG_PCI_LEGACY_PROC=y
> > CONFIG_PCI_NAMES=y
> > # CONFIG_ISA is not set
> > # CONFIG_MCA is not set
> > # CONFIG_SCx200 is not set
> >
> > #
> > # Executable file formats
> > #
> > CONFIG_BINFMT_ELF=y
> > # CONFIG_BINFMT_AOUT is not set
> > # CONFIG_BINFMT_MISC is not set
> >
> > #
> > # Device Drivers
> > #
> >
> > #
> > # Generic Driver Options
> > #
> >
> > #
> > # Memory Technology Devices (MTD)
> > #
> > # CONFIG_MTD is not set
> >
> > #
> > # Parallel port support
> > #
> > CONFIG_PARPORT=y
> > CONFIG_PARPORT_PC=y
> > CONFIG_PARPORT_PC_CML1=y
> > # CONFIG_PARPORT_SERIAL is not set
> > CONFIG_PARPORT_PC_FIFO=y
> > CONFIG_PARPORT_PC_SUPERIO=y
> > # CONFIG_PARPORT_OTHER is not set
> > # CONFIG_PARPORT_1284 is not set
> >
> > #
> > # Plug and Play support
> > #
> >
> > #
> > # Block devices
> > #
> > CONFIG_BLK_DEV_FD=y
> > # CONFIG_PARIDE is not set
> > # CONFIG_BLK_CPQ_DA is not set
> > # CONFIG_BLK_CPQ_CISS_DA is not set
> > # CONFIG_BLK_DEV_DAC960 is not set
> > # CONFIG_BLK_DEV_UMEM is not set
> > CONFIG_BLK_DEV_LOOP=y
> > # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> > # CONFIG_BLK_DEV_NBD is not set
> > # CONFIG_BLK_DEV_RAM is not set
> > # CONFIG_BLK_DEV_INITRD is not set
> > # CONFIG_LBD is not set
> > # CONFIG_DCSSBLK is not set
> >
> > #
> > # ATA/ATAPI/MFM/RLL support
> > #
> > CONFIG_IDE=y
> > CONFIG_BLK_DEV_IDE=y
> >
> > #
> > # Please see Documentation/ide.txt for help/info on IDE drives
> > #
> > # CONFIG_BLK_DEV_HD_IDE is not set
> > CONFIG_BLK_DEV_IDEDISK=y
> > CONFIG_IDEDISK_MULTI_MODE=y
> > # CONFIG_IDEDISK_STROKE is not set
> > CONFIG_BLK_DEV_IDECD=y
> > # CONFIG_BLK_DEV_IDETAPE is not set
> > # CONFIG_BLK_DEV_IDEFLOPPY is not set
> > # CONFIG_BLK_DEV_IDESCSI is not set
> > CONFIG_IDE_TASK_IOCTL=y
> > CONFIG_IDE_TASKFILE_IO=y
> >
> > #
> > # IDE chipset support/bugfixes
> > #
> > CONFIG_IDE_GENERIC=y
> > # CONFIG_BLK_DEV_CMD640 is not set
> > CONFIG_BLK_DEV_IDEPCI=y
> > CONFIG_IDEPCI_SHARE_IRQ=y
> > # CONFIG_BLK_DEV_OFFBOARD is not set
> > CONFIG_BLK_DEV_GENERIC=y
> > # CONFIG_BLK_DEV_OPTI621 is not set
> > # CONFIG_BLK_DEV_RZ1000 is not set
> > CONFIG_BLK_DEV_IDEDMA_PCI=y
> > # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> > CONFIG_IDEDMA_PCI_AUTO=y
> > # CONFIG_IDEDMA_ONLYDISK is not set
> > CONFIG_BLK_DEV_ADMA=y
> > # CONFIG_BLK_DEV_AEC62XX is not set
> > # CONFIG_BLK_DEV_ALI15X3 is not set
> > # CONFIG_BLK_DEV_AMD74XX is not set
> > # CONFIG_BLK_DEV_CMD64X is not set
> > # CONFIG_BLK_DEV_TRIFLEX is not set
> > # CONFIG_BLK_DEV_CY82C693 is not set
> > # CONFIG_BLK_DEV_CS5520 is not set
> > # CONFIG_BLK_DEV_CS5530 is not set
> > # CONFIG_BLK_DEV_HPT34X is not set
> > # CONFIG_BLK_DEV_HPT366 is not set
> > # CONFIG_BLK_DEV_SC1200 is not set
> > # CONFIG_BLK_DEV_PIIX is not set
> > # CONFIG_BLK_DEV_NS87415 is not set
> > # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> > # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> > # CONFIG_BLK_DEV_SVWKS is not set
> > # CONFIG_BLK_DEV_SIIMAGE is not set
> > # CONFIG_BLK_DEV_SIS5513 is not set
> > # CONFIG_BLK_DEV_SLC90E66 is not set
> > # CONFIG_BLK_DEV_TRM290 is not set
> > CONFIG_BLK_DEV_VIA82CXXX=y
> > CONFIG_BLK_DEV_IDEDMA=y
> > # CONFIG_IDEDMA_IVB is not set
> > CONFIG_IDEDMA_AUTO=y
> > # CONFIG_DMA_NONPCI is not set
> > # CONFIG_BLK_DEV_HD is not set
> >
> > #
> > # SCSI device support
> > #
> > CONFIG_SCSI=y
> > # CONFIG_SCSI_PROC_FS is not set
> >
> > #
> > # SCSI support type (disk, tape, CD-ROM)
> > #
> > # CONFIG_BLK_DEV_SD is not set
> > # CONFIG_CHR_DEV_ST is not set
> > # CONFIG_CHR_DEV_OSST is not set
> > # CONFIG_BLK_DEV_SR is not set
> > # CONFIG_CHR_DEV_SG is not set
> >
> > #
> > # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> > #
> > # CONFIG_SCSI_MULTI_LUN is not set
> > # CONFIG_SCSI_REPORT_LUNS is not set
> > # CONFIG_SCSI_CONSTANTS is not set
> > # CONFIG_SCSI_LOGGING is not set
> >
> > #
> > # SCSI low-level drivers
> > #
> > # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> > # CONFIG_SCSI_ACARD is not set
> > # CONFIG_SCSI_AACRAID is not set
> > # CONFIG_SCSI_AIC7XXX is not set
> > # CONFIG_SCSI_AIC7XXX_OLD is not set
> > # CONFIG_SCSI_AIC79XX is not set
> > # CONFIG_SCSI_ADVANSYS is not set
> > # CONFIG_SCSI_MEGARAID is not set
> > # CONFIG_SCSI_SATA is not set
> > # CONFIG_SCSI_BUSLOGIC is not set
> > # CONFIG_SCSI_CPQFCTS is not set
> > # CONFIG_SCSI_DMX3191D is not set
> > # CONFIG_SCSI_EATA is not set
> > # CONFIG_SCSI_EATA_PIO is not set
> > # CONFIG_SCSI_FUTURE_DOMAIN is not set
> > # CONFIG_SCSI_GDTH is not set
> > # CONFIG_SCSI_IPS is not set
> > # CONFIG_SCSI_INIA100 is not set
> > # CONFIG_SCSI_PPA is not set
> > # CONFIG_SCSI_IMM is not set
> > # CONFIG_SCSI_SYM53C8XX_2 is not set
> > # CONFIG_SCSI_QLOGIC_ISP is not set
> > # CONFIG_SCSI_QLOGIC_FC is not set
> > # CONFIG_SCSI_QLOGIC_1280 is not set
> > CONFIG_SCSI_QLA2XXX=y
> > # CONFIG_SCSI_QLA21XX is not set
> > # CONFIG_SCSI_QLA22XX is not set
> > # CONFIG_SCSI_QLA2300 is not set
> > # CONFIG_SCSI_QLA2322 is not set
> > # CONFIG_SCSI_QLA6312 is not set
> > # CONFIG_SCSI_QLA6322 is not set
> > # CONFIG_SCSI_DC395x is not set
> > # CONFIG_SCSI_DC390T is not set
> > # CONFIG_SCSI_NSP32 is not set
> > # CONFIG_SCSI_DEBUG is not set
> >
> > #
> > # Multi-device support (RAID and LVM)
> > #
> > # CONFIG_MD is not set
> >
> > #
> > # Fusion MPT device support
> > #
> >
> > #
> > # IEEE 1394 (FireWire) support
> > #
> > # CONFIG_IEEE1394 is not set
> >
> > #
> > # I2O device support
> > #
> > # CONFIG_I2O is not set
> >
> > #
> > # Macintosh device drivers
> > #
> >
> > #
> > # Networking support
> > #
> > CONFIG_NET=y
> >
> > #
> > # Networking options
> > #
> > CONFIG_PACKET=y
> > # CONFIG_PACKET_MMAP is not set
> > CONFIG_NETLINK_DEV=y
> > CONFIG_UNIX=y
> > CONFIG_NET_KEY=y
> > CONFIG_INET=y
> > CONFIG_IP_MULTICAST=y
> > # CONFIG_IP_ADVANCED_ROUTER is not set
> > # CONFIG_IP_PNP is not set
> > # CONFIG_NET_IPIP is not set
> > # CONFIG_NET_IPGRE is not set
> > # CONFIG_IP_MROUTE is not set
> > # CONFIG_ARPD is not set
> > CONFIG_INET_ECN=y
> > CONFIG_SYN_COOKIES=y
> > CONFIG_INET_AH=y
> > CONFIG_INET_ESP=y
> > CONFIG_INET_IPCOMP=y
> > # CONFIG_IPV6 is not set
> > # CONFIG_DECNET is not set
> > # CONFIG_BRIDGE is not set
> > # CONFIG_NETFILTER is not set
> > CONFIG_XFRM=y
> > CONFIG_XFRM_USER=y
> >
> > #
> > # SCTP Configuration (EXPERIMENTAL)
> > #
> > CONFIG_IPV6_SCTP__=y
> > # CONFIG_IP_SCTP is not set
> > # CONFIG_ATM is not set
> > # CONFIG_VLAN_8021Q is not set
> > CONFIG_LLC=y
> > # CONFIG_LLC2 is not set
> > # CONFIG_IPX is not set
> > # CONFIG_ATALK is not set
> > # CONFIG_X25 is not set
> > # CONFIG_LAPB is not set
> > # CONFIG_NET_DIVERT is not set
> > # CONFIG_ECONET is not set
> > # CONFIG_WAN_ROUTER is not set
> > # CONFIG_NET_FASTROUTE is not set
> > # CONFIG_NET_HW_FLOWCONTROL is not set
> >
> > #
> > # QoS and/or fair queueing
> > #
> > # CONFIG_NET_SCHED is not set
> >
> > #
> > # Network testing
> > #
> > # CONFIG_NET_PKTGEN is not set
> > CONFIG_NETDEVICES=y
> >
> > #
> > # ARCnet devices
> > #
> > # CONFIG_ARCNET is not set
> > # CONFIG_DUMMY is not set
> > # CONFIG_BONDING is not set
> > # CONFIG_EQUALIZER is not set
> > # CONFIG_TUN is not set
> > # CONFIG_ETHERTAP is not set
> >
> > #
> > # Ethernet (10 or 100Mbit)
> > #
> > CONFIG_NET_ETHERNET=y
> > CONFIG_MII=y
> > # CONFIG_HAPPYMEAL is not set
> > # CONFIG_SUNGEM is not set
> > CONFIG_NET_VENDOR_3COM=y
> > CONFIG_VORTEX=y
> > # CONFIG_TYPHOON is not set
> >
> > #
> > # Tulip family network device support
> > #
> > CONFIG_NET_TULIP=y
> > # CONFIG_DE2104X is not set
> > CONFIG_TULIP=y
> > CONFIG_TULIP_MWI=y
> > CONFIG_TULIP_MMIO=y
> > CONFIG_TULIP_NAPI=y
> > CONFIG_TULIP_NAPI_HW_MITIGATION=y
> > # CONFIG_DE4X5 is not set
> > # CONFIG_WINBOND_840 is not set
> > # CONFIG_DM9102 is not set
> > # CONFIG_HP100 is not set
> > CONFIG_NET_PCI=y
> > # CONFIG_PCNET32 is not set
> > # CONFIG_AMD8111_ETH is not set
> > # CONFIG_ADAPTEC_STARFIRE is not set
> > # CONFIG_B44 is not set
> > # CONFIG_FORCEDETH is not set
> > # CONFIG_DGRS is not set
> > # CONFIG_EEPRO100 is not set
> > CONFIG_E100=y
> > CONFIG_E100_NAPI=y
> > # CONFIG_FEALNX is not set
> > # CONFIG_NATSEMI is not set
> > # CONFIG_NE2K_PCI is not set
> > # CONFIG_8139CP is not set
> > CONFIG_8139TOO=y
> > # CONFIG_8139TOO_PIO is not set
> > # CONFIG_8139TOO_TUNE_TWISTER is not set
> > # CONFIG_8139TOO_8129 is not set
> > # CONFIG_8139_OLD_RX_RESET is not set
> > CONFIG_8139_RXBUF_IDX=2
> > # CONFIG_SIS900 is not set
> > # CONFIG_EPIC100 is not set
> > # CONFIG_SUNDANCE is not set
> > # CONFIG_TLAN is not set
> > # CONFIG_VIA_RHINE is not set
> >
> > #
> > # Ethernet (1000 Mbit)
> > #
> > # CONFIG_ACENIC is not set
> > # CONFIG_DL2K is not set
> > # CONFIG_E1000 is not set
> > # CONFIG_NS83820 is not set
> > # CONFIG_HAMACHI is not set
> > # CONFIG_YELLOWFIN is not set
> > # CONFIG_R8169 is not set
> > # CONFIG_SIS190 is not set
> > # CONFIG_SK98LIN is not set
> > # CONFIG_TIGON3 is not set
> >
> > #
> > # Ethernet (10000 Mbit)
> > #
> > # CONFIG_IXGB is not set
> > # CONFIG_FDDI is not set
> > # CONFIG_HIPPI is not set
> > # CONFIG_PLIP is not set
> > # CONFIG_PPP is not set
> > # CONFIG_SLIP is not set
> >
> > #
> > # Wireless LAN (non-hamradio)
> > #
> > # CONFIG_NET_RADIO is not set
> >
> > #
> > # Token Ring devices
> > #
> > CONFIG_TR=y
> > CONFIG_IBMOL=y
> > CONFIG_IBMLS=y
> > CONFIG_3C359=y
> > CONFIG_TMS380TR=y
> > CONFIG_TMSPCI=y
> > CONFIG_ABYSS=y
> > # CONFIG_NET_FC is not set
> > # CONFIG_RCPCI is not set
> > # CONFIG_SHAPER is not set
> > CONFIG_NETCONSOLE=y
> >
> > #
> > # Wan interfaces
> > #
> > # CONFIG_WAN is not set
> >
> > #
> > # Amateur Radio support
> > #
> > # CONFIG_HAMRADIO is not set
> >
> > #
> > # IrDA (infrared) support
> > #
> > # CONFIG_IRDA is not set
> >
> > #
> > # Bluetooth support
> > #
> > # CONFIG_BT is not set
> > # CONFIG_KGDBOE is not set
> > CONFIG_NETPOLL=y
> > # CONFIG_NETPOLL_RX is not set
> > # CONFIG_NETPOLL_TRAP is not set
> > CONFIG_NET_POLL_CONTROLLER=y
> >
> > #
> > # ISDN subsystem
> > #
> > # CONFIG_ISDN is not set
> >
> > #
> > # Telephony Support
> > #
> > # CONFIG_PHONE is not set
> >
> > #
> > # Input device support
> > #
> > CONFIG_INPUT=y
> >
> > #
> > # Userland interfaces
> > #
> > CONFIG_INPUT_MOUSEDEV=y
> > CONFIG_INPUT_MOUSEDEV_PSAUX=y
> > CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> > CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> > CONFIG_INPUT_JOYDEV=y
> > # CONFIG_INPUT_TSDEV is not set
> > CONFIG_INPUT_EVDEV=y
> > # CONFIG_INPUT_EVBUG is not set
> >
> > #
> > # Input I/O drivers
> > #
> > # CONFIG_GAMEPORT is not set
> > CONFIG_SOUND_GAMEPORT=y
> > CONFIG_SERIO=y
> > CONFIG_SERIO_I8042=y
> > CONFIG_SERIO_SERPORT=y
> > # CONFIG_SERIO_CT82C710 is not set
> > # CONFIG_SERIO_PARKBD is not set
> > # CONFIG_SERIO_PCIPS2 is not set
> >
> > #
> > # Input Device Drivers
> > #
> > CONFIG_INPUT_KEYBOARD=y
> > CONFIG_KEYBOARD_ATKBD=y
> > # CONFIG_KEYBOARD_SUNKBD is not set
> > # CONFIG_KEYBOARD_XTKBD is not set
> > # CONFIG_KEYBOARD_NEWTON is not set
> > CONFIG_INPUT_MOUSE=y
> > CONFIG_MOUSE_PS2=y
> > # CONFIG_MOUSE_SERIAL is not set
> > # CONFIG_INPUT_JOYSTICK is not set
> > # CONFIG_INPUT_TOUCHSCREEN is not set
> > # CONFIG_INPUT_MISC is not set
> >
> > #
> > # Character devices
> > #
> > CONFIG_VT=y
> > CONFIG_VT_CONSOLE=y
> > CONFIG_HW_CONSOLE=y
> > # CONFIG_SERIAL_NONSTANDARD is not set
> >
> > #
> > # Serial drivers
> > #
> > CONFIG_SERIAL_8250=y
> > CONFIG_SERIAL_8250_CONSOLE=y
> > CONFIG_SERIAL_8250_NR_UARTS=4
> > # CONFIG_SERIAL_8250_EXTENDED is not set
> >
> > #
> > # Non-8250 serial port support
> > #
> > CONFIG_SERIAL_CORE=y
> > CONFIG_SERIAL_CORE_CONSOLE=y
> > CONFIG_UNIX98_PTYS=y
> > CONFIG_LEGACY_PTYS=y
> > CONFIG_LEGACY_PTY_COUNT=256
> > CONFIG_PRINTER=y
> > # CONFIG_LP_CONSOLE is not set
> > # CONFIG_PPDEV is not set
> > # CONFIG_TIPAR is not set
> > # CONFIG_QIC02_TAPE is not set
> >
> > #
> > # IPMI
> > #
> > # CONFIG_IPMI_HANDLER is not set
> >
> > #
> > # Watchdog Cards
> > #
> > # CONFIG_WATCHDOG is not set
> > # CONFIG_HW_RANDOM is not set
> > # CONFIG_NVRAM is not set
> > CONFIG_RTC=y
> > # CONFIG_DTLK is not set
> > # CONFIG_R3964 is not set
> > # CONFIG_APPLICOM is not set
> > # CONFIG_SONYPI is not set
> >
> > #
> > # Ftape, the floppy tape device driver
> > #
> > # CONFIG_FTAPE is not set
> > CONFIG_AGP=y
> > # CONFIG_AGP_ALI is not set
> > # CONFIG_AGP_ATI is not set
> > # CONFIG_AGP_AMD is not set
> > # CONFIG_AGP_AMD64 is not set
> > # CONFIG_AGP_INTEL is not set
> > # CONFIG_AGP_NVIDIA is not set
> > # CONFIG_AGP_SIS is not set
> > # CONFIG_AGP_SWORKS is not set
> > CONFIG_AGP_VIA=y
> > # CONFIG_AGP_EFFICEON is not set
> > CONFIG_DRM=y
> > # CONFIG_DRM_TDFX is not set
> > # CONFIG_DRM_GAMMA is not set
> > # CONFIG_DRM_R128 is not set
> > CONFIG_DRM_RADEON=y
> > # CONFIG_DRM_MGA is not set
> > # CONFIG_DRM_SIS is not set
> > # CONFIG_MWAVE is not set
> > # CONFIG_RAW_DRIVER is not set
> > # CONFIG_HANGCHECK_TIMER is not set
> >
> > #
> > # I2C support
> > #
> > CONFIG_I2C=y
> > CONFIG_I2C_CHARDEV=y
> >
> > #
> > # I2C Algorithms
> > #
> > CONFIG_I2C_ALGOBIT=y
> > # CONFIG_I2C_ALGOPCF is not set
> >
> > #
> > # I2C Hardware Bus support
> > #
> > # CONFIG_I2C_ALI1535 is not set
> > # CONFIG_I2C_ALI15X3 is not set
> > # CONFIG_I2C_AMD756 is not set
> > # CONFIG_I2C_AMD8111 is not set
> > # CONFIG_I2C_ELV is not set
> > # CONFIG_I2C_I801 is not set
> > # CONFIG_I2C_I810 is not set
> > # CONFIG_I2C_ISA is not set
> > # CONFIG_I2C_NFORCE2 is not set
> > # CONFIG_I2C_PHILIPSPAR is not set
> > # CONFIG_I2C_PARPORT is not set
> > # CONFIG_I2C_PARPORT_LIGHT is not set
> > # CONFIG_I2C_PIIX4 is not set
> > # CONFIG_I2C_PROSAVAGE is not set
> > # CONFIG_I2C_SAVAGE4 is not set
> > # CONFIG_SCx200_ACB is not set
> > # CONFIG_I2C_SIS5595 is not set
> > # CONFIG_I2C_SIS630 is not set
> > # CONFIG_I2C_SIS96X is not set
> > # CONFIG_I2C_VELLEMAN is not set
> > CONFIG_I2C_VIA=y
> > CONFIG_I2C_VIAPRO=y
> > # CONFIG_I2C_VOODOO3 is not set
> >
> > #
> > # I2C Hardware Sensors Chip support
> > #
> > CONFIG_I2C_SENSOR=y
> > # CONFIG_SENSORS_ADM1021 is not set
> > # CONFIG_SENSORS_ASB100 is not set
> > # CONFIG_SENSORS_EEPROM is not set
> > # CONFIG_SENSORS_FSCHER is not set
> > # CONFIG_SENSORS_GL518SM is not set
> > # CONFIG_SENSORS_IT87 is not set
> > # CONFIG_SENSORS_LM75 is not set
> > # CONFIG_SENSORS_LM78 is not set
> > # CONFIG_SENSORS_LM80 is not set
> > # CONFIG_SENSORS_LM83 is not set
> > # CONFIG_SENSORS_LM85 is not set
> > # CONFIG_SENSORS_LM90 is not set
> > # CONFIG_SENSORS_VIA686A is not set
> > CONFIG_SENSORS_W83781D=y
> > # CONFIG_SENSORS_W83L785TS is not set
> > # CONFIG_I2C_DEBUG_CORE is not set
> > # CONFIG_I2C_DEBUG_BUS is not set
> > # CONFIG_I2C_DEBUG_CHIP is not set
> >
> > #
> > # Multimedia devices
> > #
> > CONFIG_VIDEO_DEV=y
> >
> > #
> > # Video For Linux
> > #
> >
> > #
> > # Video Adapters
> > #
> > CONFIG_VIDEO_BT848=m
> > # CONFIG_VIDEO_BWQCAM is not set
> > # CONFIG_VIDEO_CQCAM is not set
> > # CONFIG_VIDEO_CPIA is not set
> > # CONFIG_VIDEO_SAA5249 is not set
> > # CONFIG_TUNER_3036 is not set
> > # CONFIG_VIDEO_STRADIS is not set
> > # CONFIG_VIDEO_ZORAN is not set
> > # CONFIG_VIDEO_SAA7134 is not set
> > # CONFIG_VIDEO_MXB is not set
> > # CONFIG_VIDEO_DPC is not set
> > # CONFIG_VIDEO_HEXIUM_ORION is not set
> > # CONFIG_VIDEO_HEXIUM_GEMINI is not set
> > # CONFIG_VIDEO_CX88 is not set
> >
> > #
> > # Radio Adapters
> > #
> > # CONFIG_RADIO_GEMTEK_PCI is not set
> > # CONFIG_RADIO_MAXIRADIO is not set
> > # CONFIG_RADIO_MAESTRO is not set
> >
> > #
> > # Digital Video Broadcasting Devices
> > #
> > # CONFIG_DVB is not set
> > CONFIG_VIDEO_TUNER=m
> > CONFIG_VIDEO_BUF=m
> > CONFIG_VIDEO_BTCX=m
> > CONFIG_VIDEO_IR=m
> >
> > #
> > # Graphics support
> > #
> > # CONFIG_FB is not set
> > CONFIG_VIDEO_SELECT=y
> >
> > #
> > # Console display driver support
> > #
> > CONFIG_VGA_CONSOLE=y
> > # CONFIG_MDA_CONSOLE is not set
> > CONFIG_DUMMY_CONSOLE=y
> >
> > #
> > # Sound
> > #
> > CONFIG_SOUND=y
> >
> > #
> > # Advanced Linux Sound Architecture
> > #
> > CONFIG_SND=y
> > # CONFIG_SND_SEQUENCER is not set
> > CONFIG_SND_OSSEMUL=y
> > CONFIG_SND_MIXER_OSS=y
> > CONFIG_SND_PCM_OSS=y
> > # CONFIG_SND_RTCTIMER is not set
> > # CONFIG_SND_VERBOSE_PRINTK is not set
> > # CONFIG_SND_DEBUG is not set
> >
> > #
> > # Generic devices
> > #
> > # CONFIG_SND_DUMMY is not set
> > # CONFIG_SND_MTPAV is not set
> > # CONFIG_SND_SERIAL_U16550 is not set
> > # CONFIG_SND_MPU401 is not set
> >
> > #
> > # PCI devices
> > #
> > # CONFIG_SND_ALI5451 is not set
> > # CONFIG_SND_AZT3328 is not set
> > CONFIG_SND_BT87X=m
> > # CONFIG_SND_CS46XX is not set
> > # CONFIG_SND_CS4281 is not set
> > # CONFIG_SND_EMU10K1 is not set
> > # CONFIG_SND_KORG1212 is not set
> > # CONFIG_SND_MIXART is not set
> > # CONFIG_SND_NM256 is not set
> > # CONFIG_SND_RME32 is not set
> > # CONFIG_SND_RME96 is not set
> > # CONFIG_SND_RME9652 is not set
> > # CONFIG_SND_HDSP is not set
> > # CONFIG_SND_TRIDENT is not set
> > # CONFIG_SND_YMFPCI is not set
> > # CONFIG_SND_ALS4000 is not set
> > CONFIG_SND_CMIPCI=y
> > # CONFIG_SND_ENS1370 is not set
> > # CONFIG_SND_ENS1371 is not set
> > # CONFIG_SND_ES1938 is not set
> > # CONFIG_SND_ES1968 is not set
> > # CONFIG_SND_MAESTRO3 is not set
> > # CONFIG_SND_FM801 is not set
> > # CONFIG_SND_ICE1712 is not set
> > # CONFIG_SND_ICE1724 is not set
> > # CONFIG_SND_INTEL8X0 is not set
> > # CONFIG_SND_SONICVIBES is not set
> > # CONFIG_SND_VIA82XX is not set
> > # CONFIG_SND_VX222 is not set
> >
> > #
> > # ALSA USB devices
> > #
> > # CONFIG_SND_USB_AUDIO is not set
> >
> > #
> > # Open Sound System
> > #
> > # CONFIG_SOUND_PRIME is not set
> >
> > #
> > # USB support
> > #
> > CONFIG_USB=y
> > CONFIG_USB_DEBUG=y
> >
> > #
> > # Miscellaneous USB options
> > #
> > CONFIG_USB_DEVICEFS=y
> > # CONFIG_USB_BANDWIDTH is not set
> > # CONFIG_USB_DYNAMIC_MINORS is not set
> >
> > #
> > # USB Host Controller Drivers
> > #
> > CONFIG_USB_EHCI_HCD=y
> > # CONFIG_USB_OHCI_HCD is not set
> > CONFIG_USB_UHCI_HCD=y
> >
> > #
> > # USB Device Class drivers
> > #
> > # CONFIG_USB_AUDIO is not set
> > # CONFIG_USB_BLUETOOTH_TTY is not set
> > # CONFIG_USB_MIDI is not set
> > # CONFIG_USB_ACM is not set
> > # CONFIG_USB_PRINTER is not set
> > CONFIG_USB_STORAGE=y
> > # CONFIG_USB_STORAGE_DEBUG is not set
> > # CONFIG_USB_STORAGE_DATAFAB is not set
> > CONFIG_USB_STORAGE_FREECOM=y
> > CONFIG_USB_STORAGE_ISD200=y
> > # CONFIG_USB_STORAGE_DPCM is not set
> > # CONFIG_USB_STORAGE_HP8200e is not set
> > CONFIG_USB_STORAGE_SDDR09=y
> > CONFIG_USB_STORAGE_SDDR55=y
> > # CONFIG_USB_STORAGE_JUMPSHOT is not set
> >
> > #
> > # USB Human Interface Devices (HID)
> > #
> > CONFIG_USB_HID=y
> > CONFIG_USB_HIDINPUT=y
> > # CONFIG_HID_FF is not set
> > # CONFIG_USB_HIDDEV is not set
> > # CONFIG_USB_AIPTEK is not set
> > # CONFIG_USB_WACOM is not set
> > # CONFIG_USB_KBTAB is not set
> > # CONFIG_USB_POWERMATE is not set
> > # CONFIG_USB_XPAD is not set
> >
> > #
> > # USB Imaging devices
> > #
> > # CONFIG_USB_MDC800 is not set
> > # CONFIG_USB_MICROTEK is not set
> > # CONFIG_USB_HPUSBSCSI is not set
> >
> > #
> > # USB Multimedia devices
> > #
> > # CONFIG_USB_DABUSB is not set
> > # CONFIG_USB_VICAM is not set
> > # CONFIG_USB_DSBR is not set
> > # CONFIG_USB_IBMCAM is not set
> > # CONFIG_USB_KONICAWC is not set
> > # CONFIG_USB_OV511 is not set
> > # CONFIG_USB_PWC is not set
> > # CONFIG_USB_SE401 is not set
> > # CONFIG_USB_STV680 is not set
> > # CONFIG_USB_W9968CF is not set
> >
> > #
> > # USB Network adaptors
> > #
> > # CONFIG_USB_CATC is not set
> > # CONFIG_USB_KAWETH is not set
> > # CONFIG_USB_PEGASUS is not set
> > # CONFIG_USB_RTL8150 is not set
> > # CONFIG_USB_USBNET is not set
> >
> > #
> > # USB port drivers
> > #
> > # CONFIG_USB_USS720 is not set
> >
> > #
> > # USB Serial Converter support
> > #
> > # CONFIG_USB_SERIAL is not set
> >
> > #
> > # USB Miscellaneous drivers
> > #
> > # CONFIG_USB_EMI62 is not set
> > # CONFIG_USB_EMI26 is not set
> > # CONFIG_USB_TIGL is not set
> > # CONFIG_USB_AUERSWALD is not set
> > # CONFIG_USB_RIO500 is not set
> > # CONFIG_USB_LEGOTOWER is not set
> > # CONFIG_USB_BRLVGER is not set
> > # CONFIG_USB_LCD is not set
> > # CONFIG_USB_LED is not set
> > # CONFIG_USB_TEST is not set
> >
> > #
> > # USB Gadget Support
> > #
> > # CONFIG_USB_GADGET is not set
> >
> > #
> > # File systems
> > #
> > CONFIG_EXT2_FS=y
> > CONFIG_EXT2_FS_XATTR=y
> > # CONFIG_EXT2_FS_POSIX_ACL is not set
> > # CONFIG_EXT2_FS_SECURITY is not set
> > CONFIG_EXT3_FS=y
> > CONFIG_EXT3_FS_XATTR=y
> > # CONFIG_EXT3_FS_POSIX_ACL is not set
> > # CONFIG_EXT3_FS_SECURITY is not set
> > CONFIG_JBD=y
> > # CONFIG_JBD_DEBUG is not set
> > CONFIG_FS_MBCACHE=y
> > # CONFIG_REISERFS_FS is not set
> > # CONFIG_JFS_FS is not set
> > # CONFIG_XFS_FS is not set
> > # CONFIG_MINIX_FS is not set
> > # CONFIG_ROMFS_FS is not set
> > # CONFIG_QUOTA is not set
> > # CONFIG_AUTOFS_FS is not set
> > CONFIG_AUTOFS4_FS=y
> >
> > #
> > # CD-ROM/DVD Filesystems
> > #
> > CONFIG_ISO9660_FS=y
> > CONFIG_JOLIET=y
> > # CONFIG_ZISOFS is not set
> > # CONFIG_UDF_FS is not set
> >
> > #
> > # DOS/FAT/NT Filesystems
> > #
> > CONFIG_FAT_FS=y
> > # CONFIG_MSDOS_FS is not set
> > CONFIG_VFAT_FS=y
> > # CONFIG_NTFS_FS is not set
> >
> > #
> > # Pseudo filesystems
> > #
> > CONFIG_PROC_FS=y
> > CONFIG_PROC_KCORE=y
> > CONFIG_SYSFS=y
> > # CONFIG_DEVFS_FS is not set
> > # CONFIG_DEVPTS_FS_XATTR is not set
> > CONFIG_TMPFS=y
> > # CONFIG_HUGETLBFS is not set
> > # CONFIG_HUGETLB_PAGE is not set
> > CONFIG_RAMFS=y
> >
> > #
> > # Miscellaneous filesystems
> > #
> > # CONFIG_ADFS_FS is not set
> > # CONFIG_AFFS_FS is not set
> > # CONFIG_HFS_FS is not set
> > # CONFIG_HFSPLUS_FS is not set
> > # CONFIG_BEFS_FS is not set
> > # CONFIG_BFS_FS is not set
> > # CONFIG_EFS_FS is not set
> > # CONFIG_CRAMFS is not set
> > # CONFIG_VXFS_FS is not set
> > # CONFIG_HPFS_FS is not set
> > # CONFIG_QNX4FS_FS is not set
> > # CONFIG_SYSV_FS is not set
> > # CONFIG_UFS_FS is not set
> >
> > #
> > # Network File Systems
> > #
> > CONFIG_NFS_FS=y
> > CONFIG_NFS_V3=y
> > # CONFIG_NFS_V4 is not set
> > CONFIG_NFS_DIRECTIO=y
> > CONFIG_NFSD=y
> > CONFIG_NFSD_V3=y
> > # CONFIG_NFSD_V4 is not set
> > CONFIG_NFSD_TCP=y
> > CONFIG_LOCKD=y
> > CONFIG_LOCKD_V4=y
> > CONFIG_EXPORTFS=y
> > CONFIG_SUNRPC=y
> > # CONFIG_SUNRPC_GSS is not set
> > CONFIG_SMB_FS=y
> > CONFIG_SMB_NLS_DEFAULT=y
> > CONFIG_SMB_NLS_REMOTE="euc-jp"
> > # CONFIG_CIFS is not set
> > # CONFIG_NCP_FS is not set
> > # CONFIG_CODA_FS is not set
> > # CONFIG_AFS_FS is not set
> >
> > #
> > # Partition Types
> > #
> > CONFIG_PARTITION_ADVANCED=y
> > # CONFIG_ACORN_PARTITION is not set
> > # CONFIG_OSF_PARTITION is not set
> > # CONFIG_AMIGA_PARTITION is not set
> > # CONFIG_ATARI_PARTITION is not set
> > # CONFIG_MAC_PARTITION is not set
> > CONFIG_MSDOS_PARTITION=y
> > # CONFIG_BSD_DISKLABEL is not set
> > # CONFIG_MINIX_SUBPARTITION is not set
> > # CONFIG_SOLARIS_X86_PARTITION is not set
> > # CONFIG_UNIXWARE_DISKLABEL is not set
> > CONFIG_LDM_PARTITION=y
> > # CONFIG_LDM_DEBUG is not set
> > # CONFIG_NEC98_PARTITION is not set
> > # CONFIG_SGI_PARTITION is not set
> > # CONFIG_ULTRIX_PARTITION is not set
> > # CONFIG_SUN_PARTITION is not set
> > # CONFIG_EFI_PARTITION is not set
> >
> > #
> > # Native Language Support
> > #
> > CONFIG_NLS=y
> > CONFIG_NLS_DEFAULT="iso8859-1"
> > CONFIG_NLS_CODEPAGE_437=y
> > # CONFIG_NLS_CODEPAGE_737 is not set
> > # CONFIG_NLS_CODEPAGE_775 is not set
> > CONFIG_NLS_CODEPAGE_850=y
> > # CONFIG_NLS_CODEPAGE_852 is not set
> > # CONFIG_NLS_CODEPAGE_855 is not set
> > # CONFIG_NLS_CODEPAGE_857 is not set
> > # CONFIG_NLS_CODEPAGE_860 is not set
> > # CONFIG_NLS_CODEPAGE_861 is not set
> > # CONFIG_NLS_CODEPAGE_862 is not set
> > # CONFIG_NLS_CODEPAGE_863 is not set
> > # CONFIG_NLS_CODEPAGE_864 is not set
> > # CONFIG_NLS_CODEPAGE_865 is not set
> > # CONFIG_NLS_CODEPAGE_866 is not set
> > # CONFIG_NLS_CODEPAGE_869 is not set
> > # CONFIG_NLS_CODEPAGE_936 is not set
> > # CONFIG_NLS_CODEPAGE_950 is not set
> > CONFIG_NLS_CODEPAGE_932=y
> > # CONFIG_NLS_CODEPAGE_949 is not set
> > # CONFIG_NLS_CODEPAGE_874 is not set
> > # CONFIG_NLS_ISO8859_8 is not set
> > # CONFIG_NLS_CODEPAGE_1250 is not set
> > # CONFIG_NLS_CODEPAGE_1251 is not set
> > CONFIG_NLS_ISO8859_1=y
> > # CONFIG_NLS_ISO8859_2 is not set
> > # CONFIG_NLS_ISO8859_3 is not set
> > # CONFIG_NLS_ISO8859_4 is not set
> > # CONFIG_NLS_ISO8859_5 is not set
> > # CONFIG_NLS_ISO8859_6 is not set
> > # CONFIG_NLS_ISO8859_7 is not set
> > # CONFIG_NLS_ISO8859_9 is not set
> > # CONFIG_NLS_ISO8859_13 is not set
> > # CONFIG_NLS_ISO8859_14 is not set
> > CONFIG_NLS_ISO8859_15=y
> > # CONFIG_NLS_KOI8_R is not set
> > # CONFIG_NLS_KOI8_U is not set
> > CONFIG_NLS_UTF8=y
> >
> > #
> > # Profiling support
> > #
> > # CONFIG_PROFILING is not set
> >
> > #
> > # Kernel hacking
> > #
> > CONFIG_DEBUG_KERNEL=y
> > # CONFIG_EARLY_PRINTK is not set
> > CONFIG_DEBUG_STACKOVERFLOW=y
> > # CONFIG_DEBUG_STACK_USAGE is not set
> > CONFIG_DEBUG_SLAB=y
> > # CONFIG_DEBUG_IOVIRT is not set
> > # CONFIG_MAGIC_SYSRQ is not set
> > CONFIG_DEBUG_SPINLOCK=y
> > CONFIG_DEBUG_PAGEALLOC=y
> > # CONFIG_SPINLINE is not set
> > CONFIG_DEBUG_INFO=y
> > CONFIG_DEBUG_SPINLOCK_SLEEP=y
> > # CONFIG_KGDB is not set
> > CONFIG_FRAME_POINTER=y
> >
> > #
> > # Security options
> > #
> > # CONFIG_SECURITY is not set
> >
> > #
> > # Cryptographic options
> > #
> > CONFIG_CRYPTO=y
> > CONFIG_CRYPTO_HMAC=y
> > CONFIG_CRYPTO_NULL=y
> > CONFIG_CRYPTO_MD4=y
> > CONFIG_CRYPTO_MD5=y
> > CONFIG_CRYPTO_SHA1=y
> > CONFIG_CRYPTO_SHA256=y
> > CONFIG_CRYPTO_SHA512=y
> > CONFIG_CRYPTO_DES=y
> > CONFIG_CRYPTO_BLOWFISH=y
> > CONFIG_CRYPTO_TWOFISH=y
> > CONFIG_CRYPTO_SERPENT=y
> > CONFIG_CRYPTO_AES=y
> > CONFIG_CRYPTO_CAST5=y
> > CONFIG_CRYPTO_CAST6=y
> > CONFIG_CRYPTO_DEFLATE=y
> > # CONFIG_CRYPTO_TEST is not set
> >
> > #
> > # Library routines
> > #
> > CONFIG_CRC32=y
> > CONFIG_ZLIB_INFLATE=y
> > CONFIG_ZLIB_DEFLATE=y
> > CONFIG_X86_BIOS_REBOOT=y

--=-pcGLSyDicBCTpomiKa7z
Content-Disposition: attachment; filename=direct_io_work-aio_complete.patch
Content-Type: text/plain; name=direct_io_work-aio_complete.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.3-mm4.orig/fs/direct-io.c	2004-03-04 14:44:13.635931855 -0800
+++ linux-2.6.3-mm4/fs/direct-io.c	2004-03-04 15:11:27.860131715 -0800
@@ -1076,8 +1076,12 @@ direct_io_worker(int rw, struct kiocb *i
 		}
 		dio_complete(dio, offset, ret);
 		/* We could have also come here on an AIO file extend */
-		if (!is_sync_kiocb(iocb) && !(rw == WRITE && ret >= 0 &&
-			dio->result < dio->size))
+		if (!is_sync_kiocb(iocb) && rw == WRITE && 
+		    ret >= 0 && dio->result == dio->size)
+			/*
+			 * For AIO writes where we have completed the
+			 * i/o, we have to mark the the aio complete.
+			 */
 			aio_complete(iocb, ret, 0);
 		kfree(dio);
 	}

--=-pcGLSyDicBCTpomiKa7z--

