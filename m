Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbULBRlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbULBRlA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 12:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbULBRlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 12:41:00 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:43469 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261699AbULBRkl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 12:40:41 -0500
Subject: [PATCH 6/6] Add member node to selinuxfs
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1102008948.26015.154.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Dec 2004 12:35:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a member node to selinuxfs to export the
security_member_sid interface to userspace for obtaining security
polyinstantiation decisions.  Please apply.

Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>

 security/selinux/selinuxfs.c |   65
+++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+)

Index: linux-2.6/security/selinux/selinuxfs.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/selinuxfs.c,v
retrieving revision 1.50
diff -u -p -r1.50 selinuxfs.c
--- linux-2.6/security/selinux/selinuxfs.c	22 Nov 2004 18:06:49
-0000	1.50
+++ linux-2.6/security/selinux/selinuxfs.c	2 Dec 2004 14:37:56 -0000
@@ -71,6 +71,7 @@ enum sel_inos {
 	SEL_MLS,	/* return if MLS policy is enabled */
 	SEL_DISABLE,	/* disable SELinux until next reboot */
 	SEL_AVC,	/* AVC management directory */
+	SEL_MEMBER,	/* compute polyinstantiation membership decision */
 };
 
 #define TMPBUFLEN	12
@@ -307,12 +308,14 @@ static ssize_t sel_write_access(struct f
 static ssize_t sel_write_create(struct file * file, char *buf, size_t
size);
 static ssize_t sel_write_relabel(struct file * file, char *buf, size_t
size);
 static ssize_t sel_write_user(struct file * file, char *buf, size_t
size);
+static ssize_t sel_write_member(struct file * file, char *buf, size_t
size);
 
 static ssize_t (*write_op[])(struct file *, char *, size_t) = {
 	[SEL_ACCESS] = sel_write_access,
 	[SEL_CREATE] = sel_write_create,
 	[SEL_RELABEL] = sel_write_relabel,
 	[SEL_USER] = sel_write_user,
+	[SEL_MEMBER] = sel_write_member,
 };
 
 static ssize_t selinux_transaction_write(struct file *file, const char
__user *buf, size_t size, loff_t *pos)
@@ -582,6 +585,67 @@ out:
 	return length;
 }
 
+static ssize_t sel_write_member(struct file * file, char *buf, size_t
size)
+{
+	char *scon, *tcon;
+	u32 ssid, tsid, newsid;
+	u16 tclass;
+	ssize_t length;
+	char *newcon;
+	u32 len;
+
+	length = task_has_security(current, SECURITY__COMPUTE_MEMBER);
+	if (length)
+		return length;
+
+	length = -ENOMEM;
+	scon = kmalloc(size+1, GFP_KERNEL);
+	if (!scon)
+		return length;
+	memset(scon, 0, size+1);
+
+	tcon = kmalloc(size+1, GFP_KERNEL);
+	if (!tcon)
+		goto out;
+	memset(tcon, 0, size+1);
+
+	length = -EINVAL;
+	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
+		goto out2;
+
+	length = security_context_to_sid(scon, strlen(scon)+1, &ssid);
+	if (length < 0)
+		goto out2;
+	length = security_context_to_sid(tcon, strlen(tcon)+1, &tsid);
+	if (length < 0)
+		goto out2;
+
+	length = security_member_sid(ssid, tsid, tclass, &newsid);
+	if (length < 0)
+		goto out2;
+
+	length = security_sid_to_context(newsid, &newcon, &len);
+	if (length < 0)
+		goto out2;
+
+	if (len > SIMPLE_TRANSACTION_LIMIT) {
+		printk(KERN_ERR "%s:  context size (%u) exceeds payload "
+		       "max\n", __FUNCTION__, len);
+		length = -ERANGE;
+		goto out3;
+	}
+
+	memcpy(buf, newcon, len);
+	length = len;
+out3:
+	kfree(newcon);
+out2:
+	kfree(tcon);
+out:
+	kfree(scon);
+	return length;
+}
+
 static struct inode *sel_make_inode(struct super_block *sb, int mode)
 {
 	struct inode *ret = new_inode(sb);
@@ -1117,6 +1181,7 @@ static int sel_fill_super(struct super_b
 		[SEL_COMMIT_BOOLS] = {"commit_pending_bools", &sel_commit_bools_ops,
S_IWUSR},
 		[SEL_MLS] = {"mls", &sel_mls_ops, S_IRUGO},
 		[SEL_DISABLE] = {"disable", &sel_disable_ops, S_IWUSR},
+		[SEL_MEMBER] = {"member", &transaction_ops, S_IRUGO|S_IWUGO},
 		/* last one */ {""}
 	};
 	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

