Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261756AbTCaSM2>; Mon, 31 Mar 2003 13:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261757AbTCaSM2>; Mon, 31 Mar 2003 13:12:28 -0500
Received: from main.gmane.org ([80.91.224.249]:27097 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S261756AbTCaSM1>;
	Mon, 31 Mar 2003 13:12:27 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: David Wuertele <dave-gnus@bfnet.com>
Subject: flash as hda causes 2.4.18 to hang in
 grok_partitions()...add_to_page_cache_unique()
Date: Mon, 31 Mar 2003 10:22:54 -0800
Organization: Berkeley Fluent Network
Message-ID: <m3smt3xuo1.fsf@bfnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2 (i686-pc-linux-gnu)
Cancel-Lock: sha1:O7s21xdbwmQPmQNnYQPRQJJQeYc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a mipsel linux 2.4.18 system that has a compact flash IDE
disk as hda.  For some reason, in grok_partitions, the kernel goes
bye-bye.  I've traced it as far as read_page_cache().

The console prints this:

  ide0 at 0x2200-0x2207,0x220a on irq 3
  config_drive_xfer_rate for drive hda (0)
  hda: 250880 sectors (128 MB) w/1KiB Cache, CHS=980/8/32, DMA
  Partition check:
   /dev/ide/host0/bus0/target0/lun0:

Then hangs.  If I use KGDB to trace the kernel to that point, and do a
backtrace, here's what I see:

  #0  add_to_page_cache_unique (page=0x81042840, mapping=0x810b7520, offset=0, hash=0x8109df5c)
      at /mipsel-linux/include/asm/atomic.h:133
  #1  0x80133d8c in read_cache_page (mapping=0x810b7520, index=0, filler=0x8014b2d4 <blkdev_readpage>, data=0x0)
      at filemap.c:2780
  #2  0x8016b83c in read_dev_sector (bdev=0xffffcfe1, n=2165011744, p=0x803b9dd0) at check.c:433
  #3  0x8016bc98 in handle_ide_mess (bdev=0x810a2120) at msdos.c:485
  #4  0x8016bf18 in msdos_partition (hd=0x803b53e0, bdev=0x810a2120, first_sector=0, 
      first_part_minor=-2130059428) at msdos.c:555
  #5  0x8016b114 in check_partition (hd=0x803b53e0, dev=768, first_part_minor=1) at check.c:270
  #6  0x8016b77c in grok_partitions (dev=0x803b53e0, drive=-2130042592, minors=64, size=250880) at check.c:415
  #7  0x8016b644 in register_disk (gdev=0x1, dev=8480, minors=0, ops=0x8109df5c, size=250880) at check.c:390
  #8  0x8020b79c in ide_geninit (hwif=0x803a3f14) at ide.c:666
  #9  0x80211ae4 in ide_init () at ide.c:3840
  #10 0x801ffd00 in blk_dev_init () at ll_rw_blk.c:1159
  #11 0x80200aa4 in device_init () at genhd.c:184
  #12 0x80108a8c in do_initcalls () at init/main.c:676
  #13 0x80108ae4 in do_basic_setup () at init/main.c:760
  #14 0x80108ca0 in init (unused=0x3f) at init/main.c:830
  #15 0x80109654 in kernel_thread (fn=0x80108c90 <init>, arg=0x0, flags=8457984) at process.c:207

Any suggestions?

Dave

