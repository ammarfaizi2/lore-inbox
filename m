Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262856AbVG2VZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbVG2VZS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 17:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbVG2VYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 17:24:09 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:20932 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262856AbVG2VVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 17:21:35 -0400
Subject: [patch 14/15] Allow KGDB to work well with loaded modules
Date: Fri, 29 Jul 2005 14:21:33 -0700
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
       amitkale@linsyssoft.com
From: Tom Rini <trini@kernel.crashing.org>
Message-Id: <resend.14.2972005.trini@kernel.crashing.org>
In-Reply-To: <resend.13.2972005.trini@kernel.crashing.org>
References: <resend.13.2972005.trini@kernel.crashing.org> <1.2972005.trini@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: Amit S. Kale <amitkale@linsyssoft.com>
This allows for KGDB to better deal with autoloaded modules.

---

 linux-2.6.13-rc3-trini/include/linux/module.h |   16 +++++++
 linux-2.6.13-rc3-trini/kernel/module.c        |   56 ++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff -puN include/linux/module.h~module include/linux/module.h
--- linux-2.6.13-rc3/include/linux/module.h~module	2005-07-29 11:55:34.000000000 -0700
+++ linux-2.6.13-rc3-trini/include/linux/module.h	2005-07-29 11:55:34.000000000 -0700
@@ -210,8 +210,17 @@ enum module_state
 	MODULE_STATE_LIVE,
 	MODULE_STATE_COMING,
 	MODULE_STATE_GOING,
+ 	MODULE_STATE_GONE,
 };
 
+#ifdef CONFIG_KGDB
+#define MAX_SECTNAME 31
+struct mod_section {
+       void *address;
+       char name[MAX_SECTNAME + 1];
+};
+#endif
+
 /* Similar stuff for section attributes. */
 #define MODULE_SECT_NAME_LEN 32
 struct module_sect_attr
@@ -239,6 +248,13 @@ struct module
 	/* Unique handle for this module */
 	char name[MODULE_NAME_LEN];
 
+#ifdef CONFIG_KGDB
+	/* keep kgdb info at the begining so that gdb doesn't have a chance to
+	 * miss out any fields */
+	unsigned long num_sections;
+	struct mod_section *mod_sections;
+#endif
+
 	/* Sysfs stuff. */
 	struct module_kobject mkobj;
 	struct module_param_attrs *param_attrs;
diff -puN kernel/module.c~module kernel/module.c
--- linux-2.6.13-rc3/kernel/module.c~module	2005-07-29 11:55:34.000000000 -0700
+++ linux-2.6.13-rc3-trini/kernel/module.c	2005-07-29 11:55:34.000000000 -0700
@@ -617,6 +617,12 @@ sys_delete_module(const char __user *nam
 	if (ret != 0)
 		goto out;
 
+	down(&notify_mutex);
+	notifier_call_chain(&module_notify_list, MODULE_STATE_GOING,
+        			mod);
+	up(&notify_mutex);
+
+
 	/* Never wait if forced. */
 	if (!forced && module_refcount(mod) != 0)
 		wait_for_zero_refcount(mod);
@@ -629,6 +635,11 @@ sys_delete_module(const char __user *nam
 	}
 	free_module(mod);
 
+	down(&notify_mutex);
+	notifier_call_chain(&module_notify_list, MODULE_STATE_GONE,
+			NULL);
+	up(&notify_mutex);
+
  out:
 	up(&module_mutex);
 	return ret;
@@ -1167,6 +1178,11 @@ static void free_module(struct module *m
 	/* Arch-specific cleanup. */
 	module_arch_cleanup(mod);
 
+#ifdef CONFIG_KGDB
+	/* kgdb info */
+	vfree(mod->mod_sections);
+#endif
+
 	/* Module unload stuff */
 	module_unload_free(mod);
 
@@ -1401,6 +1417,31 @@ static void setup_modinfo(struct module 
 }
 #endif
 
+#ifdef CONFIG_KGDB
+int add_modsects (struct module *mod, Elf_Ehdr *hdr, Elf_Shdr *sechdrs, const
+                char *secstrings)
+{
+        int i;
+
+        mod->num_sections = hdr->e_shnum - 1;
+        mod->mod_sections = vmalloc((hdr->e_shnum - 1)*
+		sizeof (struct mod_section));
+
+        if (mod->mod_sections == NULL) {
+                return -ENOMEM;
+        }
+
+        for (i = 1; i < hdr->e_shnum; i++) {
+                mod->mod_sections[i - 1].address = (void *)sechdrs[i].sh_addr;
+                strncpy(mod->mod_sections[i - 1].name, secstrings +
+                                sechdrs[i].sh_name, MAX_SECTNAME);
+                mod->mod_sections[i - 1].name[MAX_SECTNAME] = '\0';
+	}
+
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_KALLSYMS
 int is_exported(const char *name, const struct module *mod)
 {
@@ -1768,6 +1809,12 @@ static struct module *load_module(void _
 
 	add_kallsyms(mod, sechdrs, symindex, strindex, secstrings);
 
+#ifdef CONFIG_KGDB
+        if ((err = add_modsects(mod, hdr, sechdrs, secstrings)) < 0) {
+                goto nomodsectinfo;
+        }
+#endif
+
 	err = module_finalize(hdr, sechdrs, mod);
 	if (err < 0)
 		goto cleanup;
@@ -1815,6 +1862,11 @@ static struct module *load_module(void _
  arch_cleanup:
 	module_arch_cleanup(mod);
  cleanup:
+
+#ifdef CONFIG_KGDB
+nomodsectinfo:
+       vfree(mod->mod_sections);
+#endif
 	module_unload_free(mod);
 	module_free(mod, mod->module_init);
  free_core:
@@ -1902,6 +1954,10 @@ sys_init_module(void __user *umod,
 		/* Init routine failed: abort.  Try to protect us from
                    buggy refcounters. */
 		mod->state = MODULE_STATE_GOING;
+		down(&notify_mutex);
+		notifier_call_chain(&module_notify_list, MODULE_STATE_GOING,
+				mod);
+		up(&notify_mutex);
 		synchronize_sched();
 		if (mod->unsafe)
 			printk(KERN_ERR "%s: module is now stuck!\n",
_
