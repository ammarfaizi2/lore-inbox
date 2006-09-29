Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161231AbWI2CKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161231AbWI2CKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWI2CKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:10:47 -0400
Received: from xenotime.net ([66.160.160.81]:6541 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751306AbWI2CKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:10:46 -0400
Date: Thu, 28 Sep 2006 19:12:00 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Dave Jones <davej@redhat.com>, devzero@web.de,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: [PATCH] list module taint flags in Oops/panic
Message-Id: <20060928191200.5b76998c.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

When listing loaded modules during an oops or panic, also list each
module's Tainted flags if non-zero (P: Proprietary or F: Forced load only).

If a module is did not taint the kernel, it is just listed like
	usbcore
but if it did taint the kernel, it is listed like
	wizmodem(PF)

Example:
[ 3260.121718] Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP: 
[ 3260.121729]  [<ffffffff8804c099>] :dump_test:proc_dump_test+0x99/0xc8
[ 3260.121742] PGD fe8d067 PUD 264a6067 PMD 0 
[ 3260.121748] Oops: 0002 [1] SMP 
[ 3260.121753] CPU 1 
[ 3260.121756] Modules linked in: dump_test(P) snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device ide_cd generic ohci1394 snd_hda_intel snd_hda_codec snd_pcm snd_timer snd ieee1394 snd_page_alloc piix ide_core arcmsr aic79xx scsi_transport_spi usblp
[ 3260.121785] Pid: 5556, comm: bash Tainted: P      2.6.18-git10 #1

[Alternatively, I can look into listing tainted flags with 'lsmod',
but that won't help in oopsen/panics so much.]

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 include/linux/module.h |    2 ++
 kernel/module.c        |   36 +++++++++++++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 3 deletions(-)

--- linux-2618-g10.orig/include/linux/module.h
+++ linux-2618-g10/include/linux/module.h
@@ -320,6 +320,8 @@ struct module
 	/* Am I GPL-compatible */
 	int license_gplok;
 
+	unsigned int taints;	/* same bits as kernel:tainted */
+
 #ifdef CONFIG_MODULE_UNLOAD
 	/* Reference counts */
 	struct module_ref ref[NR_CPUS];
--- linux-2618-g10.orig/kernel/module.c
+++ linux-2618-g10/kernel/module.c
@@ -851,6 +851,7 @@ static int check_version(Elf_Shdr *sechd
 		printk("%s: no version for \"%s\" found: kernel tainted.\n",
 		       mod->name, symname);
 		add_taint(TAINT_FORCED_MODULE);
+		mod->taints |= TAINT_FORCED_MODULE;
 	}
 	return 1;
 }
@@ -1325,6 +1326,7 @@ static void set_license(struct module *m
 		printk(KERN_WARNING "%s: module license '%s' taints kernel.\n",
 		       mod->name, license);
 		add_taint(TAINT_PROPRIETARY_MODULE);
+		mod->taints |= TAINT_PROPRIETARY_MODULE;
 	}
 }
 
@@ -1604,6 +1606,7 @@ static struct module *load_module(void _
 	/* This is allowed: modprobe --force will invalidate it. */
 	if (!modmagic) {
 		add_taint(TAINT_FORCED_MODULE);
+		mod->taints |= TAINT_FORCED_MODULE;
 		printk(KERN_WARNING "%s: no version magic, tainting kernel.\n",
 		       mod->name);
 	} else if (!same_magic(modmagic, vermagic)) {
@@ -1697,10 +1700,14 @@ static struct module *load_module(void _
 	/* Set up license info based on the info section */
 	set_license(mod, get_modinfo(sechdrs, infoindex, "license"));
 
-	if (strcmp(mod->name, "ndiswrapper") == 0)
+	if (strcmp(mod->name, "ndiswrapper") == 0) {
 		add_taint(TAINT_PROPRIETARY_MODULE);
-	if (strcmp(mod->name, "driverloader") == 0)
+		mod->taints |= TAINT_PROPRIETARY_MODULE;
+	}
+	if (strcmp(mod->name, "driverloader") == 0) {
 		add_taint(TAINT_PROPRIETARY_MODULE);
+		mod->taints |= TAINT_PROPRIETARY_MODULE;
+	}
 
 	/* Set up MODINFO_ATTR fields */
 	setup_modinfo(mod, sechdrs, infoindex);
@@ -1746,6 +1753,7 @@ static struct module *load_module(void _
 		printk(KERN_WARNING "%s: No versions for exported symbols."
 		       " Tainting kernel.\n", mod->name);
 		add_taint(TAINT_FORCED_MODULE);
+		mod->taints |= TAINT_FORCED_MODULE;
 	}
 #endif
 
@@ -2212,6 +2220,28 @@ struct module *module_text_address(unsig
 	return mod;
 }
 
+static char *taint_flags(unsigned int taints)
+{
+	static char buf[8];
+	int bx;
+
+	if (!taints)
+		return "";
+
+	buf[0] = '(';
+	bx = 1;
+	if (taints & TAINT_PROPRIETARY_MODULE)
+		buf [bx++] = 'P';
+	if (taints & TAINT_FORCED_MODULE)
+		buf [bx++] = 'F';
+	/* TAINT_FORCED_RMMOD: could be added */
+	/* TAINT_UNSAFE_SMP, TAINT_MACHINE_CHECK, TAINT_BAD_PAGE
+	 * don't apply to modules */
+	buf[bx] = ')';
+
+	return buf;
+}
+
 /* Don't grab lock, we're oopsing. */
 void print_modules(void)
 {
@@ -2219,7 +2249,7 @@ void print_modules(void)
 
 	printk("Modules linked in:");
 	list_for_each_entry(mod, &modules, list)
-		printk(" %s", mod->name);
+		printk(" %s%s", mod->name, taint_flags(mod->taints));
 	printk("\n");
 }
 


---
