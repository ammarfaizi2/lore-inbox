Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbUDRLfi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 07:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264159AbUDRLfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 07:35:36 -0400
Received: from pra64-d92.gd.dial-up.cz ([193.85.64.92]:30848 "EHLO
	penguin.localdomain") by vger.kernel.org with ESMTP id S264044AbUDRLfZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 07:35:25 -0400
Date: Sun, 18 Apr 2004 13:35:18 +0200
To: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: menuconfig and UTF-8
Message-ID: <20040418113518.GA2588@penguin.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org, sam@ravnborg.org
References: <20040404122426.GA16383@penguin.localdomain> <20040405212148.GA2387@mars.ravnborg.org> <20040406184000.GB3770@penguin.localdomain> <yw1xfzbhnde8.fsf@kth.se> <20040406192219.GA5938@penguin.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406192219.GA5938@penguin.localdomain>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: sebek64@post.cz (Marcel Sebek)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is another patch.  It saves LC_CTYPE value to a temporary variable
and restores it for *config targets.  It fixes the problem with
menuconfig and UTF-8 console.



diff -urN linux-2.6/Makefile linux-2.6-new/Makefile
--- linux-2.6/Makefile	2004-04-18 13:20:47.000000000 +0200
+++ linux-2.6-new/Makefile	2004-04-18 13:26:31.000000000 +0200
@@ -131,14 +131,20 @@
 endif
 
 # Make sure we're not wasting cpu-cycles doing locale handling, yet do make
-# sure error messages appear in the user-desired language
+# sure error messages appear in the user-desired language and LC_CTYPE is
+# preserved for *config targets
 ifdef LC_ALL
 LANG := $(LC_ALL)
 LC_ALL :=
 endif
 LC_COLLATE := C
+ifdef LC_CTYPE
+SAVED_LC_CTYPE := $(LC_CTYPE)
+else
+SAVED_LC_CTYPE := C
+endif
 LC_CTYPE := C
-export LANG LC_ALL LC_COLLATE LC_CTYPE
+export LANG LC_ALL LC_COLLATE LC_CTYPE SAVED_LC_CTYPE
 
 srctree		:= $(if $(KBUILD_SRC),$(KBUILD_SRC),$(CURDIR))
 TOPDIR		:= $(srctree)
diff -urN linux-2.6/scripts/kconfig/Makefile linux-2.6-new/scripts/kconfig/Makefile
--- linux-2.6/scripts/kconfig/Makefile	2004-04-18 13:27:37.000000000 +0200
+++ linux-2.6-new/scripts/kconfig/Makefile	2004-04-18 13:27:56.000000000 +0200
@@ -4,6 +4,9 @@
 
 .PHONY: oldconfig xconfig gconfig menuconfig config silentoldconfig
 
+LC_CTYPE := $(SAVED_LC_CTYPE)
+export LC_CTYPE
+
 xconfig: $(obj)/qconf
 	$< arch/$(ARCH)/Kconfig
 


-- 
Marcel Sebek
jabber: sebek@jabber.cz                     ICQ: 279852819
linux user number: 307850                 GPG ID: 5F88735E
GPG FP: 0F01 BAB8 3148 94DB B95D  1FCA 8B63 CA06 5F88 735E

