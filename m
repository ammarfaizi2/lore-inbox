Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVAMX3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVAMX3i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 18:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbVAMX1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 18:27:37 -0500
Received: from smtp1.libero.it ([193.70.192.51]:61341 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S261778AbVAMXWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 18:22:25 -0500
Message-ID: <41E70234.50900@gmail.com>
Date: Fri, 14 Jan 2005 00:20:20 +0100
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: vamsi_krishna@in.ibm.com, prasanna@in.ibm.com
CC: Greg KH <greg@kroah.com>, Nathan Lynch <nathanl@austin.ibm.com>,
       suparna@in.ibm.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Kprobes /proc entry
References: <41E2AC82.8020909@gmail.com> <20050110181445.GA31209@kroah.com> <1105479077.17592.8.camel@pants.austin.ibm.com> <20050111213400.GB18422@kroah.com>
In-Reply-To: <20050111213400.GB18422@kroah.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Voilà! Here is kprobes debug patch via debugfs.



- --- ./kernel/kprobes.c	2005-01-13 20:41:11.000000000 +0100
+++ ./kernel/kprobes.c	2005-01-13 20:39:27.000000000 +0100
@@ -33,6 +33,9 @@
 #include <linux/hash.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/debugfs.h>
+#include <linux/kallsyms.h>
 #include <asm/cacheflush.h>
 #include <asm/errno.h>
 #include <asm/kdebug.h>
@@ -131,6 +134,96 @@
 	unregister_kprobe(&jp->kp);
 }

+#ifdef CONFIG_DEBUG_FS
+int kprobes_open(struct inode *inode, struct file *file)
+{
+	try_module_get(THIS_MODULE);
+	return 0;
+}
+
+int kprobes_release(struct inode *inode, struct file *file)
+{
+	module_put(THIS_MODULE);
+	return 0;
+}
+
+void kprobes_list_info(struct kprobe *k, char *p)
+{
+	ssize_t len = 0;
+	char *module, namebuf[KSYM_NAME_LEN+1];
+	const char *hook, *func;
+	unsigned long off, size, handler, addr = (unsigned long)k->addr;
+
+	if(k->pre_handler) {
+		handler = (unsigned long)k->pre_handler;
+		func = kallsyms_lookup(addr, &size, &off, &module, namebuf);
+		len += sprintf(p + len, "PRE\t0x%lx(%s+%#lx)\t",
+			       addr, func, off);
+		hook = kallsyms_lookup(handler, &size, &off, &module, namebuf);
+		len += sprintf(p + len, "0x%lx(%s)\t%s\n", handler, hook,
+			       strlen(module) ? module : "[built-in]");
+	}
+	if(k->post_handler) {
+		handler = (unsigned long)k->post_handler;
+		func = kallsyms_lookup(addr, &size, &off, &module, namebuf);
+		len += sprintf(p + len, "POST\t0x%lx(%s+%#lx)\t",
+			       addr, func, off);
+		hook = kallsyms_lookup(handler, &size, &off, &module, namebuf);
+		len += sprintf(p + len, "0x%lx(%s)\t%s\n", handler, hook,
+			       strlen(module) ? module : "[built-in]");
+	}
+	if(k->fault_handler) {
+		handler = (unsigned long)k->fault_handler;
+		func = kallsyms_lookup(addr, &size, &off, &module, namebuf);
+		len += sprintf(p + len, "FAULT\t0x%lx(%s+%#lx)\t",
+			       addr, func, off);
+		hook = kallsyms_lookup(handler, &size, &off, &module, namebuf);
+		len += sprintf(p + len, "0x%lx(%s)\t%s\n", handler, hook,
+			       strlen(module) ? module : "[built-in]");
+	}
+	if(k->break_handler) {
+		handler = (unsigned long)k->break_handler;
+		func = kallsyms_lookup(addr, &size, &off, &module, namebuf);
+		len += sprintf(p + len, "BREAK\t0x%lx(%s+%#lx)\t",
+			       addr, func, off);
+		hook = kallsyms_lookup(handler, &size, &off, &module, namebuf);
+		len += sprintf(p + len, "0x%lx(%s)\t%s\n", handler, hook,
+			       strlen(module) ? module : "[built-in]");
+	}
+}
+
+ssize_t kprobes_read(struct file *file, char __user *buf,
+			 size_t size, loff_t *off)
+{
+	int i;
+	char *data = "";
+	ssize_t len = 0;
+	struct hlist_head *head;
+	struct hlist_node *node;
+	struct kprobe *k;
+	
+	spin_lock(&kprobe_lock);
+	for(i = 0; i < KPROBE_TABLE_SIZE; i++) {
+		head = &kprobe_table[i];
+		hlist_for_each(node, head) {
+			if((k = hlist_entry(node, struct kprobe, hlist))) {
+				kprobes_list_info(k, data + len);
+				len = strlen(data);
+			}
+		}
+	}
+	spin_unlock(&kprobe_lock);
+	return simple_read_from_buffer(buf, size, off, data, len);
+}
+
+struct dentry *kprobes_dir, *kprobes_list;
+struct file_operations kprobes_fops = {
+	.open = kprobes_open,
+	.read = kprobes_read,
+	.release = kprobes_release
+	};
+#endif
+
 static int __init init_kprobes(void)
 {
 	int i, err = 0;
@@ -140,6 +233,16 @@
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++)
 		INIT_HLIST_HEAD(&kprobe_table[i]);

+#ifdef CONFIG_DEBUG_FS
+	if(!(kprobes_dir = debugfs_create_dir("kprobes", NULL)))
+		return -ENODEV;
+	if(!(kprobes_list = debugfs_create_file("list", S_IRUGO, kprobes_dir,
+					  	NULL, &kprobes_fops))) {
+		debugfs_remove(kprobes_dir);
+		return -ENODEV;
+	}
+#endif
+
 	err = register_die_notifier(&kprobe_exceptions_nb);
 	return err;

Signed-off-by: Luca Falavigna <dktrkranz@gmail.com>



Regards,

					Luca

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQecCMxZrwl7j21nOAQKEawf/csjjWfFF/UlsN5qZQ3QyYJ1lTSSvuKnh
5ttGdB0hI3Qra+CIR6A/2qhUVomNTV4fcf80R6pMqOmUY61FmYFx2Mv6cRs4fqK3
BoLlOYYAKv3x5dgePdmI3n5ENss3UUYfTG5zd5ng3Qo2IqjwI/L2CR/CM1peXRV1
EXjhTmwU78c+0PLYHPwglDxawfkDO62AyMGqcytg0wFnDDfhjbIHrt48ynl6EIwL
oPvxQteQYSp15hRxAQbMRDz/1mzlhNMXZX6dKE15XrE31mk5P/iEaNadInv5r4DU
1ZFEpV0nKuJkmxSA4nVJHtLO7R+lqzkmFBmTBn9HT6Mh0U76aryixA==
=zQ7Z
-----END PGP SIGNATURE-----
