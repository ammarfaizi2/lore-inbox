Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265197AbTADFzz>; Sat, 4 Jan 2003 00:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265236AbTADFzz>; Sat, 4 Jan 2003 00:55:55 -0500
Received: from dp.samba.org ([66.70.73.150]:50899 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265197AbTADFzv>;
	Sat, 4 Jan 2003 00:55:51 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Wang, Stanley" <stanley.wang@intel.com>
Cc: "Zhuang, Louis" <louis.zhuang@intel.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: Kernel module version support. 
In-reply-to: Your message of "Fri, 03 Jan 2003 16:36:29 +0800."
             <957BD1C2BF3CD411B6C500A0C944CA2601F11712@pdsmsx32.pd.intel.com> 
Date: Sat, 04 Jan 2003 16:06:18 +1100
Message-Id: <20030104060424.712BE2C39C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <957BD1C2BF3CD411B6C500A0C944CA2601F11712@pdsmsx32.pd.intel.com> you
> I agree with you. It's a more elegant way:)
> But we couldn't get the module's base address from /proc/modules.=20
> And could you print "mod->core" in /proc/modules?(Just like the =
> following
> patch)

You need to following patch first: the current /proc/modules is not
extensible, so adding a field breaks things.  This changes the
/proc/modules format, and then your patch is as I planned.

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: /proc/modules rework
Author: Rusty Russell
Status: Tested on 2.5.52

D: This changes the dependency list in /proc/modules to be one field,
D: rather than a space-separated set of dependencies, and makes sure
D: the contents are there even if CONFIG_MODULE_UNLOAD is off.
D:
D: This allows us to append fields (eg. the module address for
D: oprofile, and the module status) without breaking userspace.
D: module-init-tools already handles this format (which you can detect
D: by the presence of "-" or "," in the fourth field).

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17749-linux-2.5-bk/kernel/module.c .17749-linux-2.5-bk.updated/kernel/module.c
--- .17749-linux-2.5-bk/kernel/module.c	2003-01-02 14:48:01.000000000 +1100
+++ .17749-linux-2.5-bk.updated/kernel/module.c	2003-01-03 19:12:01.000000000 +1100
@@ -481,19 +481,29 @@ sys_delete_module(const char *name_user,
 static void print_unload_info(struct seq_file *m, struct module *mod)
 {
 	struct module_use *use;
+	int printed_something = 0;
 
-	seq_printf(m, " %u", module_refcount(mod));
+	seq_printf(m, " %u ", module_refcount(mod));
 
-	list_for_each_entry(use, &mod->modules_which_use_me, list)
-		seq_printf(m, " %s", use->module_which_uses->name);
+	/* Always include a trailing , so userspace can differentiate
+           between this and the old multi-field proc format. */
+	list_for_each_entry(use, &mod->modules_which_use_me, list) {
+		printed_something = 1;
+		seq_printf(m, "%s,", use->module_which_uses->name);
+	}
 
-	if (mod->unsafe)
-		seq_printf(m, " [unsafe]");
+	if (mod->unsafe) {
+		printed_something = 1;
+		seq_printf(m, "[unsafe],");
+	}
 
 	if (mod->init != init_module && mod->exit == cleanup_module)
-		seq_printf(m, " [permanent]");
+		printed_something = 1;
+		seq_printf(m, "[permanent],");
+	}
 
-	seq_printf(m, "\n");
+	if (!printed_something)
+		seq_printf(m, "-");
 }
 
 void __symbol_put(const char *symbol)
@@ -534,7 +544,8 @@ EXPORT_SYMBOL_GPL(symbol_put_addr);
 #else /* !CONFIG_MODULE_UNLOAD */
 static void print_unload_info(struct seq_file *m, struct module *mod)
 {
-	seq_printf(m, "\n");
+	/* We don't know the usage count, or what modules are using. */
+	seq_printf(m, " - -");
 }
 
 static inline void module_unload_free(struct module *mod)
@@ -1370,6 +1381,7 @@ static int m_show(struct seq_file *m, vo
 	seq_printf(m, "%s %lu",
 		   mod->name, mod->init_size + mod->core_size);
 	print_unload_info(m, mod);
+	seq_printf(m, "\n");
 	return 0;
 }
 struct seq_operations modules_op = {
