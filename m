Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbTCELF7>; Wed, 5 Mar 2003 06:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbTCELF7>; Wed, 5 Mar 2003 06:05:59 -0500
Received: from dsl-212-144-227-117.arcor-ip.net ([212.144.227.117]:20096 "EHLO
	VikingPC.home") by vger.kernel.org with ESMTP id <S265446AbTCELFy> convert rfc822-to-8bit;
	Wed, 5 Mar 2003 06:05:54 -0500
Date: Wed, 5 Mar 2003 12:16:22 +0100
From: Corvus Corax <corvusvcorax@gemia.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (update) optional hardcoded cmdline i386, x86_64
 linux-2.4.20
Message-Id: <20030305121622.048d9a91.corvusvcorax@gemia.de>
In-Reply-To: <20030305021334.078a77a1.corvusvcorax@gemia.de>
References: <20030304125855.61497226.corvusvcorax@gemia.de>
	<20030305021334.078a77a1.corvusvcorax@gemia.de>
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 5 Mar 2003 02:13:34 +0100
schrieb Corvus Corax <corvusvcorax@gemia.de>:

> 2003.03.04 -- cmdline-linux-2.4.20.patch
> This patch provides an optional hardcoded kernel command line
> along with with specifyable override behaviour
> against the command line provided by the bootloader (if any)
> written for arch/i386 and arch/x86_64 in linux-2.4.20
> by Eric Noack (Corvus V Corax) <corvusvcorax@gemia.de>
> 
 
this patch should now fullfill the requirements of both
code-style and patch-committing-style, does it?

>  
> Corvus Corax
> (aka Eric Noack)                              _ __ ____ _____ _______ ________ ____
                                            .*°` `  `    `     `       `        `
  i386+x86_64-cmdline-linux-2.4.20.patch   /    2nd try
_,____,____,____,___,__,_,_,_,_,_,_,_,,,.*°


diff -ru linux-2.4.20.old/arch/i386/config.in linux/arch/i386/config.in
--- linux-2.4.20.old/arch/i386/config.in	2003-03-04 10:58:05.000000000 +0100
+++ linux/arch/i386/config.in	2003-03-04 11:19:27.000000000 +0100
@@ -316,6 +316,12 @@
    bool '    Use real mode APM BIOS call to power off' CONFIG_APM_REAL_MODE_POWER_OFF
 fi
 
+bool 'Hardcoded kernel command line' CONFIG_CMDLINE_ENABLE
+if [ "$CONFIG_CMDLINE_ENABLE" = "y" ]; then
+    bool '    Bootloader overrides hardcoded' CONFIG_CMDLINE_OVERRIDE
+    string '   Initial kernel command line' CONFIG_CMDLINE "root=301 ro"
+fi
+
 endmenu
 
 source drivers/mtd/Config.in
diff -ru linux-2.4.20.old/arch/i386/kernel/setup.c linux/arch/i386/kernel/setup.c
--- linux-2.4.20.old/arch/i386/kernel/setup.c	2003-03-04 10:59:15.000000000 +0100
+++ linux/arch/i386/kernel/setup.c	2003-03-05 11:44:22.000000000 +0100
@@ -325,6 +325,18 @@
 	}
 #endif
 
+#ifdef CONFIG_CMDLINE_ENABLE
+	#ifdef CONFIG_CMDLINE_OVERRIDE
+	static inline char *choose_valid_command_line()
+	{
+		if (*COMMAND_LINE) return COMMAND_LINE; else return CONFIG_CMDLINE;
+	}
+	#else
+	static inline char *choose_valid_command_line() {return CONFIG_CMDLINE;}
+	#endif
+#else
+static inline char *choose_valid_command_line() {return COMMAND_LINE;}
+#endif
 
 static char command_line[COMMAND_LINE_SIZE];
        char saved_command_line[COMMAND_LINE_SIZE];
@@ -733,12 +745,14 @@
 
 static void __init parse_cmdline_early (char ** cmdline_p)
 {
-	char c = ' ', *to = command_line, *from = COMMAND_LINE;
+	char c = ' ', *to = command_line, *from;
 	int len = 0;
 	int userdef = 0;
 
+	from=choose_valid_command_line();
+
 	/* Save unparsed command line copy for /proc/cmdline */
-	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
+	memcpy(saved_command_line, from, COMMAND_LINE_SIZE);
 	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
 
 	for (;;) {
diff -ru linux-2.4.20.old/arch/x86_64/config.in linux/arch/x86_64/config.in
--- linux-2.4.20.old/arch/x86_64/config.in	2003-03-04 10:58:15.000000000 +0100
+++ linux/arch/x86_64/config.in	2003-03-04 11:21:01.000000000 +0100
@@ -118,6 +118,12 @@
    fi
 fi
 
+bool 'Hardcoded kernel command line' CONFIG_CMDLINE_ENABLE
+if [ "$CONFIG_CMDLINE_ENABLE" = "y" ]; then
+    bool '    Bootloader overrides hardcoded' CONFIG_CMDLINE_OVERRIDE
+    string '   Initial kernel command line' CONFIG_CMDLINE "root=301 ro"
+fi
+
 endmenu
 
 source drivers/mtd/Config.in
diff -ru linux-2.4.20.old/arch/x86_64/kernel/e820.c linux/arch/x86_64/kernel/e820.c
--- linux-2.4.20.old/arch/x86_64/kernel/e820.c	2003-03-04 10:58:44.000000000 +0100
+++ linux/arch/x86_64/kernel/e820.c	2003-03-05 10:38:21.000000000 +0100
@@ -473,18 +473,33 @@
 	e820_print_map(who);
 }
 
+#ifdef CONFIG_CMDLINE_ENABLE
+	#ifdef CONFIG_CMDLINE_OVERRIDE
+	static inline char *choose_valid_command_line()
+	{
+		if (*COMMAND_LINE) return COMMAND_LINE; else return CONFIG_CMDLINE; 
+	}
+	#else
+	static inline char *choose_valid_command_line() {return CONFIG_CMDLINE;}
+	#endif
+#else
+static inline char *choose_valid_command_line() {return COMMAND_LINE;}
+#endif
+
 extern char command_line[], saved_command_line[];
 extern int fallback_aper_order;
 extern int iommu_setup(char *opt);
 
 void __init parse_mem_cmdline (char ** cmdline_p)
 {
-	char c = ' ', *to = command_line, *from = COMMAND_LINE;
+	char c = ' ', *to = command_line, *from;
 	int len = 0;
 	int usermem = 0;
 
+	from=choose_valid_command_line();
+
 	/* Save unparsed command line copy for /proc/cmdline */
-	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
+	memcpy(saved_command_line, from, COMMAND_LINE_SIZE);
 	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
 
 	for (;;) {
diff -ru linux-2.4.20.old/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-2.4.20.old/Documentation/Configure.help	2003-03-04 10:55:32.000000000 +0100
+++ linux/Documentation/Configure.help	2003-03-05 10:46:56.000000000 +0100
@@ -24033,6 +24033,24 @@
   You can also say M here to compile this support as a module (which
   will be called arthur.o).
 
+Hardcoded kernel command line
+CONFIG_CMDLINE_ENABLE
+  When you create a kernel for booting directly from a floppy, or you
+  don't trust the command line provided by the bootloader for security
+  reasons, you can add support for a hardcoded command line by saying Y.
+  Most times you won't need this, say N.
+
+Bootloader overrides hardcoded
+CONFIG_CMDLINE_OVERRIDE
+  If you specify a hardcoded kernel command line, but you want to use
+  the same kernel with your favorite bootmanager (p.e. LILO),
+  the bootloader can set its own command line, this way overriding
+  the internal hardcoded one, if set to Y,
+  If you set this to N the bootloaders command line will just
+  be ignored and the hardcoded command line will be used instead.
+  This might be important doe to security reasons.
+  Most times it's better to say Y.
+
 Initial kernel command line
 CONFIG_CMDLINE
   On some architectures (EBSA110 and CATS), there is currently no way
@@ -24040,6 +24058,8 @@
   architectures, you should supply some command-line options at build
   time by entering them here. As a minimum, you should specify the
   memory size and the root device (e.g., mem=64M root=/dev/nfs).
+  This item has been added to i386 and x64_64,
+  as an optional feature, too.
 
 Kernel-mode alignment trap handler
 CONFIG_ALIGNMENT_TRAP

===END=OF=FILE=================================================================
