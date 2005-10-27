Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbVJ0QKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbVJ0QKo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 12:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbVJ0QKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 12:10:44 -0400
Received: from mail.capitalgenomix.com ([143.247.20.203]:34017 "EHLO
	mail.capitalgenomix.com") by vger.kernel.org with ESMTP
	id S1751219AbVJ0QKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 12:10:30 -0400
Message-ID: <4360FB44.3010900@capitalgenomix.com>
Date: Thu, 27 Oct 2005 12:07:32 -0400
From: "Fao, Sean" <sean.fao@capitalgenomix.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: [PATCH 3/3] kconfig and lxdialog, kernel 2.6.13.4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a functionality modification that implements a proposed 
design change to lxdialog.  Specifically, this patch makes use of the 
proposed "Abort" functionality of lxdialog, which adds an "Abort" button 
in *addition* to the "Yes" and "No" buttons that are currently displayed 
when a user exits kconfig.  The Abort button allows a user to return to 
the root menu of kconfig rather than exiting.

Signed-off-by: Sean E. Fao <sean.fao@capitalgenomix.com>

diff -up linux-2.6.13.4/scripts/kconfig/mconf.c 
linux/scripts/kconfig/mconf.c
--- linux-2.6.13.4/scripts/kconfig/mconf.c    2005-10-10 
13:54:29.000000000 -0500
+++ linux/scripts/kconfig/mconf.c    2005-10-27 09:32:09.000000000 -0500
@@ -1041,7 +1041,7 @@ int main(int ac, char **av)
 {
     struct symbol *sym;
     char *mode;
-    int stat;
+    int stat, abort;
 
     setlocale(LC_ALL, "");
     bindtextdomain(PACKAGE, LOCALEDIR);
@@ -1064,34 +1064,44 @@ int main(int ac, char **av)
     tcgetattr(1, &ios_org);
     atexit(conf_cleanup);
     init_wsize();
-    conf(&rootmenu);
 
-    do {
-        cprint_init();
-        cprint("--yesno");
-        cprint(_("Do you wish to save your new kernel configuration?"));
-        cprint("5");
-        cprint("60");
-        stat = exec_conf();
-    } while (stat < 0);
-
-    if (stat == 0) {
-        if (conf_write(NULL)) {
-            fprintf(stderr, _("\n\n"
-                "Error during writing of the kernel configuration.\n"
-                "Your kernel configuration changes were NOT saved."
-                "\n\n"));
-            return 1;
-        }
-        printf(_("\n\n"
-            "*** End of Linux kernel configuration.\n"
-            "*** Execute 'make' to build the kernel or try 'make help'."
-            "\n\n"));
-    } else {
-        fprintf(stderr, _("\n\n"
-            "Your kernel configuration changes were NOT saved."
-            "\n\n"));
-    }
+  /* Loop if abort button is pushed from exit dialog */
+  do
+  {
+      conf(&rootmenu);
+
+      do {
+          cprint_init();
+          cprint("--yesnoabort");
+          cprint(_("Do you wish to save your new kernel configuration?"));
+          cprint("5");
+          cprint("60");
+          stat = exec_conf();
+      } while (stat < 0);
+
+      if (stat == 0) {
+          if (conf_write(NULL)) {
+              fprintf(stderr, _("\n\n"
+                  "Error during writing of the kernel configuration.\n"
+                  "Your kernel configuration changes were NOT saved."
+                  "\n\n"));
+        abort = 0;
+              return 1;
+          }
+          printf(_("\n\n"
+              "*** End of Linux kernel configuration.\n"
+              "*** Execute 'make' to build the kernel or try 'make help'."
+              "\n\n"));
+      abort = 0;
+      } else if (stat == 2) {
+        abort = 1;
+    } else {
+            fprintf(stderr, _("\n\n"
+                "Your kernel configuration changes were NOT saved."
+                "\n\n"));
+        abort = 0;
+      }
+  } while (abort); /* Loop if abort button is pushed from exit dialog */
 
     return 0;
 }

-- 
Sean

