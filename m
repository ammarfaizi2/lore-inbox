Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbVLZXG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbVLZXG0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 18:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVLZXG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 18:06:26 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:15500 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1751095AbVLZXG0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 18:06:26 -0500
Date: Mon, 26 Dec 2005 23:35:48 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: .config not updated after make clean
Message-ID: <20051226223548.GA2438@mars.ravnborg.org>
References: <43AABBA1.76F0.0078.0@novell.com> <20051222212508.GA1323@mars.ravnborg.org> <43ABB683.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ABB683.76F0.0078.0@novell.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks, and assuming you're going to push this upwards... Jan

Hi Jan - just pushed atteched patch.
Slightly simplified compared to first version.

	Sam
	
kbuild: always run 'make silentoldconfig' when tree is cleaned

If the file .kconfig.d is missing then make sure to run
'make silentoldconfig', since we have no way to detect if
a Kconfig file has been updated.

-kconfig.d is created by kconfig and is removed as part
of 'make clean' so the situation is likely to occur in reality.

Jan Beulich <JBeulich@novell.com> reported this bug.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---
commit 752625cff3eba81cbc886988d5b420064c033948
tree 10281d9345281b3d118aa8b29b3fb21e1ea10655
parent 54e08a2392e99ba9e48ce1060e0b52a39118419c
author Sam Ravnborg <sam@mars.ravnborg.org> Mon, 26 Dec 2005 23:34:03 +0100
committer Sam Ravnborg <sam@mars.ravnborg.org> Mon, 26 Dec 2005 23:34:03 +0100

 Makefile               |   10 ++++++----
 scripts/kconfig/util.c |    2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

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
