Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264883AbUFAEcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264883AbUFAEcV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 00:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbUFAEcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 00:32:21 -0400
Received: from ozlabs.org ([203.10.76.45]:24456 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264883AbUFAEcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 00:32:17 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16572.1746.652355.7388@cargo.ozlabs.ibm.com>
Date: Tue, 1 Jun 2004 14:32:18 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org, olh@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][PPC64] Fix missing RELOCs, add linux,phandle property
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a couple of bugs in arch/ppc64/kernel/prom.c.  We
were missing a couple of places where we needed to use RELOC().  I
added the RELOC in one case, and in the other, moved the variable that
we were accessing onto the stack (and reduced its size).  (We use the
variable to get a property value, but we aren't interested in the
value, just in whether the property exists or not.  Since we pass the
size of the variable to the OF getprop call, it won't overflow.)  The
effect of missing the RELOCs would be that random memory locations get
used on IBM pSeries systems (possibly causing random boot failures).

The other thing that this does is add a linux,phandle property to each
node, containing the phandle for the node, which is the token that OF
uses to identify the node.  Some nodes reference other nodes by means
of their phandle.  Without the linux,phandle property, userspace code
looking at the OF device-tree image in /proc/device-tree has no way of
knowing which other node is being referenced.

Signed-off-by: Paul Mackerras <paulus@samba.org>

Please apply.

Thanks,
Paul.

diff -urN linux-2.5/arch/ppc64/kernel/prom.c ppc64-2.5-pseries/arch/ppc64/kernel/prom.c
--- linux-2.5/arch/ppc64/kernel/prom.c	2004-05-26 07:58:59.000000000 +1000
+++ ppc64-2.5-pseries/arch/ppc64/kernel/prom.c	2004-05-31 14:20:35.000000000 +1000
@@ -654,8 +654,6 @@
 #endif /* DEBUG_PROM */
 }
 
-static char hypertas_funcs[1024];
-
 static void __init
 prom_instantiate_rtas(void)
 {
@@ -665,6 +663,7 @@
 	struct systemcfg *_systemcfg = RELOC(systemcfg);
 	ihandle prom_rtas;
         u32 getprop_rval;
+	char hypertas_funcs[4];
 
 #ifdef DEBUG_PROM
 	prom_print(RELOC("prom_instantiate_rtas: start...\n"));
@@ -1556,7 +1555,7 @@
 		if (*mem_end != RELOC(initrd_start))
 			prom_panic(RELOC("No memory for copy_device_tree"));
 
-		prom_print("Huge device_tree: moving initrd\n");
+		prom_print(RELOC("Huge device_tree: moving initrd\n"));
 		/* Move by 4M. */
 		initrd_len = RELOC(initrd_end) - RELOC(initrd_start);
 		*mem_end = RELOC(initrd_start) + 4 * 1024 * 1024;
@@ -1590,6 +1589,7 @@
 	char *prev_name, *namep;
 	unsigned char *valp;
 	unsigned long offset = reloc_offset();
+	phandle ibm_phandle;
 
 	np = make_room(mem_start, mem_end, struct device_node);
 	memset(np, 0, sizeof(*np));
@@ -1652,23 +1652,24 @@
 		prev_propp = &pp->next;
 	}
 
-	/* Add a "linux_phandle" value */
-        if (np->node) {
-		u32 ibm_phandle = 0;
-		int len;
-
-                /* First see if "ibm,phandle" exists and use its value */
-                len = (int)
-                        call_prom(RELOC("getprop"), 4, 1, node, RELOC("ibm,phandle"),
-                                  &ibm_phandle, sizeof(ibm_phandle));
-                if (len < 0) {
-                        np->linux_phandle = np->node;
-                } else {
-                        np->linux_phandle = ibm_phandle;
-		}
-	}
-
-	*prev_propp = 0;
+	/* Add a "linux,phandle" property. */
+	namep = make_room(mem_start, mem_end, char[16]);
+	strcpy(namep, RELOC("linux,phandle"));
+	pp = make_room(mem_start, mem_end, struct property);
+	pp->name = PTRUNRELOC(namep);
+	pp->length = sizeof(phandle);
+	valp = make_room(mem_start, mem_end, phandle);
+	pp->value = PTRUNRELOC(valp);
+	*(phandle *)valp = node;
+	*prev_propp = PTRUNRELOC(pp);
+	pp->next = NULL;
+
+	/* Set np->linux_phandle to the value of the ibm,phandle property
+	   if it exists, otherwise to the phandle for this node. */
+	np->linux_phandle = node;
+	if ((int)call_prom(RELOC("getprop"), 4, 1, node, RELOC("ibm,phandle"),
+			   &ibm_phandle, sizeof(ibm_phandle)) > 0)
+		np->linux_phandle = ibm_phandle;
 
 	/* get the node's full name */
 	namep = (char *)*mem_start;
