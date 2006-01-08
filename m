Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWAHDKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWAHDKw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 22:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWAHDKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 22:10:52 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:33987 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751127AbWAHDKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 22:10:52 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
cc: Paulo Marques <pmarques@grupopie.com>
Subject: [patch 2.6.15 v2] Tell kallsyms_lookup_name() to ignore type U entries
In-reply-to: Your message of "Fri, 06 Jan 2006 15:18:46 -0000."
             <43BE8A56.2070500@grupopie.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 08 Jan 2006 14:10:50 +1100
Message-ID: <32183.1136689850@ocs3.ocs.com.au>
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

Tell kallsyms_lookup_name() to ignore type U entries in modules.

Signed-off-by: Keith Owens <kaos@sgi.com>

---

 module.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

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


