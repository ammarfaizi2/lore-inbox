Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbUCVTQj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 14:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbUCVTQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 14:16:39 -0500
Received: from expms3.cites.uiuc.edu ([128.174.5.207]:11317 "EHLO
	expms3.cites.uiuc.edu") by vger.kernel.org with ESMTP
	id S262272AbUCVTQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 14:16:35 -0500
Date: Mon, 22 Mar 2004 13:16:31 -0600
From: slindber@uiuc.edu
Subject: [Problem]: "access beyond end" of DVD-R 
To: linux-kernel@vger.kernel.org
Cc: slindber@uiuc.edu
X-Mailer: Webmail Mirapoint Direct 3.3.7-GR
MIME-Version: 1.0
Message-Id: <21ddee39.25333f6f.81c3b00@expms3.cites.uiuc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, I'm not subscribed, so please CC me on responses.

I have done my best to gather as much info about this problem; I'd never looked at the kernel before this.

I have a reproducible read error on a DVD-R when trying to access files beyond ~4G.  Here is the relevant kernel output:

UDF-fs DEBUG fs/udf/lowlevel.c:57:udf_get_last_session: XA disk: no, vol_desc_start=0
UDF-fs DEBUG fs/udf/super.c:1550:udf_fill_super: Multi-session=0
UDF-fs DEBUG fs/udf/super.c:538:udf_vrs: Starting at sector 16 (2048 byte sectors)
UDF-fs DEBUG fs/udf/super.c:565:udf_vrs: ISO9660 Primary Volume Descriptor found
UDF-fs DEBUG fs/udf/super.c:568:udf_vrs: ISO9660 Supplementary Volume Descriptor found
UDF-fs DEBUG fs/udf/super.c:574:udf_vrs: ISO9660 Volume Descriptor Set Terminator found
UDF-fs DEBUG fs/udf/super.c:881:udf_load_pvoldesc: recording time 1078289507/0, 2004/03/02 22:51 (1e98)
UDF-fs DEBUG fs/udf/super.c:892:udf_load_pvoldesc: volIdent[] = 'NARUTO (01-25)'
UDF-fs DEBUG fs/udf/super.c:899:udf_load_pvoldesc: volSetIdent[] = '40451003'
UDF-fs DEBUG fs/udf/super.c:1091:udf_load_logicalvol: Partition (0:0) type 1 on volume 1
UDF-fs DEBUG fs/udf/super.c:1101:udf_load_logicalvol: FileSet found in LogicalVolDesc at block=0, partition=0
UDF-fs DEBUG fs/udf/super.c:929:udf_load_partdesc: Searching map: (0 == 0)
UDF-fs DEBUG fs/udf/super.c:1011:udf_load_partdesc: Partition (0:0 type 1511) starts at physical 257, block length 2226881
UDF-fs DEBUG fs/udf/super.c:1344:udf_load_partition: Using anchor in block 256
UDF-fs DEBUG fs/udf/super.c:1577:udf_fill_super: Lastblock=0
UDF-fs DEBUG fs/udf/super.c:853:udf_find_fileset: Fileset at block=0, partition=0
UDF-fs DEBUG fs/udf/super.c:915:udf_load_fileset: Rootdir at block=7, partition=0
UDF-fs INFO UDF 0.9.7 (2002/11/15) Mounting volume 'NARUTO (01-25)', timestamp 2004/03/02 22:51 (1e98)
attempt to access beyond end of device
hdc: rw=0, want=8174536, limit=8123200
Buffer I/O error on device hdc, logical block 2043633

There are more attempt to "access beyond end of device" messages, but they are similar so I've snipped them.

I've had this problem on every kernel I've used (2.4.22 and 2.6.3 from gentoo, and 2.6.4-rc1-mm1).  I've had it with three different discs, ISO, ISO/UDF, and UDF only (the output comes from the last disc).  The entire disc is readable in Windows.

The machine is a Dell Inspiron 8500 with a Samsung CD-RW/DVD-ROM SN-324B, ATAPI CD/DVD-ROM drive.

Just guessing, but the result of

	maxsector = bio->bi_bdev->bd_inode->i_size >> 9;

in devices\block\ll_rw_blk.c, generic_make_request setting maxsector to 8123200 sectors is not correct.  This implies that the disc is ~3.87G, instead of 2226881 blocks (~4.25G) as the UDF filesystem describes.

However, I can't figure out what's causing the problem.

Thanks for any help (and remember to CC me),
Shawn
