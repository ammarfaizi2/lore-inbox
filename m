Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbVH2QMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbVH2QMi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 12:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVH2QMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 12:12:36 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:42677 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751287AbVH2QL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 12:11:59 -0400
Subject: [patch 15/16] Allow KGDB to work well with loaded modules
Date: Mon, 29 Aug 2005 09:11:58 -0700
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org
From: Tom Rini <trini@kernel.crashing.org>
Message-Id: <resend.15.2982005.trini@kernel.crashing.org>
In-Reply-To: <resend.14.2982005.trini@kernel.crashing.org>
References: <resend.14.2982005.trini@kernel.crashing.org> <1.2982005.trini@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This allows for KGDB to better deal with autoloaded modules.  The way this
works, requires a patch to GDB.  This patch can be found at
ftp://source.mvista.com/pub/kgdb/gdb-6.3-kgdb-module-notification.patch

The way this works is that the solib-search-path must contain the location of
any module to be debugged, and then when a module is loaded GDB acts like a
shared library has been loaded now, and can be used that way.

---

 linux-2.6.13-trini/include/linux/module.h |   16 ++++++++
 linux-2.6.13-trini/kernel/module.c        |   56 ++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff -puN include/linux/module.h~module include/linux/module.h
--- linux-2.6.13/include/linux/module.h~module	2005-08-29 09:03:42.000000000 -0700
+++ linux-2.6.13-trini/include/linux/module.h	2005-08-29 09:03:42.000000000 -0700
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
--- linux-2.6.13/kernel/module.c~module	2005-08-29 09:03:42.000000000 -0700
+++ linux-2.6.13-trini/kernel/module.c	2005-08-29 09:03:42.000000000 -0700
@@ -623,6 +623,12 @@ sys_delete_module(const char __user *nam
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
@@ -635,6 +641,11 @@ sys_delete_module(const char __user *nam
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
@@ -1173,6 +1184,11 @@ static void free_module(struct module *m
 	/* Arch-specific cleanup. */
 	module_arch_cleanup(mod);
 
+#ifdef CONFIG_KGDB
+	/* kgdb info */
+	vfree(mod->mod_sections);
+#endif
+
 	/* Module unload stuff */
 	module_unload_free(mod);
 
@@ -1407,6 +1423,31 @@ static void setup_modinfo(struct module 
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
@@ -1775,6 +1816,12 @@ static struct module *load_module(void _
 
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
@@ -1822,6 +1869,11 @@ static struct module *load_module(void _
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
@@ -1909,6 +1961,10 @@ sys_init_module(void __user *umod,
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
