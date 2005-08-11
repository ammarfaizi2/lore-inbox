Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbVHKLEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbVHKLEX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 07:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbVHKLEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 07:04:23 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:29389 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1030262AbVHKLEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 07:04:23 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: pmarques@grupopie.com, kai.germaschewski@gmx.de, kai@germaschewski.name
Subject: [PATCH] do not save thousands of useless symbols in KALLSYMS kernels
Date: Thu, 11 Aug 2005 14:03:39 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LCz+Cgxq9w6Bruz"
Message-Id: <200508111403.39708.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_LCz+Cgxq9w6Bruz
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sample of my kernel's mostly useless symbols
(starting_with:# of symbols):

__func__: 624
__vendorstr_: 1760
__pci_fixup_PCI_: 116
__ksymtab_: 2597
__kstrtab_: 2597
__kcrctab_: 2597
__initcall_: 236
__devicestr_: 4686
__devices_: 1760
Total: 16973
Lines in System.map: 39735

Excluding them from in-kernel symbol table saves ~300kb:

   text    data     bss     dec     hex filename
4337710 1054414  259296 5651420  563bdc vmlinux.carrier1 - w/o KALLSYMS
4342068 1296046  259296 5897410  59fcc2 vmlinux - with KALLSYMS+patch
4341948 1607634  259296 6208878  5ebd6e vmlinux.carrier - with KALLSYMS
        ^^^^^^^
--
vda

--Boundary-00=_LCz+Cgxq9w6Bruz
Content-Type: text/x-diff;
  charset="koi8-r";
  name="kallsyms.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kallsyms.c.diff"

--- linux-2.6.12.org/scripts/kallsyms.c.org	Sun Jun 19 16:11:06 2005
+++ linux-2.6.12.org/scripts/kallsyms.c	Wed Aug 10 23:52:06 2005
@@ -36,7 +36,7 @@
 
 /* we use only a subset of the complete symbol table to gather the token count,
  * to speed up compression, at the expense of a little compression ratio */
-#define WORKING_SET		1024
+#define WORKING_SET		(1024*4)
 
 /* first find the best token only on the list of tokens that would profit more
  * than GOOD_BAD_THRESHOLD. Only if this list is empty go to the "bad" list.
@@ -102,11 +102,34 @@ usage(void)
  * This ignores the intensely annoying "mapping symbols" found
  * in ARM ELF files: $a, $t and $d.
  */
+/*
+__func__: 624
+__vendorstr_: 1760
+__pci_fixup_PCI_: 116
+__ksymtab_: 2597
+__kstrtab_: 2597
+__kcrctab_: 2597
+__initcall_: 236
+__devicestr_: 4686
+__devices_: 1760
+Total: 16973
+Lines in System.map: 39735
+*/
 static inline int
 is_arm_mapping_symbol(const char *str)
 {
-	return str[0] == '$' && strchr("atd", str[1])
-	       && (str[2] == '\0' || str[2] == '.');
+	return (str[0] == '$' && strchr("atd", str[1])
+	       && (str[2] == '\0' || str[2] == '.')
+	)
+	|| (0 == strncmp(str, "__ksymtab_", sizeof("__ksymtab_")-1))
+	|| (0 == strncmp(str, "__kstrtab_", sizeof("__kstrtab_")-1))
+	|| (0 == strncmp(str, "__kcrctab_", sizeof("__kcrctab_")-1))
+	|| (0 == strncmp(str, "__devices_", sizeof("__devices_")-1))
+	|| (0 == strncmp(str, "__devicestr_", sizeof("__devicestr_")-1))
+	|| (0 == strncmp(str, "__vendorstr_", sizeof("__vendorstr_")-1))
+	|| (0 == strncmp(str, "__pci_fixup_PCI_", sizeof("__pci_fixup_PCI_")-1))
+	|| (0 == strncmp(str, "__func__", sizeof("__func__")-1))
+	;
 }
 
 static int

--Boundary-00=_LCz+Cgxq9w6Bruz--

