Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267734AbUHPQ2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267734AbUHPQ2r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 12:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267755AbUHPQ2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 12:28:47 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:60658 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S267734AbUHPQ2n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 12:28:43 -0400
Subject: [PATCH][SELINUX] Revalidate access to controlling tty
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1092673645.16631.97.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 16 Aug 2004 12:27:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the SELinux flush_unauthorized_files function to also
recheck access to the controlling tty and reset it if it is no longer
accessible under the new security context.  This patch is relative to the
selinuxfs devnull patch.  Please apply.

Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>
Signed-off-by:  James Morris <jmorris@redhat.com>

 security/selinux/hooks.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+)

diff -X /home/sds/dontdiff -ru linux-2.6.8.old/security/selinux/hooks.c linux-2.6.8/security/selinux/hooks.c
--- linux-2.6.8.old/security/selinux/hooks.c	2004-08-05 11:03:54.362725160 -0400
+++ linux-2.6.8/security/selinux/hooks.c	2004-08-05 11:04:04.038254256 -0400
@@ -43,6 +43,7 @@
 #include <linux/kd.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv6.h>
+#include <linux/tty.h>
 #include <net/icmp.h>
 #include <net/ip.h>		/* for sysctl_local_port_range[] */
 #include <net/tcp.h>		/* struct or_callable used in sock_rcv_skb */
@@ -1733,8 +1734,32 @@
 {
 	struct avc_audit_data ad;
 	struct file *file, *devnull = NULL;
+	struct tty_struct *tty = current->signal->tty;
 	long j = -1;
 
+	if (tty) {
+		file_list_lock();
+		file = list_entry(tty->tty_files.next, typeof(*file), f_list);
+		if (file) {
+			/* Revalidate access to controlling tty.
+			   Use inode_has_perm on the tty inode directly rather
+			   than using file_has_perm, as this particular open
+			   file may belong to another process and we are only
+			   interested in the inode-based check here. */
+			struct inode *inode = file->f_dentry->d_inode;
+			if (inode_has_perm(current, inode, 
+					   FILE__READ | FILE__WRITE, 
+					   NULL, NULL)) {
+				/* Reset controlling tty. */
+				current->signal->tty = NULL;
+				current->signal->tty_old_pgrp = 0;
+			}
+		}
+		file_list_unlock();
+	}
+
+	/* Revalidate access to inherited open files. */
+
 	AVC_AUDIT_DATA_INIT(&ad,FS);
 
 	spin_lock(&files->file_lock);

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

