Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162940AbWLBLDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162940AbWLBLDM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162425AbWLBLAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:00:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:61385 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1759457AbWLBK73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aCbodRSdZ8GVupxsCMdQNiDp/RxTLdYlM8NsfGZ8ZS9oheEQVUbylMHJtWavH4bje3D0fQKDPTux4ESetJzLflaXpM4SbKK+KUrqeyBCkDbcRObSiMpeV6HXwBvCdL9zB739mQ5Ct6RC5Y0n8LXYTIXu0/0Y3fNrbt6o4x+jGJo=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/26] Dynamic kernel command-line - ia64
Date: Sat, 2 Dec 2006 12:51:53 +0200
User-Agent: KMail/1.9.5
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021251.54268.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/ia64/kernel/efi.c linux-2.6.19/arch/ia64/kernel/efi.c
--- linux-2.6.19.org/arch/ia64/kernel/efi.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/ia64/kernel/efi.c	2006-12-02 11:31:32.000000000 +0200
@@ -412,11 +412,11 @@ efi_init (void)
 	efi_char16_t *c16;
 	u64 efi_desc_size;
 	char *cp, vendor[100] = "unknown";
-	extern char saved_command_line[];
+	extern char __initdata boot_command_line[];
 	int i;
 
 	/* it's too early to be able to use the standard kernel command line support... */
-	for (cp = saved_command_line; *cp; ) {
+	for (cp = boot_command_line; *cp; ) {
 		if (memcmp(cp, "mem=", 4) == 0) {
 			mem_limit = memparse(cp + 4, &cp);
 		} else if (memcmp(cp, "max_addr=", 9) == 0) {
diff -urNp linux-2.6.19.org/arch/ia64/kernel/sal.c linux-2.6.19/arch/ia64/kernel/sal.c
--- linux-2.6.19.org/arch/ia64/kernel/sal.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/ia64/kernel/sal.c	2006-12-02 11:31:32.000000000 +0200
@@ -194,9 +194,9 @@ static void __init
 chk_nointroute_opt(void)
 {
 	char *cp;
-	extern char saved_command_line[];
+	extern char __initdata boot_command_line[];
 
-	for (cp = saved_command_line; *cp; ) {
+	for (cp = boot_command_line; *cp; ) {
 		if (memcmp(cp, "nointroute", 10) == 0) {
 			no_int_routing = 1;
 			printk ("no_int_routing on\n");
diff -urNp linux-2.6.19.org/arch/ia64/kernel/setup.c linux-2.6.19/arch/ia64/kernel/setup.c
--- linux-2.6.19.org/arch/ia64/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/ia64/kernel/setup.c	2006-12-02 11:31:32.000000000 +0200
@@ -404,7 +404,7 @@ setup_arch (char **cmdline_p)
 	ia64_patch_vtop((u64) __start___vtop_patchlist, (u64) __end___vtop_patchlist);
 
 	*cmdline_p = __va(ia64_boot_param->command_line);
-	strlcpy(saved_command_line, *cmdline_p, COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, *cmdline_p, COMMAND_LINE_SIZE);
 
 	efi_init();
 	io_port_init();
