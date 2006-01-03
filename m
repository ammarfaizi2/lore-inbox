Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWACN3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWACN3K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWACN2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:28:20 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:44037 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932360AbWACNZi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:38 -0500
Subject: [PATCH 21/26] kbuild: always run 'make silentoldconfig' when tree is cleaned
In-Reply-To: <20060103132035.GA17485@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Tue, 3 Jan 2006 14:25:26 +0100
Message-Id: <11362947263545@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>
Date: 1135636443 +0100

If the file .kconfig.d is missing then make sure to run
'make silentoldconfig', since we have no way to detect if
a Kconfig file has been updated.

-kconfig.d is created by kconfig and is removed as part
of 'make clean' so the situation is likely to occur in reality.

Jan Beulich <JBeulich@novell.com> reported this bug.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile               |   10 ++++++----
 scripts/kconfig/util.c |    2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

752625cff3eba81cbc886988d5b420064c033948
diff --git a/Makefile b/Makefile
index 922c763..d3598ef 100644
--- a/Makefile
+++ b/Makefile
@@ -477,18 +477,20 @@ ifeq ($(dot-config),1)
 
 # Read in dependencies to all Kconfig* files, make sure to run
 # oldconfig if changes are detected.
--include .config.cmd
+-include .kconfig.d
 
 include .config
 
 # If .config needs to be updated, it will be done via the dependency
 # that autoconf has on .config.
 # To avoid any implicit rule to kick in, define an empty command
-.config: ;
+.config .kconfig.d: ;
 
 # If .config is newer than include/linux/autoconf.h, someone tinkered
-# with it and forgot to run make oldconfig
-include/linux/autoconf.h: .config
+# with it and forgot to run make oldconfig.
+# If kconfig.d is missing then we are probarly in a cleaned tree so
+# we execute the config step to be sure to catch updated Kconfig files
+include/linux/autoconf.h: .kconfig.d .config
 	$(Q)mkdir -p include/linux
 	$(Q)$(MAKE) -f $(srctree)/Makefile silentoldconfig
 else
diff --git a/scripts/kconfig/util.c b/scripts/kconfig/util.c
index 1fa4c0b..a711007 100644
--- a/scripts/kconfig/util.c
+++ b/scripts/kconfig/util.c
@@ -33,7 +33,7 @@ int file_write_dep(const char *name)
 	FILE *out;
 
 	if (!name)
-		name = ".config.cmd";
+		name = ".kconfig.d";
 	out = fopen("..config.tmp", "w");
 	if (!out)
 		return 1;
-- 
1.0.6

