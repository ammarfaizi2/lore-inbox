Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWCYEbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWCYEbb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWCYE2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:28:03 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:58044
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750850AbWCYE1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:27:50 -0500
Date: Fri, 24 Mar 2006 20:27:27 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, lucho@ionkov.net,
       ericvh@gmail.com, Chris Wright <chrisw@sous-sol.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 13/20] v9fs: assign dentry ops to negative dentries
Message-ID: <20060325042727.GN21260@kroah.com>
References: <20060325041355.180237000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="v9fs-assign-dentry-ops-to-negative-dentries.patch"
In-Reply-To: <20060325042556.GA21260@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

table review patch.  If anyone has any objections, please let us know.

------------------

From: Latchesar Ionkov <lucho@ionkov.net>

If a file is not found in v9fs_vfs_lookup, the function creates negative
dentry, but doesn't assign any dentry ops.  This leaves the negative entry
in the cache (there is no d_delete to mark it for removal).  If the file is
created outside of the mounted v9fs filesystem, the file shows up in the
directory with weird permissions.

This patch assigns the default v9fs dentry ops to the negative dentry.

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>
Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 fs/9p/vfs_inode.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.16.orig/fs/9p/vfs_inode.c
+++ linux-2.6.16/fs/9p/vfs_inode.c
@@ -614,6 +614,7 @@ static struct dentry *v9fs_vfs_lookup(st
 
 	sb = dir->i_sb;
 	v9ses = v9fs_inode2v9ses(dir);
+	dentry->d_op = &v9fs_dentry_operations;
 	dirfid = v9fs_fid_lookup(dentry->d_parent);
 
 	if (!dirfid) {
@@ -681,8 +682,6 @@ static struct dentry *v9fs_vfs_lookup(st
 		goto FreeFcall;
 
 	fid->qid = fcall->params.rstat.stat.qid;
-
-	dentry->d_op = &v9fs_dentry_operations;
 	v9fs_stat2inode(&fcall->params.rstat.stat, inode, inode->i_sb);
 
 	d_add(dentry, inode);

--
