Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWICW3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWICW3t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWICW3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:29:48 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:10453 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751232AbWICW3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:29:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TV8c0vFAR7YNaDv9zTBF5MxdzhBjXeReqPm7pUb7ruqCMs2j4feX2W1AZ4Jj8yfSwt982JUfC+ivQhkDurZJpLtg6Bb9opm5d+fzw1C/B3syrhthZCx19sk4Ja5XZj2v4bda3ZWEtoOGBfIRnxvFXaXUcxQ3CPrJkCqFFgcXiFg=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: [PATCH 10/26] Dynamic kernel command-line - ia64
Date: Mon, 4 Sep 2006 01:19:54 +0300
User-Agent: KMail/1.9.4
Cc: Matt Domsch <Matt_Domsch@dell.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johninsd@san.rr.com,
       davej@codemonkey.org.uk, Riley@williams.name, trini@kernel.crashing.org,
       davem@davemloft.net, ecd@brainaid.de, jj@sunsite.ms.mff.cuni.cz,
       anton@samba.org, wli@holomorphy.com, lethal@linux-sh.org, rc@rc0.org.uk,
       spyro@f2s.com, rth@twiddle.net, avr32@atmel.com, hskinnemoen@atmel.com,
       starvik@axis.com, ralf@linux-mips.org, matthew@wil.cx,
       grundler@parisc-linux.org, geert@linux-m68k.org, zippel@linux-m68k.org,
       paulus@samba.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
       uclinux-v850@lsi.nec.co.jp, chris@zankel.net
References: <200609040115.22856.alon.barlev@gmail.com>
In-Reply-To: <200609040115.22856.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609040119.59772.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rename saved_command_line into boot_command_line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.18-rc5-mm1.org/arch/ia64/kernel/efi.c linux-2.6.18-rc5-mm1/arch/ia64/kernel/efi.c
--- linux-2.6.18-rc5-mm1.org/arch/ia64/kernel/efi.c	2006-09-03 18:56:48.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/ia64/kernel/efi.c	2006-09-03 23:52:15.000000000 +0300
@@ -413,11 +413,11 @@ efi_init (void)
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
diff -urNp linux-2.6.18-rc5-mm1.org/arch/ia64/kernel/sal.c linux-2.6.18-rc5-mm1/arch/ia64/kernel/sal.c
--- linux-2.6.18-rc5-mm1.org/arch/ia64/kernel/sal.c	2006-09-03 18:55:08.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/ia64/kernel/sal.c	2006-09-03 23:42:12.000000000 +0300
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
diff -urNp linux-2.6.18-rc5-mm1.org/arch/ia64/kernel/setup.c linux-2.6.18-rc5-mm1/arch/ia64/kernel/setup.c
--- linux-2.6.18-rc5-mm1.org/arch/ia64/kernel/setup.c	2006-09-03 18:56:48.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/ia64/kernel/setup.c	2006-09-03 19:47:58.000000000 +0300
@@ -260,7 +260,7 @@ reserve_memory (void)
 	 * after a kernel panic.
 	 */
 	{
-		char *from = strstr(saved_command_line, "crashkernel=");
+		char *from = strstr(boot_command_line, "crashkernel=");
 		if (from) {
 			unsigned long size, base;
 			size = memparse(from + 12, &from);
@@ -433,7 +433,7 @@ setup_arch (char **cmdline_p)
 	ia64_patch_vtop((u64) __start___vtop_patchlist, (u64) __end___vtop_patchlist);
 
 	*cmdline_p = __va(ia64_boot_param->command_line);
-	strlcpy(saved_command_line, *cmdline_p, COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, *cmdline_p, COMMAND_LINE_SIZE);
 
 	efi_init();
 	io_port_init();
@@ -514,7 +514,7 @@ setup_arch (char **cmdline_p)
 
 #ifdef CONFIG_CRASH_DUMP
 	{
-		char *from = strstr(saved_command_line, "elfcorehdr=");
+		char *from = strstr(boot_command_line, "elfcorehdr=");
 
 		if (from)
 			elfcorehdr_addr = memparse(from+11, &from);

-- 
VGER BF report: H 0
