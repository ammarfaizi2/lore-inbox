Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751718AbWIPHvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbWIPHvI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 03:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbWIPHvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 03:51:07 -0400
Received: from tomts40-srv.bellnexxia.net ([209.226.175.97]:57217 "EHLO
	tomts40-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751720AbWIPHvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 03:51:05 -0400
Date: Sat, 16 Sep 2006 03:51:03 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>
Cc: ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>
Subject: [PATCH 1/11] LTTng-core 0.5.111 : Relay+DebugFS (DebugFS fix)
Message-ID: <20060916075103.GB29360@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_Krystal-23203-1158393063-0001-2"
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 03:48:59 up 24 days,  4:57,  3 users,  load average: 0.22, 0.13, 0.10
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-23203-1158393063-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

1 - DebugFS stalled dentry patch
DebugFS seems to keep a stalled dentry when a process is in a directory that is
being removed. Force a differed deletion.
patch-2.6.17-lttng-core-0.5.111-debugfs.diff


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

--=_Krystal-23203-1158393063-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-2.6.17-lttng-core-0.5.111-debugfs.diff"

--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -266,6 +266,7 @@ EXPORT_SYMBOL_GPL(debugfs_create_dir);
 void debugfs_remove(struct dentry *dentry)
 {
 	struct dentry *parent;
+	int ret = 0;
 	
 	if (!dentry)
 		return;
@@ -278,9 +279,10 @@ void debugfs_remove(struct dentry *dentr
 	if (debugfs_positive(dentry)) {
 		if (dentry->d_inode) {
 			if (S_ISDIR(dentry->d_inode->i_mode))
-				simple_rmdir(parent->d_inode, dentry);
+				ret = simple_rmdir(parent->d_inode, dentry);
 			else
-				simple_unlink(parent->d_inode, dentry);
+				ret = simple_unlink(parent->d_inode, dentry);
+			if(ret) d_delete(dentry);
 		dput(dentry);
 		}
 	}

--=_Krystal-23203-1158393063-0001-2--
