Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262386AbVAJSBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbVAJSBT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVAJRyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:54:37 -0500
Received: from smtp1.libero.it ([193.70.192.51]:44267 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S262379AbVAJRje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:39:34 -0500
Message-ID: <41E2AC82.8020909@gmail.com>
Date: Mon, 10 Jan 2005 17:25:38 +0100
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: vamsi_krishna@in.ibm.com, prasanna@in.ibm.com
CC: suparna@in.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Kprobes /proc entry
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This simple patch adds a new file in /proc, listing every kprobe which
is currently registered in the kernel. This patch is checked against
kernel 2.6.10



- --- ./kernel/kprobes.c	2005-01-03 20:40:52.000000000 +0100
+++ ./kernel/kprobes.c	2005-01-10 15:19:17.000000000 +0100
@@ -32,6 +32,7 @@
 #include <linux/spinlock.h>
 #include <linux/hash.h>
 #include <linux/init.h>
+#include <linux/kallsyms.h>
 #include <linux/module.h>
 #include <asm/cacheflush.h>
 #include <asm/errno.h>
@@ -131,6 +132,70 @@
 	unregister_kprobe(&jp->kp);
 }

+void get_kprobes_info(struct kprobe *k, char *p)
+{
+	int len = 0;
+	char *module, namebuf[KSYM_NAME_LEN+1];
+	const char *hook, *func;
+	unsigned long off, size, handler, addr = (unsigned long)k->addr;
+
+	if(k->pre_handler) {
+		handler = (unsigned long)k->pre_handler;
+		func = kallsyms_lookup(addr, &size, &off, &module, namebuf);
+		len += sprintf(p + len, "PRE 0x%lx(%s+%#lx)\t",
+			       addr, func, off);
+		hook = kallsyms_lookup(handler, &size, &off, &module, namebuf);
+		len += sprintf(p + len, "0x%lx(%s)\t%s\n", handler, hook,
+			       strlen(module) ? module : "[built-in]");
+	}
+	if(k->post_handler) {
+		handler = (unsigned long)k->pre_handler;
+		func = kallsyms_lookup(addr, &size, &off, &module, namebuf);
+		hook = kallsyms_lookup(handler, &size, &off, &module, namebuf);
+		len += sprintf(p + len, "POST\t0x%lx(%s)\t0x%lx(%s)\t%s\n",
+			       handler, hook, addr, func,
+			       strlen(module) ? module : "[built-in]");
+	}
+	if(k->fault_handler) {
+		handler = (unsigned long)k->pre_handler;
+		func = kallsyms_lookup(addr, &size, &off, &module, namebuf);
+		hook = kallsyms_lookup(handler, &size, &off, &module, namebuf);
+		len += sprintf(p + len, "FAULT\t0x%lx(%s)\t0x%lx(%s)\t%s\n",
+			       handler, hook, addr, func,
+			       strlen(module) ? module : "[built-in]");
+	}
+	if(k->break_handler) {
+		handler = (unsigned long)k->pre_handler;
+		func = kallsyms_lookup(addr, &size, &off, &module, namebuf);
+		hook = kallsyms_lookup(handler, &size, &off, &module, namebuf);
+		len += sprintf(p + len, "BREAK\t0x%lx(%s)\t0x%lx(%s)\t%s\n",
+			       handler, hook, addr, func,
+			       strlen(module) ? module : "[built-in]");
+	}
+}
+
+int get_kprobes_list(char *page)
+{
+
+	int i, len = 0;
+	struct hlist_head *head;
+	struct hlist_node *node;
+	struct kprobe *k;
+
+	spin_lock(&kprobe_lock);
+	for(i = 0; i < KPROBE_TABLE_SIZE; i++) {
+		head = &kprobe_table[i];
+		hlist_for_each(node, head) {
+			if((k = hlist_entry(node, struct kprobe, hlist))) {
+				get_kprobes_info(k, page + len);
+				len = strlen(page);
+			}
+		}
+	}
+	spin_unlock(&kprobe_lock);
+	return len;
+}
+
 static int __init init_kprobes(void)
 {
 	int i, err = 0;
- --- ./fs/proc/proc_misc.c	2005-01-03 20:40:44.000000000 +0100
+++ ./fs/proc/proc_misc.c	2005-01-09 23:50:32.000000000 +0100
@@ -66,6 +66,7 @@
 extern int get_exec_domain_list(char *);
 extern int get_dma_list(char *);
 extern int get_locks_status (char *, char **, off_t, int);
+extern int get_kprobes_list(char *);

 static int proc_calc_metrics(char *page, char **start, off_t off,
 				 int count, int *eof, int len)
@@ -547,6 +548,15 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }

+#ifdef CONFIG_KPROBES
+static int kprobes_read_proc(char *page, char **start, off_t off,
+			     int count, int *eof, void *data)
+{
+	int len = get_kprobes_list(page);
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+#endif
+
 #ifdef CONFIG_MAGIC_SYSRQ
 /*
  * writing 'C' to /proc/sysrq-trigger is like sysrq-C
@@ -601,6 +611,9 @@
 		{"cmdline",	cmdline_read_proc},
 		{"locks",	locks_read_proc},
 		{"execdomains",	execdomains_read_proc},
+#ifdef CONFIG_KPROBES
+		{"kprobes", kprobes_read_proc},
+#endif
 		{NULL,}
 	};
 	for (p = simple_ones; p->name; p++)

Signed-off-by: Luca Falavigna <dktrkranz@gmail.com>



Regards,

					Luca

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQeKsghZrwl7j21nOAQLBsAf9GV9qIV00kCLuGRFckh5HEmRypl2WylZm
kCKcpttG1qaDmeD1Rxee6nDMT3zuOlooHjUJhMFXAA1u63oEp0j9BzjuaO+IF/PQ
WloKCDquY/nmHMj/C37b9xmdXAGrEpozXcRo1JLd/6SRDNybeCxZDaO5IjK0y5bH
NvWvdF86RokC2QujFyrX228M2wNbIKt9yFCpaWtOT723tezDdp2DLB/h3uTiY84i
pCLuG0xV8ccakSmJRAkC7qGy8pqJTAt7mY8JVdTxJN5XiDUorHEU/FaUNWLHD4xY
NheUG+AWtTy1ulrKEK3T7uK0UEmgpzSokafasFLqvtbtQX1+tdRe1Q==
=Tnde
-----END PGP SIGNATURE-----

