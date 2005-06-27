Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVF0RqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVF0RqS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 13:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVF0RqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 13:46:18 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:25015 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261351AbVF0Rp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 13:45:58 -0400
Subject: [PATCH] Documentation: Kernel Initialization Mechanisms
From: Matthew Gilbert <mgilbert@mvista.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 27 Jun 2005 10:45:57 -0700
Message-Id: <1119894357.7998.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Below is documentation I've started on the kernel initialization
mechanisms. Other than reading the source, I haven't been able to find
much discussion on the topic. 

My explanations of the different init levels is lacking. I haven't been
able to find any documentation on them. Existing usage seems to vary
quite a bit so its hard to tell their intended functionality. I was
hoping to get some help defining what the intended usage was. Especially
regarding what services are available at each level.

Feedback is appreciated. Thanks _matt

Signed-off-by: Matthew Gilbert <mgilbert@mvista.com>

--- linux-2.6.12.1/Documentation/initcalls.txt.orig	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.12.1/Documentation/initcalls.txt	2005-06-24 16:58:45.232683368 -0700
@@ -0,0 +1,120 @@
+===============================
+Linux Initialization Mechanisms
+===============================
+
+__initcall
+----------
+
+2.4 has a single mechanism for adding a function to kernel
+initialization, mark the function with the __initcall macro. This macro
+places a *reference* to the function in a special section of the kernel
+(.initcall.init). __initcall does not change the linkage of the
+specified function, only a reference to the function is placed in
+.initcall.init. On bootup, this section is then iterated over, calling
+each function in link order.
+
+2.6 Improvements
+----------------
+
+2.6 improves the initialization process by adding a coarse order to the
+initialization sequence. 2.6 defines 7 levels of initialization plus
+application specific initialization sections (e.g. console and
+security).  The definition of these levels of initialization can be
+found in include/linux/init.h. The 2.4 macro __initcall still exists but
+is re-mapped to the device initialization level. Function calls within a
+level are still relegated to link order.
+
+   * core_initcall
+   * postcore_initcall
+   * arch_initcall
+   * subsys_initcall
+   * fs_initcall
+   * device_initcall
+   * late_initcall
+
+Each named initialization section is transformed into a numbered .text
+section.  These sections are then linked into the kernel in numeric
+order as can be seen below in the snippet from the ARM linker script.
+
+      __initcall_start = .;
+         *(.initcall1.init)
+         *(.initcall2.init)
+         *(.initcall3.init)
+         *(.initcall4.init)
+         *(.initcall5.init)
+         *(.initcall6.init)
+         *(.initcall7.init)
+      __initcall_end = .;
+
+The same 2.4 mechanism to call initialization functions is used in 2.6,
+the initcall section is iterated over calling each function in link
+order. However, the linker script now adds some amount of control over
+how the initialization functions are placed in the initcall section.
+
+__init
+------
+
+The initcall mechanism is used to add a function to kernel
+initialization and to add some amount of order to those calls. __init is
+also commonly used within the kernel. This function (or __initdata for
+data) attribute specifies section placement. __init relocates the
+function (not a reference like above) to the .init.text section. The
+kernel frees the .init.text section after boot.
+
+The __init and initcall mechanisms can be used together. However, care
+must be taken to ensure a function used with initcall is not called by
+any other means (e.g. timer initialization structure). This also applied
+in 2.4 when using __initcall.
+
+Initialization Levels
+---------------------
+
+core -- Level 1
+```````````````
+
+	Used for core kernel services and for some early arch/driver
+	specific initialization that do not depend on any kernel core
+	initialization.
+
+postcore -- Level 2
+```````````````````
+
+	Initialization of functions that depend on core initialization and
+	that do not fall into the other categories.
+
+arch -- Level 3
+```````````````
+
+	Used for architecture specific initialization (i386, ARM, Mips,
+	etc.).
+
+subsys -- Level 4
+`````````````````
+
+	Used to initialize kernel subsystems.
+
+fs -- Level 5
+`````````````
+
+	describe level
+
+device -- Level 6
+`````````````````
+
+	Device initialization.
+
+late -- Level 7
+```````````````
+
+	describe level
+
+console
+```````
+
+	Console specific initialization.
+
+security
+````````
+
+	Security specific initialization.
+


