Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265613AbTIJTUS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265632AbTIJTSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:18:51 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:46091 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265613AbTIJTRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:17:35 -0400
Date: Wed, 10 Sep 2003 21:17:34 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Roman Zippel <zippel@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
Subject: kconfig: Allow architectures to select board specific configs
Message-ID: <20030910191734.GB5604@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Roman Zippel <zippel@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
References: <20030910191411.GA5517@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910191411.GA5517@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1269  -> 1.1270 
#	scripts/kconfig/conf.c	1.9     -> 1.10   
#	scripts/kconfig/Makefile	1.9     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/10	sam@mars.ravnborg.org	1.1270
# kconfig: Allow architectures to select board specific configs
# 
# This patch introduces the framework required for architectures to supply
# several independent configurations. Three architectures does this today:
# ppc, ppc64 and arm.
# The infrastructure provided here requires the files to be located in
# the following directory:
# arch/$(ARCH)/configs
# The file shall be named <board>_defconfig
# 
# To select the configuration for ppc/gemini simply issue the following command:
# make gemini_defconfig
# This will generate a valid configuration.
# 
# ppc and ppc64 already comply to the above requirements, arm needs some
# trivial updates.
# --------------------------------------------
#
diff -Nru a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
--- a/scripts/kconfig/Makefile	Wed Sep 10 21:15:40 2003
+++ b/scripts/kconfig/Makefile	Wed Sep 10 21:15:40 2003
@@ -40,6 +40,9 @@
 defconfig: $(obj)/conf
 	$< -d arch/$(ARCH)/Kconfig
 
+%_defconfig: $(obj)/conf
+	$(Q)$< -D arch/$(ARCH)/configs/$@ arch/$(ARCH)/Kconfig
+
 # Help text used by make help
 help:
 	@echo  '  oldconfig	  - Update current config utilising a line-oriented program'
diff -Nru a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
--- a/scripts/kconfig/conf.c	Wed Sep 10 21:15:40 2003
+++ b/scripts/kconfig/conf.c	Wed Sep 10 21:15:40 2003
@@ -26,6 +26,7 @@
 	set_no,
 	set_random
 } input_mode = ask_all;
+char *defconfig_file;
 
 static int indent = 1;
 static int valid_stdin = 1;
@@ -483,11 +484,12 @@
 
 int main(int ac, char **av)
 {
+	int i = 1;
 	const char *name;
 	struct stat tmpstat;
 
-	if (ac > 1 && av[1][0] == '-') {
-		switch (av[1][1]) {
+	if (ac > i && av[i][0] == '-') {
+		switch (av[i++][1]) {
 		case 'o':
 			input_mode = ask_new;
 			break;
@@ -498,6 +500,15 @@
 		case 'd':
 			input_mode = set_default;
 			break;
+		case 'D':
+			input_mode = set_default;
+			defconfig_file = av[i++];
+			if (!defconfig_file) {
+				printf("%s: No default config file specified\n",
+					av[0]);
+				exit(1);
+			}
+			break;
 		case 'n':
 			input_mode = set_no;
 			break;
@@ -516,18 +527,21 @@
 			printf("%s [-o|-s] config\n", av[0]);
 			exit(0);
 		}
-		name = av[2];
-	} else
-		name = av[1];
+	}
+  	name = av[i];
+	if (!name) {
+		printf("%s: Kconfig file missing\n", av[0]);
+	}
 	conf_parse(name);
 	//zconfdump(stdout);
 	switch (input_mode) {
 	case set_default:
-		name = conf_get_default_confname();
-		if (conf_read(name)) {
+		if (!defconfig_file)
+			defconfig_file = conf_get_default_confname();
+		if (conf_read(defconfig_file)) {
 			printf("***\n"
 				"*** Can't find default configuration \"%s\"!\n"
-				"***\n", name);
+				"***\n", defconfig_file);
 			exit(1);
 		}
 		break;
