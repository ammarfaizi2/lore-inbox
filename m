Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267301AbUJGO5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267301AbUJGO5W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 10:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266864AbUJGO5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 10:57:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20499 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267301AbUJGOy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 10:54:58 -0400
Date: Thu, 7 Oct 2004 15:54:47 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Richard Earnshaw <Richard.Earnshaw@arm.com>, linux-kernel@vger.kernel.org,
       Catalin Marinas <Catalin.Marinas@arm.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC] ARM binutils feature churn causing kernel problems
Message-ID: <20041007155447.A8579@flint.arm.linux.org.uk>
Mail-Followup-To: Richard Earnshaw <Richard.Earnshaw@arm.com>,
	linux-kernel@vger.kernel.org,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Sam Ravnborg <sam@ravnborg.org>
References: <20040927210305.A26680@flint.arm.linux.org.uk> <20041001211106.F30122@flint.arm.linux.org.uk> <tnxllemvgi7.fsf@arm.com> <1096931899.32500.37.camel@localhost.localdomain> <loom.20041005T130541-400@post.gmane.org> <20041005125324.A6910@flint.arm.linux.org.uk> <1096981035.14574.20.camel@pc960.cambridge.arm.com> <20041005141452.B6910@flint.arm.linux.org.uk> <1096983608.14574.32.camel@pc960.cambridge.arm.com> <20041005145140.E6910@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041005145140.E6910@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Tue, Oct 05, 2004 at 02:51:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 02:51:40PM +0100, Russell King wrote:
> On Tue, Oct 05, 2004 at 02:40:08PM +0100, Richard Earnshaw wrote:
> > On Tue, 2004-10-05 at 14:14, Russell King wrote:
> > 
> > > > Why don't you pass s to is_arm_mapping_symbol and have it do the same
> > > > thing as you've done in get_ksymbol?
> > > 
> > > "sym_entry" is not an ELF symtab structure - it's a parsed version
> > > of the `nm' output, and as such does not contain the symbol type nor
> > > binding information.
> > > 
> > 
> > Ah.  That makes the question in your previous message make more sense
> > then.  What options do you pass to nm?
> 
> Only -n.
> 
> > Looking at the output of nm -fsysv shows that currently the mapping
> > symbols are being incorrectly typed (the EABI requires them to be
> > STT_NOTYPE, but the previous ELF specification -- not supported by GNU
> > utils -- required them to be typed by the data they addressed.  I'll
> > submit a patch for that shortly).
> 
> Ugg - in that case, we need to go with the "match the name" version
> until these changes in binutils have matured (== 2 or 3 years time.)

Ok, here's a patch which fixes the problem using the original method.

This patch filters out the ARM mapping symbols by matching the name
only.  Unfortunately, we are unable to use STT_NOTYPE / STB_LOCAL
since existing binutils does not generate ARM mapping symbols
correctly.

Reference: 02-debug/03-kallsyms.diff
Signed-off-by: Russell King <rmk@arm.linux.org.uk>

===== kernel/module.c 1.120 vs edited =====
--- 1.120/kernel/module.c	2004-09-08 07:33:04 +01:00
+++ edited/kernel/module.c	2004-10-01 20:39:43 +01:00
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
+++ edited/scripts/kallsyms.c	2004-10-01 20:41:43 +01:00
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


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
