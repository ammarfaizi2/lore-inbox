Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266167AbUAVCWN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 21:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbUAVCWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 21:22:13 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:40894 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S266167AbUAVCWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 21:22:10 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 22 Jan 2004 13:22:04 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16399.13260.882442.103487@notabene.cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH - 2.6.2-pre] Make naming of parititions in sysfs match /proc/partitions.
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



In fs/partitions/check.c  there are two pieces of code that add a 
partition number to a block-device name:

  - the 'disk_name' function 
  - a snprintf in add_partitions.

'disk_name' inserts a 'p' before the partition number if the device
name ends with a digit.  The snprintf in add_partitions doesn't.

This patch rectifies this anomily so that names in sysfs can be
parsed more reliably.


 ----------- Diffstat output ------------
 ./fs/partitions/check.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff ./fs/partitions/check.c~current~ ./fs/partitions/check.c
--- ./fs/partitions/check.c~current~	2004-01-22 08:57:32.000000000 +1100
+++ ./fs/partitions/check.c	2004-01-22 08:58:37.000000000 +1100
@@ -315,7 +315,10 @@ void add_partition(struct gendisk *disk,
 			S_IFBLK|S_IRUSR|S_IWUSR,
 			"%s/part%d", disk->devfs_name, part);
 
-	snprintf(p->kobj.name,KOBJ_NAME_LEN,"%s%d",disk->kobj.name,part);
+	if (isdigit(disk->kobj.name[strlen(disk->kobj.name)-1]))
+		snprintf(p->kobj.name,KOBJ_NAME_LEN,"%sp%d",disk->kobj.name,part);
+	else
+		snprintf(p->kobj.name,KOBJ_NAME_LEN,"%s%d",disk->kobj.name,part);
 	p->kobj.parent = &disk->kobj;
 	p->kobj.ktype = &ktype_part;
 	kobject_register(&p->kobj);
