Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316434AbSHFWuV>; Tue, 6 Aug 2002 18:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316499AbSHFWuU>; Tue, 6 Aug 2002 18:50:20 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:45834 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316434AbSHFWsY>; Tue, 6 Aug 2002 18:48:24 -0400
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] module cleanup (4/5)
Message-Id: <E17cDBF-0002vC-00@scrub.xs4all.nl>
From: Roman Zippel <zippel@linux-m68k.org>
Date: Wed, 07 Aug 2002 00:51:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch introduces two macros mod_for_each_locked/mod_for_done_locked
to safely iterate over the module list.

diff -ur linux-2.5/arch/alpha/mm/extable.c linux-mod/arch/alpha/mm/extable.c
--- linux-2.5/arch/alpha/mm/extable.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/alpha/mm/extable.c	Thu Aug  1 14:35:31 2002
@@ -46,22 +46,17 @@
 	ret = search_one_table(__start___ex_table, __stop___ex_table - 1,
 			       addr - gp);
 #else
-	extern spinlock_t modlist_lock;
-	unsigned long flags;
-	/* The kernel is the last "module" -- no need to treat it special. */
 	struct module *mp;
 
 	ret = 0;
-	spin_lock_irqsave(&modlist_lock, flags);
-	for (mp = module_list; mp ; mp = mp->next) {
-		if (!mp->ex_table_start || !(mp->flags&(MOD_RUNNING|MOD_INITIALIZING)))
+	mod_for_each_locked(mp) {
+		if (!mp->ex_table_start)
 			continue;
 		ret = search_one_table(mp->ex_table_start,
 				       mp->ex_table_end - 1, addr - mp->gp);
 		if (ret)
 			break;
-	}
-	spin_unlock_irqrestore(&modlist_lock, flags);
+	} mod_for_done_locked
 #endif
 
 	return ret;
@@ -77,22 +72,17 @@
 			       addr - exc_gp);
 	if (ret) return ret;
 #else
-	extern spinlock_t modlist_lock;
-	unsigned long flags;
-	/* The kernel is the last "module" -- no need to treat it special. */
 	struct module *mp;
 
 	ret = 0;
-	spin_lock_irqsave(&modlist_lock, flags);
-	for (mp = module_list; mp ; mp = mp->next) {
-		if (!mp->ex_table_start || !(mp->flags&(MOD_RUNNING|MOD_INITIALIZING)))
+	mod_for_each_locked(mp) {
+		if (!mp->ex_table_start)
 			continue;
 		ret = search_one_table(mp->ex_table_start,
 				       mp->ex_table_end - 1, addr - exc_gp);
 		if (ret)
 			break;
-	}
-	spin_unlock_irqrestore(&modlist_lock, flags);
+	} mod_for_done_locked
 	if (ret) return ret;
 #endif
 
diff -ur linux-2.5/arch/arm/mm/extable.c linux-mod/arch/arm/mm/extable.c
--- linux-2.5/arch/arm/mm/extable.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/arm/mm/extable.c	Thu Aug  1 14:35:31 2002
@@ -30,8 +30,6 @@
         return 0;
 }
 
-extern spinlock_t modlist_lock;
-
 unsigned long
 search_exception_table(unsigned long addr)
 {
@@ -41,22 +39,17 @@
 	/* There is only the kernel to search.  */
 	ret = search_one_table(__start___ex_table, __stop___ex_table-1, addr);
 #else
-	/* The kernel is the last "module" -- no need to treat it special.  */
-	unsigned long flags;
 	struct module *mp;
 
 	ret = 0;
-	spin_lock_irqsave(&modlist_lock, flags);
-	for (mp = module_list; mp != NULL; mp = mp->next) {
-		if (mp->ex_table_start == NULL ||
-		    !(mp->flags & (MOD_RUNNING | MOD_INITIALIZING)))
+	mod_for_each_locked(mp) {
+		if (mp->ex_table_start == NULL)
 			continue;
 		ret = search_one_table(mp->ex_table_start,
 				       mp->ex_table_end - 1, addr);
 		if (ret)
 			break;
-	}
-	spin_unlock_irqrestore(&modlist_lock, flags);
+	} mod_for_done_locked
 #endif
 
 	return ret;
diff -ur linux-2.5/arch/cris/mm/extable.c linux-mod/arch/cris/mm/extable.c
--- linux-2.5/arch/cris/mm/extable.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/cris/mm/extable.c	Thu Aug  1 14:35:31 2002
@@ -48,15 +48,15 @@
 	/* There is only the kernel to search.  */
 	return search_one_table(__start___ex_table, __stop___ex_table-1, addr);
 #else
-	/* The kernel is the last "module" -- no need to treat it special.  */
 	struct module *mp;
-	for (mp = module_list; mp != NULL; mp = mp->next) {
+
+	mod_for_each_locked(mp) {
 		if (mp->ex_table_start == NULL)
 			continue;
 		ret = search_one_table(mp->ex_table_start,
 				       mp->ex_table_end - 1, addr);
 		if (ret) return ret;
-	}
+	} mod_for_done_locked
 #endif
 
 	return 0;
diff -ur linux-2.5/arch/i386/kernel/traps.c linux-mod/arch/i386/kernel/traps.c
--- linux-2.5/arch/i386/kernel/traps.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/i386/kernel/traps.c	Thu Aug  1 14:39:28 2002
@@ -98,21 +98,19 @@
  * be the address of a calling routine
  */
 
-#ifdef CONFIG_MODULES
-
-extern struct module *module_list;
-extern struct module kernel_module;
-
 static inline int kernel_text_address(unsigned long addr)
 {
 	int retval = 0;
+#ifdef CONFIG_MODULES
 	struct module *mod;
+#endif
 
 	if (addr >= (unsigned long) &_stext &&
 	    addr <= (unsigned long) &_etext)
 		return 1;
 
-	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
+#ifdef CONFIG_MODULES
+	mod_for_each_locked(mod) {
 		/* mod_bound tests for addr being inside the vmalloc'ed
 		 * module area. Of course it'd be better to test only
 		 * for the .text subset... */
@@ -120,20 +118,11 @@
 			retval = 1;
 			break;
 		}
-	}
+	} mod_for_done_locked
+#endif
 
 	return retval;
 }
-
-#else
-
-static inline int kernel_text_address(unsigned long addr)
-{
-	return (addr >= (unsigned long) &_stext &&
-		addr <= (unsigned long) &_etext);
-}
-
-#endif
 
 void show_trace(unsigned long * stack)
 {
diff -ur linux-2.5/arch/i386/mm/extable.c linux-mod/arch/i386/mm/extable.c
--- linux-2.5/arch/i386/mm/extable.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/i386/mm/extable.c	Thu Aug  1 14:35:31 2002
@@ -31,8 +31,6 @@
         return 0;
 }
 
-extern spinlock_t modlist_lock;
-
 unsigned long
 search_exception_table(unsigned long addr)
 {
@@ -43,20 +41,16 @@
 	ret = search_one_table(__start___ex_table, __stop___ex_table-1, addr);
 	return ret;
 #else
-	unsigned long flags;
-	/* The kernel is the last "module" -- no need to treat it special.  */
 	struct module *mp;
 
-	spin_lock_irqsave(&modlist_lock, flags);
-	for (mp = module_list; mp != NULL; mp = mp->next) {
-		if (mp->ex_table_start == NULL || !(mp->flags&(MOD_RUNNING|MOD_INITIALIZING)))
+	mod_for_each_locked(mp) {
+		if (mp->ex_table_start == NULL)
 			continue;
 		ret = search_one_table(mp->ex_table_start,
 				       mp->ex_table_end - 1, addr);
 		if (ret)
 			break;
-	}
-	spin_unlock_irqrestore(&modlist_lock, flags);
+	} mod_for_done_locked
 	return ret;
 #endif
 }
diff -ur linux-2.5/arch/ia64/mm/extable.c linux-mod/arch/ia64/mm/extable.c
--- linux-2.5/arch/ia64/mm/extable.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/ia64/mm/extable.c	Thu Aug  1 14:35:31 2002
@@ -54,8 +54,7 @@
 	struct archdata *archdata;
 	struct module *mp;
 
-	/* The kernel is the last "module" -- no need to treat it special. */
-	for (mp = module_list; mp; mp = mp->next) {
+	mod_for_each_locked(mp) {
 		if (!mp->ex_table_start)
 			continue;
 		archdata = (struct archdata *) mp->archdata_start;
@@ -67,7 +66,7 @@
 			fix.cont = entry->cont + (unsigned long) archdata->gp;
 			return fix;
 		}
-	}
+	} mod_for_done_locked
 #endif
 	return fix;
 }
diff -ur linux-2.5/arch/m68k/kernel/traps.c linux-mod/arch/m68k/kernel/traps.c
--- linux-2.5/arch/m68k/kernel/traps.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/m68k/kernel/traps.c	Thu Aug  1 14:35:31 2002
@@ -820,7 +820,6 @@
 
 
 static int kstack_depth_to_print = 48;
-extern struct module kernel_module;
 
 static inline int kernel_text_address(unsigned long addr)
 {
@@ -834,13 +833,13 @@
 		return 1;
 
 #ifdef CONFIG_MODULES
-	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
+	mod_for_each_locked(mod) {
 		/* mod_bound tests for addr being inside the vmalloc'ed
 		 * module area. Of course it'd be better to test only
 		 * for the .text subset... */
 		if (mod_bound(addr, 0, mod))
 			return 1;
-	}
+	} mod_for_done_locked
 #endif
 
 	return 0;
diff -ur linux-2.5/arch/m68k/mm/extable.c linux-mod/arch/m68k/mm/extable.c
--- linux-2.5/arch/m68k/mm/extable.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/m68k/mm/extable.c	Thu Aug  1 14:35:31 2002
@@ -40,15 +40,15 @@
 	ret = search_one_table(__start___ex_table, __stop___ex_table-1, addr);
 	if (ret) return ret;
 #else
-	/* The kernel is the last "module" -- no need to treat it special.  */
 	struct module *mp;
-	for (mp = module_list; mp != NULL; mp = mp->next) {
+
+	mod_for_each_locked(mp) {
 		if (mp->ex_table_start == NULL)
 			continue;
 		ret = search_one_table(mp->ex_table_start,
 				       mp->ex_table_end-1, addr);
 		if (ret) return ret;
-	}
+	} mod_for_done_locked
 #endif
 
 	return 0;
diff -ur linux-2.5/arch/mips/kernel/traps.c linux-mod/arch/mips/kernel/traps.c
--- linux-2.5/arch/mips/kernel/traps.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/mips/kernel/traps.c	Thu Aug  1 14:35:31 2002
@@ -245,8 +245,6 @@
 	return (first == last && first->insn == value) ? first->nextinsn : 0;
 }
 
-extern spinlock_t modlist_lock;
-
 static inline unsigned long
 search_dbe_table(unsigned long addr)
 {
@@ -257,29 +255,23 @@
 	ret = search_one_table(__start___dbe_table, __stop___dbe_table-1, addr);
 	return ret;
 #else
-	unsigned long flags;
-
-	/* The kernel is the last "module" -- no need to treat it special.  */
 	struct module *mp;
 	struct archdata *ap;
 
-	spin_lock_irqsave(&modlist_lock, flags);
-	for (mp = module_list; mp != NULL; mp = mp->next) {
+	mod_for_each_locked(mp) {
 		if (!mod_member_present(mp, archdata_end) ||
         	    !mod_archdata_member_present(mp, struct archdata,
 						 dbe_table_end))
 			continue;
 		ap = (struct archdata *)(mp->archdata_start);
 
-		if (ap->dbe_table_start == NULL ||
-		    !(mp->flags & (MOD_RUNNING | MOD_INITIALIZING)))
+		if (ap->dbe_table_start == NULL)
 			continue;
 		ret = search_one_table(ap->dbe_table_start,
 				       ap->dbe_table_end - 1, addr);
 		if (ret)
 			break;
-	}
-	spin_unlock_irqrestore(&modlist_lock, flags);
+	} mod_for_done_locked
 	return ret;
 #endif
 }
diff -ur linux-2.5/arch/mips/mm/extable.c linux-mod/arch/mips/mm/extable.c
--- linux-2.5/arch/mips/mm/extable.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/mips/mm/extable.c	Thu Aug  1 14:35:31 2002
@@ -30,8 +30,6 @@
 	return 0;
 }
 
-extern spinlock_t modlist_lock;
-
 unsigned long
 search_exception_table(unsigned long addr)
 {
@@ -42,21 +40,16 @@
 	ret = search_one_table(__start___ex_table, __stop___ex_table-1, addr);
 	return ret;
 #else
-	unsigned long flags;
-
-	/* The kernel is the last "module" -- no need to treat it special.  */
 	struct module *mp;
 
-	spin_lock_irqsave(&modlist_lock, flags);
-	for (mp = module_list; mp != NULL; mp = mp->next) {
-		if (mp->ex_table_start == NULL || !(mp->flags&(MOD_RUNNING|MOD_INITIALIZING)))
+	mod_for_each_locked(mp) {
+		if (mp->ex_table_start == NULL)
 			continue;
 		ret = search_one_table(mp->ex_table_start,
 				       mp->ex_table_end - 1, addr);
 		if (ret)
 			break;
-	}
-	spin_unlock_irqrestore(&modlist_lock, flags);
+	} mod_for_done_locked
 	return ret;
 #endif
 }
diff -ur linux-2.5/arch/mips64/mm/extable.c linux-mod/arch/mips64/mm/extable.c
--- linux-2.5/arch/mips64/mm/extable.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/mips64/mm/extable.c	Thu Aug  1 14:35:31 2002
@@ -35,31 +35,25 @@
 	return 0;
 }
 
-extern spinlock_t modlist_lock;
-
 unsigned long search_exception_table(unsigned long addr)
 {
 	unsigned long ret = 0;
-	unsigned long flags;
-	
+
 #ifndef CONFIG_MODULES
 	/* There is only the kernel to search.  */
 	ret = search_one_table(__start___ex_table, __stop___ex_table-1, addr);
 	return ret;
 #else
-	/* The kernel is the last "module" -- no need to treat it special.  */
 	struct module *mp;
 
-	spin_lock_irqsave(&modlist_lock, flags);
-	for (mp = module_list; mp != NULL; mp = mp->next) {
+	mod_for_each_locked(mp) {
 		if (mp->ex_table_start == NULL)
 			continue;
 		ret = search_one_table(mp->ex_table_start,
 				       mp->ex_table_end - 1, addr);
 		if (ret)
 			break;
-	}
-	spin_unlock_irqrestore(&modlist_lock, flags);
+	} mod_for_done_locked
 	return ret;
 #endif
 }
diff -ur linux-2.5/arch/mips64/sgi-ip22/ip22-berr.c linux-mod/arch/mips64/sgi-ip22/ip22-berr.c
--- linux-2.5/arch/mips64/sgi-ip22/ip22-berr.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/mips64/sgi-ip22/ip22-berr.c	Thu Aug  1 14:35:31 2002
@@ -43,8 +43,6 @@
 	return 0;
 }
 
-extern spinlock_t modlist_lock;
-
 static inline unsigned long
 search_dbe_table(unsigned long addr)
 {
@@ -55,29 +53,23 @@
 	ret = search_one_table(__start___dbe_table, __stop___dbe_table-1, addr);
 	return ret;
 #else
-	unsigned long flags;
-
-	/* The kernel is the last "module" -- no need to treat it special.  */
 	struct module *mp;
 	struct archdata *ap;
 
-	spin_lock_irqsave(&modlist_lock, flags);
-	for (mp = module_list; mp != NULL; mp = mp->next) {
+	mod_for_each_locked(mp) {
 		if (!mod_member_present(mp, archdata_end) ||
         	    !mod_archdata_member_present(mp, struct archdata,
 						 dbe_table_end))
 			continue;
 		ap = (struct archdata *)(mod->archdata_start);
 
-		if (ap->dbe_table_start == NULL ||
-		    !(mp->flags & (MOD_RUNNING | MOD_INITIALIZING)))
+		if (ap->dbe_table_start == NULL)
 			continue;
 		ret = search_one_table(ap->dbe_table_start,
 				       ap->dbe_table_end - 1, addr);
 		if (ret)
 			break;
-	}
-	spin_unlock_irqrestore(&modlist_lock, flags);
+	} mod_for_done_locked
 	return ret;
 #endif
 }
diff -ur linux-2.5/arch/mips64/sgi-ip27/ip27-berr.c linux-mod/arch/mips64/sgi-ip27/ip27-berr.c
--- linux-2.5/arch/mips64/sgi-ip27/ip27-berr.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/mips64/sgi-ip27/ip27-berr.c	Thu Aug  1 14:35:31 2002
@@ -46,8 +46,6 @@
 	return 0;
 }
 
-extern spinlock_t modlist_lock;
-
 static inline unsigned long
 search_dbe_table(unsigned long addr)
 {
@@ -58,29 +56,23 @@
 	ret = search_one_table(__start___dbe_table, __stop___dbe_table-1, addr);
 	return ret;
 #else
-	unsigned long flags;
-
-	/* The kernel is the last "module" -- no need to treat it special.  */
 	struct module *mp;
 	struct archdata *ap;
 
-	spin_lock_irqsave(&modlist_lock, flags);
-	for (mp = module_list; mp != NULL; mp = mp->next) {
+	mod_for_each_locked(mp) {
 		if (!mod_member_present(mp, archdata_end) ||
         	    !mod_archdata_member_present(mp, struct archdata,
 						 dbe_table_end))
 			continue;
 		ap = (struct archdata *)(mod->archdata_start);
 
-		if (ap->dbe_table_start == NULL ||
-		    !(mp->flags & (MOD_RUNNING | MOD_INITIALIZING)))
+		if (ap->dbe_table_start == NULL)
 			continue;
 		ret = search_one_table(ap->dbe_table_start,
 				       ap->dbe_table_end - 1, addr);
 		if (ret)
 			break;
-	}
-	spin_unlock_irqrestore(&modlist_lock, flags);
+	} mod_for_done_locked
 	return ret;
 #endif
 }
diff -ur linux-2.5/arch/parisc/mm/extable.c linux-mod/arch/parisc/mm/extable.c
--- linux-2.5/arch/parisc/mm/extable.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/parisc/mm/extable.c	Thu Aug  1 14:35:31 2002
@@ -53,17 +53,16 @@
                                 addr);
 #else
 	struct exception_table_entry *ret;
-	/* The kernel is the last "module" -- no need to treat it special. */
 	struct module *mp;
 
-	for (mp = module_list; mp ; mp = mp->next) {
+	mod_for_each_locked(mp) {
 		if (!mp->ex_table_start)
 			continue;
 		ret = search_one_table(mp->ex_table_start, mp->ex_table_end - 1,
 				       addr);
 		if (ret)
 			return ret;
-	}
+	} mod_for_done_locked
 	return 0;
 #endif
 }
diff -ur linux-2.5/arch/ppc/mm/extable.c linux-mod/arch/ppc/mm/extable.c
--- linux-2.5/arch/ppc/mm/extable.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/ppc/mm/extable.c	Thu Aug  1 14:35:31 2002
@@ -80,16 +80,16 @@
 	ret = search_one_table(__start___ex_table, __stop___ex_table-1, addr);
 	if (ret) return ret;
 #else
-	/* The kernel is the last "module" -- no need to treat it special.  */
 	struct module *mp;
-	for (mp = module_list; mp != NULL; mp = mp->next) {
+
+	mod_for_each_locked(mp) {
 		if (mp->ex_table_start == NULL)
 			continue;
 		ret = search_one_table(mp->ex_table_start,
 				       mp->ex_table_end - 1, addr);
 		if (ret)
 			return ret;
-	}
+	} mod_for_done_locked
 #endif
 
 	return 0;
diff -ur linux-2.5/arch/ppc64/mm/extable.c linux-mod/arch/ppc64/mm/extable.c
--- linux-2.5/arch/ppc64/mm/extable.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/ppc64/mm/extable.c	Thu Aug  1 14:35:31 2002
@@ -82,16 +82,16 @@
 	ret = search_one_table(__start___ex_table, __stop___ex_table-1, addr);
 	if (ret) return ret;
 #else
-	/* The kernel is the last "module" -- no need to treat it special.  */
 	struct module *mp;
-	for (mp = module_list; mp != NULL; mp = mp->next) {
+
+	mod_for_each_locked(mp) {
 		if (mp->ex_table_start == NULL)
 			continue;
 		ret = search_one_table(mp->ex_table_start,
 				       mp->ex_table_end - 1, addr);
 		if (ret)
 			return ret;
-	}
+	} mod_for_done_locked
 #endif
 
 	return 0;
diff -ur linux-2.5/arch/s390/kernel/traps.c linux-mod/arch/s390/kernel/traps.c
--- linux-2.5/arch/s390/kernel/traps.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/s390/kernel/traps.c	Thu Aug  1 14:35:31 2002
@@ -70,21 +70,19 @@
  */
 extern char _stext, _etext;
 
-#ifdef CONFIG_MODULES
-
-extern struct module *module_list;
-extern struct module kernel_module;
-
 static inline int kernel_text_address(unsigned long addr)
 {
 	int retval = 0;
+#ifdef CONFIG_MODULES
 	struct module *mod;
+#endif
 
 	if (addr >= (unsigned long) &_stext &&
 	    addr <= (unsigned long) &_etext)
 		return 1;
 
-	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
+#ifdef CONFIG_MODULES
+	mod_for_each_locked(mod) {
 		/* mod_bound tests for addr being inside the vmalloc'ed
 		 * module area. Of course it'd be better to test only
 		 * for the .text subset... */
@@ -92,20 +90,11 @@
 			retval = 1;
 			break;
 		}
-	}
+	} mod_for_done_locked
+#endif
 
 	return retval;
 }
-
-#else
-
-static inline int kernel_text_address(unsigned long addr)
-{
-	return (addr >= (unsigned long) &_stext &&
-		addr <= (unsigned long) &_etext);
-}
-
-#endif
 
 void show_trace(unsigned long * stack)
 {
diff -ur linux-2.5/arch/s390/mm/extable.c linux-mod/arch/s390/mm/extable.c
--- linux-2.5/arch/s390/mm/extable.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/s390/mm/extable.c	Thu Aug  1 14:35:31 2002
@@ -37,8 +37,6 @@
         return 0;
 }
 
-extern spinlock_t modlist_lock;
-
 unsigned long
 search_exception_table(unsigned long addr)
 {
@@ -51,14 +49,11 @@
 	if (ret) ret = FIX_PSW(ret);
 	return ret;
 #else
-	unsigned long flags;
-	/* The kernel is the last "module" -- no need to treat it special.  */
 	struct module *mp;
         addr &= 0x7fffffff;  /* remove amode bit from address */
 
-	spin_lock_irqsave(&modlist_lock, flags);
-	for (mp = module_list; mp != NULL; mp = mp->next) {
-		if (mp->ex_table_start == NULL || !(mp->flags&(MOD_RUNNING|MOD_INITIALIZING)))
+	mod_for_each_locked(mp) {
+		if (mp->ex_table_start == NULL)
 			continue;
 		ret = search_one_table(mp->ex_table_start,
 				       mp->ex_table_end - 1, addr);
@@ -66,8 +61,7 @@
 			ret = FIX_PSW(ret);
 			break;
 		}
-	}
-	spin_unlock_irqrestore(&modlist_lock, flags);
+	} mod_for_done_locked
 	return ret;
 #endif
 }
diff -ur linux-2.5/arch/s390x/kernel/traps.c linux-mod/arch/s390x/kernel/traps.c
--- linux-2.5/arch/s390x/kernel/traps.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/s390x/kernel/traps.c	Thu Aug  1 14:35:31 2002
@@ -72,21 +72,19 @@
  */
 extern char _stext, _etext;
 
-#ifdef CONFIG_MODULES
-
-extern struct module *module_list;
-extern struct module kernel_module;
-
 static inline int kernel_text_address(unsigned long addr)
 {
 	int retval = 0;
+#ifdef CONFIG_MODULES
 	struct module *mod;
+#endif
 
 	if (addr >= (unsigned long) &_stext &&
 	    addr <= (unsigned long) &_etext)
 		return 1;
 
-	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
+#ifdef CONFIG_MODULES
+	mod_for_each_locked(mod) {
 		/* mod_bound tests for addr being inside the vmalloc'ed
 		 * module area. Of course it'd be better to test only
 		 * for the .text subset... */
@@ -94,20 +92,11 @@
 			retval = 1;
 			break;
 		}
-	}
+	} mod_for_done_locked
+#endif
 
 	return retval;
 }
-
-#else
-
-static inline int kernel_text_address(unsigned long addr)
-{
-	return (addr >= (unsigned long) &_stext &&
-		addr <= (unsigned long) &_etext);
-}
-
-#endif
 
 void show_trace(unsigned long * stack)
 {
diff -ur linux-2.5/arch/s390x/mm/extable.c linux-mod/arch/s390x/mm/extable.c
--- linux-2.5/arch/s390x/mm/extable.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/s390x/mm/extable.c	Thu Aug  1 14:35:31 2002
@@ -37,8 +37,6 @@
         return 0;
 }
 
-extern spinlock_t modlist_lock;
-
 unsigned long
 search_exception_table(unsigned long addr)
 {
@@ -49,20 +47,16 @@
 	ret = search_one_table(__start___ex_table, __stop___ex_table-1, addr);
 	return ret;
 #else
-	unsigned long flags;
-	/* The kernel is the last "module" -- no need to treat it special.  */
 	struct module *mp;
 
-	spin_lock_irqsave(&modlist_lock, flags);
-	for (mp = module_list; mp != NULL; mp = mp->next) {
-		if (mp->ex_table_start == NULL || !(mp->flags&(MOD_RUNNING|MOD_INITIALIZING)))
+	mod_for_each_locked(mp) {
+		if (mp->ex_table_start == NULL)
 			continue;
 		ret = search_one_table(mp->ex_table_start,
 				       mp->ex_table_end - 1, addr);
 		if (ret) 
 			break;
-	}
-	spin_unlock_irqrestore(&modlist_lock, flags);
+	} mod_for_done_locked
 	return ret;
 #endif
 }
diff -ur linux-2.5/arch/sh/mm/extable.c linux-mod/arch/sh/mm/extable.c
--- linux-2.5/arch/sh/mm/extable.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/sh/mm/extable.c	Thu Aug  1 14:35:31 2002
@@ -43,15 +43,15 @@
 	ret = search_one_table(__start___ex_table, __stop___ex_table-1, addr);
 	if (ret) return ret;
 #else
-	/* The kernel is the last "module" -- no need to treat it special.  */
 	struct module *mp;
-	for (mp = module_list; mp != NULL; mp = mp->next) {
-		if (mp->ex_table_start == NULL || !(mp->flags&(MOD_RUNNING|MOD_INITIALIZING)))
+
+	mod_for_each_locked(mp) {
+		if (mp->ex_table_start == NULL)
 			continue;
 		ret = search_one_table(mp->ex_table_start,
 				       mp->ex_table_end - 1, addr);
 		if (ret) return ret;
-	}
+	} mod_for_done_locked
 #endif
 
 	return 0;
diff -ur linux-2.5/arch/sparc/mm/extable.c linux-mod/arch/sparc/mm/extable.c
--- linux-2.5/arch/sparc/mm/extable.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/sparc/mm/extable.c	Thu Aug  1 14:35:31 2002
@@ -57,12 +57,10 @@
         return 0;
 }
 
-extern spinlock_t modlist_lock;
-
 unsigned long
 search_exception_table(unsigned long addr, unsigned long *g2)
 {
-	unsigned long ret = 0, flags;
+	unsigned long ret = 0;
 
 #ifndef CONFIG_MODULES
 	/* There is only the kernel to search.  */
@@ -70,19 +68,16 @@
 			       __stop___ex_table-1, addr, g2);
 	return ret;
 #else
-	/* The kernel is the last "module" -- no need to treat it special.  */
 	struct module *mp;
 
-	spin_lock_irqsave(&modlist_lock, flags);
-	for (mp = module_list; mp != NULL; mp = mp->next) {
-		if (mp->ex_table_start == NULL || !(mp->flags & (MOD_RUNNING | MOD_INITIALIZING)))
+	mod_for_each_locked(mp) {
+		if (mp->ex_table_start == NULL)
 			continue;
 		ret = search_one_table(mp->ex_table_start,
 				       mp->ex_table_end-1, addr, g2);
 		if (ret)
 			break;
-	}
-	spin_unlock_irqrestore(&modlist_lock, flags);
+	} mod_for_done_locked
 	return ret;
 #endif
 }
diff -ur linux-2.5/arch/sparc64/mm/extable.c linux-mod/arch/sparc64/mm/extable.c
--- linux-2.5/arch/sparc64/mm/extable.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/sparc64/mm/extable.c	Thu Aug  1 14:35:31 2002
@@ -57,12 +57,10 @@
         return 0;
 }
 
-extern spinlock_t modlist_lock;
-
 unsigned long
 search_exception_table(unsigned long addr, unsigned long *g2)
 {
-	unsigned long ret = 0, flags;
+	unsigned long ret = 0;
 
 #ifndef CONFIG_MODULES
 	/* There is only the kernel to search.  */
@@ -70,19 +68,16 @@
 			       __stop___ex_table-1, addr, g2);
 	return ret;
 #else
-	/* The kernel is the last "module" -- no need to treat it special.  */
 	struct module *mp;
 
-	spin_lock_irqsave(&modlist_lock, flags);
-	for (mp = module_list; mp != NULL; mp = mp->next) {
-		if (mp->ex_table_start == NULL || !(mp->flags & (MOD_RUNNING | MOD_INITIALIZING)))
+	mod_for_each_locked(mp) {
+		if (mp->ex_table_start == NULL)
 			continue;
 		ret = search_one_table(mp->ex_table_start,
 				       mp->ex_table_end-1, addr, g2);
 		if (ret)
 			break;
-	}
-	spin_unlock_irqrestore(&modlist_lock, flags);
+	} mod_for_done_locked
 	return ret;
 #endif
 }
diff -ur linux-2.5/arch/x86_64/kernel/traps.c linux-mod/arch/x86_64/kernel/traps.c
--- linux-2.5/arch/x86_64/kernel/traps.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/x86_64/kernel/traps.c	Thu Aug  1 14:35:31 2002
@@ -112,21 +112,20 @@
 #endif
 
 
-#ifdef CONFIG_MODULES
-
-extern struct module *module_list;
-extern struct module kernel_module;
 
 static inline int kernel_text_address(unsigned long addr)
 {
    int retval = 0;
+#ifdef CONFIG_MODULES
    struct module *mod;
+#endif
 
    if (addr >= (unsigned long) &_stext &&
        addr <= (unsigned long) &_etext)
        return 1;
 
-   for (mod = module_list; mod != &kernel_module; mod = mod->next) {
+#ifdef CONFIG_MODULES
+   mod_for_each_locked(mod) {
        /* mod_bound tests for addr being inside the vmalloc'ed
         * module area. Of course it'd be better to test only
         * for the .text subset... */
@@ -134,20 +133,11 @@
            retval = 1;
            break;
        }
-   }
+   } mod_for_done_locked
+#endif
 
    return retval;
 }
-
-#else
-
-static inline int kernel_text_address(unsigned long addr)
-{
-   return (addr >= (unsigned long) &_stext &&
-       addr <= (unsigned long) &_etext);
-}
-
-#endif
 
 /*
  * These constants are for searching for possible module text
diff -ur linux-2.5/arch/x86_64/mm/extable.c linux-mod/arch/x86_64/mm/extable.c
--- linux-2.5/arch/x86_64/mm/extable.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/x86_64/mm/extable.c	Thu Aug  1 14:35:31 2002
@@ -49,31 +49,25 @@
         return 0;
 }
 
-extern spinlock_t modlist_lock;
-
 unsigned long
 search_exception_table(unsigned long addr)
 {
 	unsigned long ret = 0;
-	unsigned long flags;
 
 #ifndef CONFIG_MODULES
 	/* There is only the kernel to search.  */
 	return search_one_table(__start___ex_table, __stop___ex_table-1, addr);
 #else
-	/* The kernel is the last "module" -- no need to treat it special.  */
 	struct module *mp;
 
-	spin_lock_irqsave(&modlist_lock, flags);
-	for (mp = module_list; mp != NULL; mp = mp->next) {
-		if (mp->ex_table_start == NULL || !(mp->flags&(MOD_RUNNING|MOD_INITIALIZING)))
+	mod_for_each_locked(mp) {
+		if (mp->ex_table_start == NULL)
 			continue;
 		ret = search_one_table(mp->ex_table_start,
 				       mp->ex_table_end - 1, addr);
 		if (ret)
 			break;
-	}
-	spin_unlock_irqrestore(&modlist_lock, flags);
+	} mod_for_done_locked
 	return ret;
 #endif
 }
diff -ur linux-2.5/include/linux/module.h linux-mod/include/linux/module.h
--- linux-2.5/include/linux/module.h	Thu Aug  1 16:43:07 2002
+++ linux-mod/include/linux/module.h	Thu Aug  1 14:41:01 2002
@@ -317,6 +306,19 @@
 #define MOD_IN_USE		1
 
 extern struct module *module_list;
+extern spinlock_t modlist_lock;
+
+#define mod_for_each_locked(mod)					\
+{									\
+	unsigned long __flags;						\
+	spin_lock_irqsave(&modlist_lock, __flags);			\
+	for (mod = module_list; mod != NULL; mod = mod->next) {		\
+		if (!(mod->flags & (MOD_RUNNING|MOD_INITIALIZING)))	\
+			continue;
+#define mod_for_done_locked						\
+	}								\
+	spin_unlock_irqrestore(&modlist_lock, __flags);			\
+}
 
 #endif /* !__GENKSYMS__ */
 
diff -ur linux-2.5/kernel/module.c linux-mod/kernel/module.c
--- linux-2.5/kernel/module.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/kernel/module.c	Thu Aug  1 17:10:39 2002
@@ -45,6 +45,7 @@
 struct module kernel_module =
 {
 	.size_of_struct		= sizeof(struct module),
+	.size			= sizeof(struct module),
 	.name 			= "",
 	.uc	 		= {ATOMIC_INIT(1)},
 	.flags			= MOD_RUNNING,
