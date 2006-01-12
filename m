Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbWALEMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbWALEMR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 23:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbWALEMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 23:12:17 -0500
Received: from ms-smtp-03-smtplb.tampabay.rr.com ([65.32.5.133]:19148 "EHLO
	ms-smtp-03.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S965018AbWALEMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 23:12:16 -0500
Message-ID: <43C5D71B.1060002@cfl.rr.com>
Date: Wed, 11 Jan 2006 23:12:11 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: [PATCH] pktcdvd & udf bugfixes
Content-Type: multipart/mixed;
 boundary="------------020809050301050303010602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020809050301050303010602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Attached is a patch to fix a few bugs in the pktcdvd driver and udf 
filesystem.  Ben Collins said I should post it to the list and cc Jens 
Axboe as he works on this area.  The patch is rather short, but fixes 
the following bugs:

1) The pktcdvd driver was using an 8 bit field to store the packet 
length obtained from the disc track info.  This causes it to overflow 
packet length values of 128 sectors or more.  I changed the field to 32 
bits to fix this.

2) The pktcdvd driver defaulted to it's maximum allowed packet length 
when it detected a 0 in the track info field.  I changed this to fail 
the operation and refuse to access the media.  This seems more sane than 
attempting to access it with a value that almost certainly will not work.

3) The pktcdvd driver uses a compile time macro constant to define the 
maximum supported packet length.  I changed this from 32 sectors to 128 
sectors because that allows over 100 MB of additional usable space on a 
700 MB cdrw, and increases throughput.

4) The UDF filesystem refused to update the file's uid and gid on the 
disk if the in memory inode's id matched the values in the uid= and gid= 
mount options.  This was causing the owner to change from the desktop 
user to root when the volume was ejected and remounted.  I changed this 
so that if the inode's id matches the mount option, it writes a -1 to 
disk, because when the filesystem reads a -1 from disk, it uses the 
mount option for the in memory inode.  This allows you to use the 
uid/gid mount options in the way you would expect.

At some point I hope to find the time to refactor pktcdvd to properly 
allocate buffers of the length specified on the disc rather than the 
compile time maximum, but that will be a larger change and require more 
testing.


--------------020809050301050303010602
Content-Type: text/x-patch;
 name="pktcdvd_len_fix+udf_uid_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pktcdvd_len_fix+udf_uid_fix.diff"

diff -r -u linux-source-2.6.15/drivers/block/pktcdvd.c linux-source-2.6.15.new/drivers/block/pktcdvd.c
--- linux-source-2.6.15/drivers/block/pktcdvd.c	2005-11-14 12:44:28.000000000 -0500
+++ linux-source-2.6.15.new/drivers/block/pktcdvd.c	2006-01-03 20:00:01.000000000 -0500
@@ -1639,7 +1639,7 @@
 	pd->settings.size = be32_to_cpu(ti.fixed_packet_size) << 2;
 	if (pd->settings.size == 0) {
 		printk("pktcdvd: detected zero packet size!\n");
-		pd->settings.size = 128;
+		return -ENXIO;
 	}
 	if (pd->settings.size > PACKET_MAX_SECTORS) {
 		printk("pktcdvd: packet size is too big\n");
Only in linux-source-2.6.15.new/drivers/block: pktcdvd.c~
diff -r -u linux-source-2.6.15/fs/udf/inode.c linux-source-2.6.15.new/fs/udf/inode.c
--- linux-source-2.6.15/fs/udf/inode.c	2005-11-02 11:29:10.000000000 -0500
+++ linux-source-2.6.15.new/fs/udf/inode.c	2006-01-03 19:02:23.000000000 -0500
@@ -1342,9 +1342,11 @@
 
 	if (inode->i_uid != UDF_SB(inode->i_sb)->s_uid)
 		fe->uid = cpu_to_le32(inode->i_uid);
+	else fe->uid = cpu_to_le32(-1);
 
 	if (inode->i_gid != UDF_SB(inode->i_sb)->s_gid)
 		fe->gid = cpu_to_le32(inode->i_gid);
+	else fe->gid = cpu_to_le32(-1);
 
 	udfperms =	((inode->i_mode & S_IRWXO)     ) |
 			((inode->i_mode & S_IRWXG) << 2) |
diff -r -u linux-source-2.6.15/include/linux/pktcdvd.h linux-source-2.6.15.new/include/linux/pktcdvd.h
--- linux-source-2.6.15/include/linux/pktcdvd.h	2005-11-02 11:29:13.000000000 -0500
+++ linux-source-2.6.15.new/include/linux/pktcdvd.h	2006-01-02 21:48:41.000000000 -0500
@@ -114,7 +114,7 @@
 
 struct packet_settings
 {
-	__u8			size;		/* packet size in (512 byte) sectors */
+	__u32			size;		/* packet size in (512 byte) sectors */
 	__u8			fp;		/* fixed packets */
 	__u8			link_loss;	/* the rest is specified
 						 * as per Mt Fuji */
@@ -169,7 +169,7 @@
 #if (PAGE_SIZE % CD_FRAMESIZE) != 0
 #error "PAGE_SIZE must be a multiple of CD_FRAMESIZE"
 #endif
-#define PACKET_MAX_SIZE		32
+#define PACKET_MAX_SIZE		128
 #define PAGES_PER_PACKET	(PACKET_MAX_SIZE * CD_FRAMESIZE / PAGE_SIZE)
 #define PACKET_MAX_SECTORS	(PACKET_MAX_SIZE * CD_FRAMESIZE >> 9)
 

--------------020809050301050303010602--
