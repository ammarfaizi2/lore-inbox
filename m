Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269932AbUJVHPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269932AbUJVHPp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 03:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269853AbUJVHOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 03:14:37 -0400
Received: from ozlabs.org ([203.10.76.45]:9118 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269952AbUJVHJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 03:09:19 -0400
Subject: [PATCH] Eliminate init_module and cleanup_module from Documentation
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1098428960.12103.75.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 22 Oct 2004 17:09:20 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Eliminate Obsolete init_module and cleanup_module From Documentation
Status: Untested
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

In 2.2, you used to just be able to call functions "init_module" and
"cleanup_module" and they'd be magically called.  Th

These days you should use module_init(myinit)/module_exit(myexit) and
avoid #ifdef MODULE.

diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/Documentation/DocBook/mousedrivers.tmpl working-2.6.9-bk6-obsolete-init_module/Documentation/DocBook/mousedrivers.tmpl
--- linux-2.6.9-bk6/Documentation/DocBook/mousedrivers.tmpl	2004-10-19 14:33:48.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/Documentation/DocBook/mousedrivers.tmpl	2004-10-22 14:02:00.000000000 +1000
@@ -200,38 +200,33 @@ __init ourmouse_init(void)
   </para>
   <para>
     Next, in order to be able to use and test our code we need to add some 
-    module code to support it. This too is fairly simple:
+    startup and shutdown code to support it. This too is fairly simple:
   </para>
   <programlisting>
-#ifdef MODULE
-
-int init_module(void)
+static int init(void)
 {
         if(ourmouse_init()&lt;0)
                 return -ENODEV:
         return 0;
 }
 
-void cleanup_module(void)
+static void cleanup(void)
 {
         misc_deregister(&amp;our_mouse);
         free_region(OURMOUSE_BASE, 3);
 }
-
-
-#endif
+module_init(init);
+module_exit(cleanup);
   </programlisting>
 
   <para>
-    The module code provides the normal two functions. The 
-    <function>init_module</function> function is called when the module is 
-    loaded. In our case it simply calls the initialising function we wrote 
+    The <function>module_init</function> macro sets the function to call when the module is inserted (or at boot if the module were built into the kernel).  In our case it is <function>init</function>, which simply calls the initialising function we wrote 
     and returns an error if this fails. This ensures the module will only 
     be loaded if it was successfully set up.
   </para>
   <para>
-    The <function>cleanup_module</function> function is called when the 
-    module is unloaded. We give the miscellaneous device entry back, and 
+    The <function>module_exit</function> macro sets the function to call when the 
+    module is unloaded: if this is not set, the module cannot be unloaded. We give the miscellaneous device entry back, and 
     then free our I/O resources. If we didn't free the I/O resources then 
     the next time the module loaded it would think someone else had its I/O 
     space.
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/Documentation/DocBook/videobook.tmpl working-2.6.9-bk6-obsolete-init_module/Documentation/DocBook/videobook.tmpl
--- linux-2.6.9-bk6/Documentation/DocBook/videobook.tmpl	2004-06-17 08:47:50.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/Documentation/DocBook/videobook.tmpl	2004-10-22 14:02:00.000000000 +1000
@@ -731,13 +731,14 @@ static int io = 0x300;
 
 static int io = -1;
 
+#endif
 
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("A driver for an imaginary radio card.");
-MODULE_PARM(io, "i");
+module_param(io, int, 0444);
 MODULE_PARM_DESC(io, "I/O address of the card.");
 
-int init_module(void)
+static int __init init(void)
 {
         if(io==-1)
         {
@@ -748,25 +749,26 @@ int init_module(void)
         return myradio_init(NULL);
 }
 
-void cleanup_module(void)
+static void __exit cleanup(void)
 {
         video_unregister_device(&amp;my_radio);
         release_region(io, MY_IO_SIZE);
 }
 
-#endif
+module_init(init);
+module_exit(cleanup);
 
   </programlisting>
   <para>
         In this example we set the IO base by default if the driver is compiled into
-        the kernel where you cannot pass a parameter. For the module we require the
+        the kernel: you can still set it using "my_radio.irq" if this file is called <filename>my_radio.c</filename>. For the module we require the
         user sets the parameter. We set io to a nonsense port (-1) so that we can
         tell if the user supplied an io parameter or not.
   </para>
   <para>
         We use MODULE_ defines to give an author for the card driver and a
         description. We also use them to declare that io is an integer and it is the
-        address of the card.
+        address of the card, and can be read by anyone from sysfs.
   </para>
   <para>
         The clean-up routine unregisters the video_device we registered, and frees
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/Documentation/i2c/writing-clients working-2.6.9-bk6-obsolete-init_module/Documentation/i2c/writing-clients
--- linux-2.6.9-bk6/Documentation/i2c/writing-clients	2004-10-22 07:56:43.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/Documentation/i2c/writing-clients	2004-10-22 14:04:04.000000000 +1000
@@ -571,7 +571,7 @@ the driver module is usually enough.
      have to be cleaned up! */
   static int __initdata foo_initialized = 0;
 
-  int __init foo_init(void)
+  static int __init foo_init(void)
   {
     int res;
     printk("foo version %s (%s)\n",FOO_VERSION,FOO_DATE);
@@ -585,41 +585,27 @@ the driver module is usually enough.
     return 0;
   }
 
-  int __init foo_cleanup(void)
+  void foo_cleanup(void)
   {
-    int res;
     if (foo_initialized == 1) {
       if ((res = i2c_del_driver(&foo_driver))) {
         printk("foo: Driver registration failed, module not removed.\n");
-        return res;
+        return;
       }
       foo_initialized --;
     }
-    return 0;
   }
 
-  #ifdef MODULE
-
   /* Substitute your own name and email address */
   MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>"
   MODULE_DESCRIPTION("Driver for Barf Inc. Foo I2C devices");
 
-  int init_module(void)
-  {
-    return foo_init();
-  }
-
-  int cleanup_module(void)
-  {
-    return foo_cleanup();
-  }
-
-  #endif /* def MODULE */
+  module_init(foo_init);
+  module_exit(foo_cleanup);
 
 Note that some functions are marked by `__init', and some data structures
-by `__init_data'. If this driver is compiled as part of the kernel (instead
-of as a module), those functions and structures can be removed after
-kernel booting is completed.
+by `__init_data'.  Hose functions and structures can be removed after
+kernel booting (or module loading) is completed.
 
 Command function
 ================
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/Documentation/s390/s390dbf.txt working-2.6.9-bk6-obsolete-init_module/Documentation/s390/s390dbf.txt
--- linux-2.6.9-bk6/Documentation/s390/s390dbf.txt	2004-05-10 15:12:43.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/Documentation/s390/s390dbf.txt	2004-10-22 14:02:00.000000000 +1000
@@ -271,12 +271,12 @@ Examples
  * hex_ascii- + raw-view Example
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <asm/debug.h>
 
 static debug_info_t* debug_info;
 
-int init_module(void)
+static int init(void)
 {
     /* register 4 debug areas with one page each and 4 byte data field */
 
@@ -291,23 +291,26 @@ int init_module(void)
     return 0;
 }
 
-void cleanup_module(void)
+static void cleanup(void)
 {
     debug_unregister (debug_info);
 }
 
+module_init(init);
+module_exit(cleanup);
+
 ---------------------------------------------------------------------------
 
 /*
  * sprintf-view Example
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <asm/debug.h>
 
 static debug_info_t* debug_info;
 
-int init_module(void)
+static int init(void)
 {
     /* register 4 debug areas with one page each and data field for */
     /* format string pointer + 2 varargs (= 3 * sizeof(long))       */
@@ -321,11 +324,14 @@ int init_module(void)
     return 0;
 }
 
-void cleanup_module(void)
+static void cleanup(void)
 {
     debug_unregister (debug_info);
 }
 
+module_init(init);
+module_exit(cleanup);
+
 
 
 ProcFS Interface
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/Documentation/sound/oss/README.modules working-2.6.9-bk6-obsolete-init_module/Documentation/sound/oss/README.modules
--- linux-2.6.9-bk6/Documentation/sound/oss/README.modules	2004-03-12 07:56:35.000000000 +1100
+++ working-2.6.9-bk6-obsolete-init_module/Documentation/sound/oss/README.modules	2004-10-22 14:02:00.000000000 +1000
@@ -59,8 +59,9 @@ sound.o # The sound driver
 uart401.o # Used by sb, maybe other cards
 
  Whichever card you have, try feeding it the options that would be the
-default if you were making the driver wired, not as modules. You can look
-at the init_module() code for the card to see what args are expected.
+default if you were making the driver wired, not as modules. You can
+look at function referred to by module_init() for the card to see what
+args are expected.
 
  Note that at present there is no way to configure the io, irq and other
 parameters for the modular drivers as one does for the wired drivers.. One

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

