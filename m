Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUCJEBf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 23:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbUCJEBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 23:01:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:51154 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261937AbUCJEB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 23:01:28 -0500
Subject: [PATCH] ppc64: Let OF initialize all displays in the system
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1078891091.9745.56.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 10 Mar 2004 14:58:11 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reworks the early boot calls to OF to initialize displays.

All present displays are now initialized in reverse order so the
OF console stays on the first one. Initializing them all is necessary
for dual head configurations as we need OF driver to properly setup
the secondary TMDS of the video card, XFree isn't able to do that
currently

Ben.

===== arch/ppc64/kernel/prom.c 1.57 vs edited =====
--- 1.57/arch/ppc64/kernel/prom.c	Mon Mar  1 11:58:47 2004
+++ edited/arch/ppc64/kernel/prom.c	Tue Mar  9 20:54:04 2004
@@ -130,6 +130,7 @@
 struct prom_t prom;
 
 char *prom_display_paths[FB_MAX] __initdata = { 0, };
+phandle prom_display_nodes[FB_MAX] __initdata;
 unsigned int prom_num_displays = 0;
 char *of_stdout_device = 0;
 
@@ -177,7 +178,7 @@
 
 extern unsigned long reloc_offset(void);
 
-extern void enter_prom(void *dummy,...);
+extern void enter_prom(struct prom_args *args);
 extern void copy_and_flush(unsigned long dest, unsigned long src,
 			   unsigned long size, unsigned long offset);
 
@@ -1500,13 +1501,12 @@
 	/* Default machine type. */
 	_systemcfg->platform = prom_find_machine_type();
 
-
 	/* On pSeries, copy the CPU hold code */
 	if (_systemcfg->platform == PLATFORM_PSERIES)
 		copy_and_flush(0, KERNELBASE - offset, 0x100, 0);
 
 	/* Start storing things at klimit */
-	mem = RELOC(klimit) - offset; 
+      	mem = RELOC(klimit) - offset; 
 
 	/* Get the full OF pathname of the stdout device */
 	p = (char *) mem;
@@ -1646,10 +1646,10 @@
 {
 	phandle node;
 	ihandle ih;
-	int i;
+	int i, j;
 	unsigned long offset = reloc_offset();
         struct prom_t *_prom = PTRRELOC(&prom);
-	char type[64], *path;
+	char type[16], *path;
 	static unsigned char default_colors[] = {
 		0x00, 0x00, 0x00,
 		0x00, 0x00, 0xaa,
@@ -1672,6 +1672,12 @@
 
 	_prom->disp_node = 0;
 
+	prom_print(RELOC("Looking for displays\n"));
+	if (RELOC(of_stdout_device) != 0) {
+		prom_print(RELOC("OF stdout is   : "));
+		prom_print(PTRRELOC(RELOC(of_stdout_device)));
+		prom_print(RELOC("\n"));
+	}
 	for (node = 0; prom_next_node(&node); ) {
 		type[0] = 0;
 		call_prom(RELOC("getprop"), 4, 1, node, RELOC("device_type"),
@@ -1682,19 +1688,48 @@
 		path = (char *) mem;
 		memset(path, 0, 256);
 		if ((long) call_prom(RELOC("package-to-path"), 3, 1,
-				    node, path, 255) < 0)
+				    node, path, 250) < 0)
 			continue;
-		prom_print(RELOC("opening display "));
+		prom_print(RELOC("found display   : "));
+		prom_print(path);
+		prom_print(RELOC("\n"));
+		
+		/*
+		 * If this display is the device that OF is using for stdout,
+		 * move it to the front of the list.
+		 */
+		mem += strlen(path) + 1;
+		i = RELOC(prom_num_displays);
+		RELOC(prom_num_displays) = i + 1;
+		if (RELOC(of_stdout_device) != 0 && i > 0
+		    && strcmp(PTRRELOC(RELOC(of_stdout_device)), path) == 0) {
+			for (; i > 0; --i) {
+				RELOC(prom_display_paths[i])
+					= RELOC(prom_display_paths[i-1]);
+				RELOC(prom_display_nodes[i])
+					= RELOC(prom_display_nodes[i-1]);
+			}
+			_prom->disp_node = (ihandle)(unsigned long)node;
+		}
+		RELOC(prom_display_paths[i]) = PTRUNRELOC(path);
+		RELOC(prom_display_nodes[i]) = node;
+		if (_prom->disp_node == 0)
+			_prom->disp_node = (ihandle)(unsigned long)node;
+		if (RELOC(prom_num_displays) >= FB_MAX)
+			break;
+	}
+	prom_print(RELOC("Opening displays...\n"));
+	for (j = RELOC(prom_num_displays) - 1; j >= 0; j--) {
+		path = PTRRELOC(RELOC(prom_display_paths[j]));
+		prom_print(RELOC("opening display : "));
 		prom_print(path);
 		ih = (ihandle)call_prom(RELOC("open"), 1, 1, path);
 		if (ih == (ihandle)0 || ih == (ihandle)-1) {
 			prom_print(RELOC("... failed\n"));
 			continue;
 		}
-		prom_print(RELOC("... ok\n"));
 
-		if (_prom->disp_node == 0)
-			_prom->disp_node = (ihandle)(unsigned long)node;
+		prom_print(RELOC("... ok\n"));
 
 		/* Setup a useable color table when the appropriate
 		 * method is available. Should update this to set-colors */
@@ -1711,26 +1746,8 @@
 					   clut[2]) != 0)
 				break;
 #endif /* CONFIG_LOGO_LINUX_CLUT224 */
-
-		/*
-		 * If this display is the device that OF is using for stdout,
-		 * move it to the front of the list.
-		 */
-		mem += strlen(path) + 1;
-		i = RELOC(prom_num_displays)++;
-		if (RELOC(of_stdout_device) != 0 && i > 0
-		    && strcmp(PTRRELOC(RELOC(of_stdout_device)), path) == 0) {
-			for (; i > 0; --i)
-				RELOC(prom_display_paths[i]) = RELOC(prom_display_paths[i-1]);
-		}
-		RELOC(prom_display_paths[i]) = PTRUNRELOC(path);
-		if (RELOC(prom_num_displays) >= FB_MAX)
-			break;
-		/* XXX Temporary workaround: only open the first display so we don't
-		 * lose debug output
-		 */
-		break;
 	}
+	
 	return DOUBLEWORD_ALIGN(mem);
 }
 


