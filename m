Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWICWJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWICWJZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWICWJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:09:10 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:25868 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750830AbWICWIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:08:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WGYeeSZpmfmqg8sHverDa9wm9z0Q9DL0OIoPU0B/ypm3FFfnHZN8R5CcVtDxIMYVvRL8QxvKGip3kVCv++WJplqfziiGN01j4XQJEc2JV6RZmzs8QaztylEHUdPNd4OQrdFulMBvMaRF88Cgqd2vaUHFDlv7yfb2UD7zowsKGXA=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: [PATCH 15/26] Dynamic kernel command-line - parisc
Date: Mon, 4 Sep 2006 00:59:11 +0300
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
References: <200609040050.13410.alon.barlev@gmail.com>
In-Reply-To: <200609040050.13410.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609040059.12081.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp 
linux-2.6.18-rc5-mm1.org/arch/parisc/kernel/setup.c 
linux-2.6.18-rc5-mm1/arch/parisc/kernel/setup.c
--- linux-2.6.18-rc5-mm1.org/arch/parisc/kernel/setup.c	
2006-09-03 18:55:13.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/parisc/kernel/setup.c	
2006-09-03 21:01:13.000000000 +0300
@@ -45,7 +45,7 @@
 #include <asm/io.h>
 #include <asm/setup.h>
 
-char	command_line[COMMAND_LINE_SIZE] __read_mostly;
+char	__initdata command_line[COMMAND_LINE_SIZE] 
__read_mostly;
 
 /* Intended for ccio/sba/cpu statistics 
under /proc/bus/{runway|gsc} */
 struct proc_dir_entry * proc_runway_root __read_mostly = 
NULL;
@@ -71,9 +71,9 @@ void __init setup_cmdline(char **cmdline
 	/* boot_args[0] is free-mem start, boot_args[1] is ptr to 
command line */
 	if (boot_args[0] < 64) {
 		/* called from hpux boot loader */
-		saved_command_line[0] = '\0';
+		boot_command_line[0] = '\0';
 	} else {
-		strcpy(saved_command_line, (char *)__va(boot_args[1]));
+		strcpy(boot_command_line, (char *)__va(boot_args[1]));
 
 #ifdef CONFIG_BLK_DEV_INITRD
 		if (boot_args[2] != 0) /* did palo pass us a ramdisk? */
@@ -84,7 +84,7 @@ void __init setup_cmdline(char **cmdline
 #endif
 	}
 
-	strcpy(command_line, saved_command_line);
+	strcpy(command_line, boot_command_line);
 	*cmdline_p = command_line;
 }
 
diff -urNp linux-2.6.18-rc5-mm1.org/arch/parisc/mm/init.c 
linux-2.6.18-rc5-mm1/arch/parisc/mm/init.c
--- linux-2.6.18-rc5-mm1.org/arch/parisc/mm/init.c	
2006-09-03 18:56:50.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/parisc/mm/init.c	2006-09-03 
23:52:54.000000000 +0300
@@ -77,12 +77,12 @@ static void __init mem_limit_func(void)
 {
 	char *cp, *end;
 	unsigned long limit;
-	extern char saved_command_line[];
+	extern char __initdata boot_command_line[];
 
 	/* We need this before __setup() functions are called */
 
 	limit = MAX_MEM;
-	for (cp = saved_command_line; *cp; ) {
+	for (cp = boot_command_line; *cp; ) {
 		if (memcmp(cp, "mem=", 4) == 0) {
 			cp += 4;
 			limit = memparse(cp, &end);

-- 
VGER BF report: U 0.494487
