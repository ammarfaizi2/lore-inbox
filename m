Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262750AbVATRjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbVATRjD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 12:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbVATRgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 12:36:54 -0500
Received: from smtp0.libero.it ([193.70.192.33]:12967 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S262221AbVATReW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 12:34:22 -0500
Message-ID: <41EFBC77.1080006@gmail.com>
Date: Thu, 20 Jan 2005 15:13:11 +0100
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, vamsi_krishna@in.ibm.com, prasanna@in.ibm.com
CC: Nathan Lynch <nathanl@austin.ibm.com>, suparna@in.ibm.com,
       lkml <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] Kprobes /proc entry
References: <41E2AC82.8020909@gmail.com> <20050110181445.GA31209@kroah.com> <1105479077.17592.8.camel@pants.austin.ibm.com> <20050111213400.GB18422@kroah.com> <41E70234.50900@gmail.com> <20050113233446.GA2710@kroah.com> <41EBEE98.7090207@gmail.com> <20050118064401.GA9529@kroah.com>
In-Reply-To: <20050118064401.GA9529@kroah.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Greg KH ha scritto:
> Also, why not use the seqfile interface for this, to prevent overflowing
> the read buffer?
Great idea!

> Am I missing where you allocate the space for the data to be put into?
seq_read does the job now. It manages to allocate PAGE_SIZE bytes.
Assuming function, hook and module names occupy KSYM_NAME_LEN bytes each,
maximum length will be 424 bytes for each kprobe. I don't think it would be
useful to allocate more memory than PAGE_SIZE. Please, let me know your opinion.



- --- ./kernel/kprobes.c	2005-01-19 11:03:03.000000000 +0100
+++ ./kernel/kprobes.c	2005-01-20 15:02:47.000000000 +0100
@@ -33,6 +33,10 @@
 #include <linux/hash.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/debugfs.h>
+#include <linux/kallsyms.h>
+#include <linux/seq_file.h>
 #include <asm/cacheflush.h>
 #include <asm/errno.h>
 #include <asm/kdebug.h>
@@ -45,6 +49,13 @@
 unsigned int kprobe_cpu = NR_CPUS;
 static DEFINE_SPINLOCK(kprobe_lock);

+static char *ktype[] = {
+	"PRE",
+	"POST",
+	"FAULT",
+	"BREAK",
+};
+
 /* Locks kprobe: irqs must be disabled */
 void lock_kprobes(void)
 {
@@ -131,15 +142,92 @@
 	unregister_kprobe(&jp->kp);
 }

+static void kprobes_print(struct seq_file *seq, unsigned long addr,
+			  unsigned long handler, int type)
+{
+	char *module, namebuf[KSYM_NAME_LEN+1];
+	const char *hook, *func;
+	unsigned long off, size;
+
+	func = kallsyms_lookup(addr, &size, &off, &module, namebuf);
+	seq_printf(seq, "%s\t0x%lx(%s+%#lx)\t", ktype[type], addr, func, off);
+	hook = kallsyms_lookup(handler, &size, &off, &module, namebuf);
+	seq_printf(seq, "0x%lx(%s)\t%s\n", handler, hook,
+		   strlen(module) ? module : "[built-in]");
+}
+
+static int kprobes_show(struct seq_file *seq, void *unused)
+{
+	int i;
+	struct kprobe *k;
+	struct hlist_node *node;
+	unsigned long addr, handler;
+		
+	spin_lock(&kprobe_lock);
+	for(i = 0; i < KPROBE_TABLE_SIZE; i++) {
+		hlist_for_each_entry(k, node, &kprobe_table[i], hlist) {
+			if(!k)
+				continue;
+			addr = (unsigned long)k->addr;
+			if(k->pre_handler) {
+				handler = (unsigned long)k->pre_handler;
+				kprobes_print(seq, addr, handler, PRE);
+			}
+			if(k->post_handler) {
+				handler = (unsigned long)k->post_handler;
+				kprobes_print(seq, addr, handler, POST);
+			}
+			if(k->fault_handler) {
+				handler = (unsigned long)k->fault_handler;
+				kprobes_print(seq, addr, handler, FAULT);
+			}
+			if(k->break_handler) {
+				handler = (unsigned long)k->break_handler;
+				kprobes_print(seq, addr, handler, BREAK);
+			}
+		}
+	}
+	spin_unlock(&kprobe_lock);
+	return 0;
+}
+
+static int kprobes_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, kprobes_show, NULL);
+}
+
+static struct file_operations kprobes_fops = {
+	.open = kprobes_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.owner = THIS_MODULE
+};
+
 static int __init init_kprobes(void)
 {
 	int i, err = 0;
+	struct dentry *kprobes_dir, *kprobes_list;

 	/* FIXME allocate the probe table, currently defined statically */
 	/* initialize all list heads */
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++)
 		INIT_HLIST_HEAD(&kprobe_table[i]);

+	kprobes_dir = debugfs_create_dir("kprobes", NULL);
+	if(!kprobes_dir) {
+		printk("kprobes: could not create debugfs entry\n");
+		goto finish;
+	}
+	kprobes_list = debugfs_create_file("list", S_IRUGO, kprobes_dir,
+					   NULL, &kprobes_fops);
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
- --- ./include/linux/kprobes.h	2005-01-03 20:40:51.000000000 +0100
+++ ./include/linux/kprobes.h	2005-01-20 13:59:27.000000000 +0100
@@ -82,6 +82,13 @@
 	kprobe_opcode_t *entry;	/* probe handling code to jump to */
 };

+enum kprobe_type {
+	PRE=0,
+	POST,
+	FAULT,
+	BREAK,
+};
+
 #ifdef CONFIG_KPROBES
 /* Locks kprobe: irq must be disabled */
 void lock_kprobes(void);

Signed-off-by: Luca Falavigna <dktrkranz@gmail.com>



Regards,

					Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQe+8dhZrwl7j21nOAQJDHAf+KOkiM3K7S23ALmOntaobAKykZVzKEB5o
e7vBZuUhADoG+5VzeUybHiFDP22dvEZ06iVn4O70VuL1fcOsrUNyJri2Vefkc8at
Krxxd3Qb0a8903ksx2IzO3d+S+lV30gJie8yHZLrFTp8eCJtSEO8wuXXx0BQtT86
QG1VAxh2hP3ytsbNRNHczeI1yE+PhzdJ2pmJRwTm9tdTWoYznk0QTi/3AUqwvLXE
WCxG5ED8vUzeywBB1jL0u3Zq9z+Q+ul8BzsnPhAN8v7Zeo9R4YfbK2dgfbMpVW+N
UHO9AqYYDIJN62h2j+iQmtrNPmILjUmVx4uQtYkjk0MQytdN9lbhCw==
=paEq
-----END PGP SIGNATURE-----

