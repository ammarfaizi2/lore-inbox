Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266386AbUJAUSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266386AbUJAUSx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 16:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266344AbUJAUQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 16:16:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6160 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266308AbUJAULS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:11:18 -0400
Date: Fri, 1 Oct 2004 21:11:06 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC] ARM binutils feature churn causing kernel problems
Message-ID: <20041001211106.F30122@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Sam Ravnborg <sam@ravnborg.org>
References: <20040927210305.A26680@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040927210305.A26680@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Mon, Sep 27, 2004 at 09:03:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 09:03:05PM +0100, Russell King wrote:
> [<address>] ($a+0xfoo/0xbar) from [<address>] ($a+0xfoo/0xbar)

Ok, here's a _partly_ tested patch which fixes kallsyms itself.  I'm
not certain whether this fixes the module side of it since I haven't
had an oops from a module to confirm yet.

Comments at this stage only please?

===== kernel/module.c 1.120 vs edited =====
--- 1.120/kernel/module.c	2004-09-08 07:33:04 +01:00
+++ edited/kernel/module.c	2004-10-01 20:39:43 +01:00
@@ -1903,6 +1903,15 @@
 }
 
 #ifdef CONFIG_KALLSYMS
+/*
+ * This ignores the intensely annoying "mapping symbols" found
+ * in ARM ELF files: $a, $t and $d.
+ */
+static inline int is_arm_mapping_symbol(const char *str)
+{
+	return str[0] == '$' && strchr("atd", str[1]) && str[2] == '\0';
+}
+
 static const char *get_ksymbol(struct module *mod,
 			       unsigned long addr,
 			       unsigned long *size,
@@ -1927,11 +1936,13 @@
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
+++ edited/scripts/kallsyms.c	2004-10-01 20:41:43 +01:00
@@ -32,6 +32,16 @@
 	exit(1);
 }
 
+/*
+ * This ignores the intensely annoying "mapping symbols" found
+ * in ARM ELF files: $a, $t and $d.
+ */
+static inline int
+is_arm_mapping_symbol(const char *str)
+{
+	return str[0] == '$' && strchr("atd", str[1]) && str[2] == '\0';
+}
+
 static int
 read_symbol(FILE *in, struct sym_entry *s)
 {
@@ -56,7 +66,8 @@
 		_sinittext = s->addr;
 	else if (strcmp(str, "_einittext") == 0)
 		_einittext = s->addr;
-	else if (toupper(s->type) == 'A' || toupper(s->type) == 'U')
+	else if (toupper(s->type) == 'A' || toupper(s->type) == 'U' ||
+		 is_arm_mapping_symbol(str))
 		return -1;
 
 	s->sym = strdup(str);


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
