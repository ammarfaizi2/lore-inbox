Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262821AbVAKVC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262821AbVAKVC2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbVAKVAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:00:49 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:52447 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262755AbVAKU7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 15:59:39 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] user based capabilities 0.1
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Tue, 11 Jan 2005 21:59:29 +0100
Message-ID: <87r7krr8b2.fsf@goat.bogus.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

This patch implements user based capabilities.

With this module, you will be able to grant capabilities based on
user-/groupid (root by default). This patch uses sysfs/kobject for the
user interface.

For example you can create a group raw and change the capability
net_raw to this group:

# chgrp raw /sys/usercaps/net_raw
# chmod ug+x /sys/usercaps/net_raw
# chgrp raw /sbin/ping
# chmod u-s /sbin/ping; chmod g+s /sbin/ping

or you can give a group of users some capability:

# chgrp wheel /sys/usercaps/sys_admin
# chmod ug+x /sys/usercaps/sys_admin

Known bugs:
- show()/store() not implemented
- only minimally tested against 2.6.9

Regards, Olaf.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=usercaps.patch
Content-Description: User base capabilities

diff -urN a/usercaps/Makefile b/usercaps/Makefile
--- a/usercaps/Makefile	Thu Jan  1 01:00:00 1970
+++ b/usercaps/Makefile	Tue Jan 11 19:12:07 2005
@@ -0,0 +1,7 @@
+#
+# Makefile for user based capabilities
+# usage: make -C /usr/src/linux M=$PWD
+#
+
+obj-m += usercaps.o
+usercaps-objs := capabilities.o
diff -urN a/usercaps/capabilities.c b/usercaps/capabilities.c
--- a/usercaps/capabilities.c	Thu Jan  1 01:00:00 1970
+++ b/usercaps/capabilities.c	Tue Jan 11 19:08:55 2005
@@ -0,0 +1,120 @@
+/* Copyright (c) 2005 Olaf Dietsche
+ *
+ * User based capabilities for Linux.
+ */
+
+#include <linux/dcache.h>
+#include <linux/init.h>
+#include <linux/kobject.h>
+#include <linux/module.h>
+#include <linux/namei.h>
+#include <linux/security.h>
+#include <linux/sysfs.h>
+
+static struct kobject usercaps = {
+	.name = "usercaps",
+};
+
+struct caps_attribute {
+	struct attribute attr;
+	struct inode *inode;
+};
+
+static struct caps_attribute caps[] = {
+	{ .attr = { .name = "chown", .mode = 0100, } },
+	{ .attr = { .name = "dac_override", .mode = 0100, } },
+	{ .attr = { .name = "dac_read_search", .mode = 0100, } },
+	{ .attr = { .name = "fowner", .mode = 0100, } },
+	{ .attr = { .name = "fsetid", .mode = 0100, } },
+	{ .attr = { .name = "kill", .mode = 0100, } },
+	{ .attr = { .name = "setgid", .mode = 0100, } },
+	{ .attr = { .name = "setuid", .mode = 0100, } },
+	{ .attr = { .name = "setpcap", .mode = 0100, } },
+	{ .attr = { .name = "linux_immutable", .mode = 0100, } },
+	{ .attr = { .name = "net_bind_service", .mode = 0100, } },
+	{ .attr = { .name = "net_broadcast", .mode = 0100, } },
+	{ .attr = { .name = "net_admin", .mode = 0100, } },
+	{ .attr = { .name = "net_raw", .mode = 0100, } },
+	{ .attr = { .name = "ipc_lock", .mode = 0100, } },
+	{ .attr = { .name = "ipc_owner", .mode = 0100, } },
+	{ .attr = { .name = "sys_module", .mode = 0100, } },
+	{ .attr = { .name = "sys_rawio", .mode = 0100, } },
+	{ .attr = { .name = "sys_chroot", .mode = 0100, } },
+	{ .attr = { .name = "sys_ptrace", .mode = 0100, } },
+	{ .attr = { .name = "sys_pacct", .mode = 0100, } },
+	{ .attr = { .name = "sys_admin", .mode = 0100, } },
+	{ .attr = { .name = "sys_boot", .mode = 0100, } },
+	{ .attr = { .name = "sys_nice", .mode = 0100, } },
+	{ .attr = { .name = "sys_resource", .mode = 0100, } },
+	{ .attr = { .name = "sys_time", .mode = 0100, } },
+	{ .attr = { .name = "sys_tty_config", .mode = 0100, } },
+	{ .attr = { .name = "mknod", .mode = 0100, } },
+	{ .attr = { .name = "lease", .mode = 0100, } },
+};
+
+static inline int usercaps_permitted(struct inode *i, int mask)
+{
+	mode_t mode = i->i_mode;
+	if (current->fsuid == i->i_uid)
+		mode >>= 6;
+	else if (in_group_p(i->i_gid))
+		mode >>= 3;
+
+	return (mode & mask) == mask;
+}
+
+static int usercaps_capable(struct task_struct *tsk, int cap)
+{
+	if (usercaps_permitted(caps[cap].inode, MAY_EXEC)) {
+		/* capability granted */
+		tsk->flags |= PF_SUPERPRIV;
+		return 0;
+	}
+
+	/* capability denied */
+	return -EPERM;
+}
+
+static struct security_operations usercaps_security_ops = {
+	.capable = usercaps_capable,
+};
+
+static struct dentry *get_dentry(struct dentry *parent, const char *name)
+{
+	struct qstr qstr;
+	qstr.name = name;
+	qstr.len = strlen(name);
+	qstr.hash = full_name_hash(name, qstr.len);
+	return lookup_hash(&qstr, parent);
+}
+
+static int __init init_capabilities(void)
+{
+	int i, err;
+	kobject_register(&usercaps);
+	for (i = 0; i < sizeof(caps) / sizeof(caps[0]); ++i) {
+		struct dentry *d;
+		sysfs_create_file(&usercaps, &caps[i].attr);
+		d = get_dentry(usercaps.dentry, caps[i].attr.name);
+		caps[i].inode = d->d_inode;
+	}
+
+	err = register_security(&usercaps_security_ops);
+	if (err)
+		kobject_unregister(&usercaps);
+
+	return err;
+}
+
+static void __exit exit_capabilities(void)
+{
+	kobject_unregister(&usercaps);
+	unregister_security(&usercaps_security_ops);
+}
+
+module_init(init_capabilities)
+module_exit(exit_capabilities)
+
+MODULE_AUTHOR("Olaf Dietsche");
+MODULE_DESCRIPTION("User based capabilities");
+MODULE_LICENSE("GPL");

--=-=-=--
