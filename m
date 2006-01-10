Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932538AbWAJTxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbWAJTxe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWAJTxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:53:33 -0500
Received: from fmr21.intel.com ([143.183.121.13]:55474 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932524AbWAJTw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:52:59 -0500
Message-Id: <20060110204045.712982192@csdlinux-2.jf.intel.com>
References: <20060110203912.007577046@csdlinux-2.jf.intel.com>
Date: Tue, 10 Jan 2006 12:39:13 -0800
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Cc: tony.luck@intel.com, "Systemtap" <systemtap@sources.redhat.com>,
       "Jim Keniston" <jkenisto@us.ibm.com>, "Keith Owens" <kaos@sgi.com>
Subject: [patch 1/2] [BUG]kallsyms_lookup_name should return the text addres
Content-Disposition: inline; filename=kallsyms_lookup_name_fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH][BUG]kallsyms_lookup_name should return the text addres

On architectures like IA64, kallsyms_lookup_name(name) returns
the actual text address corresponding to the "name" and sometimes
returns address of the function descriptor, the behavior is
not consistent.

The bug is kallsyms_lookup_name() -> module_kallsyms_lookup_name(mod, name)
search the name in the given module and returns the address when
name is matched. This address very well could be the address of 'U' type
which is different address than 't' type.

Example:
Here is the output of cat /proc/kallsyms when we have test1.ko using the
my_test_reentrant_export_function.
-----------------------------------------------------------------
a00000020008c090 U my_test_reentrant_export_function    [test1]
a00000020008c0a0 r __ksymtab_my_test_reentrant_export_function  [mon_dummy]
a00000020008c0b0 r __kstrtab_my_test_reentrant_export_function  [mon_dummy]
a00000020008c0d8 r __kcrctab_my_test_reentrant_export_function  [mon_dummy]
00000000a356bab8 a __crc_my_test_reentrant_export_function      [mon_dummy]
a00000020008c000 T my_test_reentrant_export_function    [mon_dummy]
---------------------------------------------------------------

When we have test1.ko loaded, 
kallsyms_lookup_name(my_test_reentrant_export_function)
returns 0xa00000020008c090 which is a function descriptor address and 
when test1.ko is removed
kallsyms_lookup_name(my_test_reentrant_export_function)
returns 0xa00000020008c000 which is the actual text address

The current patch check for 't' type(text type) and always returns
text address. 

With this below fix, kallsyms_lookup_name(name) always 
returns consistent text address.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
-------------------------------------------------------------------

 kernel/module.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6.15-mm1/kernel/module.c
===================================================================
--- linux-2.6.15-mm1.orig/kernel/module.c
+++ linux-2.6.15-mm1/kernel/module.c
@@ -2085,13 +2085,14 @@ struct module *module_get_kallsym(unsign
 	up(&module_mutex);
 	return NULL;
 }
-
+/* Return the text address corresponding to this name */
 static unsigned long mod_find_symname(struct module *mod, const char *name)
 {
 	unsigned int i;
 
 	for (i = 0; i < mod->num_symtab; i++)
-		if (strcmp(name, mod->strtab+mod->symtab[i].st_name) == 0)
+		if ((strcmp(name, mod->strtab+mod->symtab[i].st_name) == 0) &&
+			(mod->symtab[i].st_info == 't'))
 			return mod->symtab[i].st_value;
 	return 0;
 }

--

