Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269169AbUJTLoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269169AbUJTLoy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 07:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269401AbUJTLnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 07:43:01 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4873 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270200AbUJTLjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 07:39:02 -0400
Date: Wed, 20 Oct 2004 12:38:53 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Sam Ravnborg <sam@ravnborg.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Fix ARM kernel build with permitted binutils versions
Message-ID: <20041020123853.A14627@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>
References: <20040927210305.A26680@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040927210305.A26680@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Mon, Sep 27, 2004 at 09:03:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here's the latest version of the patch, fixing all presently known
issues with ARM binutils post 2.11.90 by changing the kernel to suit.

Yes, it sounds like the wrong thing to do, but shrug.

---

All ARM binutils versions post 2.11.90 contains an extra "feature" which
interferes with the kernel in various ways - extra "mapping symbols"
in the ELF symbol table '$a', '$t' and '$d'.  This causes two problems:

1. Since '$a' symbols have the same value as function names, this
   causes anything which uses the kallsyms infrastructure to report
   wrong values.
2. programs which parse System.map do not expect symbols to start with
   '$'.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>

===== kernel/module.c 1.120 vs edited =====
--- 1.120/kernel/module.c	2004-09-08 07:33:04 +01:00
+++ edited/kernel/module.c	2004-10-08 16:34:19 +01:00
@@ -1903,6 +1903,16 @@
 }
 
 #ifdef CONFIG_KALLSYMS
+/*
+ * This ignores the intensely annoying "mapping symbols" found
+ * in ARM ELF files: $a, $t and $d.
+ */
+static inline int is_arm_mapping_symbol(const char *str)
+{
+	return str[0] == '$' && strchr("atd", str[1]) 
+	       && (str[2] == '\0' || str[2] == '.');
+}
+
 static const char *get_ksymbol(struct module *mod,
 			       unsigned long addr,
 			       unsigned long *size,
@@ -1927,11 +1937,13 @@
 		 * and inserted at a whim. */
 		if (mod->symtab[i].st_value <= addr
 		    && mod->symtab[i].st_value > mod->symtab[best].st_value
-		    && *(mod->strtab + mod->symtab[i].st_name) != '\0' )
+		    && *(mod->strtab + mod->symtab[i].st_name) != '\0'
+		    && !is_arm_mapping_symbol(mod->strtab + mod->symtab[i].st_name))
 			best = i;
 		if (mod->symtab[i].st_value > addr
 		    && mod->symtab[i].st_value < nextval
-		    && *(mod->strtab + mod->symtab[i].st_name) != '\0')
+		    && *(mod->strtab + mod->symtab[i].st_name) != '\0'
+		    && !is_arm_mapping_symbol(mod->strtab + mod->symtab[i].st_name))
 			nextval = mod->symtab[i].st_value;
 	}
 
===== scripts/kallsyms.c 1.12 vs edited =====
--- 1.12/scripts/kallsyms.c	2004-07-11 10:23:27 +01:00
+++ edited/scripts/kallsyms.c	2004-10-08 16:34:20 +01:00
@@ -32,6 +32,17 @@
 	exit(1);
 }
 
+/*
+ * This ignores the intensely annoying "mapping symbols" found
+ * in ARM ELF files: $a, $t and $d.
+ */
+static inline int
+is_arm_mapping_symbol(const char *str)
+{
+	return str[0] == '$' && strchr("atd", str[1])
+	       && (str[2] == '\0' || str[2] == '.');
+}
+
 static int
 read_symbol(FILE *in, struct sym_entry *s)
 {
@@ -56,7 +67,8 @@
 		_sinittext = s->addr;
 	else if (strcmp(str, "_einittext") == 0)
 		_einittext = s->addr;
-	else if (toupper(s->type) == 'A' || toupper(s->type) == 'U')
+	else if (toupper(s->type) == 'A' || toupper(s->type) == 'U' ||
+		 is_arm_mapping_symbol(str))
 		return -1;
 
 	s->sym = strdup(str);
===== scripts/mksysmap 1.4 vs edited =====
--- 1.4/scripts/mksysmap	2004-08-18 22:05:12 +01:00
+++ edited/scripts/mksysmap	2004-10-08 16:39:39 +01:00
@@ -40,5 +40,5 @@
 # so we just ignore them to let readprofile continue to work.
 # (At least sparc64 has __crc_ in the middle).
 
-$NM -n $1 | grep -v '\( [aUw] \)\|\(__crc_\)' > $2
+$NM -n $1 | grep -v '\( [aUw] \)\|\(__crc_\)\|\( \$[adt]\)' > $2
 

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
