Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422972AbWAMVHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422972AbWAMVHK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 16:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422975AbWAMVHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 16:07:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:28876 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422974AbWAMVHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 16:07:08 -0500
From: Neil Brown <neilb@suse.de>
To: Sven Geggus <sven@geggus.net>
Date: Sat, 14 Jan 2006 08:06:47 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17352.5735.965046.569208@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15: oops in sysfs_create_link
In-Reply-To: message from Sven Geggus on Friday January 13
References: <20060113163043.GA5417@geggus.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday January 13, sven@geggus.net wrote:
> Hello kernel people,
> 
> the attached oops happens when I try to create an md-array on an aoe device
> in conjunction with vanilla Kernel 2.6.15+drbd+aoe:
> 
> --cut--
> kernel BUG at fs/sysfs/symlink.c:87!

Thanks for the report.
This should be fixed by the following patch.

NeilBrown


----------------------
Remove slashed from disk names when creation dev names in sysfs

e.g. The sx8 driver uses names like sx8/0.
This would make a md component dev name like
   /sys/block/md0/md/dev-sx8/0
which is no allowed.  So we change the '/' to '!' just like
fs/partitions/check.c(register_disk) does.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    3 +++
 1 file changed, 3 insertions(+)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-01-12 11:18:52.000000000 +1100
+++ ./drivers/md/md.c	2006-01-12 09:44:39.000000000 +1100
@@ -1238,6 +1238,7 @@ static int bind_rdev_to_array(mdk_rdev_t
 	mdk_rdev_t *same_pdev;
 	char b[BDEVNAME_SIZE], b2[BDEVNAME_SIZE];
 	struct kobject *ko;
+	char *s;
 
 	if (rdev->mddev) {
 		MD_BUG();
@@ -1277,6 +1278,8 @@ static int bind_rdev_to_array(mdk_rdev_t
 	bdevname(rdev->bdev,b);
 	if (kobject_set_name(&rdev->kobj, "dev-%s", b) < 0)
 		return -ENOMEM;
+	while ( (s=strchr(rdev->kobj.k_name, '/')) != NULL)
+		*s = '!';
 			
 	list_add(&rdev->same_set, &mddev->disks);
 	rdev->mddev = mddev;
