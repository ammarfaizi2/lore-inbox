Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264798AbTFBRLX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 13:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264799AbTFBRLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 13:11:23 -0400
Received: from zeus.kernel.org ([204.152.189.113]:6365 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264798AbTFBRLU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 13:11:20 -0400
Date: Mon, 2 Jun 2003 11:21:13 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Neil Schemenauer <nas@python.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] new IO scheduler for 2.4.20
Message-ID: <20030602112112.E1522@schatzie.adilger.int>
Mail-Followup-To: Neil Schemenauer <nas@python.ca>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 May 2003 08:09, Neil Schemenauer wrote:
> The major benefit of this patch is that read latency is much lower while
> lots of writes are occuring.  On my machine, running:
>
>  while :; do dd if=/dev/zero of=foo bs=1M count=1000 conv=notrunc; done
>
> makes 2.4.20 unusable.  With this patch the "write bomb" causes no
> particular problems.
>
> With this version of the patch I've improved the bulk read performance
> of the elevator.  The bonnie++ results are now:
>
>                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block--
>                Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP
> 2.4.20           1G 13001  97 34939  18 13034   7 12175  92 34112  14
> 2.4.20-nas       1G 12923  98 36471  17 13340   8 10809  83 35569  13
>
> Note that the "rewrite" and "per-char read" stats are slightly bogus for
> 2.4.20-nas.  Reads get a boost in priority over writes.  When the
> "per-char read" test has started there is still some writing happening
> from the rewrite test.  I think the net effect is that the "rewrite"
> number is too high and the "per-char read" number is too low.
>
> I would be very pleased if someone could run some tests on using bonnie,
> contest, or their other favorite benchmarks and post the results.

In local testing we hit the following problem at boot:

SCSI device sda: 35565080 512-byte hdwr sectors (18209 MB)
Partition check:
  sda:elevator returned crap (-1069467520)
------------[ cut here ]------------
kernel BUG at ll_rw_blk.c:1043!
invalid operand: 0000

CPU:    0
EIP:    0060:[<c01d40ab>]    Not tainted
EFLAGS: 00010086

EIP is at __make_request [kernel] 0x3bb 
(2.4.20-9smp-l18-b_devel-30-05-2003-fercher-nas)
eax: 00000025   ebx: c466a2e0   ecx: 00000001   edx: 00000001
esi: 00000000   edi: c464b638   ebp: c44c9d30   esp: c44c9c90
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 1, stackpage=c44c9000)
Stack: c02c7ea6 c0413880 c464b640 c463b880 00000400 00000000 00000002 
00000002
        00000000 c44c8000 00000000 c0413880 c03e1fc4 c011ac62 c44c9d10 
c0413880
        00000000 c44c9cec c020707b c4623a38 c4623a38 c4695980 c4652400 
c4623a00
Call Trace:   [<c011ac62>] schedule [kernel] 0x362 (0xc44c9cc4))
[<c020707b>] scsi_insert_special_req [kernel] 0x1b (0xc44c9cd8))
[<c020723a>] scsi_queue_next_request [kernel] 0x4a (0xc44c9d04))
[<c01d43f9>] generic_make_request [kernel] 0x119 (0xc44c9d34))
[<c01d445f>] submit_bh [kernel] 0x4f (0xc44c9d68))
[<c014f140>] block_read_full_page [kernel] 0x2e0 (0xc44c9d84))
[<c012411d>] bh_action [kernel] 0x4d (0xc44c9dc8))
[<c0123fc4>] tasklet_hi_action [kernel] 0x74 (0xc44c9dd4))
[<c0135981>] add_to_page_cache_unique [kernel] 0x81 (0xc44c9e14))
[<c0138459>] read_cache_page [kernel] 0x89 (0xc44c9e30))
[<c0152a20>] blkdev_get_block [kernel] 0x0 (0xc44c9e38))
[<c014367c>] __alloc_pages [kernel] 0x7c (0xc44c9e44))
[<c0174d46>] read_dev_sector [kernel] 0x36 (0xc44c9e5c))
[<c0152ab0>] blkdev_readpage [kernel] 0x0 (0xc44c9e68))
[<c01756e9>] handle_ide_mess [kernel] 0x29 (0xc44c9e90))
[<c01758c5>] msdos_partition [kernel] 0x65 (0xc44c9ebc))
[<c0163cfc>] new_inode [kernel] 0xc (0xc44c9ed0))
[<c0174b4f>] check_partition [kernel] 0xff (0xc44c9ef0))
[<c02236fa>] sd_init_onedisk [kernel] 0x7ba (0xc44c9f24))
[<c0174cd2>] grok_partitions [kernel] 0xc2 (0xc44c9f5c))
[<c0223d76>] sd_finish [kernel] 0x106 (0xc44c9f80))
[<c0201985>] scsi_register_device_module [kernel] 0x155 (0xc44c9fa8))
[<c0105094>] init [kernel] 0x34 (0xc44c9fdc))
[<c0105060>] init [kernel] 0x0 (0xc44c9fe0))
[<c0107459>] kernel_thread_helper [kernel] 0x5 (0xc44c9ff0))


Code: 0f 0b 13 04 9a 7e 2c c0 59 5f 8b 95 74 ff ff ff 85 d2 74 15
  <0>Kernel panic: Attempted to kill init!

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

