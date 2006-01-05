Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWAEAwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWAEAwx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWAEAuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:50:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:58041 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750947AbWAEAtu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:49:50 -0500
Cc: rostedt@goodmis.org
Subject: [PATCH] sysfs: handle failures in sysfs_make_dirent
In-Reply-To: <11364221713236@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jan 2006 16:49:31 -0800
Message-Id: <11364221712096@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] sysfs: handle failures in sysfs_make_dirent

I noticed that if sysfs_make_dirent fails to allocate the sd, then a
null will be passed to sysfs_put.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit e80a5dea8e056d8f398be1900d61c581d379f02f
tree 97d6e0d1c669987c54961bec49347b3717e55d52
parent 8218ef80932aa7e5e3d20c929a640c8d82133a9a
author Steven Rostedt <rostedt@goodmis.org> Wed, 23 Nov 2005 09:15:44 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 04 Jan 2006 16:18:09 -0800

 fs/sysfs/dir.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index 59734ba..d367803 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -112,7 +112,11 @@ static int create_dir(struct kobject * k
 			}
 		}
 		if (error && (error != -EEXIST)) {
-			sysfs_put((*d)->d_fsdata);
+			struct sysfs_dirent *sd = (*d)->d_fsdata;
+			if (sd) {
+ 				list_del_init(&sd->s_sibling);
+				sysfs_put(sd);
+			}
 			d_drop(*d);
 		}
 		dput(*d);

