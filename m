Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751581AbWHaCQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbWHaCQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 22:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbWHaCQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 22:16:56 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:4404 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751579AbWHaCQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 22:16:55 -0400
Date: Wed, 30 Aug 2006 19:16:07 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Johannes Berg <johannes@sipsolutions.net>,
       "Luis R. Rodriguez" <mcgrof@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: observations on configfs
Message-ID: <20060831021607.GN7715@ca-server1.us.oracle.com>
Mail-Followup-To: Johannes Berg <johannes@sipsolutions.net>,
	"Luis R. Rodriguez" <mcgrof@gmail.com>,
	linux-kernel@vger.kernel.org
References: <1156868070.3788.38.camel@ux156> <20060829163136.GW7715@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060829163136.GW7715@ca-server1.us.oracle.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 09:31:36AM -0700, Joel Becker wrote:
> On Tue, Aug 29, 2006 at 06:14:30PM +0200, Johannes Berg wrote:
> >  (1) it is possible to have
> > 
> >      | $ ls /config
> >      | 02-example  02-example
> > 
> >      Seems like that should be prohibited when registering the new
> > configfs subsystem.
> 
> 	Hmm, yeah, this is a bug.  I've added
> http://oss.oracle.com/bugzilla/show_bug.cgi?id=755.  Thanks for
> reporting this!

	Here's a fix, if you can try it:


diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index df02545..816e8ef 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -86,6 +86,32 @@ static struct configfs_dirent *configfs_
 	return sd;
 }
 
+/*
+ *
+ * Return -EEXIST if there is already a configfs element with the same
+ * name for the same parent.
+ *
+ * called with parent inode's i_mutex held
+ */
+int configfs_dirent_exists(struct configfs_dirent *parent_sd,
+			   const unsigned char *new)
+{
+	struct configfs_dirent * sd;
+
+	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+		if (sd->s_element) {
+			const unsigned char *existing = configfs_get_name(sd);
+			if (strcmp(existing, new))
+				continue;
+			else
+				return -EEXIST;
+		}
+	}
+
+	return 0;
+}
+
+
 int configfs_make_dirent(struct configfs_dirent * parent_sd,
 			 struct dentry * dentry, void * element,
 			 umode_t mode, int type)
@@ -136,8 +162,10 @@ static int create_dir(struct config_item
 	int error;
 	umode_t mode = S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO;
 
-	error = configfs_make_dirent(p->d_fsdata, d, k, mode,
-				     CONFIGFS_DIR);
+	error = configfs_dirent_exists(p->d_fsdata, d->d_name.name);
+	if (!error)
+		error = configfs_make_dirent(p->d_fsdata, d, k, mode,
+					     CONFIGFS_DIR);
 	if (!error) {
 		error = configfs_create(d, mode, init_dir);
 		if (!error) {
-- 

"Not everything that can be counted counts, and not everything
 that counts can be counted."
        - Albert Einstein 

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
