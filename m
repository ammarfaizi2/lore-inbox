Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266319AbUIMHyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266319AbUIMHyx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 03:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbUIMHyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 03:54:53 -0400
Received: from relay.pair.com ([209.68.1.20]:47122 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S266319AbUIMHyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 03:54:49 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <414551FD.4020701@kegel.com>
Date: Mon, 13 Sep 2004 00:53:33 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Fix allnoconfig on arm with small tweak to kconfig?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[argh.  sent to arm list by mistake first time.]

'make allnoconfig' generates a broken .config on arm because
none of the boolean CPU types get selected.
ARCH_RPC *does* get selected ok, and I can make CPU_SA110 the
default if ARCH_RPC, but that doesn't help, since allnoconfig
sets all booleans that are exposed to the user to false, so
CPU_SA110 remains false.

Hiding the CPU_SA110 rule from the user (and thus from allnoconfig)
either by removing the prompt, or by modifying the CPU_SA110 rule
by adding  && !ARCH_RPC to the end of the prompt,
does in fact allow 'make arch=arm allnoconfig' to generate a good .config file.
That's not a fix, as it breaks interactive configuration, but it does suggest a fix:
add a 'allnoconfig' boolean one can sense in Kconfig files.
Then Kconfig authors could hide precious default boolean
options from the wrath of allnoconfig by adding a 'if !allnoconfig' on the
menu statement.

I tried it (see patch below), but couldn't get it to work in first
few tries.  Can someone who understands kconfig have a look?
Thanks!
- Dan

--- linux-2.6.5/scripts/kconfig/conf.c.old      Mon Sep 13 00:13:34 2004
+++ linux-2.6.5/scripts/kconfig/conf.c  Mon Sep 13 00:23:51 2004
@@ -28,6 +28,8 @@
  } input_mode = ask_all;
  char *defconfig_file;

+int allnoconfig = 0;   /* kludge.  Set in main(), read in sym_init(). */
+
  static int indent = 1;
  static int valid_stdin = 1;
  static int conf_cnt;
@@ -511,6 +513,7 @@
                         break;
                 case 'n':
                         input_mode = set_no;
+                       allnoconfig = 1;
                         break;
                 case 'm':
                         input_mode = set_mod;
--- linux-2.6.5/scripts/kconfig/zconf.tab.c.old Mon Sep 13 00:20:33 2004
+++ linux-2.6.5/scripts/kconfig/zconf.tab.c     Mon Sep 13 00:29:02 2004
@@ -1925,6 +1925,13 @@
         modules_sym = sym_lookup("MODULES", 0);
         rootmenu.prompt = menu_add_prop(P_MENU, "Linux Kernel Configuration", NULL, NULL);

+       /* Let config files know if -n is in force so they can hide important defaults */
+       {
+               struct symbol *sym = sym_lookup("allnoconfig", 0);
+               extern int allnoconfig;
+               sym_set_tristate_value(sym, allnoconfig ? yes : no);
+       }
+
         //zconfdebug = 1;
         zconfparse();
         if (zconfnerrs)
--- linux-2.6.5/arch/arm/mm/Kconfig.old Sun Sep 12 23:21:12 2004
+++ linux-2.6.5/arch/arm/mm/Kconfig     Mon Sep 13 00:25:33 2004
@@ -185,8 +185,11 @@

  # SA110
  config CPU_SA110
-       bool "Support StrongARM(R) SA-110 processor" if !ARCH_EBSA110 && !FOOTBRIDGE && !ARCH_TBOX && !ARCH_SHARK && !ARCH_NEXUSPCI && ARCH_RPC
-       default y if ARCH_EBSA110 || FOOTBRIDGE || ARCH_TBOX || ARCH_SHARK || ARCH_NEXUSPCI
+       bool "Support StrongARM(R) SA-110 processor" if !ARCH_EBSA110 && !FOOTBRIDGE && !ARCH_TBOX && !ARCH_SHARK && !ARCH_NEXUSPCI && !allnoconfig
+        # Note: the RiscPC from Acorn shipped with several microprocessors over the years.
+        # It is arguably wrong to pick one of them as the default, but we have to if we
+        # want 'make allnoconfig' to work.
+       default y if ARCH_EBSA110 || FOOTBRIDGE || ARCH_TBOX || ARCH_SHARK || ARCH_NEXUSPCI || ARCH_RPC
         select CPU_32v3 if ARCH_RPC
         select CPU_32v4 if !ARCH_RPC
         select CPU_ABRT_EV4

-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change

