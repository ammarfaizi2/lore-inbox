Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbUEVTWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUEVTWG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 15:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbUEVTWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 15:22:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:48853 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261832AbUEVTWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 15:22:00 -0400
Date: Sat, 22 May 2004 12:21:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lorenzo Allegrucci <l_allegrucci@despammed.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.6-mm5 oops mounting ext3 or reiserfs with -o barrier
Message-Id: <20040522122126.2940f8f4.akpm@osdl.org>
In-Reply-To: <200405222107.55505.l_allegrucci@despammed.com>
References: <200405222107.55505.l_allegrucci@despammed.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lorenzo Allegrucci <l_allegrucci@despammed.com> wrote:
>
> 
> I get a 100% reproducible oops mounting an ext3 or reiserfs
> partition with -o barrier enabled.
> Hand written oops (for ext3):

That's a lot of hand-writing.  Thanks for doing that.  You can usually omit
the hex numbers in [brackets] when doing this.

The crash is here:

static inline void blkdev_dequeue_request(struct request *req)
{
	BUG_ON(list_empty(&req->queuelist));

perhaps related to that I/O error sending the code through less-tested
paths.


> hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> hda: drive_cmd: error=0x04 { DriveStatusError }
> end_request: I/O error, dev hda, sector 84666781
> ------------[ cut here ]------------
> kernel BUG at include/linux/blkdev.h:576!
> invalid operand: 0000 [#1]
> PREEMPT
> Modules linked in: lp emu10k1 sound soundcore ac97_codec unix
> CPU:    0
> EIP:    0060:[<c02125ae>]    Not tainted VLI
> EFLAGS: 00010046   (2.6.6-mm5)
> EIP is at __ide_end_request+0xbe/0x110
> eax: 00000e7a   ebx: da88636c   ecx: 00000000   edx: da88636c
> esi: 00000000   edi: c038180c   ebp: 00000008   esp: c0368ec4
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 0, threadinfo=c0368000 task=c02d1a40)
> Stack: 00000001 00000008 da88636c 050be99d 00000000 c02128fc 00000008 c0116718
>        00000000 c036bb01 00000246 00000001 00000000 c038180c 00000286 c0368000
>        dffdfa78 c038180c c0212a79 c02abc65 c0381760 042aa50a 00000051 dffdf951
> Call Trace:
>  [<c02128fc>] ide_complete_barrier+0xec/0x160
>  [<c0116718>] release_console_sem+0xc8/0xe0
>  [<c0212a79>] ide_end_drive_cmd+0x109/0x370
>  [<c021d54c>] idedisk_error+0x6c/0x1f0
>  [<c02024d2>] end_that_request_last+0x52/0xb0
>  [<c021258c>] __ide_end_request+0x9c/0x110
>  [<c01fefc2>] elv_queue_empty+0x12/0x20
>  [<c0213548>] ide_do_request+0x78/0x390
>  [<c0213059>] drive_cmd_intr+0x79/0xd0
>  [<c0213cd3>] ide_intr+0xd3/0x170
>  [<c0212fe0>] drive_cmd_intr+0x0/0xd0
>  [<c0106f60>] handle_IRQ_event+0x30/0x60
>  [<c01072b0>] do_IRQ+0xc0/0x1a0
> ========================
>  [<c01058c8>] common_interrupt+0x18/0x20
>  [<c01038d3>] default_idle+0x23/0x30
>  [<c010393c>] cpu_idle+0x2c/0x40
>  [<c03455d9>] start_kernel+0x179/0x1c0
>  [<c0345320>] unknown_bootoption+0x0/0x110
> 
> Code: 75 1d 89 d8 e8 f4 fe fe ff 8b 47 70 8b 40 08 c7 40 20 00 00 00 00 c7 04
>  <0>Kernel panic: Fatal exception in interrupt
> In interrupt handler - not syncing
> 
> 
> hda is a Maxtor 6Y060L0
> 
> -- 
> Lorenzo
