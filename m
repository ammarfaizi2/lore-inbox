Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWAFFg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWAFFg0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 00:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752384AbWAFFg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 00:36:26 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:25256 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751171AbWAFFg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 00:36:26 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: [patch 2.6.15] Tell kallsyms_lookup_name() to ignore type U entries
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 Jan 2006 16:36:19 +1100
Message-ID: <11037.1136525779@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When one module exports a function symbol and another module uses that
symbol then kallsyms shows the symbol twice.  Once from the consumer
with a type of 'U' and once from the provider with a type of 't' or
'T'.  On most architectures, both entries have the same address so it
does not matter which one is returned by kallsyms_lookup_name().  But
on architectures with function descriptors, the 'U' entry points to the
descriptor, not to the code body, which is not what we want.

IA64 # grep -w qla2x00_remove_one /proc/kallsyms
a000000208c25ef8 U qla2x00_remove_one   [qla2300]   <= descriptor
a000000208bf44c0 t qla2x00_remove_one   [qla2xxx]   <= function body

Tell kallsyms_lookup_name() to ignore type U entries.

Signed-off-by: Keith Owens <kaos@sgi.com>

---

 kallsyms.c |    6 ++++--
 module.c   |    3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

Index: linux/kernel/kallsyms.c
===================================================================
--- linux.orig/kernel/kallsyms.c	2006-01-06 12:58:52.842111488 +1100
+++ linux/kernel/kallsyms.c	2006-01-06 12:59:03.436355969 +1100
@@ -144,12 +144,14 @@ unsigned long kallsyms_lookup_name(const
 {
 	char namebuf[KSYM_NAME_LEN+1];
 	unsigned long i;
-	unsigned int off;
+	unsigned int off, prev_off;
 
 	for (i = 0, off = 0; i < kallsyms_num_syms; i++) {
+		prev_off = off;
 		off = kallsyms_expand_symbol(off, namebuf);
 
-		if (strcmp(namebuf, name) == 0)
+		if (strcmp(namebuf, name) == 0 &&
+		    kallsyms_get_symbol_type(prev_off) != 'U')
 			return kallsyms_addresses[i];
 	}
 	return module_kallsyms_lookup_name(name);
Index: linux/kernel/module.c
===================================================================
--- linux.orig/kernel/module.c	2006-01-06 12:58:52.841135060 +1100
+++ linux/kernel/module.c	2006-01-06 12:59:03.438308825 +1100
@@ -2050,7 +2050,8 @@ static unsigned long mod_find_symname(st
 	unsigned int i;
 
 	for (i = 0; i < mod->num_symtab; i++)
-		if (strcmp(name, mod->strtab+mod->symtab[i].st_name) == 0)
+		if (strcmp(name, mod->strtab+mod->symtab[i].st_name) == 0 &&
+		    mod->symtab[i].st_info != 'U')
 			return mod->symtab[i].st_value;
 	return 0;
 }

