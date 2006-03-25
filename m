Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWCYE1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWCYE1v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWCYE1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:27:14 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:35260
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750825AbWCYE1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:27:07 -0500
Date: Fri, 24 Mar 2006 20:26:44 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Bob Copeland <email@bobcopeland.com>,
       Paul Fulghum <paulkf@microgate.com>, Maneesh Soni <maneesh@in.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 06/20] sysfs: sysfs_remove_dir() needs to invalidate the dentry
Message-ID: <20060325042644.GG21260@kroah.com>
References: <20060325041355.180237000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="driver-0001-sysfs-sysfs_remove_dir-needs-to-invalidate-the-dentry.patch"
In-Reply-To: <20060325042556.GA21260@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
When calling sysfs_remove_dir() don't allow any further sysfs functions
to work for this kobject anymore.  This fixes a nasty USB cdc-acm oops
on disconnect.

Many thanks to Bob Copeland and Paul Fulghum for taking the time to
track this down.

Cc: Bob Copeland <email@bobcopeland.com>
Cc: Paul Fulghum <paulkf@microgate.com>
Cc: Maneesh Soni <maneesh@in.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 fs/sysfs/dir.c   |    1 +
 fs/sysfs/inode.c |    6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

641e6f30a095f3752ed84fd9d279382f5d3ef4c1
--- linux-2.6.16.orig/fs/sysfs/dir.c
+++ linux-2.6.16/fs/sysfs/dir.c
@@ -302,6 +302,7 @@ void sysfs_remove_dir(struct kobject * k
 	 * Drop reference from dget() on entrance.
 	 */
 	dput(dentry);
+	kobj->dentry = NULL;
 }
 
 int sysfs_rename_dir(struct kobject * kobj, const char *new_name)
--- linux-2.6.16.orig/fs/sysfs/inode.c
+++ linux-2.6.16/fs/sysfs/inode.c
@@ -227,12 +227,16 @@ void sysfs_drop_dentry(struct sysfs_dire
 void sysfs_hash_and_remove(struct dentry * dir, const char * name)
 {
 	struct sysfs_dirent * sd;
-	struct sysfs_dirent * parent_sd = dir->d_fsdata;
+	struct sysfs_dirent * parent_sd;
+
+	if (!dir)
+		return;
 
 	if (dir->d_inode == NULL)
 		/* no inode means this hasn't been made visible yet */
 		return;
 
+	parent_sd = dir->d_fsdata;
 	mutex_lock(&dir->d_inode->i_mutex);
 	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
 		if (!sd->s_element)

--
