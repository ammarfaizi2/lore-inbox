Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261899AbSIYD0B>; Tue, 24 Sep 2002 23:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261893AbSIYDZf>; Tue, 24 Sep 2002 23:25:35 -0400
Received: from dp.samba.org ([66.70.73.150]:45696 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261899AbSIYDQr>;
	Tue, 24 Sep 2002 23:16:47 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Module rewrite 12/20: Old-style MODULE_PARM() support
Date: Wed, 25 Sep 2002 13:03:03 +1000
Message-Id: <20020925032201.C15842C13D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ I wasn't going to do this, since MODULE_PARM (being un-typechecked)
  is so frequently misused.  But there are so many modules (compared
  with code which uses __setup) that it's probably a worthwhile
  bandaid ]

Name: MODULE_PARM support for older modules
Author: Rusty Russell
Status: Experimental
Depends: Module/param-modules.patch.gz
Depends: Module/param-setup_core.patch.gz

D: This is the backwards compatibility code for MODULE_PARM in case
D: they don't get converted before 2.6.0.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24314-linux-2.5.38/include/linux/module.h .24314-linux-2.5.38.updated/include/linux/module.h
--- .24314-linux-2.5.38/include/linux/module.h	2002-09-25 06:44:12.000000000 +1000
+++ .24314-linux-2.5.38.updated/include/linux/module.h	2002-09-25 06:46:04.000000000 +1000
@@ -14,6 +14,7 @@
 #include <linux/stat.h>
 #include <linux/compiler.h>
 #include <linux/bigref.h>
+#include <linux/stringify.h>
 #include <asm/module.h>
 
 /* Not Yet Implemented */
@@ -241,6 +242,17 @@ static inline int module_put(struct modu
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
@@ -259,11 +271,11 @@ extern spinlock_t modlist_lock;
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24314-linux-2.5.38/init/Config.help .24314-linux-2.5.38.updated/init/Config.help
--- .24314-linux-2.5.38/init/Config.help	2002-09-25 06:44:12.000000000 +1000
+++ .24314-linux-2.5.38.updated/init/Config.help	2002-09-25 06:44:36.000000000 +1000
@@ -96,6 +96,11 @@ CONFIG_MODULE_UNLOAD
   that some modules may not be unloadable anyway).  This makes your
   kernel slightly smaller and simpler.  If unsure, say Y.
 
+CONFIG_OBSOLETE_MODPARM
+  Without this option you will not be able to use module parameters on
+  modules which have not been converted to the new module parameter
+  system yet.  If unsure, say Y.
+
 CONFIG_MODVERSIONS
   Usually, modules have to be recompiled whenever you switch to a new
   kernel.  Saying Y here makes it possible, and safe, to use the
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24314-linux-2.5.38/init/Config.in .24314-linux-2.5.38.updated/init/Config.in
--- .24314-linux-2.5.38/init/Config.in	2002-09-25 06:44:12.000000000 +1000
+++ .24314-linux-2.5.38.updated/init/Config.in	2002-09-25 06:44:36.000000000 +1000
@@ -16,4 +16,5 @@ comment 'Loadable module support'
 bool 'Enable loadable module support' CONFIG_MODULES
 dep_bool '  Kernel module loader' CONFIG_KMOD $CONFIG_MODULES
 dep_bool '  Module unloading' CONFIG_MODULE_UNLOAD $CONFIG_MODULES
+dep_bool '  Obsolete module parameters' CONFIG_OBSOLETE_MODPARM $CONFIG_MODULES
 endmenu
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24314-linux-2.5.38/kernel/module.c .24314-linux-2.5.38.updated/kernel/module.c
--- .24314-linux-2.5.38/kernel/module.c	2002-09-25 06:44:12.000000000 +1000
+++ .24314-linux-2.5.38.updated/kernel/module.c	2002-09-25 06:44:36.000000000 +1000
@@ -23,6 +23,7 @@
 #include <linux/elf.h>
 #include <linux/seq_file.h>
 #include <linux/fcntl.h>
+#include <linux/params.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 #include <asm/pgalloc.h>
@@ -335,6 +336,129 @@ sys_delete_module(const char *name_user,
 }
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
@@ -624,7 +748,7 @@ static struct module *load_module(void *
 	Elf_Shdr *sechdrs;
 	char *secstrings;
 	unsigned int i, symindex, exportindex, strindex, setupindex, exindex,
-		modnameindex;
+		modnameindex, obsparmindex;
 	long arglen;
 	unsigned long common_length;
 	struct sizes sizes, used;
@@ -662,7 +786,7 @@ static struct module *load_module(void *
 
 	/* May not export symbols, or have setup params, so these may
            not exist */
-	exportindex = setupindex = 0;
+	exportindex = setupindex = obsparmindex = 0;
 
 	/* And these should exist, but gcc whinges if we don't init them */
 	symindex = strindex = exindex = modnameindex = 0;
@@ -698,6 +822,11 @@ static struct module *load_module(void *
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
@@ -823,13 +952,23 @@ static struct module *load_module(void *
 	if (err < 0)
 		goto cleanup;
 
-	/* Size of section 0 is 0, so this works well of no params */
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
