Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266146AbUBQMkV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 07:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266147AbUBQMkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 07:40:20 -0500
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:44270 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S266146AbUBQMih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 07:38:37 -0500
From: Vincent ROQUETA <vincent.roqueta@ext.bull.net>
Reply-To: vincent.roqueta@ext.bull.net
Organization: Bull
Subject: A little bug in quotas ext3 2.6.3-rc3-mm1 patch
Date: Tue, 17 Feb 2004 13:30:49 +0100
User-Agent: KMail/1.5
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402171330.49441.vincent.roqueta@ext.bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel patch 2.6.3-rc3-mm1

file : /fs/ext3/super.c

+static int
+ext3_quota_on(struct super_block *sb, int type, int format_id, char *path)
+{
+       int err;
+       struct nameidata nd;
+
+       if (!EXT3_SB(sb)->s_qf_names[0] && !EXT3_SB(sb)->s_qf_names[1]) {
+               /* Not journalling quota? */
+               return vfs_quota_on(sb, type, format_id, path);
+       }
+       err = path_lookup(path, LOOKUP_FOLLOW, &nd);
+       if (err)
+               return err;
+       if (nd.mnt->mnt_sb != sb)       /* Quotafile not on the same fs? */
+               return -EXDEV;
+       if (nd.dentry->d_parent->d_inode != sb->s_root->d_inode) {
+               /* Quotafile not of fs root? */
+               printk(KERN_WARNING "EXT3-fs: Quota file not on filesystem "
+                               "root. Journalled quota will not work\n");

	} /* Close if ...*/


+       if (!ext3_should_journal_data(nd.dentry->d_inode))
+               printk(KERN_WARNING "EXT3-fs: Quota file does not have "
+                       "data-journalling. Journalled quota will not
 work\n"); +       path_release(&nd);
+       return vfs_quota_on(sb, type, format_id, path);
+}
+
 #endif

-------------------------------------------------------

