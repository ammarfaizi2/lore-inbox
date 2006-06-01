Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965235AbWFAFPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965235AbWFAFPs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 01:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWFAFOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 01:14:35 -0400
Received: from ns2.suse.de ([195.135.220.15]:17321 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964891AbWFAFOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 01:14:24 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 1 Jun 2006 15:14:13 +1000
Message-Id: <1060601051413.27649@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 009 of 10] md: Allow resync_start to be set and queried via sysfs.
References: <20060601150955.27444.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./Documentation/md.txt |    6 ++++++
 ./drivers/md/md.c      |   26 ++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff ./Documentation/md.txt~current~ ./Documentation/md.txt
--- ./Documentation/md.txt~current~	2006-06-01 15:05:30.000000000 +1000
+++ ./Documentation/md.txt	2006-06-01 15:05:30.000000000 +1000
@@ -205,6 +205,12 @@ All md devices contain:
      simply a number that is interpretted differently by different
      levels.  It can be written while assembling an array.
 
+  resync_start
+     The point at which resync should start.  If no resync is needed,
+     this will be a very large number.  At array creation it will
+     default to 0, though starting the array as 'clean' will
+     set it much larger.
+
    new_dev
      This file can be written but not read.  The value written should
      be a block device number as major:minor.  e.g. 8:0

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-06-01 15:05:30.000000000 +1000
+++ ./drivers/md/md.c	2006-06-01 15:05:30.000000000 +1000
@@ -2235,6 +2235,30 @@ chunk_size_store(mddev_t *mddev, const c
 static struct md_sysfs_entry md_chunk_size =
 __ATTR(chunk_size, 0644, chunk_size_show, chunk_size_store);
 
+static ssize_t
+resync_start_show(mddev_t *mddev, char *page)
+{
+	return sprintf(page, "%llu\n", (unsigned long long)mddev->recovery_cp);
+}
+
+static ssize_t
+resync_start_store(mddev_t *mddev, const char *buf, size_t len)
+{
+	/* can only set chunk_size if array is not yet active */
+	char *e;
+	unsigned long long n = simple_strtoull(buf, &e, 10);
+
+	if (mddev->pers)
+		return -EBUSY;
+	if (!*buf || (*e && *e != '\n'))
+		return -EINVAL;
+
+	mddev->recovery_cp = n;
+	return len;
+}
+static struct md_sysfs_entry md_resync_start =
+__ATTR(resync_start, 0644, resync_start_show, resync_start_store);
+
 /*
  * The array state can be:
  *
@@ -2771,6 +2795,7 @@ static struct attribute *md_default_attr
 	&md_raid_disks.attr,
 	&md_chunk_size.attr,
 	&md_size.attr,
+	&md_resync_start.attr,
 	&md_metadata.attr,
 	&md_new_device.attr,
 	&md_safe_delay.attr,
@@ -3263,6 +3288,7 @@ static int do_md_stop(mddev_t * mddev, i
 		mddev->array_size = 0;
 		mddev->size = 0;
 		mddev->raid_disks = 0;
+		mddev->recovery_cp = 0;
 
 		disk = mddev->gendisk;
 		if (disk)
