Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164250AbWLHBFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164250AbWLHBFq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164324AbWLHBFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:05:45 -0500
Received: from cantor2.suse.de ([195.135.220.15]:46657 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164322AbWLHBFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:05:39 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 12:05:52 +1100
Message-Id: <1061208010552.21344@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 005 of 5] md: Allow mddevs to live a bit longer to avoid a loop with udev.
References: <20061208120132.21203.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As md devices a automatically created on first open, and automatically
destroyed on last close if they have no significant state, a loop can
be caused with udev.

If you open/close an md device that will generate add and remove
events to udev.  udev will open the device, notice nothing is there
and close it again ... which generates another pair of add/remove events. 
Ad infinitum.

So: Change md to only destroy a device if an explicity MD_STOP was
requested.  This means that md devices might hang around longer than
you would like, but it is easy to get rid of them, and that could even
be automated in user-space (e.g. by mdadm --monitor).


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-12-07 21:01:11.000000000 +1100
+++ ./drivers/md/md.c	2006-12-08 10:22:46.000000000 +1100
@@ -292,7 +292,7 @@ static mddev_t * mddev_find(dev_t unit)
 	atomic_set(&new->active, 1);
 	spin_lock_init(&new->write_lock);
 	init_waitqueue_head(&new->sb_wait);
-	new->dead = 1;
+	new->dead = 0;
 
 	new->queue = blk_alloc_queue(GFP_KERNEL);
 	if (!new->queue) {
