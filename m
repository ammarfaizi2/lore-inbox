Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWICWc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWICWc1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWICWcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:32:18 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:23952 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750779AbWICWbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:31:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YrYZG7QzPC0sytwMipIbXpyRkaN8PpnZ3JGO/KMd5yTnH+9uk5gFTQ+uE1j2jvzT2WB4Jm5SNiR5c7C2jgY1OPy5VPMZYpqxc58oVYn/rM8lDXFF9S14HAmAmzH1CrrwBFBfolVWrUHNIMub15FXl9pTJbWGzifcTV2tC3Xv2A0=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: [PATCH 25/26] Dynamic kernel command-line - x86_64
Date: Mon, 4 Sep 2006 01:24:30 +0300
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
Message-Id: <200609040124.31749.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.18-rc5-mm1.org/include/asm-x86_64/bootsetup.h linux-2.6.18-rc5-mm1/include/asm-x86_64/bootsetup.h
--- linux-2.6.18-rc5-mm1.org/include/asm-x86_64/bootsetup.h	2006-06-18 04:49:35.000000000 +0300
+++ linux-2.6.18-rc5-mm1/include/asm-x86_64/bootsetup.h	2006-09-03 19:47:59.000000000 +0300
@@ -31,7 +31,7 @@ extern char x86_boot_params[BOOT_PARAM_S
 #define EDD_MBR_SIG_NR (*(unsigned char *) (PARAM+EDD_MBR_SIG_NR_BUF))
 #define EDD_MBR_SIGNATURE ((unsigned int *) (PARAM+EDD_MBR_SIG_BUF))
 #define EDD_BUF     ((struct edd_info *) (PARAM+EDDBUF))
-#define COMMAND_LINE saved_command_line
+#define COMMAND_LINE boot_command_line
 
 #define RAMDISK_IMAGE_START_MASK  	0x07FF
 #define RAMDISK_PROMPT_FLAG		0x8000
diff -urNp linux-2.6.18-rc5-mm1.org/arch/x86_64/kernel/head64.c linux-2.6.18-rc5-mm1/arch/x86_64/kernel/head64.c
--- linux-2.6.18-rc5-mm1.org/arch/x86_64/kernel/head64.c	2006-09-03 18:56:53.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/x86_64/kernel/head64.c	2006-09-03 23:47:39.000000000 +0300
@@ -34,7 +34,7 @@ static void __init clear_bss(void)
 #define OLD_CL_BASE_ADDR        0x90000
 #define OLD_CL_OFFSET           0x90022
 
-extern char saved_command_line[];
+extern char __initdata boot_command_line[];
 
 static void __init copy_bootdata(char *real_mode_data)
 {
@@ -50,7 +50,7 @@ static void __init copy_bootdata(char *r
 		new_data = OLD_CL_BASE_ADDR + * (u16 *) OLD_CL_OFFSET;
 	}
 	command_line = (char *) ((u64)(new_data));
-	memcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
+	memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 }
 
 void __init x86_64_start_kernel(char * real_mode_data)
diff -urNp linux-2.6.18-rc5-mm1.org/arch/x86_64/kernel/setup.c linux-2.6.18-rc5-mm1/arch/x86_64/kernel/setup.c
--- linux-2.6.18-rc5-mm1.org/arch/x86_64/kernel/setup.c	2006-09-03 18:56:53.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/x86_64/kernel/setup.c	2006-09-03 20:55:20.000000000 +0300
@@ -100,7 +100,7 @@ EXPORT_SYMBOL_GPL(edid_info);
 
 extern int root_mountflags;
 
-char command_line[COMMAND_LINE_SIZE];
+char __initdata command_line[COMMAND_LINE_SIZE];
 
 struct resource standard_io_resources[] = {
 	{ .name = "dma1", .start = 0x00, .end = 0x1f,
@@ -376,7 +376,7 @@ void __init setup_arch(char **cmdline_p)
 
 	early_identify_cpu(&boot_cpu_data);
 
-	strlcpy(command_line, saved_command_line, COMMAND_LINE_SIZE);
+	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 
 	parse_early_param();

-- 
VGER BF report: H 0
