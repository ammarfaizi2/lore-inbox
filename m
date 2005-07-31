Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVGaW0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVGaW0K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 18:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVGaW0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 18:26:10 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23819 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261559AbVGaW0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 18:26:09 -0400
Date: Mon, 1 Aug 2005 00:26:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove support for gcc < 3.2
Message-ID: <20050731222606.GL3608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes support for gcc < 3.2 .

The advantages are:
- reducing the number of supported gcc versions from 8 to 4 [1]
  allows the removal of several #ifdef's and workarounds
- my impression is that the older compilers are only rarely
  used, so miscompilations of a driver with an old gcc might
  not be detected for a longer amount of time

My personal opinion about the time and space a compilation requires is 
that this is no longer that much of a problem for modern hardware, and 
in the worst case you can compile the kernels for older machines on more 
recent machines.

This patch does not yet remove all the #ifdef's and other things that 
are now no longer required, it only let's the compilation #error for 
older gcc versions and updates the documentation.

I'd like to see this patch in the next -mm, and if noone will tell a 
strong reason for keeping support for these gcc versions I'll send the 
cleanups that are now.

[1] support removed: 2.95, 2.96, 3.0, 3.1
    still supported: 3.2, 3.3, 3.4, 4.0


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/Changes    |   23 ++---------------------
 README                   |    6 +++---
 include/linux/compiler.h |    4 +---
 3 files changed, 6 insertions(+), 27 deletions(-)

--- linux-2.6.13-rc4-mm1/include/linux/compiler.h.old	2005-07-31 19:07:34.000000000 +0200
+++ linux-2.6.13-rc4-mm1/include/linux/compiler.h	2005-07-31 19:08:24.000000000 +0200
@@ -40,10 +40,8 @@
 #error no compiler-gcc.h file for this gcc version
 #elif __GNUC__ == 4
 # include <linux/compiler-gcc4.h>
-#elif __GNUC__ == 3
+#elif (__GNUC__ == 3 && __GNUC_MINOR__ >= 2)
 # include <linux/compiler-gcc3.h>
-#elif __GNUC__ == 2
-# include <linux/compiler-gcc2.h>
 #else
 # error Sorry, your compiler is too old/not recognized.
 #endif
--- linux-2.6.13-rc4-mm1/README.old	2005-07-31 19:11:01.000000000 +0200
+++ linux-2.6.13-rc4-mm1/README	2005-07-31 19:11:38.000000000 +0200
@@ -174,9 +174,9 @@
 
 COMPILING the kernel:
 
- - Make sure you have gcc 2.95.3 available.
-   gcc 2.91.66 (egcs-1.1.2), and gcc 2.7.2.3 are known to miscompile
-   some parts of the kernel, and are *no longer supported*.
+ - Make sure you have gcc >= 3.2 available.
+   Older versions of gcc are *no longer supported*.
+
    Also remember to upgrade your binutils package (for as/ld/nm and company)
    if necessary. For more information, refer to Documentation/Changes.
 
--- linux-2.6.13-rc4-mm1/Documentation/Changes.old	2005-07-31 19:11:56.000000000 +0200
+++ linux-2.6.13-rc4-mm1/Documentation/Changes	2005-07-31 19:12:48.000000000 +0200
@@ -48,7 +48,7 @@
 hardware, for example, you probably needn't concern yourself with
 isdn4k-utils.
 
-o  Gnu C                  2.95.3                  # gcc --version
+o  Gnu C                  3.2                     # gcc --version
 o  Gnu make               3.79.1                  # make --version
 o  binutils               2.12                    # ld -v
 o  util-linux             2.10o                   # fdformat --version
@@ -75,26 +75,7 @@
 ---
 
 The gcc version requirements may vary depending on the type of CPU in your
-computer. The next paragraph applies to users of x86 CPUs, but not
-necessarily to users of other CPUs. Users of other CPUs should obtain
-information about their gcc version requirements from another source.
-
-The recommended compiler for the kernel is gcc 2.95.x (x >= 3), and it
-should be used when you need absolute stability. You may use gcc 3.0.x
-instead if you wish, although it may cause problems. Later versions of gcc 
-have not received much testing for Linux kernel compilation, and there are 
-almost certainly bugs (mainly, but not exclusively, in the kernel) that
-will need to be fixed in order to use these compilers. In any case, using
-pgcc instead of plain gcc is just asking for trouble.
-
-The Red Hat gcc 2.96 compiler subtree can also be used to build this tree.
-You should ensure you use gcc-2.96-74 or later. gcc-2.96-54 will not build
-the kernel correctly.
-
-In addition, please pay attention to compiler optimization.  Anything
-greater than -O2 may not be wise.  Similarly, if you choose to use gcc-2.95.x
-or derivatives, be sure not to use -fstrict-aliasing (which, depending on
-your version of gcc 2.95.x, may necessitate using -fno-strict-aliasing).
+computer.
 
 Make
 ----

