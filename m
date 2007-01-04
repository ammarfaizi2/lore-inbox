Return-Path: <linux-kernel-owner+w=401wt.eu-S932330AbXADImA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbXADImA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 03:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbXADImA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 03:42:00 -0500
Received: from ns2.suse.de ([195.135.220.15]:38264 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932330AbXADIl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 03:41:59 -0500
Date: Thu, 4 Jan 2007 09:40:49 +0100
From: Olaf Hering <olh@suse.de>
To: Anton Blanchard <anton@samba.org>, linuxppc-dev@ozlabs.org,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] relax check for AIX in msdos partition table
Message-ID: <20070104084049.GA19959@suse.de>
References: <20061206211630.GB27857@krispykreme> <20061206222213.GA17446@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20061206222213.GA17446@localhost.localdomain>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, David Gibson wrote:

> On Thu, Dec 07, 2006 at 08:16:30AM +1100, Anton Blanchard wrote:

> > The patch to identify AIX disks and ignore them has caused at least one
> > machine to fail to find the root partition on 2.6.19. The patch is:
> > 
> > http://lkml.org/lkml/2006/7/31/117
> > 
> > The problem is some disk formatters do not blow away the first 4 bytes
> > of the disk. If the disk we are installing to used to have AIX on it,
> > then the first 4 bytes will still have IBMA in EBCDIC.
> > 
> > The install in question was debian etch. Im not sure what the best fix
> > is, perhaps the AIX detection code could check more than the first 4
> > bytes.
> 
> Yeah, I had this problem on paulus' old PReP machine - I had to
> manually zap the AIX magic number to get it to see the perfectly good
> partitions.

What pre-historic fdisk was used to create the partition table? At least
the current version of fdisk does not let me manipulate the existing
partition table before I remove the AIX marker. The patch below should
fix it. Partition table entries 2,3,4 from an AIX 4.3 install have type 0x41.

Also, the whole partition info for primary partitions is in this block:

  dd if=/dev/sdb count=$(( 4 * 16 )) bs=1 skip=$(( 0x1be ))

All other data do not matter, beside the 0x55aa marker at the end of the
first block.

Signed-off-by: Olaf Hering <olh@suse.de>

---
 fs/partitions/msdos.c |   12 +++++++++++-
 include/linux/genhd.h |    2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

Index: linux-2.6/fs/partitions/msdos.c
===================================================================
--- linux-2.6.orig/fs/partitions/msdos.c
+++ linux-2.6/fs/partitions/msdos.c
@@ -63,15 +63,25 @@ msdos_magic_present(unsigned char *p)
 #define AIX_LABEL_MAGIC4	0xC1
 static int aix_magic_present(unsigned char *p, struct block_device *bdev)
 {
+	struct partition *pt = (struct partition *) (p + 0x1be);
 	Sector sect;
 	unsigned char *d;
-	int ret = 0;
+	int slot, ret = 0;
 
 	if (p[0] != AIX_LABEL_MAGIC1 &&
 		p[1] != AIX_LABEL_MAGIC2 &&
 		p[2] != AIX_LABEL_MAGIC3 &&
 		p[3] != AIX_LABEL_MAGIC4)
 		return 0;
+	/* Assume the partition table is valid if Linux partitions exists */
+	for (slot = 1; slot <= 4; slot++, pt++) {
+		if (pt->sys_ind == LINUX_SWAP_PARTITION ||
+			pt->sys_ind == LINUX_RAID_PARTITION ||
+			pt->sys_ind == LINUX_DATA_PARTITION ||
+			pt->sys_ind == LINUX_LVM_PARTITION ||
+			is_extended_partition(pt))
+			return 0;
+	}
 	d = read_dev_sector(bdev, 7, &sect);
 	if (d) {
 		if (d[0] == '_' && d[1] == 'L' && d[2] == 'V' && d[3] == 'M')
Index: linux-2.6/include/linux/genhd.h
===================================================================
--- linux-2.6.orig/include/linux/genhd.h
+++ linux-2.6/include/linux/genhd.h
@@ -21,6 +21,8 @@ enum {
 	WIN98_EXTENDED_PARTITION = 0x0f,
 
 	LINUX_SWAP_PARTITION = 0x82,
+	LINUX_DATA_PARTITION = 0x83,
+	LINUX_LVM_PARTITION = 0x8e,
 	LINUX_RAID_PARTITION = 0xfd,	/* autodetect RAID partition */
 
 	SOLARIS_X86_PARTITION =	LINUX_SWAP_PARTITION,
