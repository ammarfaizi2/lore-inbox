Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265633AbSKEApt>; Mon, 4 Nov 2002 19:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265630AbSKEApt>; Mon, 4 Nov 2002 19:45:49 -0500
Received: from dp.samba.org ([66.70.73.150]:26047 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264756AbSKEApi>;
	Mon, 4 Nov 2002 19:45:38 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] Module loader against 2.5.46: 8/9 
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
In-reply-to: Your message of "Tue, 05 Nov 2002 11:21:48 +1100."
             <20021105002215.8EEE22C0F8@lists.samba.org> 
Date: Tue, 05 Nov 2002 11:43:42 +1100
Message-Id: <20021105005213.D57732C069@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wedge to support old-style "MODULE_PARM" decls, by turning them into
the equivalent PARAM table at load time.

With this, module parameters work again on all modules.
Rusty.

Name: MODULE_PARM support for older modules
Author: Rusty Russell
Status: Experimental
Depends: Module/param-modules.patch.gz
Depends: Module/forceunload.patch.gz

D: This is the backwards compatibility code for MODULE_PARM.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17025-linux-2.5.45/include/linux/module.h .17025-linux-2.5.45.updated/include/linux/module.h
--- .17025-linux-2.5.45/include/linux/module.h	2002-11-01 12:03:21.000000000 +1100
+++ .17025-linux-2.5.45.updated/include/linux/module.h	2002-11-01 12:03:57.000000000 +1100
@@ -15,6 +15,7 @@
 #include <linux/compiler.h>
 #include <linux/cache.h>
 #include <linux/kmod.h>
+#include <linux/stringify.h>
 #include <asm/module.h>
 #include <asm/uaccess.h> /* For struct exception_table_entry */
 
@@ -274,6 +275,17 @@ extern spinlock_t modlist_lock;
 #define __MOD_DEC_USE_COUNT(mod) module_put(mod)
 #define SET_MODULE_OWNER(dev) ((dev)->owner = THIS_MODULE)
 
+struct obsolete_modparm { char name[64]; char type[64]; void *addr; };
+#ifdef MODULE
+/* DEPRECATED: Do not use. */
+#define MODULE_PARM(var,type)						    \
+struct obsolete_modparm __parm_##var __attribute__((section(".obsparm"))) = \
+{ __stringify(var), type };
+
+#else
+#define MODULE_PARM(var,type)
+#endif
+
 /* People do this inside their init routines, when the module isn't
    "live" yet.  They should no longer be doing that, but
    meanwhile... */
@@ -286,11 +298,11 @@ extern spinlock_t modlist_lock;
 #endif
 #define MOD_DEC_USE_COUNT module_put(THIS_MODULE)
 #define try_inc_mod_count(mod) try_module_get(mod)
-#define MODULE_PARM(parm,string)
 #define EXPORT_NO_SYMBOLS
 extern int module_dummy_usage;
 #define GET_USE_COUNT(module) (module_dummy_usage)
 #define MOD_IN_USE 0
+#define __MODULE_STRING(x) __stringify(x)
 #define __mod_between(a_start, a_len, b_start, b_len)		\
 (((a_start) >= (b_start) && (a_start) <= (b_start)+(b_len))	\
  || ((a_start)+(a_len) >= (b_start)				\
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17025-linux-2.5.45/init/Kconfig .17025-linux-2.5.45.updated/init/Kconfig
--- .17025-linux-2.5.45/init/Kconfig	2002-11-01 12:03:24.000000000 +1100
+++ .17025-linux-2.5.45.updated/init/Kconfig	2002-11-01 12:06:00.000000000 +1100
@@ -135,6 +135,14 @@ config MODULE_FORCE_UNLOAD
 	  rmmod).  This is mainly for kernel developers and desparate users.
 	  If unsure, say N.
 
+config OBSOLETE_MODPARM
+	bool
+	default y
+	help
+	  Without this option you will not be able to use module parameters on
+	  modules which have not been converted to the new module parameter
+	  system yet.  If unsure, say Y.
+
 config KMOD
 	bool "Kernel module loader"
 	depends on MODULES
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17025-linux-2.5.45/kernel/module.c .17025-linux-2.5.45.updated/kernel/module.c
--- .17025-linux-2.5.45/kernel/module.c	2002-11-01 12:03:24.000000000 +1100
+++ .17025-linux-2.5.45.updated/kernel/module.c	2002-11-01 12:03:57.000000000 +1100
@@ -500,6 +500,129 @@ sys_delete_module(const char *name_user,
 
 #endif /* CONFIG_MODULE_UNLOAD */
 
+#ifdef CONFIG_OBSOLETE_MODPARM
+static int param_set_byte(const char *val, struct kernel_param *kp)  
+{
+	char *endp;
+	long l;
+
+	if (!val) return -EINVAL;
+	l = simple_strtol(val, &endp, 0);
+	if (endp == val || *endp || ((char)l != l))
+		return -EINVAL;
+	*((char *)kp->arg) = l;
+	return 0;
+}
+
+static int param_string(const char *name, const char *val,
+			unsigned int min, unsigned int max,
+			char *dest)
+{
+	if (strlen(val) < min || strlen(val) > max) {
+		printk(KERN_ERR
+		       "Parameter %s length must be %u-%u characters\n",
+		       name, min, max);
+		return -EINVAL;
+	}
+	strcpy(dest, val);
+	return 0;
+}
+
+extern int set_obsolete(const char *val, struct kernel_param *kp)
+{
+	unsigned int min, max;
+	char *p, *endp;
+	struct obsolete_modparm *obsparm = kp->arg;
+
+	if (!val) {
+		printk(KERN_ERR "Parameter %s needs an argument\n", kp->name);
+		return -EINVAL;
+	}
+
+	/* type is: [min[-max]]{b,h,i,l,s} */
+	p = obsparm->type;
+	min = simple_strtol(p, &endp, 10);
+	if (endp == obsparm->type)
+		min = max = 1;
+	else if (*endp == '-') {
+		p = endp+1;
+		max = simple_strtol(p, &endp, 10);
+	} else
+		max = min;
+	switch (*endp) {
+	case 'b':
+		return param_array(kp->name, val, min, max, obsparm->addr,
+				   1, param_set_byte);
+	case 'h':
+		return param_array(kp->name, val, min, max, obsparm->addr,
+				   sizeof(short), param_set_short);
+	case 'i':
+		return param_array(kp->name, val, min, max, obsparm->addr,
+				   sizeof(int), param_set_int);
+	case 'l':
+		return param_array(kp->name, val, min, max, obsparm->addr,
+				   sizeof(long), param_set_long);
+	case 's':
+		return param_string(kp->name, val, min, max, obsparm->addr);
+	}
+	printk(KERN_ERR "Unknown obsolete parameter type %s\n", obsparm->type);
+	return -EINVAL;
+}
+
+static int obsolete_params(const char *name,
+			   char *args,
+			   struct obsolete_modparm obsparm[],
+			   unsigned int num,
+			   Elf_Shdr *sechdrs,
+			   unsigned int symindex,
+			   const char *strtab)
+{
+	struct kernel_param *kp;
+	unsigned int i;
+	int ret;
+
+	kp = kmalloc(sizeof(kp[0]) * num, GFP_KERNEL);
+	if (!kp)
+		return -ENOMEM;
+
+	for (i = 0; i < num; i++) {
+		kp[i].name = obsparm[i].name;
+		kp[i].perm = 000;
+		kp[i].set = set_obsolete;
+		kp[i].get = NULL;
+		obsparm[i].addr
+			= (void *)find_local_symbol(sechdrs, symindex, strtab,
+						    obsparm[i].name);
+		if (!obsparm[i].addr) {
+			printk("%s: falsely claims to have parameter %s\n",
+			       name, obsparm[i].name);
+			ret = -EINVAL;
+			goto out;
+		}
+		kp[i].arg = &obsparm[i];
+	}
+
+	ret = parse_args(name, args, kp, num, NULL);
+ out:
+	kfree(kp);
+	return ret;
+}
+#else
+static int obsolete_params(const char *name,
+			   char *args,
+			   struct obsolete_modparm obsparm[],
+			   unsigned int num,
+			   Elf_Shdr *sechdrs,
+			   unsigned int symindex,
+			   const char *strtab)
+{
+	if (num != 0)
+		printk(KERN_WARNING "%s: Ignoring obsolete parameters\n",
+		       name);
+	return 0;
+}
+#endif /* CONFIG_OBSOLETE_MODPARM */
+
 /* Find an symbol for this module (ie. resolve internals first).
    It we find one, record usage.  Must be holding module_mutex. */
 unsigned long find_symbol_internal(Elf_Shdr *sechdrs,
@@ -811,7 +934,7 @@ static struct module *load_module(void *
 	Elf_Shdr *sechdrs;
 	char *secstrings;
 	unsigned int i, symindex, exportindex, strindex, setupindex, exindex,
-		modnameindex;
+		modnameindex, obsparmindex;
 	long arglen;
 	unsigned long common_length;
 	struct sizes sizes, used;
@@ -849,7 +972,7 @@ static struct module *load_module(void *
 
 	/* May not export symbols, or have setup params, so these may
            not exist */
-	exportindex = setupindex = 0;
+	exportindex = setupindex = obsparmindex = 0;
 
 	/* And these should exist, but gcc whinges if we don't init them */
 	symindex = strindex = exindex = modnameindex = 0;
@@ -885,6 +1008,11 @@ static struct module *load_module(void *
 			/* Exception table */
 			DEBUGP("Exception table found in section %u\n", i);
 			exindex = i;
+		} else if (strcmp(secstrings+sechdrs[i].sh_name, ".obsparm")
+			   == 0) {
+			/* Obsolete MODULE_PARM() table */
+			DEBUGP("Obsolete param found in section %u\n", i);
+			obsparmindex = i;
 		}
 #ifndef CONFIG_MODULE_UNLOAD
 		/* Don't load .exit sections */
@@ -1002,13 +1130,23 @@ static struct module *load_module(void *
 	if (err < 0)
 		goto cleanup;
 
-	/* Size of section 0 is 0, so this works well if no params */
-	err = parse_args(mod->args,
-			 (struct kernel_param *)
-			 sechdrs[setupindex].sh_offset,
-			 sechdrs[setupindex].sh_size
-			 / sizeof(struct kernel_param),
-			 NULL);
+	if (obsparmindex) {
+		err = obsolete_params(mod->name, mod->args,
+				      (struct obsolete_modparm *)
+				      sechdrs[obsparmindex].sh_offset,
+				      sechdrs[obsparmindex].sh_size
+				      / sizeof(struct obsolete_modparm),
+				      sechdrs, symindex,
+				      (char *)sechdrs[strindex].sh_offset);
+	} else {
+		/* Size of section 0 is 0, so this works well if no params */
+		err = parse_args(mod->name, mod->args,
+				 (struct kernel_param *)
+				 sechdrs[setupindex].sh_offset,
+				 sechdrs[setupindex].sh_size
+				 / sizeof(struct kernel_param),
+				 NULL);
+	}
 	if (err < 0)
 		goto cleanup;
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
