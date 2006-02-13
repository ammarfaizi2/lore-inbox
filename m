Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751635AbWBMGK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbWBMGK1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 01:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbWBMGK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 01:10:27 -0500
Received: from adsl-71-140-189-62.dsl.pltn13.pacbell.net ([71.140.189.62]:33413
	"EHLO aexorsyst.com") by vger.kernel.org with ESMTP
	id S1751635AbWBMGK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 01:10:26 -0500
From: "John Z. Bohach" <jzb@aexorsyst.com>
Reply-To: jzb@aexorsyst.com
To: linux-kernel@vger.kernel.org
Subject: console_setup depends (wrongly?) on CONFIG_PRINTK
Date: Sun, 12 Feb 2006 22:10:10 -0800
User-Agent: KMail/1.5.2
Cc: alan@redhat.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602122210.10748.jzb@aexorsyst.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

It appears that console_setup() code only gets compiled into the kernel if 
CONFIG_PRINTK is enabled.  One detrimental side-effect of this is that 
serial8250_console_setup() never gets invoked when CONFIG_PRINTK is not set, 
resulting in baud rate not being read/parsed from command line (i.e. 
console=ttyS0,115200n8 is ignored, at least the baud rate part...)

Attached patch moves console_setup() code from inside

#ifdef CONFIG_PRINTK

to outside (in printk.c), removing dependence on said config. option.

This is not new code, its a straight cut/paste of existing code to make it not 
depend on CONFIG_PRINTK.  I've tested it, and it accomplishes goal of getting 
serial8250_console_setup() invoked, and I see no negative impact elsewhere.  

Please take a look at this, and apply to the kernel at next appropriate 
opportuinty...

Regards,
John Z. Bohach


--- linux-2.6.15.4/kernel/printk.c      2006-02-09 23:22:48.000000000 -0800
+++ linux-2.6.15.4-fixed/kernel/printk.c        2006-02-12 21:36:04.000000000 
-0
800
@@ -122,44 +122,6 @@
 static int log_buf_len = __LOG_BUF_LEN;
 static unsigned long logged_chars; /* Number of chars produced since last 
read+
clear operation */
 
-/*
- *     Setup a list of consoles. Called from init/main.c
- */
-static int __init console_setup(char *str)
-{
-       char name[sizeof(console_cmdline[0].name)];
-       char *s, *options;
-       int idx;
-
-       /*
-        *      Decode str into name, index, options.
-        */
-       if (str[0] >= '0' && str[0] <= '9') {
-               strcpy(name, "ttyS");
-               strncpy(name + 4, str, sizeof(name) - 5);
-       } else
-               strncpy(name, str, sizeof(name) - 1);
-       name[sizeof(name) - 1] = 0;
-       if ((options = strchr(str, ',')) != NULL)
-               *(options++) = 0;
-#ifdef __sparc__
-       if (!strcmp(str, "ttya"))
-               strcpy(name, "ttyS0");
-       if (!strcmp(str, "ttyb"))
-               strcpy(name, "ttyS1");
-#endif
-       for (s = name; *s; s++)
-               if ((*s >= '0' && *s <= '9') || *s == ',')
-                       break;
-       idx = simple_strtoul(s, NULL, 10);
-       *s = 0;
-
-       add_preferred_console(name, idx, options);
-       return 1;
-}
-
-__setup("console=", console_setup);
-
 static int __init log_buf_len_setup(char *str)
 {
        unsigned long size = memparse(str, &str);
@@ -659,6 +621,44 @@
 
 #endif
 
+/*
+ *     Setup a list of consoles. Called from init/main.c
+ */
+static int __init console_setup(char *str)
+{
+       char name[sizeof(console_cmdline[0].name)];
+       char *s, *options;
+       int idx;
+
+       /*
+        *      Decode str into name, index, options.
+        */
+       if (str[0] >= '0' && str[0] <= '9') {
+               strcpy(name, "ttyS");
+               strncpy(name + 4, str, sizeof(name) - 5);
+       } else
+               strncpy(name, str, sizeof(name) - 1);
+       name[sizeof(name) - 1] = 0;
+       if ((options = strchr(str, ',')) != NULL)
+               *(options++) = 0;
+#ifdef __sparc__
+       if (!strcmp(str, "ttya"))
+               strcpy(name, "ttyS0");
+       if (!strcmp(str, "ttyb"))
+               strcpy(name, "ttyS1");
+#endif
+       for (s = name; *s; s++)
+               if ((*s >= '0' && *s <= '9') || *s == ',')
+                       break;
+       idx = simple_strtoul(s, NULL, 10);
+       *s = 0;
+
+       add_preferred_console(name, idx, options);
+       return 1;
+}
+
+__setup("console=", console_setup);
+
 /**
  * add_preferred_console - add a device to the list of preferred consoles.
  * @name: device name




-- 
     ###  Any similarity between my views and the truth is completely ###
     ###  coincidental, except that they are endorsed by NO ONE       ###

