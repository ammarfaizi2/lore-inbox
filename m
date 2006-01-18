Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030399AbWARTlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030399AbWARTlP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 14:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbWARTlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 14:41:15 -0500
Received: from baikonur.stro.at ([213.239.196.228]:56474 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S1030399AbWARTlO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 14:41:14 -0500
Date: Wed, 18 Jan 2006 20:40:56 +0100
From: maximilian attems <maks@sternwelten.at>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       Bastian Blank <waldi@debian.org>
Subject: [patch] kbuild: add automatic updateconfig target
Message-ID: <20060118194056.GA26532@nancy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bastian Blank <waldi@debian.org>

current hack for daily build linux-2.6-git is quite ugly: 
yes "n" | make oldconfig

belows target helps to build git snapshots in a more automated way,
setting the new options to their default.

Signed-off-by: maximilian attems <maks@sternwelten.at>


diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 5760e05..5bf2718 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -23,6 +23,9 @@ oldconfig: $(obj)/conf
 silentoldconfig: $(obj)/conf
 	$< -s arch/$(ARCH)/Kconfig
 
+updateconfig: $(obj)/conf
+	$< -U arch/$(ARCH)/Kconfig
+
 update-po-config: $(obj)/kxgettext
 	xgettext --default-domain=linux \
           --add-comments --keyword=_ --keyword=N_ \
@@ -74,6 +77,7 @@ help:
 	@echo  '  xconfig	  - Update current config utilising a QT based front-end'
 	@echo  '  gconfig	  - Update current config utilising a GTK based front-end'
 	@echo  '  oldconfig	  - Update current config utilising a provided .config as base'
+	@echo  '  updateconfig	  - Update current config in an automated way'
 	@echo  '  randconfig	  - New config with random answer to all options'
 	@echo  '  defconfig	  - New config with default answer to all options'
 	@echo  '  allmodconfig	  - New config selecting modules when possible'
diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 10eeae5..4e7b6a1 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -24,7 +24,8 @@ enum {
 	set_yes,
 	set_mod,
 	set_no,
-	set_random
+	set_random,
+	update_default,
 } input_mode = ask_all;
 char *defconfig_file;
 
@@ -117,6 +118,7 @@ static void conf_askvalue(struct symbol 
 		fgets_check_stream(line, 128, stdin);
 		return;
 	case set_default:
+	case update_default:
 		printf("%s\n", def);
 		return;
 	default:
@@ -390,6 +392,7 @@ static int conf_choice(struct menu *menu
 		case set_yes:
 		case set_mod:
 		case set_no:
+		case update_default:
 			cnt = def;
 			printf("%d\n", cnt);
 			break;
@@ -544,6 +547,9 @@ int main(int ac, char **av)
 			input_mode = set_random;
 			srandom(time(NULL));
 			break;
+		case 'U':
+			input_mode = update_default;
+			break;
 		case 'h':
 		case '?':
 			printf("%s [-o|-s] config\n", av[0]);
@@ -568,6 +574,7 @@ int main(int ac, char **av)
 		}
 		break;
 	case ask_silent:
+	case update_default:
 		if (stat(".config", &tmpstat)) {
 			printf(_("***\n"
 				"*** You have not yet configured your kernel!\n"
