Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932929AbWJIQkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932929AbWJIQkU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 12:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932956AbWJIQkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 12:40:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:28083 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932929AbWJIQkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 12:40:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=K3jNFYqMRR+sD0txeoTMMD3kudHK/6O/RlxOoiBAtMcvX+OM3SOmU/GxgRthPRnwDHgcIV1VryKL9fkBAoDqYY9sHDgKz+RYxTC2l+OIN4kJ3F/mE+/nfTVTFJjVJGJgM0CLCCTITvYAtazAb90lq+kn9ZUhcoSaWk520/mmGIc=
Date: Mon, 9 Oct 2006 18:40:17 +0200
From: Luca Tettamanti <kronos.it@gmail.com>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.19-git] Fix error handling in create_files()
Message-ID: <20061009164017.GA13698@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
current code in create_files() detects an error iff the last
sysfs_add_file fails:

for (attr = grp->attrs; *attr && !error; attr++) {
        error = sysfs_add_file(dir, *attr, SYSFS_KOBJ_ATTR);
}
if (error)
        remove_files(dir,grp);

In order to do the proper cleanup upon failure 'error' must be checked on
every iteration.

Signed-Off-By: Luca Tettamanti <kronos.it@gmail.com>

---
 fs/sysfs/group.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 122145b..1c490d6 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -33,6 +33,8 @@ static int create_files(struct dentry * 
 
 	for (attr = grp->attrs; *attr && !error; attr++) {
 		error = sysfs_add_file(dir, *attr, SYSFS_KOBJ_ATTR);
+		if (error)
+			break;
 	}
 	if (error)
 		remove_files(dir,grp);


Luca
-- 
Recursion n.:
	See Recursion.
