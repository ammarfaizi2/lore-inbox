Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161071AbWBBERo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbWBBERo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 23:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161076AbWBBERo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 23:17:44 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:63651 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161071AbWBBERn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 23:17:43 -0500
Date: Wed, 1 Feb 2006 20:15:43 -0800
To: linux-kernel@vger.kernel.org
Cc: linuxram@us.ibm.com
Subject: [RFC PATCH] crc generation fix for EXPORT_SYMBOL_GPL
Message-ID: <20060202041543.GA6755@RAM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: linuxram@us.ibm.com (Ram Pai)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently genksym does not take into account the GPLness of the exported
symbol while generating the crc for the exported symbol. Any symbol
changes from EXPORT_SYMBOL to EXPORT_SYMBOL_GPL would not reflect in the
Module.symvers file.  This patch fixes that problem.

With the patch one could find the changes in GPLness of the exported symbols
between two releases of the kernel by diffing their Module.symvers file.

Signed-off-by Ram Pai (linuxram@us.ibm.com)

 scripts/genksyms/genksyms.c      |    4 +++-
 scripts/genksyms/genksyms.h      |    2 +-
 scripts/genksyms/parse.c_shipped |    2 +-
 scripts/genksyms/parse.y         |    2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

Index: linux-2.6.15.2/scripts/genksyms/genksyms.c
===================================================================
--- linux-2.6.15.2.orig/scripts/genksyms/genksyms.c
+++ linux-2.6.15.2/scripts/genksyms/genksyms.c
@@ -426,11 +426,11 @@ expand_and_crc_list(struct string_list *
 
   return crc;
 }
 
 void
-export_symbol(const char *name)
+export_symbol(const char *name, const char *export_type)
 {
   struct symbol *sym;
 
   sym = find_symbol(name, SYM_NORMAL);
   if (!sym)
@@ -443,10 +443,12 @@ export_symbol(const char *name)
 	fprintf(debugfile, "Export %s == <", name);
 
       expansion_trail = (struct symbol *)-1L;
 
       crc = expand_and_crc_list(sym->defn, 0xffffffff) ^ 0xffffffff;
+      if (strncmp(export_type, "EXPORT_SYMBOL_GPL", 17) == 0)
+	crc = partial_crc32("__gpl__", crc);
 
       sym = expansion_trail;
       while (sym != (struct symbol *)-1L)
 	{
 	  struct symbol *n = sym->expansion_trail;
Index: linux-2.6.15.2/scripts/genksyms/genksyms.h
===================================================================
--- linux-2.6.15.2.orig/scripts/genksyms/genksyms.h
+++ linux-2.6.15.2/scripts/genksyms/genksyms.h
@@ -65,11 +65,11 @@ extern struct string_list *current_list,
 
 
 struct symbol *find_symbol(const char *name, enum symbol_type ns);
 struct symbol *add_symbol(const char *name, enum symbol_type type,
 			   struct string_list *defn, int is_extern);
-void export_symbol(const char *);
+void export_symbol(const char *, const char *);
 
 struct string_list *reset_list(void);
 void free_list(struct string_list *s, struct string_list *e);
 void free_node(struct string_list *list);
 struct string_list *copy_node(struct string_list *);
Index: linux-2.6.15.2/scripts/genksyms/parse.c_shipped
===================================================================
--- linux-2.6.15.2.orig/scripts/genksyms/parse.c_shipped
+++ linux-2.6.15.2/scripts/genksyms/parse.c_shipped
@@ -1341,11 +1341,11 @@ case 120:
 #line 453 "scripts/genksyms/parse.y"
 { yyval = NULL; ;
     break;}
 case 122:
 #line 459 "scripts/genksyms/parse.y"
-{ export_symbol((*yyvsp[-2])->string); yyval = yyvsp[0]; ;
+{ export_symbol((*yyvsp[-2])->string, (*yyvsp[-4])->string); yyval = yyvsp[0]; ;
     break;}
 }
    /* the action file gets copied in in place of this dollarsign */
 #line 543 "/usr/lib/bison.simple"
 
Index: linux-2.6.15.2/scripts/genksyms/parse.y
===================================================================
--- linux-2.6.15.2.orig/scripts/genksyms/parse.y
+++ linux-2.6.15.2/scripts/genksyms/parse.y
@@ -454,11 +454,11 @@ asm_phrase_opt:
 	| ASM_PHRASE
 	;
 
 export_definition:
 	EXPORT_SYMBOL_KEYW '(' IDENT ')' ';'
-		{ export_symbol((*$3)->string); $$ = $5; }
+		{ export_symbol((*$3)->string, (*$1)->string); $$ = $5; }
 	;
 
 
 %%
 
