Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129904AbQLLXMS>; Tue, 12 Dec 2000 18:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130315AbQLLXMI>; Tue, 12 Dec 2000 18:12:08 -0500
Received: from 4dyn46.com21.casema.net ([212.64.95.46]:49416 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S129904AbQLLXL4>;
	Tue, 12 Dec 2000 18:11:56 -0500
Date: Tue, 12 Dec 2000 23:41:26 +0100
From: Jasper Spaans <jasper@spaans.ds9a.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] raid5 crash with 2.4.0-test12 [Was: Linux-2.4.0-test12]
Message-ID: <20001212234126.A1866@spaans.ds9a.nl>
In-Reply-To: <20001212160605.A1835@spaans.ds9a.nl> <Pine.LNX.4.10.10012121047140.2239-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012121047140.2239-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Dec 12, 2000 at 11:06:07AM -0800
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2000 C. Jasper Spaans - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2000 at 11:06:07AM -0800, Linus Torvalds wrote:

> > Dec 12 14:04:50 spaans kernel: invalid operand: 0000
> > Dec 12 14:04:50 spaans kernel: CPU:    1
> > Dec 12 14:04:50 spaans kernel: EIP:    0010:[end_buffer_io_bad+85/92]
> >
> > Dec 12 14:04:50 spaans kernel: Call Trace:
> >			[raid5_end_buffer_io+68/128]
> >			[complete_stripe+151/272]
> >			[handle_stripe+331/1092]
> >			[raid5d+173/260]
> >			[md_thread+299/508]
> 
> Looks like somebody didn't initialize the "b_end_io" pointer - the code
> defaults to it being "end_buffer_io_bad" (which oopses unconditionally on
> purpose exactly to find places where it wasn't initialized).
> 
> And it obviously looks like it's the raid5 code that does it.
>
> To get better debug output, could you please do something for me? 
> 
> In fs/buffer.c, get rid of "end_buffer_io_bad" completely, and replace all
> users of it with NULL.
> 
> Then, in drivers/block/ll_rw_block.c: generic_make_request(), add a test
> like
> 
> 	if (!bh->b_end_io) BUG();
> 
> to the top of that function.
> 
> You'll still get a oops, but the difference is that you'll get the oops
> when the request is queued, rather than when the requst is finished, which
> will make it easier to figure out what the thing is that leads up to this.

Right, well, I applied your suggestions, and I got it to oops -- dunno how,
but it oopsed.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00000000>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000000   ebx: 00000008   ecx: c146c400   edx: 00000202
esi: c154d560   edi: c154d400   ebp: c70791a0   esp: c14ade9c
ds: 0018   es: 0018   ss: 0018
Process raid5d (pid: 9, stackpage=c14ad000)
Stack: c01c916c c70791a0 00000001 00000008 c154d400 00000002 00000000 c01c9ccf 
       c154d400 00000002 00000001 c154d400 c146c400 c154d400 00000003 00000003 
       c146c400 c01ca827 c154d400 c154d400 c146c400 000000a2 c14b1ec0 c02e8c80 
Call Trace: [<c01c916c>] [<c01c9ccf>] [<c01ca827>] [<c018c070>] [<c018c0c9>] [<c018c3ed>] [<c01cad99>] 
       [<c01d1b57>] [<c0109a88>] 
Code:  Bad EIP value.

>>EIP; 00000000 Before first symbol
Trace; c01c916c <raid5_end_buffer_io+44/80>
Trace; c01c9ccf <complete_stripe+97/110>
Trace; c01ca827 <handle_stripe+14b/444>
Trace; c018c070 <start_request+134/204>
Trace; c018c0c9 <start_request+18d/204>
Trace; c018c3ed <ide_do_request+285/2dc>
Trace; c01cad99 <raid5d+ad/104>
Trace; c01d1b57 <md_thread+12b/1fc>
Trace; c0109a88 <kernel_thread+28/38>

Strange thing is that it doesn't call BUG() and the trace seems quite
identical -- this caused me to start looking at the code in
drivers/md/raid5.c and it seems this null pointer deref is coming from there
- Neil, do you have some documentation on how this code should work, as
stripe_head causes some null-pointer-derefs inside my head..

It seems a stripe_head is quite similar to a block_head, but why is
raid5_end_buffer_io calling the bh_end_io function from the stripe_head, I'd
assume it should be called from ll_rw_block.c?

Regards,
-- 
Jasper Spaans  <jasper@spaans.ds9a.nl>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
