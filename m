Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284659AbRL0Koa>; Thu, 27 Dec 2001 05:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285070AbRL0KoU>; Thu, 27 Dec 2001 05:44:20 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:42909 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S284659AbRL0KoF>; Thu, 27 Dec 2001 05:44:05 -0500
Date: Thu, 27 Dec 2001 12:42:50 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG and Kernel Panic on 2.5.2-pre1 with loop and cdrom 
In-Reply-To: <Pine.LNX.4.33.0112270813090.28333-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.33.0112271241480.8153-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry the previous emails didn't help much, here is a properly decoded oops as well as a
printout of the values before the BIO_BUG_ON.

ll_rw_blk.c
static int end_bio_bh_io_sync(struct bio *bio, int nr_sectors)
{
	struct buffer_head *bh = bio->bi_private;
	printk(KERN_DEBUG "%s: nr_sectors=%d bh->b_size=%d\n", __FUNCTION__, nr_sectors, (bh->b_size >> 9));
	BIO_BUG_ON(nr_sectors != (bh->b_size >> 9)); <== BUG tripped here
	bh->b_end_io(bh, test_bit(BIO_UPTODATE, &bio->bi_flags));
	bio_put(bio);
	return 0;
}

Jan  1 02:01:02 mondecino kernel: loop: loaded (max 8 devices)
Jan  1 02:01:02 mondecino kernel: VFS: Disk change detected on device fd(2,0)
Jan  1 02:01:02 mondecino kernel: end_bio_bh_io_sync: nr_sectors=8 bh->b_size=8
Jan  1 02:01:02 mondecino last message repeated 3 times
Jan  1 02:01:03 mondecino kernel: end_bio_bh_io_sync: nr_sectors=2 bh->b_size=2
Jan  1 02:01:03 mondecino kernel: end_bio_bh_io_sync: nr_sectors=8 bh->b_size=8

invalid operand: 0000
CPU:    0
EIP:    0010:[<c020c065>]    Not tainted
EFLAGS: 00010286
eax: 00000020   ebx: c88db1a4   ecx: c0304cc4   edx: 000025e1
esi: cae38c64   edi: cae95000   ebp: 00000000   esp: c8adff9c
ds: 0018   es: 0018   ss: 0018
Process loop0 (pid: 697, stackpage=c8adf000)
Stack: c02e1c03 00000554 cae38c64 cae38f64 c014dd33 cae38c64 00000000 cc9170a2
       cae38c64 00000001 00000000 cae95000 cae38f64 cae38c64 00000000 00000000
       00000000 c1560018 00000f00 ca13bf30 00000000 c0107286 cae95000 cc916e80
Call Trace: [<c014dd33>] [<cc9170a2>] [<c0107286>] [<cc916e80>]

Code: 0f 0b 58 5a 8b 46 0c 83 e0 01 50 53 ff 53 34 56 e8 b6 14 f4

>>EIP; c020c065 <end_bio_bh_io_sync+25/50>   <=====
Trace; c014dd33 <bio_endio+23/30>
Trace; cc9170a2 <[loop]loop_thread+222/280>
Trace; c0107286 <kernel_thread+26/30>
Trace; cc916e80 <[loop]loop_thread+0/280>
Code;  c020c065 <end_bio_bh_io_sync+25/50>
00000000 <_EIP>:
Code;  c020c065 <end_bio_bh_io_sync+25/50>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c020c067 <end_bio_bh_io_sync+27/50>
   2:   58                        pop    %eax
Code;  c020c068 <end_bio_bh_io_sync+28/50>
   3:   5a                        pop    %edx
Code;  c020c069 <end_bio_bh_io_sync+29/50>
   4:   8b 46 0c                  mov    0xc(%esi),%eax
Code;  c020c06c <end_bio_bh_io_sync+2c/50>
   7:   83 e0 01                  and    $0x1,%eax
Code;  c020c06f <end_bio_bh_io_sync+2f/50>
   a:   50                        push   %eax
Code;  c020c070 <end_bio_bh_io_sync+30/50>
   b:   53                        push   %ebx
Code;  c020c071 <end_bio_bh_io_sync+31/50>
   c:   ff 53 34                  call   *0x34(%ebx)
Code;  c020c074 <end_bio_bh_io_sync+34/50>
   f:   56                        push   %esi
Code;  c020c075 <end_bio_bh_io_sync+35/50>
  10:   e8 b6 14 f4 00            call   f414cb <_EIP+0xf414cb> c114d530 <_end+d6c100/c444c30>


