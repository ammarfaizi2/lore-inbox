Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751910AbWCFHFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbWCFHFL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 02:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbWCFHFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 02:05:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24727 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751910AbWCFHFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 02:05:09 -0500
Date: Mon, 6 Mar 2006 02:04:58 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: ericvh@gmail.com, rminnich@lanl.gov
Subject: 9pfs double kfree
Message-ID: <20060306070456.GA16478@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, ericvh@gmail.com,
	rminnich@lanl.gov
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Probably the first of many found with Coverity.

This is kfree'd outside of both arms of the if condition already,
so fall through and free it just once.

Second variant is double-nasty, it deref's the free'd fcall
before it tries to free it a second time.

(I wish we had a kfree variant that NULL'd the target when it was free'd)

Coverity bugs: 987, 986

Signed-off-by: Dave Jones <davej@redhat.com>


--- linux-2.6.15.noarch/fs/9p/vfs_super.c~	2006-03-06 01:53:38.000000000 -0500
+++ linux-2.6.15.noarch/fs/9p/vfs_super.c	2006-03-06 01:54:36.000000000 -0500
@@ -156,7 +156,6 @@ static struct super_block *v9fs_get_sb(s
 	stat_result = v9fs_t_stat(v9ses, newfid, &fcall);
 	if (stat_result < 0) {
 		dprintk(DEBUG_ERROR, "stat error\n");
-		kfree(fcall);
 		v9fs_t_clunk(v9ses, newfid);
 	} else {
 		/* Setup the Root Inode */
--- linux-2.6.15.noarch/fs/9p/vfs_inode.c~	2006-03-06 01:57:05.000000000 -0500
+++ linux-2.6.15.noarch/fs/9p/vfs_inode.c	2006-03-06 01:58:05.000000000 -0500
@@ -274,7 +274,6 @@ v9fs_create(struct v9fs_session_info *v9
 		PRINT_FCALL_ERROR("clone error", fcall);
 		goto error;
 	}
-	kfree(fcall);
 
 	err = v9fs_t_create(v9ses, fid, name, perm, mode, &fcall);
 	if (err < 0) {
