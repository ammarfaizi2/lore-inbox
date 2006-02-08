Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030615AbWBHXds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030615AbWBHXds (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 18:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030618AbWBHXds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 18:33:48 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:14979 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1030615AbWBHXds
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 18:33:48 -0500
Date: Wed, 8 Feb 2006 15:39:57 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>, torvalds@osdl.org,
       Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>,
       Chuck Wolber <chuckw@quantumlinux.com>, alan@lxorguk.ukuu.org.uk
Subject: [PATCH 24/23] md: remove slashes from disk names when creation dev names in sysfs
Message-ID: <20060208233957.GP30803@sorel.sous-sol.org>
References: <20060208064503.924238000@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208064503.924238000@sorel.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
(this should've been in the series.  i missed this one, mea culpa)
------------------

e.g. The sx8 driver uses names like sx8/0.

This would make a md component dev name like

   /sys/block/md0/md/dev-sx8/0

which is not allowed.  So we change the '/' to '!' just like
fs/partitions/check.c(register_disk) does.

Signed-off-by: Neil Brown <neilb@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/md/md.c |    3 +++
 1 files changed, 3 insertions(+)

--- linux-2.6.15.3.orig/drivers/md/md.c
+++ linux-2.6.15.3/drivers/md/md.c
@@ -1182,6 +1182,7 @@ static int bind_rdev_to_array(mdk_rdev_t
 	mdk_rdev_t *same_pdev;
 	char b[BDEVNAME_SIZE], b2[BDEVNAME_SIZE];
 	struct kobject *ko;
+	char *s;
 
 	if (rdev->mddev) {
 		MD_BUG();
@@ -1213,6 +1214,8 @@ static int bind_rdev_to_array(mdk_rdev_t
 	bdevname(rdev->bdev,b);
 	if (kobject_set_name(&rdev->kobj, "dev-%s", b) < 0)
 		return -ENOMEM;
+	while ( (s=strchr(rdev->kobj.k_name, '/')) != NULL)
+		*s = '!';
 			
 	list_add(&rdev->same_set, &mddev->disks);
 	rdev->mddev = mddev;
