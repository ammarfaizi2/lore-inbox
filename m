Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268134AbUG2Pdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268134AbUG2Pdt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268133AbUG2PSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:18:53 -0400
Received: from email-out2.iomega.com ([147.178.1.83]:12238 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264853AbUG2OpV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:45:21 -0400
Subject: Re: Can not read UDF CD
From: Pat LaVarre <p.lavarre@ieee.org>
To: David Balazic <david.balazic@hermes.si>
Cc: "'linux_udf@hpesjro.fc.hp.com'" <linux_udf@hpesjro.fc.hp.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <B1ECE240295BB146BAF3A94E00F2DBFF0901FE@piramida.hermes.si>
References: <B1ECE240295BB146BAF3A94E00F2DBFF0901FE@piramida.hermes.si>
Content-Type: text/plain
Organization: 
Message-Id: <1091112289.5803.53.camel@patibmrh9>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Jul 2004 08:44:49 -0600
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jul 2004 14:45:19.0450 (UTC) FILETIME=[AB5A53A0:01
	C4757A]
X-imss-version: 2.0
X-imss-result: Passed
X-imss-scores: Clean:1.09575 C:9 M:0 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David B:

/// In short,

I suggest quickly trying the mount -o lastblock= and anchor= udf.ko
options described at:

http://lxr.linux.no/source/Documentation/filesystems/udf.txt?v=2.6.5

else working thru til able to try the phgfsck described at my page:

http://udfko.blog-city.com/read/577369.htm

If you do post the phgfsck report on the web, I'll gladly link to it.

/// At length, in Seven parts ...

/// 1) Similarly

> UDF-fs DEBUG fs/udf/misc.c:236:udf_read_tagged: location mismatch block 30878, tag 30878 != 256
> UDF-fs DEBUG fs/udf/super.c:1342:udf_load_partition: No Anchor block found
> UDF-fs: No partition found (1)

In the merely private archives of linux_udf, just this week we see me
suffering thru something highly similar, specifically:

kernel: UDF-fs DEBUG fs/udf/misc.c:236:udf_read_tagged: location mismatch block 256, tag 0 != 256
kernel: UDF-fs DEBUG fs/udf/super.c:1342:udf_load_partition: No Anchor block found
kernel: UDF-fs: No partition found (1)

Note, since 2.6.7, by default these messages will grow more cryptic, we will see only:

kernel: UDF-fs: No partition found (1)

> > > UDF-fs DEBUG fs/udf/misc.c:236:udf_read_tagged: location mismatch block 30878, tag 30878 != 256
> > UDF-fs DEBUG fs/udf/misc.c:236:udf_read_tagged: location mismatch block 256, tag 0 != 256

I'm guessing these messages mean the try to mount halted over garbage
found at LBA x100 (256), but Ben wrote this code, not me.

/// 2) Where

What kind of cable do you use, what is your device name, what is your
mount point?

Til I know, I will cover both USB and PATAPI and pretend you want to
mount /dev/scd0 at /mnt/scd0.

/// 3) -o lastblock="$n"

Up in user land, my workaround was:

n="`dc -e \"\`sudo blockdev --getsize /dev/scd0\` 512 * 2048 / 1 - p\"`"
sudo mount -r -o lastblock="$n" /dev/scd0 /mnt/scd0

/// 4) patch -p1 ...

To recover the feature:

sudo mount -r /dev/scd0 /mnt/scd0

for such unfriendly discs, I web-published the patch quoted below to the
patches-udf.lastblock package of http://iomrrdtools.sourceforge.net/

/// 5) -o anchor=...

If -o lastblock="$n" doesn't work for you, then one more blind try is -o
anchor="$n" i.e.

n="`dc -e \"\`sudo blockdev --getsize /dev/scd0\` 512 * 2048 / 1 - p\"`"
sudo mount -r -o anchor="$n" /dev/scd0 /mnt/scd0

Please note -o anchor is arguably reckless except when combined with -r.

/// 6) phgfsck

If neither blind try works for you, then to make sense of the disc you
can try phgfsck.  For example, here, I see:

$ sudo phgfsck -scsi /dev/sg0 | grep 'AVDPs at'
        Number of AVDPs: 2, AVDPs at  N-256,  N
$

Seeing "AVDP ... at ... N" tells me to try what I mentioned above:

n="`dc -e \"\`sudo blockdev --getsize /dev/scd0\` 512 * 2048 / 1 - p\"`"
sudo mount -r -o anchor="$n" /dev/scd0 /mnt/scd0

/// 7) reconfiguring Linux to permit phgfsck

http://www.extra.research.philips.com/udf/
is the Philips page that offers the phgfsck, aka the "Philips UDF
Verifier".

My clarification of that page is:

http://udfko.blog-city.com/read/577369.htm

Philips deserves nothing but kudos for donating the phgfsck to improve
UDF interoperability worldwide ... except the fact remains they haven't
chosen to release their copyright under a license approved as open
source by such authorities as sourceforge.net.

Consequently, the phgfsck can be unusually hard to use in Linux. 
Specifically, it does Not incorporate any of the better SCSI pass thru
libraries.  Privately, as yet I've heard from Two employees of different
corporations who privately requested and privately were denied
permission to donate code into the phgfsck, because its source is partly
closed.

First, as yet with the phgfsck, you have to substitute an sg name for
the regular dev name, even when running 2.6.

To discover your sg name, you can try each of /dev/sg* to see what
happens, or you can download yet another tool, such as sg_scan -i or my
own plscsi -w, found at http://members.aol.com/plscsi/linux/

In theory `phgfsck -showscsi` will give you device names, but for me
that query doesn't work reliably.  Trying here just now in
2.6.8-rc2-bk7, it hangs.  In the past, I've seen it miss names.

Often you need root privilege to discover the sg name.

You will probably have an sg name to find only if your kernel has a
drivers/scsi/sg.ko and your device name was among the /dev/scd*

Else you might have to get into substituting ide-scsi.ko for ide-cd.ko,
especially if your device name was among the /dev/hd*.  linux-scsi
speaks occasionally of the issues such substitutions raise.

Pat LaVarre
http://iomrrdtools.sourceforge.net/
http://udfko.blog-city.com/

--- From: http://sourceforge.net/project/showfiles.php?group_id=101444&package_id=125426

See also: Readme.txt
... Copyright (c) 2004 Iomega Corp
... free software ...
... GNU General Public License as ... either ... or ...
...

diff -urp linux-2.6.8-rc2-bk7/fs/udf/lowlevel.c linux-2.6.8-rc2-bk7-pel/fs/udf/lowlevel.c
--- linux-2.6.8-rc2-bk7/fs/udf/lowlevel.c	2004-06-15 23:19:36.000000000 -0600
+++ linux-2.6.8-rc2-bk7-pel/fs/udf/lowlevel.c	2004-07-28 14:46:02.373806296 -0600
@@ -73,9 +73,9 @@ udf_get_last_block(struct super_block *s
 	struct block_device *bdev = sb->s_bdev;
 	unsigned long lblock = 0;
 
-	if (ioctl_by_bdev(bdev, CDROM_LAST_WRITTEN, (unsigned long) &lblock))
-		lblock = bdev->bd_inode->i_size >> sb->s_blocksize_bits;
-
+	if (!ioctl_by_bdev(bdev, CDROM_LAST_WRITTEN, (unsigned long) &lblock))
+		return lblock;
+	lblock = bdev->bd_inode->i_size >> sb->s_blocksize_bits;
 	if (lblock)
 		return lblock - 1;
 	else
diff -urp linux-2.6.8-rc2-bk7/fs/udf/super.c linux-2.6.8-rc2-bk7-pel/fs/udf/super.c
--- linux-2.6.8-rc2-bk7/fs/udf/super.c	2004-07-28 10:36:35.928051888 -0600
+++ linux-2.6.8-rc2-bk7-pel/fs/udf/super.c	2004-07-28 14:45:45.356393336 -0600
@@ -1562,6 +1562,9 @@ static int udf_fill_super(struct super_b
  		goto error_out;
 	}
 
+	if (!UDF_SB_LASTBLOCK(sb)) {
+		UDF_SB_LASTBLOCK(sb) = udf_get_last_block(sb);
+	}
 	udf_find_anchor(sb);
 
 	/* Fill in the rest of the superblock */


