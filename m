Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262669AbVAEXgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbVAEXgc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 18:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbVAEXex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 18:34:53 -0500
Received: from newpeace.netnation.com ([204.174.223.7]:32462 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP id S262663AbVAEXeA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 18:34:00 -0500
Date: Wed, 5 Jan 2005 15:33:59 -0800
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: [2.6.10-bk7] Oops: ide_dma_timeout_retry
Message-ID: <20050105233359.GA2327@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe this bug has existed for some time now (I think I've seen it on
2.6.9 on another box), but I seem to have hardware that is reproducing it
easily now.

Setup: Dual P3 1 GHz (SMP kernel).  2.6.10-bk7, though it also occurred
with 2.6.10-rc3-bk16 and I believe older kernels.  One 2.5 TB linear MD
array consisting of 24 medium-old PATA drives.  Four PDC20270 (Promise)
controllers, one 3ware raid, onboard adaptec, etc.  The problem is
happening with one of the (Maxtor!) drives on a PDC20270:

hdn: dma_timer_expiry: dma status == 0x61   
hdn: DMA timeout error
hdn: dma timeout error: status=0x51 { DriveReady SeekComplete Error }
hdn: dma timeout error: error=0x40 { UncorrectableError }, LBAsect=375917014, high=22, low=6818262, sector=375917012
ide: failed opcode was: unknown
end_request: I/O error, dev hdn, sector 375917012
Unable to handle kernel NULL pointer dereference at virtual address 0000002c
 printing eip:
c026ce16
*pde = 00000000
Oops: 0000 [#1]
SMP 
Modules linked in: ipt_state ip_conntrack acenic
CPU:    0
EIP:    0060:[<c026ce16>]    Not tainted VLI
EFLAGS: 00010092   (2.6.10-bk7-alfie)    
EIP is at ide_dma_timeout_retry+0x56/0xf0
eax: dfcbf540   ebx: 00000000   ecx: 00000006   edx: 00001462
esi: c0419b10   edi: 00000000   ebp: ffffffff   esp: c03b3f0c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03b2000 task=c0366b40)
Stack: c0419d40 c0337267 00000051 dfcbf540 c0419d40 c0273d20 c026cfe5 c0419d40
       ffffffff c0366b40 c0419b10 00000286 dfcbf540 c026ceb0 c1409920 c03b3f60
       c012195a dfcbf540 00000000 00000000 c03b3f60 c03b3f60 c03b3f60 c0121845
Call Trace:
 [<c0273d20>] ide_dma_intr+0x0/0xb0
 [<c026cfe5>] ide_timer_expiry+0x135/0x1e0  
 [<c026ceb0>] ide_timer_expiry+0x0/0x1e0    
 [<c012195a>] run_timer_softirq+0xda/0x1a0  
 [<c0121845>] update_process_times+0x45/0x60
 [<c011d5da>] __do_softirq+0xba/0xd0        
 [<c011d61d>] do_softirq+0x2d/0x30
 [<c0103110>] apic_timer_interrupt+0x1c/0x24
 [<c0100710>] default_idle+0x0/0x40         
 [<c010073c>] default_idle+0x2c/0x40
 [<c01007cb>] cpu_idle+0x3b/0x50
 [<c03b498f>] start_kernel+0x14f/0x170
 [<c03b43a0>] unknown_bootoption+0x0/0x1e0
Code: 96 50 04 00 00 fe 83 8f 00 00 00 c6 83 90 00 00 00 01 89 1c 24 ff 96 3c 04 00 00 8b 43 70 8b 40 08 8b 58 20 c7 40 20 00 0
 <0>Kernel panic - not syncing: Fatal exception in interrupt
EXT3-fs error (device md0): ext3_get_inode_loc: unable to read inode block - inode=143556922, block=574226453
Aborting journal on device md0.

The disassembly of ide_dma_timeout_retry is:

c026cdc0 <ide_dma_timeout_retry>:
c026cdc0:       57                      push   %edi
c026cdc1:       31 ff                   xor    %edi,%edi
c026cdc3:       56                      push   %esi
c026cdc4:       53                      push   %ebx
c026cdc5:       83 ec 0c                sub    $0xc,%esp
c026cdc8:       8b 44 24 20             mov    0x20(%esp),%eax
c026cdcc:       8b 5c 24 1c             mov    0x1c(%esp),%ebx
c026cdd0:       85 c0                   test   %eax,%eax
c026cdd2:       8b 73 70                mov    0x70(%ebx),%esi
c026cdd5:       78 7f                   js     c026ce56 <ide_dma_timeout_retry+0x96>
c026cdd7:       89 5c 24 04             mov    %ebx,0x4(%esp)
c026cddb:       c7 04 24 33 72 33 c0    movl   $0xc0337233,(%esp)
c026cde2:       e8 a9 b9 ea ff          call   c0118790 <printk>
c026cde7:       89 1c 24                mov    %ebx,(%esp)
c026cdea:       ff 96 50 04 00 00       call   *0x450(%esi)
c026cdf0:       fe 83 8f 00 00 00       incb   0x8f(%ebx)
c026cdf6:       c6 83 90 00 00 00 01    movb   $0x1,0x90(%ebx)
c026cdfd:       89 1c 24                mov    %ebx,(%esp)
c026ce00:       ff 96 3c 04 00 00       call   *0x43c(%esi)
c026ce06:       8b 43 70                mov    0x70(%ebx),%eax
c026ce09:       8b 40 08                mov    0x8(%eax),%eax
c026ce0c:       8b 58 20                mov    0x20(%eax),%ebx
c026ce0f:       c7 40 20 00 00 00 00    movl   $0x0,0x20(%eax)
c026ce16: ----> 8b 4b 2c                mov    0x2c(%ebx),%ecx	<--------
c026ce19:       c7 43 40 00 00 00 00    movl   $0x0,0x40(%ebx)
c026ce20:       85 c9                   test   %ecx,%ecx
c026ce22:       74 29                   je     c026ce4d <ide_dma_timeout_retry+0x8d>
c026ce24:       8b 01                   mov    (%ecx),%eax
c026ce26:       8b 51 04                mov    0x4(%ecx),%edx
c026ce29:       89 43 0c                mov    %eax,0xc(%ebx)
c026ce2c:       89 53 10                mov    %edx,0x10(%ebx)
c026ce2f:       8b 51 30                mov    0x30(%ecx),%edx
c026ce32:       0f b7 41 1a             movzwl 0x1a(%ecx),%eax
c026ce36:       8d 04 40                lea    (%eax,%eax,2),%eax
c026ce39:       8b 44 82 04             mov    0x4(%edx,%eax,4),%eax
c026ce3d:       c7 43 50 00 00 00 00    movl   $0x0,0x50(%ebx)
c026ce44:       c1 e8 09                shr    $0x9,%eax
c026ce47:       89 43 18                mov    %eax,0x18(%ebx)
c026ce4a:       89 43 28                mov    %eax,0x28(%ebx)
c026ce4d:       83 c4 0c                add    $0xc,%esp
c026ce50:       89 f8                   mov    %edi,%eax
c026ce52:       5b                      pop    %ebx
c026ce53:       5e                      pop    %esi
c026ce54:       5f                      pop    %edi
c026ce55:       c3                      ret    
c026ce56:       89 5c 24 04             mov    %ebx,0x4(%esp)
c026ce5a:       c7 04 24 4d 72 33 c0    movl   $0xc033724d,(%esp)
c026ce61:       e8 2a b9 ea ff          call   c0118790 <printk>
c026ce66:       8b 43 70                mov    0x70(%ebx),%eax
c026ce69:       89 1c 24                mov    %ebx,(%esp)
c026ce6c:       ff 90 30 04 00 00       call   *0x430(%eax)
c026ce72:       8b 43 70                mov    0x70(%ebx),%eax
c026ce75:       8b 40 34                mov    0x34(%eax),%eax
c026ce78:       89 04 24                mov    %eax,(%esp)
c026ce7b:       ff 96 6c 04 00 00       call   *0x46c(%esi)
c026ce81:       8b 53 1c                mov    0x1c(%ebx),%edx
c026ce84:       b9 67 72 33 c0          mov    $0xc0337267,%ecx
c026ce89:       0f b6 c0                movzbl %al,%eax
c026ce8c:       89 44 24 08             mov    %eax,0x8(%esp)
c026ce90:       89 4c 24 04             mov    %ecx,0x4(%esp)
c026ce94:       89 1c 24                mov    %ebx,(%esp)
c026ce97:       ff 52 20                call   *0x20(%edx)
c026ce9a:       89 c7                   mov    %eax,%edi
c026ce9c:       e9 4f ff ff ff          jmp    c026cdf0 <ide_dma_timeout_retry+0x30>
c026cea1:       eb 0d                   jmp    c026ceb0 <ide_timer_expiry>

It appears the compiler reordered this code in drivers/ide/ide-io.c:

        /*
         * un-busy drive etc (hwgroup->busy is cleared on return) and
         * make sure request is sane                                 
         */
        rq = HWGROUP(drive)->rq;
        HWGROUP(drive)->rq = NULL;

        rq->errors = 0;

        if (!rq->bio)
                goto out;

...to something like:

	ebx = HWGROUP(drive)->rq;          (->rq is NULL)
	HWGROUP(drive)->rq = NULL;         (->rq already was NULL)
        ecx = ebx->bio;                    (ebx is NULL, Oops)
        rq->errors = 0;
        if (!ecx)
                goto out;

...and so it's Oopsing on (!rq->bio) because rq is NULL.  But why
is rq NULL in this case?

I added the usual test for NULL, printk, goto out, and the machine
continues without visibly exploding when this case occurs.  Is the
correct fix or is it expected that rq should never be NULL?

Simon-
