Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264397AbTDOIMz (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 04:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264407AbTDOIMy (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 04:12:54 -0400
Received: from dp.samba.org ([66.70.73.150]:16087 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264397AbTDOIMl (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 04:12:41 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: [PATCH] /proc/kallsyms
Date: Tue, 15 Apr 2003 17:51:43 +1000
Message-Id: <20030415082432.B5E3E2C23D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This allows access to kallsyms through /proc.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: kallsyms in proc
Author: Rusty Russell
Status: Tested on 2.5.67-bk5

D: This adds a /proc/kallsyms if you have CONFIG_KALLSYMS in your
D: kernel.  The output is nm-like, with symbols in caps (global) if
D: exported using EXPORT_SYMBOL, rather than the normal static
D: vs. non-static differntiation.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.67-bk5/include/linux/module.h working-2.5.67-bk5-kallsyms/include/linux/module.h
--- linux-2.5.67-bk5/include/linux/module.h	2003-04-08 11:15:01.000000000 +1000
+++ working-2.5.67-bk5-kallsyms/include/linux/module.h	2003-04-15 13:07:30.000000000 +1000
@@ -253,6 +253,13 @@ static inline int module_is_live(struct 
 /* Is this address in a module? */
 struct module *module_text_address(unsigned long addr);
 
+/* Returns module and fills in value, defined and namebuf, or NULL if
+   symnum out of range. */
+struct module *module_get_kallsym(unsigned int symnum,
+				  unsigned long *value,
+				  char *type,
+				  char namebuf[128]);
+int is_exported(const char *name, const struct module *mod);
 #ifdef CONFIG_MODULE_UNLOAD
 
 void __symbol_put(const char *symbol);
@@ -379,6 +386,19 @@ static inline const char *module_address
 	return NULL;
 }
 
+static inline struct module *module_get_kallsym(unsigned int symnum,
+						unsigned long *value,
+						char *type,
+						char namebuf[128])
+{
+	return NULL;
+}
+
+static inline int is_exported(const char *name, const struct module *mod)
+{
+	return 0;
+}
+
 static inline int register_module_notifier(struct notifier_block * nb)
 {
 	/* no events will happen anyway, so this can always succeed */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.67-bk5/kernel/kallsyms.c working-2.5.67-bk5-kallsyms/kernel/kallsyms.c
--- linux-2.5.67-bk5/kernel/kallsyms.c	2003-04-14 13:45:46.000000000 +1000
+++ working-2.5.67-bk5-kallsyms/kernel/kallsyms.c	2003-04-15 17:45:41.000000000 +1000
@@ -8,6 +8,11 @@
  */
 #include <linux/kallsyms.h>
 #include <linux/module.h>
+#include <linux/init.h>
+#include <linux/seq_file.h>
+#include <linux/fs.h>
+#include <linux/err.h>
+#include <linux/proc_fs.h>
 
 /* These will be re-linked against their real values during the second link stage */
 extern unsigned long kallsyms_addresses[] __attribute__((weak));
@@ -117,5 +122,162 @@ void __print_symbol(const char *fmt, uns
 	}
 }
 
+/* To avoid O(n^2) iteration, we carry prefix along. */
+struct kallsym_iter
+{
+	unsigned int nameoff; /* If iterating in core kernel symbols */
+	struct module *owner;
+	unsigned long value;
+	char type;
+	char name[128];
+};
+
+/* seq_file limits to 1 page reads at a time.  Without this cache, it
+   is v. slow, calling s_start lots of times. */
+static spinlock_t ksymcache_lock = SPIN_LOCK_UNLOCKED;
+static unsigned int ksymcache_symnum;
+static char ksymcache_name[128];
+
+static int get_ksymbol(loff_t pos, struct kallsym_iter *iter)
+{
+	unsigned stemlen;
+
+	if (pos >= kallsyms_num_syms) {
+		iter->owner = module_get_kallsym(pos - kallsyms_num_syms,
+						 &iter->value,
+						 &iter->type, iter->name);
+		if (iter->owner == NULL)
+			return 0;
+		goto test_local;
+	}
+
+	/* First char of each symbol name indicates prefix length
+	   shared with previous name (stem compresion). */
+	stemlen = kallsyms_names[iter->nameoff++];
+
+	strncpy(iter->name+stemlen, kallsyms_names+iter->nameoff, 127-stemlen);
+	iter->nameoff += strlen(kallsyms_names + iter->nameoff) + 1;
+	iter->owner = NULL;
+	iter->value = kallsyms_addresses[pos];
+	iter->type = 't';
+
+	/* Put it in cache. */
+	spin_lock(&ksymcache_lock);
+	strcpy(ksymcache_name, iter->name);
+	ksymcache_symnum = pos;
+	spin_unlock(&ksymcache_lock);
+
+ test_local:
+	/* Only label it "global" if it is exported. */
+	if (is_exported(iter->name, iter->owner))
+		iter->type += 'A' - 'a';
+	return 1;
+}
+
+static void *s_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	(*pos)++;
+	if (!get_ksymbol(*pos, p))
+		return NULL;
+
+	return p;
+}
+
+static void *s_start(struct seq_file *m, loff_t *pos)
+{
+	int cached = 0;
+	struct kallsym_iter *iter = kmalloc(sizeof(*iter), GFP_KERNEL);
+
+	if (!iter)
+		return ERR_PTR(-ENOMEM);
+
+	/* Check cache. */
+	spin_lock(&ksymcache_lock);
+	if (*pos == ksymcache_symnum) {
+		strcpy(iter->name, ksymcache_name);
+		iter->value = kallsyms_addresses[*pos];
+		iter->type = 't';
+		iter->owner = NULL;
+		cached = 1;
+	}
+	spin_unlock(&ksymcache_lock);
+	if (cached)
+		return iter;
+
+	/* If it's in the core symbols, we need to iterate through the
+           previous ones. */
+	if (*pos < kallsyms_num_syms) {
+		loff_t i;
+
+		iter->name[0] = iter->name[127] = '\0';
+		iter->nameoff = 0;
+
+		for (i = 0; i+1 < *pos; i++)
+			if (!get_ksymbol(i, iter))
+				BUG();
+	}
+	if (!get_ksymbol(*pos, iter)) {
+		kfree(iter);
+		return NULL;
+	}
+	return iter;
+}
+
+static void s_stop(struct seq_file *m, void *p)
+{
+	if (p && !IS_ERR(p))
+		kfree(p);
+}
+
+static int s_show(struct seq_file *m, void *p)
+{
+	struct kallsym_iter *iter = p;
+
+	/* Some debugging symbols have no name.  Ignore them. */ 
+	if (!iter->name[0])
+		return 0;
+
+	if (iter->owner)
+		seq_printf(m, "%0*lx %c %s\t[%s]\n",
+			   (int)(2*sizeof(void*)),
+			   iter->value, iter->type, iter->name,
+			   module_name(iter->owner));
+	else
+		seq_printf(m, "%0*lx %c %s\n",
+			   (int)(2*sizeof(void*)),
+			   iter->value, iter->type, iter->name);
+	return 0;
+}
+
+struct seq_operations kallsyms_op = {
+	.start = s_start,
+	.next = s_next,
+	.stop = s_stop,
+	.show = s_show
+};
+
+static int kallsyms_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &kallsyms_op);
+}
+
+static struct file_operations kallsyms_operations = {
+	.open = kallsyms_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+int __init kallsyms_init(void)
+{
+	struct proc_dir_entry *entry;
+
+	entry = create_proc_entry("kallsyms", 0, NULL);
+	if (entry)
+		entry->proc_fops = &kallsyms_operations;
+	return 0;
+}
+__initcall(kallsyms_init);
+
 EXPORT_SYMBOL(kallsyms_lookup);
 EXPORT_SYMBOL(__print_symbol);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.67-bk5/kernel/module.c working-2.5.67-bk5-kallsyms/kernel/module.c
--- linux-2.5.67-bk5/kernel/module.c	2003-04-14 13:45:46.000000000 +1000
+++ working-2.5.67-bk5-kallsyms/kernel/module.c	2003-04-15 15:49:21.000000000 +1000
@@ -1080,6 +1080,83 @@ static void set_license(struct module *m
 	}
 }
 
+#ifdef CONFIG_KALLSYMS
+int is_exported(const char *name, const struct module *mod)
+{
+	unsigned int i;
+
+	if (!mod) {
+		for (i = 0; __start___ksymtab+i < __stop___ksymtab; i++)
+			if (strcmp(__start___ksymtab[i].name, name) == 0)
+				return 1;
+		return 0;
+	}
+	for (i = 0; i < mod->num_syms; i++)
+		if (strcmp(mod->syms[i].name, name) == 0)
+			return 1;
+	return 0;
+}
+
+/* As per nm */
+static char elf_type(const Elf_Sym *sym,
+		     Elf_Shdr *sechdrs,
+		     const char *secstrings,
+		     struct module *mod)
+{
+	if (ELF_ST_BIND(sym->st_info) == STB_WEAK) {
+		if (ELF_ST_TYPE(sym->st_info) == STT_OBJECT)
+			return 'v';
+		else
+			return 'w';
+	}
+	if (sym->st_shndx == SHN_UNDEF)
+		return 'U';
+	if (sym->st_shndx == SHN_ABS)
+		return 'a';
+	if (sym->st_shndx >= SHN_LORESERVE)
+		return '?';
+	if (sechdrs[sym->st_shndx].sh_flags & SHF_EXECINSTR)
+		return 't';
+	if (sechdrs[sym->st_shndx].sh_flags & SHF_ALLOC
+	    && sechdrs[sym->st_shndx].sh_type != SHT_NOBITS) {
+		if (!(sechdrs[sym->st_shndx].sh_flags & SHF_WRITE))
+			return 'r';
+		else if (sechdrs[sym->st_shndx].sh_flags & ARCH_SHF_SMALL)
+			return 'g';
+		else
+			return 'd';
+	}
+	if (sechdrs[sym->st_shndx].sh_type == SHT_NOBITS) {
+		if (sechdrs[sym->st_shndx].sh_flags & ARCH_SHF_SMALL)
+			return 's';
+		else
+			return 'b';
+	}
+	if (strncmp(secstrings + sechdrs[sym->st_shndx].sh_name,
+		    ".debug", strlen(".debug")) == 0)
+		return 'n';
+	return '?';
+}
+
+static void add_kallsyms(struct module *mod,
+			 Elf_Shdr *sechdrs,
+			 unsigned int symindex,
+			 unsigned int strindex,
+			 const char *secstrings)
+{
+	unsigned int i;
+
+	mod->symtab = (void *)sechdrs[symindex].sh_addr;
+	mod->num_symtab = sechdrs[symindex].sh_size / sizeof(Elf_Sym);
+	mod->strtab = (void *)sechdrs[strindex].sh_addr;
+
+	/* Set types up while we still have access to sections. */
+	for (i = 0; i < mod->num_symtab; i++)
+		mod->symtab[i].st_info
+			= elf_type(&mod->symtab[i], sechdrs, secstrings, mod);
+}
+#endif
+
 /* Allocate and load the module: note that size of section 0 is always
    zero, and we rely on this for optional sections. */
 static struct module *load_module(void __user *umod,
@@ -1309,15 +1386,12 @@ static struct module *load_module(void _
 			goto cleanup;
 	}
 
-#ifdef CONFIG_KALLSYMS
-	mod->symtab = (void *)sechdrs[symindex].sh_addr;
-	mod->num_symtab = sechdrs[symindex].sh_size / sizeof(Elf_Sym);
-	mod->strtab = (void *)sechdrs[strindex].sh_addr;
-#endif
 	err = module_finalize(hdr, sechdrs, mod);
 	if (err < 0)
 		goto cleanup;
 
+	add_kallsyms(mod, sechdrs, symindex, strindex, secstrings);
+
 	mod->args = args;
 	if (obsparmindex) {
 		err = obsolete_params(mod->name, mod->args,
@@ -1493,6 +1567,30 @@ const char *module_address_lookup(unsign
 	}
 	return NULL;
 }
+
+struct module *module_get_kallsym(unsigned int symnum,
+				  unsigned long *value,
+				  char *type,
+				  char namebuf[128])
+{
+	struct module *mod;
+
+	down(&module_mutex);
+	list_for_each_entry(mod, &modules, list) {
+		if (symnum < mod->num_symtab) {
+			*value = mod->symtab[symnum].st_value;
+			*type = mod->symtab[symnum].st_info;
+			strncpy(namebuf,
+				mod->strtab + mod->symtab[symnum].st_name,
+				127);
+			up(&module_mutex);
+			return mod;
+		}
+		symnum -= mod->num_symtab;
+	}
+	up(&module_mutex);
+	return NULL;
+}
 #endif /* CONFIG_KALLSYMS */
 
 /* Called by the /proc file system to return a list of modules. */
