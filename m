Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286670AbSAGGaz>; Mon, 7 Jan 2002 01:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287750AbSAGGaq>; Mon, 7 Jan 2002 01:30:46 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:8596 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S286670AbSAGGah>; Mon, 7 Jan 2002 01:30:37 -0500
Date: Mon, 7 Jan 2002 08:31:27 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] More loop/BIO breakage (ll_rw_blk.c:1359)
Message-ID: <Pine.LNX.4.33.0201070828180.18265-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
	Oops reproducible by doing a "mount /dev/fd0 /floppy -o loop".
Decoded oops at the end.

loop.c
static inline void loop_handle_bio(struct loop_device *lo, struct bio
*bio)
{
	<snip>
	} else {
		struct bio *rbh = bio->bi_private;

		ret = do_bio_blockbacked(lo, bio, rbh);
		bio_endio(rbh, !ret, bio_sectors(bio)); <== [1]
		loop_put_buffer(bio);
	}
}

ll_rw_blk.c
static int end_bio_bh_io_sync(struct bio *bio, int nr_sectors)
{
	struct buffer_head *bh = bio->bi_private;

	BIO_BUG_ON(nr_sectors != (bh->b_size >> 9)); <== [2]

[1] We send the incorrect bio parameter to bio_sectors, therefore ending
up with 0 for nr_sectors when the parameters filter down to ll_rw_blk.c

[2] We end up with zero here...

Now i just have to figure out why mount complains about no valid
filesystems

--- linux/drivers/block/loop.c.orig	Sun Jan  6 13:05:06 2002
+++ linux/drivers/block/loop.c	Sun Jan  6 13:05:26 2002
@@ -525,7 +525,7 @@

 		ret = do_bio_blockbacked(lo, bio, rbh);

-		bio_endio(rbh, !ret, bio_sectors(bio));
+		bio_endio(rbh, !ret, bio_sectors(rbh));
 		loop_put_buffer(bio);
 	}
 }



kernel BUG at ll_rw_blk.c:1359!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c020db95>]    Not tainted
EFLAGS: 00010286
eax: 00000020   ebx: ca31bb64   ecx: c0314c44   edx: 0000243f
esi: cbf1c1e4   edi: cbb61000   ebp: cbb61000   esp: ca311f94
ds: 0018   es: 0018   ss: 0018
Process loop0 (pid: 705, stackpage=ca311000)
Stack: c02f138a 0000054f cbf1c1e4 cb272ae4 c014e4d9 cbf1c1e4 00000000
cc9190e2
       cbf1c1e4 00000001 00000000 cbb61000 cb272ae4 cbf1c1e4 01b61000
cadb9f28
       00000200 00000000 00000000 00000f00 cadb9f28 00000200 00000000
c0107286
Call Trace: [<c014e4d9>] [<cc9190e2>] [<c0107286>] [<cc918ec0>]

Code: 0f 0b 58 5a 8b 46 0c 83 e0 01 50 53 ff 53 34 56 e8 26 01 f4

>>EIP; c020db95 <end_bio_bh_io_sync+25/50>   <=====
Trace; c014e4d9 <bio_endio+29/40>
Trace; cc9190e2 <[loop]loop_thread+222/280>
Trace; c0107286 <kernel_thread+26/30>
Trace; cc918ec0 <[loop]loop_thread+0/280>
Code;  c020db95 <end_bio_bh_io_sync+25/50>
00000000 <_EIP>:
Code;  c020db95 <end_bio_bh_io_sync+25/50>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c020db97 <end_bio_bh_io_sync+27/50>
   2:   58                        pop    %eax
Code;  c020db98 <end_bio_bh_io_sync+28/50>
   3:   5a                        pop    %edx
Code;  c020db99 <end_bio_bh_io_sync+29/50>
   4:   8b 46 0c                  mov    0xc(%esi),%eax
Code;  c020db9c <end_bio_bh_io_sync+2c/50>
   7:   83 e0 01                  and    $0x1,%eax
Code;  c020db9f <end_bio_bh_io_sync+2f/50>
   a:   50                        push   %eax
Code;  c020dba0 <end_bio_bh_io_sync+30/50>
   b:   53                        push   %ebx
Code;  c020dba1 <end_bio_bh_io_sync+31/50>
   c:   ff 53 34                  call   *0x34(%ebx)
Code;  c020dba4 <end_bio_bh_io_sync+34/50>
   f:   56                        push   %esi
Code;  c020dba5 <end_bio_bh_io_sync+35/50>
  10:   e8 26 01 f4 00            call   f4013b <_EIP+0xf4013b> c114dcd0
<_end+d5c340/c4346d0>


