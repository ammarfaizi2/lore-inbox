Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbVAQSKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbVAQSKX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 13:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbVAQSJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 13:09:29 -0500
Received: from smtp3.libero.it ([193.70.192.127]:23964 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id S262497AbVAQR52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 12:57:28 -0500
Message-ID: <41EBEE98.7090207@gmail.com>
Date: Mon, 17 Jan 2005 17:58:00 +0100
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, vamsi_krishna@in.ibm.com, prasanna@in.ibm.com
CC: Nathan Lynch <nathanl@austin.ibm.com>, suparna@in.ibm.com,
       lkml <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] Kprobes /proc entry
References: <41E2AC82.8020909@gmail.com> <20050110181445.GA31209@kroah.com> <1105479077.17592.8.camel@pants.austin.ibm.com> <20050111213400.GB18422@kroah.com> <41E70234.50900@gmail.com> <20050113233446.GA2710@kroah.com>
In-Reply-To: <20050113233446.GA2710@kroah.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here is a modified version of kprobes patch fixing some issues reported by Greg.

Greg KH ha scritto:
>>+{
>>+	try_module_get(THIS_MODULE);
> 
> 
> Check the return value of this call?
I removed try_module_get() and module_put() because of Stephen Hemminger's mail:
"The module ref counting should be done by the VFS layer not the interface."
Thank you for this hint :)

>>+	if(!(kprobes_dir = debugfs_create_dir("kprobes", NULL)))
>>+		return -ENODEV;
>>+	if(!(kprobes_list = debugfs_create_file("list", S_IRUGO, kprobes_dir,
>>+					  	NULL, &kprobes_fops))) {
>>+		debugfs_remove(kprobes_dir);
>>+		return -ENODEV;
>>+	}
> 
> 
> You never delete this file or directory on module unload, do you?
kprobes are a built-in feature, I think there's no way to handle this.
Please, tell me if I am wrong.



- --- ./kernel/kprobes.c	2005-01-17 17:56:11.000000000 +0100
+++ ./kernel/kprobes.c	2005-01-17 17:46:04.000000000 +0100
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
@@ -131,6 +134,88 @@
 	unregister_kprobe(&jp->kp);
 }

+static int kprobes_open(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static int kprobes_release(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+void kprobes_list_info(struct kprobe *k, char *buf)
+{
+	char *module, namebuf[KSYM_NAME_LEN+1];
+	const char *hook, *func;
+	unsigned long off, size, handler, addr = (unsigned long)k->addr;
+
+	if(k->pre_handler) {
+		handler = (unsigned long)k->pre_handler;
+		func = kallsyms_lookup(addr, &size, &off, &module, namebuf);
+		buf += sprintf(buf, "PRE\t0x%lx(%s+%#lx)\t", addr, func, off);
+		hook = kallsyms_lookup(handler, &size, &off, &module, namebuf);
+		buf += sprintf(buf, "0x%lx(%s)\t%s\n", handler, hook,
+			       strlen(module) ? module : "[built-in]");
+	}
+	if(k->post_handler) {
+		handler = (unsigned long)k->post_handler;
+		func = kallsyms_lookup(addr, &size, &off, &module, namebuf);
+		buf += sprintf(buf, "POST\t0x%lx(%s+%#lx)\t", addr, func, off);
+		hook = kallsyms_lookup(handler, &size, &off, &module, namebuf);
+		buf += sprintf(buf, "0x%lx(%s)\t%s\n", handler, hook,
+			       strlen(module) ? module : "[built-in]");
+	}
+	if(k->fault_handler) {
+		handler = (unsigned long)k->fault_handler;
+		func = kallsyms_lookup(addr, &size, &off, &module, namebuf);
+		buf += sprintf(buf, "FAULT\t0x%lx(%s+%#lx)\t",
+			       addr, func, off);
+		hook = kallsyms_lookup(handler, &size, &off, &module, namebuf);
+		buf += sprintf(buf, "0x%lx(%s)\t%s\n", handler, hook,
+			       strlen(module) ? module : "[built-in]");
+	}
+	if(k->break_handler) {
+		handler = (unsigned long)k->break_handler;
+		func = kallsyms_lookup(addr, &size, &off, &module, namebuf);
+		buf += sprintf(buf, "BREAK\t0x%lx(%s+%#lx)\t",
+			       addr, func, off);
+		hook = kallsyms_lookup(handler, &size, &off, &module, namebuf);
+		buf += sprintf(buf, "0x%lx(%s)\t%s\n", handler, hook,
+			       strlen(module) ? module : "[built-in]");
+	}
+}
+
+static ssize_t kprobes_read(struct file *file, char __user *buf,
+			 size_t size, loff_t *off)
+{
+	int i;
+	char *data = "";
+	ssize_t len = 0;
+	struct hlist_node *node;
+	struct kprobe *k;
+	
+	spin_lock(&kprobe_lock);
+	for(i = 0; i < KPROBE_TABLE_SIZE; i++) {
+		hlist_for_each_entry(k, node, &kprobe_table[i], hlist) {
+			if(k) {
+				kprobes_list_info(k, data + len);
+				len += strlen(data);
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
+	.release = kprobes_release,
+	.owner = THIS_MODULE
+};
+
 static int __init init_kprobes(void)
 {
 	int i, err = 0;
@@ -140,6 +225,20 @@
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++)
 		INIT_HLIST_HEAD(&kprobe_table[i]);

+	kprobes_dir = debugfs_create_dir("kprobes", NULL);
+	if(!kprobes_dir) {
+		printk("kprobes: could not create debugfs entry\n");
+		goto finish;
+	}
+	kprobes_list = debugfs_create_file("list", S_IRUGO, kprobes_dir,
+					  	NULL, &kprobes_fops);
+	if(!kprobes_list) {		
+		printk("kprobes: could not create debugfs entry\n");
+		debugfs_remove(kprobes_dir);
+		goto finish;
+	}
+
+finish:
 	err = register_die_notifier(&kprobe_exceptions_nb);
 	return err;
 }

Signed-off-by: Luca Falavigna <dktrkranz@gmail.com>



Regards,

					Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQevumBZrwl7j21nOAQL46Af/apeTfTYuXvDdhWFsqWI7QBqpmYkj9+iu
S4A2EKsBUUlnlcZrpL08lqwMup2H8jt3zjmmCcPn2Oplr054aHIDIQveu5XMA+jJ
9w5EdDf3SZcPF+HEPmN9EV5n0BakVwGERM/8615jH804Y5IJtB8b79XMmU8wLI8x
M4JGa+kwboD260IbWRuxfRUVqJMMVL5Mibin0RFN4WCbJYfxPhDiCsH2HGNgrw1Y
m0uyuaUt4pynAVPpHJPAKPylwY/A9MC7/Zdfa2IIO118bNxKaFTMg0z+AN66jUwz
kRUzxoUfDv3kIhzkHwvyPX9hjsoSPof/xQZwxclz8p6Yz00KICdZRw==
=Ka0n
-----END PGP SIGNATURE-----

