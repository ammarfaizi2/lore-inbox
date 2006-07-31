Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWGaQHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWGaQHS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 12:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWGaQHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 12:07:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52972 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751237AbWGaQHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 12:07:15 -0400
Message-ID: <44CE2AAE.7030800@redhat.com>
Date: Mon, 31 Jul 2006 11:07:10 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: bfennema@falcon.csc.calpoly.edu
Subject: [PATCH] mount udf UDF_PART_FLAG_READ_ONLY partitions with MS_RDONLY
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, seems there's a bug where a UDF_PART_FLAG_READ_ONLY udf partition gets 
mounted read-write, then subsequent problems happen; files seem to be able 
to be removed, but file creation results in EIO or worse, oops.

EIO is coming from udf_new_block(), which returns EIO if the right flags 
aren't set; only UDF_PART_FLAG_READ_ONLY is set in this case.  We probably s
hould not have gotten this far...

Attached patch seems to fix it - and includes a printk to alert the user 
that their "rw" mount request has been converted to "ro."

Oh, btw, here's the testcase I used:

[root@magnesium ~]# mkisofs -R -J -udf -o testiso /tmp/
...
Total translation table size: 0
Total rockridge attributes bytes: 342923
Total directory bytes: 382312
Path table size(bytes): 104
Max brk space used 103000
105059 extents written (205 MB)

[root@magnesium ~]# mount -o loop testiso /mnt/test/
[root@magnesium ~]# ls /mnt/test/fsfile
/mnt/test/fsfile
[root@magnesium ~]# rm /mnt/test/fsfile
[root@magnesium ~]# ls /mnt/test/fsfile
ls: /mnt/test/fsfile: No such file or directory
[root@magnesium ~]# touch /mnt/test/fsfile
touch: cannot touch `/mnt/test/fsfile': Input/output error
[root@magnesium tmp]# grep udf /proc/mounts
/dev/loop1 /mnt/test udf rw 0 0 

Thanks,

-Eric

Force readonly mounts of UDF partitions marked as read-only.

Signed-Off-By: Eric Sandeen <sandeen@sandeen.net>

Index: linux-2.6.17/fs/udf/super.c
===================================================================
--- linux-2.6.17.orig/fs/udf/super.c
+++ linux-2.6.17/fs/udf/super.c
@@ -1615,6 +1615,10 @@ static int udf_fill_super(struct super_b
 		goto error_out;
 	}
 
+	if (UDF_SB_PARTFLAGS(sb, UDF_SB_PARTITION(sb)) & UDF_PART_FLAG_READ_ONLY)
+		printk("UDF-fs: Partition marked readonly; forcing readonly mount\n");
+		sb->s_flags |= MS_RDONLY;
+
 	if ( udf_find_fileset(sb, &fileset, &rootdir) )
 	{
 		printk("UDF-fs: No fileset found\n");


