Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVDBI3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVDBI3R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 03:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVDBI3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 03:29:16 -0500
Received: from ozlabs.org ([203.10.76.45]:2712 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261216AbVDBI2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 03:28:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16974.22444.835968.353861@cargo.ozlabs.ibm.com>
Date: Sat, 2 Apr 2005 18:28:28 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, trini@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc: clean up arch/ppc/syslib/prom_init.c
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The call_prom routine in arch/ppc/syslib/prom_init.c, which does a
client call to Open Firmware, returns a void *, and we use void * for
instance handles and package handles that are returned from and used
in OF calls.  This is a bad idea - we can't ever dereference those
things, and we end up with a lot of casts because arguments to and
return values from OF calls are sometimes handles and sometimes
numbers.

This patch cleans things up by using u32 as the type for OF handles.
The return type of call_prom becomes int because the return value from
an OF call is often an int status code.  The number of casts in
prom_init.c is reduced substantially by this patch.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc/syslib/prom_init.c pmac-2.5/arch/ppc/syslib/prom_init.c
--- linux-2.5/arch/ppc/syslib/prom_init.c	2005-01-29 09:58:49.000000000 +1100
+++ pmac-2.5/arch/ppc/syslib/prom_init.c	2005-04-02 16:48:02.000000000 +1000
@@ -53,11 +53,13 @@
 
 #define ALIGNUL(x) (((x) + sizeof(unsigned long)-1) & -sizeof(unsigned long))
 
+typedef u32 prom_arg_t;
+
 struct prom_args {
 	const char *service;
 	int nargs;
 	int nret;
-	void *args[10];
+	prom_arg_t args[10];
 };
 
 struct pci_address {
@@ -93,9 +95,9 @@
 };
 
 static void prom_exit(void);
-static void *call_prom(const char *service, int nargs, int nret, ...);
-static void *call_prom_ret(const char *service, int nargs, int nret,
-			   void **rets, ...);
+static int  call_prom(const char *service, int nargs, int nret, ...);
+static int  call_prom_ret(const char *service, int nargs, int nret,
+			  prom_arg_t *rets, ...);
 static void prom_print_hex(unsigned int v);
 static int  prom_set_color(ihandle ih, int i, int r, int g, int b);
 static int  prom_next_node(phandle *nodep);
@@ -146,7 +148,7 @@
 		;
 }
 
-static void * __init
+static int __init
 call_prom(const char *service, int nargs, int nret, ...)
 {
 	va_list list;
@@ -158,16 +160,16 @@
 	prom_args.nret = nret;
 	va_start(list, nret);
 	for (i = 0; i < nargs; ++i)
-		prom_args.args[i] = va_arg(list, void *);
+		prom_args.args[i] = va_arg(list, prom_arg_t);
 	va_end(list);
 	for (i = 0; i < nret; ++i)
-		prom_args.args[i + nargs] = NULL;
+		prom_args.args[i + nargs] = 0;
 	prom(&prom_args);
 	return prom_args.args[nargs];
 }
 
-static void * __init
-call_prom_ret(const char *service, int nargs, int nret, void **rets, ...)
+static int __init
+call_prom_ret(const char *service, int nargs, int nret, prom_arg_t *rets, ...)
 {
 	va_list list;
 	int i;
@@ -178,10 +180,10 @@
 	prom_args.nret = nret;
 	va_start(list, rets);
 	for (i = 0; i < nargs; ++i)
-		prom_args.args[i] = va_arg(list, void *);
+		prom_args.args[i] = va_arg(list, int);
 	va_end(list);
 	for (i = 0; i < nret; ++i)
-		prom_args.args[i + nargs] = NULL;
+		prom_args.args[i + nargs] = 0;
 	prom(&prom_args);
 	for (i = 1; i < nret; ++i)
 		rets[i-1] = prom_args.args[nargs + i];
@@ -227,19 +229,7 @@
 static int __init
 prom_set_color(ihandle ih, int i, int r, int g, int b)
 {
-	struct prom_args prom_args;
-
-	prom_args.service = "call-method";
-	prom_args.nargs = 6;
-	prom_args.nret = 1;
-	prom_args.args[0] = "color!";
-	prom_args.args[1] = ih;
-	prom_args.args[2] = (void *) i;
-	prom_args.args[3] = (void *) b;
-	prom_args.args[4] = (void *) g;
-	prom_args.args[5] = (void *) r;
-	prom(&prom_args);
-	return (int) prom_args.args[6];
+	return call_prom("call-method", 6, 1, "color!", ih, i, b, g, r);
 }
 
 static int __init
@@ -363,9 +353,9 @@
 	};
 	const unsigned char *clut;
 
-	prom_disp_node = NULL;
+	prom_disp_node = 0;
 
-	for (node = NULL; prom_next_node(&node); ) {
+	for (node = 0; prom_next_node(&node); ) {
 		type[0] = 0;
 		call_prom("getprop", 4, 1, node, "device_type",
 			  type, sizeof(type));
@@ -374,8 +364,7 @@
 		/* It seems OF doesn't null-terminate the path :-( */
 		path = (char *) mem;
 		memset(path, 0, 256);
-		if ((int) call_prom("package-to-path", 3, 1,
-				    node, path, 255) < 0)
+		if (call_prom("package-to-path", 3, 1, node, path, 255) < 0)
 			continue;
 
 		/*
@@ -417,11 +406,11 @@
 				prom_disp_node = prom_display_nodes[j];
 				j--;
 			} else
-				prom_disp_node = NULL;
+				prom_disp_node = 0;
 			continue;
 		} else {
 			prom_print("... ok\n");
-			call_prom("setprop", 4, 1, node, "linux,opened", 0, NULL);
+			call_prom("setprop", 4, 1, node, "linux,opened", 0, 0);
 
 			/*
 			 * Setup a usable color table when the appropriate
@@ -448,13 +437,13 @@
 	if (prom_stdout) {
 		phandle p;
 		p = call_prom("instance-to-package", 1, 1, prom_stdout);
-		if (p && (int)p != -1) {
+		if (p && p != -1) {
 			type[0] = 0;
 			call_prom("getprop", 4, 1, p, "device_type",
 				  type, sizeof(type));
 			if (strcmp(type, "display") == 0)
 				call_prom("setprop", 4, 1, p, "linux,boot-display",
-					  0, NULL);
+					  0, 0);
 		}
 	}
 
@@ -495,9 +484,8 @@
 		  &address, sizeof(address));
 	if (address == 0) {
 		/* look for an assigned address with a size of >= 1MB */
-		naddrs = (int) call_prom(getprop, 4, 1, dp,
-				"assigned-addresses",
-				addrs, sizeof(addrs));
+		naddrs = call_prom(getprop, 4, 1, dp, "assigned-addresses",
+				   addrs, sizeof(addrs));
 		naddrs /= sizeof(struct pci_reg_property);
 		for (i = 0; i < naddrs; ++i) {
 			if (addrs[i].size_lo >= (1 << 20)) {
@@ -602,16 +590,14 @@
 		pp = (struct property *) mem_start;
 		namep = (char *) (pp + 1);
 		pp->name = PTRUNRELOC(namep);
-		if ((int) call_prom("nextprop", 3, 1, node, prev_name,
-				    namep) <= 0)
+		if (call_prom("nextprop", 3, 1, node, prev_name, namep) <= 0)
 			break;
 		mem_start = ALIGNUL((unsigned long)namep + strlen(namep) + 1);
 		prev_name = namep;
 		valp = (unsigned char *) mem_start;
 		pp->value = PTRUNRELOC(valp);
-		pp->length = (int)
-			call_prom("getprop", 4, 1, node, namep,
-				  valp, mem_end - mem_start);
+		pp->length = call_prom("getprop", 4, 1, node, namep,
+				       valp, mem_end - mem_start);
 		if (pp->length < 0)
 			continue;
 #ifdef MAX_PROPERTY_LENGTH
@@ -622,7 +608,7 @@
 		*prev_propp = PTRUNRELOC(pp);
 		prev_propp = &pp->next;
 	}
-	if (np->node != NULL) {
+	if (np->node != 0) {
 		/* Add a "linux,phandle" property" */
 		pp = (struct property *) mem_start;
 		*prev_propp = PTRUNRELOC(pp);
@@ -637,8 +623,8 @@
 	*prev_propp = NULL;
 
 	/* get the node's full name */
-	l = (int) call_prom("package-to-path", 3, 1, node,
-			    (char *) mem_start, mem_end - mem_start);
+	l = call_prom("package-to-path", 3, 1, node,
+		      mem_start, mem_end - mem_start);
 	if (l >= 0) {
 		np->full_name = PTRUNRELOC((char *) mem_start);
 		*(char *)(mem_start + l) = 0;
@@ -647,7 +633,7 @@
 
 	/* do all our children */
 	child = call_prom("child", 1, 1, node);
-	while (child != (void *)0) {
+	while (child != 0) {
 		mem_start = inspect_node(child, np, mem_start, mem_end,
 					 allnextpp);
 		child = call_prom("peer", 1, 1, child);
@@ -698,8 +684,8 @@
 	 *      chrp we have a device_type property -- Cort
 	 */
 	node = call_prom("finddevice", 1, 1, "/");
-	if ((int)call_prom("getprop", 4, 1, node,
-			   "device_type",type, sizeof(type)) <= 0)
+	if (call_prom("getprop", 4, 1, node,
+		      "device_type", type, sizeof(type)) <= 0)
 		return;
 
 	/* copy the holding pattern code to someplace safe (0) */
@@ -711,7 +697,7 @@
 	/* look for cpus */
 	*(unsigned long *)(0x0) = 0;
 	asm volatile("dcbf 0,%0": : "r" (0) : "memory");
-	for (node = NULL; prom_next_node(&node); ) {
+	for (node = 0; prom_next_node(&node); ) {
 		type[0] = 0;
 		call_prom("getprop", 4, 1, node, "device_type",
 			  type, sizeof(type));
@@ -719,8 +705,7 @@
 			continue;
 		path = (char *) mem;
 		memset(path, 0, 256);
-		if ((int) call_prom("package-to-path", 3, 1,
-				    node, path, 255) < 0)
+		if (call_prom("package-to-path", 3, 1, node, path, 255) < 0)
 			continue;
 		reg = -1;
 		call_prom("getprop", 4, 1, node, "reg", &reg, sizeof(reg));
@@ -753,11 +738,10 @@
 prom_instantiate_rtas(void)
 {
 	ihandle prom_rtas;
-	unsigned int i;
-	struct prom_args prom_args;
+	prom_arg_t result;
 
 	prom_rtas = call_prom("finddevice", 1, 1, "/rtas");
-	if (prom_rtas == (void *) -1)
+	if (prom_rtas == -1)
 		return;
 
 	rtas_size = 0;
@@ -779,17 +763,10 @@
 
 	prom_rtas = call_prom("open", 1, 1, "/rtas");
 	prom_print("...");
-	prom_args.service = "call-method";
-	prom_args.nargs = 3;
-	prom_args.nret = 2;
-	prom_args.args[0] = "instantiate-rtas";
-	prom_args.args[1] = prom_rtas;
-	prom_args.args[2] = (void *) rtas_data;
-	prom(&prom_args);
-	i = 0;
-	if (prom_args.args[3] == 0)
-		i = (unsigned int)prom_args.args[4];
-	rtas_entry = i;
+	rtas_entry = 0;
+	if (call_prom_ret("call-method", 3, 2, &result,
+			  "instantiate-rtas", prom_rtas, rtas_data) == 0)
+		rtas_entry = result;
 	if ((rtas_entry == -1) || (rtas_entry == 0))
 		prom_print(" failed\n");
 	else
@@ -809,7 +786,7 @@
 	int i, l;
 	char *p, *d;
  	unsigned long phys;
-	void *result[3];
+	prom_arg_t result[3];
 	char model[32];
 	phandle node;
 	int rc;
@@ -820,11 +797,10 @@
 	/* First get a handle for the stdout device */
 	prom = pp;
 	prom_chosen = call_prom("finddevice", 1, 1, "/chosen");
-	if (prom_chosen == (void *)-1)
+	if (prom_chosen == -1)
 		prom_exit();
-	if ((int) call_prom("getprop", 4, 1, prom_chosen,
-			    "stdout", &prom_stdout,
-			    sizeof(prom_stdout)) <= 0)
+	if (call_prom("getprop", 4, 1, prom_chosen, "stdout",
+		      &prom_stdout, sizeof(prom_stdout)) <= 0)
 		prom_exit();
 
 	/* Get the full OF pathname of the stdout device */
@@ -837,8 +813,7 @@
 
 	/* Get the boot device and translate it to a full OF pathname. */
 	p = (char *) mem;
-	l = (int) call_prom("getprop", 4, 1, prom_chosen,
-			    "bootpath", p, 1<<20);
+	l = call_prom("getprop", 4, 1, prom_chosen, "bootpath", p, 1<<20);
 	if (l > 0) {
 		p[l] = 0;	/* should already be null-terminated */
 		bootpath = PTRUNRELOC(p);
@@ -885,15 +860,15 @@
 	 	 */
 		prom_print("(already at 0xc0000000) phys=0\n");
 		phys = 0;
-	} else if ((int) call_prom("getprop", 4, 1, prom_chosen, "mmu",
-				 &prom_mmu, sizeof(prom_mmu)) <= 0) {
+	} else if (call_prom("getprop", 4, 1, prom_chosen, "mmu",
+			     &prom_mmu, sizeof(prom_mmu)) <= 0) {
 		prom_print(" no MMU found\n");
-	} else if ((int)call_prom_ret("call-method", 4, 4, result, "translate",
-				      prom_mmu, &_stext, 1) != 0) {
+	} else if (call_prom_ret("call-method", 4, 4, result, "translate",
+				 prom_mmu, &_stext, 1) != 0) {
 		prom_print(" (translate failed)\n");
 	} else {
 		/* We assume the phys. address size is 3 cells */
-		phys = (unsigned long)result[2];
+		phys = result[2];
 	}
 
 	if (prom_disp_node != 0)
@@ -916,7 +891,7 @@
 	prom_print("returning 0x");
 	prom_print_hex(phys);
 	prom_print("from prom_init\n");
-	prom_stdout = NULL;
+	prom_stdout = 0;
 
 	return phys;
 }
diff -urN linux-2.5/include/asm-ppc/prom.h pmac-2.5/include/asm-ppc/prom.h
--- linux-2.5/include/asm-ppc/prom.h	2003-09-24 10:56:02.000000000 +1000
+++ pmac-2.5/include/asm-ppc/prom.h	2005-04-02 14:14:46.000000000 +1000
@@ -9,9 +9,10 @@
 #define _PPC_PROM_H
 
 #include <linux/config.h>
+#include <linux/types.h>
 
-typedef void *phandle;
-typedef void *ihandle;
+typedef u32 phandle;
+typedef u32 ihandle;
 
 extern char *prom_display_paths[];
 extern unsigned int prom_num_displays;
