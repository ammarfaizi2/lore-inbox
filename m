Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265336AbSKEXcO>; Tue, 5 Nov 2002 18:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265343AbSKEXcO>; Tue, 5 Nov 2002 18:32:14 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36113 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265336AbSKEXcM>; Tue, 5 Nov 2002 18:32:12 -0500
Date: Tue, 5 Nov 2002 23:38:44 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Cc: zippel@linux-m68k.org
Subject: [PATCH] Up silly limit on .config line length
Message-ID: <20021105233844.J24606@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kconfig brought in a bug whereby no .config line can be longer than 128
characters.  This causes a problem since it is quite common to have
.config lines longer than this on ARM, especially when they contain the
default kernel command line, like:

CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/ram0 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M("

The effect of this bug can be seen above; in this case it has chopped
off the parameters that allow this machine to boot; the missing parameters
should be:

 "root) load_ramdisk=1 prompt_ramdisk=0 mem=32M noinitrd initrd=0xc0800000,3M"

I believe that this arbitary limit should be eliminated by some method.
However, as a "get you working" patch with a new arbitary limit of 1024
characters:

--- linux/scripts/kconfig/confdata.c	Tue Nov  5 23:24:42 2002
+++ linux-sa1100/scripts/kconfig/confdata.c	Tue Nov  5 23:28:57 2002
@@ -61,7 +61,7 @@
 int conf_read(const char *name)
 {
 	FILE *in = NULL;
-	char line[128];
+	char line[1024];
 	char *p, *p2;
 	int lineno = 0;
 	struct symbol *sym;
@@ -105,7 +105,7 @@
 		}
 	}
 
-	while (fgets(line, 128, in)) {
+	while (fgets(line, sizeof(line), in)) {
 		lineno++;
 		switch (line[0]) {
 		case '#':

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

