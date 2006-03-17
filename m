Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752516AbWCQEvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbWCQEvW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 23:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbWCQEt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 23:49:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:19340 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750828AbWCQEtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 23:49:41 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 17 Mar 2006 15:48:25 +1100
Message-Id: <1060317044825.16232@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 012 of 13] md: Make 'reshape' a possible sync_action action.
References: <20060317154017.15880.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This allows reshape to be triggerred via sysfs (which is the
only way to start it happening).

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-03-17 11:48:59.000000000 +1100
+++ ./drivers/md/md.c	2006-03-17 11:48:59.000000000 +1100
@@ -2242,7 +2242,14 @@ action_store(mddev_t *mddev, const char 
 		return -EBUSY;
 	else if (cmd_match(page, "resync") || cmd_match(page, "recover"))
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-	else {
+	else if (cmd_match(page, "reshape")) {
+		int err;
+		if (mddev->pers->start_reshape == NULL)
+			return -EINVAL;
+		err = mddev->pers->start_reshape(mddev);
+		if (err)
+			return err;
+	} else {
 		if (cmd_match(page, "check"))
 			set_bit(MD_RECOVERY_CHECK, &mddev->recovery);
 		else if (cmd_match(page, "repair"))
