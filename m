Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265884AbRF3LqI>; Sat, 30 Jun 2001 07:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265887AbRF3LqA>; Sat, 30 Jun 2001 07:46:00 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:62224 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S265884AbRF3Lpk>;
	Sat, 30 Jun 2001 07:45:40 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Russell King <rmk@arm.linux.org.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.6-pre6: numerous dep_{bool,tristate} $CONFIG_ARCH_xxx bugs 
In-Reply-To: Your message of "Sat, 30 Jun 2001 10:20:24 +0100."
             <20010630102024.A12009@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 30 Jun 2001 21:45:30 +1000
Message-ID: <3465.993901530@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jun 2001 10:20:24 +0100, 
Russell King <rmk@arm.linux.org.uk> wrote:
>Err, how can $BAR be undefined?  Configure sets all config variables which
>are answered with 'n' to 'n'.

if [ "$CONFIG_xyz" = "y" ]; then
  bool CONFIG_bar
fi

CONFIG_bar can be undefined, not 'n'.  While that can cause problems,
it is also valid config code.  If I interpret AC's cryptic comments
correctly, there may be code which assumes that undefined variables are
just that, undefined.  Setting all variables to 'n' initially by Adam's
script will break such code.

This type of code treats undefined variables as "don't care", not as
"forbidden".  Is there any such code?  I don't know for sure, but I am
sure that a change of this magnitude does not belong in 2.4.

The problem Adam was trying to fix was

  dep_bool CONFIG_bar $CONFIG_ARCH_foo

where if the arch is not foo then bar is incorrectly allowed because
CONFIG_ARCH_foo is undefined.  IMHO it is safe to assume that all arch
dependent config settings are meant to be off if the arch is not
selected, i.e. setting CONFIG_ARCH_foo=n for all arch except the
current one is safe.  Setting _all_ CONFIG_foo=n for all variables is
not safe.

I still think this is the best approach, against 2.4.5-ac22.

Index: 5.54/arch/config.in
--- 5.54/arch/config.in Sat, 30 Jun 2001 21:43:30 +1000 kaos ()
+++ 5.54(w)/arch/config.in Sat, 30 Jun 2001 21:42:15 +1000 kaos (linux-2.4/D/e/15_config.in  644)
@@ -0,0 +1,21 @@
+# Ensure that all arch settings are off except the one that is selected.  This
+# simplifies arch dependent driver selection.  Each architecture's specific
+# config variable must appear in this list.  All arch's must include this file
+# at the start of arch/*/config.in.
+
+define_bool CONFIG_ALPHA n
+define_bool CONFIG_ARCH_CRIS n
+define_bool CONFIG_ARCH_M68K n
+define_bool CONFIG_ARCH_S390 n
+define_bool CONFIG_ARCH_S390X n
+define_bool CONFIG_ARM n
+define_bool CONFIG_IA64 n
+define_bool CONFIG_MIPS n
+define_bool CONFIG_MIPS_64 n
+define_bool CONFIG_PARISC n
+define_bool CONFIG_PPC n
+define_bool CONFIG_SPARC32 n
+define_bool CONFIG_SPARC64 n
+define_bool CONFIG_SUPERH n
+define_bool CONFIG_USERMODE n
+define_bool CONFIG_X86 n
Index: 5.54/arch/parisc/config.in
--- 5.54/arch/parisc/config.in Sun, 22 Apr 2001 08:14:43 +1000 kaos (linux-2.4/l/c/33_config.in 1.1.2.1 644)
+++ 5.54(w)/arch/parisc/config.in Sat, 30 Jun 2001 21:27:43 +1000 kaos (linux-2.4/l/c/33_config.in 1.1.2.1 644)
@@ -3,6 +3,8 @@
 # see the Configure script.
 #
 
+source arch/config.in
+
 mainmenu_name "Linux Kernel Configuration"
 
 define_bool CONFIG_PARISC y
Index: 5.54/arch/s390/config.in
--- 5.54/arch/s390/config.in Sun, 22 Apr 2001 08:14:43 +1000 kaos (linux-2.4/n/c/39_config.in 1.4 644)
+++ 5.54(w)/arch/s390/config.in Sat, 30 Jun 2001 21:27:50 +1000 kaos (linux-2.4/n/c/39_config.in 1.4 644)
@@ -3,6 +3,8 @@
 # see Documentation/kbuild/config-language.txt.
 #
 
+source arch/config.in
+
 define_bool CONFIG_ISA n
 define_bool CONFIG_EISA n
 define_bool CONFIG_MCA n
Index: 5.54/arch/mips64/config.in
--- 5.54/arch/mips64/config.in Wed, 20 Jun 2001 13:07:10 +1000 kaos (linux-2.4/p/c/34_config.in 1.2.1.1.1.2 644)
+++ 5.54(w)/arch/mips64/config.in Sat, 30 Jun 2001 21:42:08 +1000 kaos (linux-2.4/p/c/34_config.in 1.2.1.1.1.2 644)
@@ -2,6 +2,11 @@
 # For a description of the syntax of this configuration file,
 # see Documentation/kbuild/config-language.txt.
 #
+
+source arch/config.in
+
+define_bool CONFIG_ARCH_MIPS64 y
+
 mainmenu_name "Linux Kernel Configuration"
 
 mainmenu_option next_comment
Index: 5.54/arch/ia64/config.in
--- 5.54/arch/ia64/config.in Sun, 22 Apr 2001 07:25:55 +1000 kaos (linux-2.4/s/c/38_config.in 1.1.2.1.3.1.1.2 644)
+++ 5.54(w)/arch/ia64/config.in Sat, 30 Jun 2001 21:29:08 +1000 kaos (linux-2.4/s/c/38_config.in 1.1.2.1.3.1.1.2 644)
@@ -1,3 +1,5 @@
+source arch/config.in
+
 mainmenu_name "Kernel configuration of Linux for IA-64 machines"
 
 mainmenu_option next_comment
Index: 5.54/arch/sh/config.in
--- 5.54/arch/sh/config.in Fri, 29 Jun 2001 11:31:04 +1000 kaos (linux-2.4/t/c/42_config.in 1.1.1.1.1.1 644)
+++ 5.54(w)/arch/sh/config.in Sat, 30 Jun 2001 21:29:32 +1000 kaos (linux-2.4/t/c/42_config.in 1.1.1.1.1.1 644)
@@ -2,6 +2,9 @@
 # For a description of the syntax of this configuration file,
 # see Documentation/kbuild/config-language.txt.
 #
+
+source arch/config.in
+
 mainmenu_name "Linux/SuperH Kernel Configuration"
 
 define_bool CONFIG_SUPERH y
Index: 5.54/arch/arm/config.in
--- 5.54/arch/arm/config.in Fri, 29 Jun 2001 11:31:04 +1000 kaos (linux-2.4/x/c/32_config.in 1.3.1.2.1.1 644)
+++ 5.54(w)/arch/arm/config.in Sat, 30 Jun 2001 21:28:43 +1000 kaos (linux-2.4/x/c/32_config.in 1.3.1.2.1.1 644)
@@ -2,6 +2,9 @@
 # For a description of the syntax of this configuration file,
 # see Documentation/kbuild/config-language.txt.
 #
+
+source arch/config.in
+
 mainmenu_name "Linux Kernel Configuration"
 
 define_bool CONFIG_ARM y
Index: 5.54/arch/sparc64/config.in
--- 5.54/arch/sparc64/config.in Fri, 29 Jun 2001 11:31:04 +1000 kaos (linux-2.4/z/c/48_config.in 1.11.1.1 644)
+++ 5.54(w)/arch/sparc64/config.in Sat, 30 Jun 2001 21:29:37 +1000 kaos (linux-2.4/z/c/48_config.in 1.11.1.1 644)
@@ -2,6 +2,9 @@
 # For a description of the syntax of this configuration file,
 # see the Configure script.
 #
+
+source arch/config.in
+
 mainmenu_name "Linux/UltraSPARC Kernel Configuration"
 
 mainmenu_option next_comment
Index: 5.54/arch/m68k/config.in
--- 5.54/arch/m68k/config.in Wed, 06 Jun 2001 11:47:52 +1000 kaos (linux-2.4/E/c/5_config.in 1.1.1.4 644)
+++ 5.54(w)/arch/m68k/config.in Sat, 30 Jun 2001 21:40:20 +1000 kaos (linux-2.4/E/c/5_config.in 1.1.1.4 644)
@@ -3,6 +3,9 @@
 # see Documentation/kbuild/config-language.txt.
 #
 
+source arch/config.in
+
+define_bool CONFIG_ARCH_M68K y
 define_bool CONFIG_UID16 y
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
Index: 5.54/arch/ppc/config.in
--- 5.54/arch/ppc/config.in Fri, 29 Jun 2001 11:31:04 +1000 kaos (linux-2.4/H/c/11_config.in 1.2.1.1.2.4.1.1 644)
+++ 5.54(w)/arch/ppc/config.in Sat, 30 Jun 2001 21:29:25 +1000 kaos (linux-2.4/H/c/11_config.in 1.2.1.1.2.4.1.1 644)
@@ -3,6 +3,9 @@
 # For a description of the syntax of this configuration file,
 # see Documentation/kbuild/config-language.txt.
 #
+
+source arch/config.in
+
 define_bool CONFIG_UID16 n
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
Index: 5.54/arch/mips/config.in
--- 5.54/arch/mips/config.in Wed, 20 Jun 2001 13:07:10 +1000 kaos (linux-2.4/M/c/48_config.in 1.1.1.1.1.2 644)
+++ 5.54(w)/arch/mips/config.in Sat, 30 Jun 2001 21:29:13 +1000 kaos (linux-2.4/M/c/48_config.in 1.1.1.1.1.2 644)
@@ -2,6 +2,9 @@
 # For a description of the syntax of this configuration file,
 # see Documentation/kbuild/config-language.txt.
 #
+
+source arch/config.in
+
 define_bool CONFIG_MIPS y
 define_bool CONFIG_SMP n
 
Index: 5.54/arch/sparc/config.in
--- 5.54/arch/sparc/config.in Fri, 29 Jun 2001 11:31:04 +1000 kaos (linux-2.4/P/c/8_config.in 1.3.1.2.1.1 644)
+++ 5.54(w)/arch/sparc/config.in Sat, 30 Jun 2001 21:29:35 +1000 kaos (linux-2.4/P/c/8_config.in 1.3.1.2.1.1 644)
@@ -2,6 +2,9 @@
 # For a description of the syntax of this configuration file,
 # see Documentation/kbuild/config-language.txt.
 #
+
+source arch/config.in
+
 mainmenu_name "Linux/SPARC Kernel Configuration"
 
 define_bool CONFIG_UID16 y
Index: 5.54/arch/alpha/config.in
--- 5.54/arch/alpha/config.in Fri, 29 Jun 2001 11:31:04 +1000 kaos (linux-2.4/R/c/33_config.in 1.1.1.1.1.5 644)
+++ 5.54(w)/arch/alpha/config.in Sat, 30 Jun 2001 21:27:01 +1000 kaos (linux-2.4/R/c/33_config.in 1.1.1.1.1.5 644)
@@ -3,6 +3,8 @@
 # see Documentation/kbuild/config-language.txt.
 #
 
+source arch/config.in
+
 define_bool CONFIG_ALPHA y
 define_bool CONFIG_UID16 n
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
Index: 5.54/arch/i386/config.in
--- 5.54/arch/i386/config.in Fri, 29 Jun 2001 11:31:04 +1000 kaos (linux-2.4/T/c/36_config.in 1.1.2.1.3.1.1.9 644)
+++ 5.54(w)/arch/i386/config.in Sat, 30 Jun 2001 21:28:59 +1000 kaos (linux-2.4/T/c/36_config.in 1.1.2.1.3.1.1.9 644)
@@ -2,6 +2,9 @@
 # For a description of the syntax of this configuration file,
 # see Documentation/kbuild/config-language.txt.
 #
+
+source arch/config.in
+
 mainmenu_name "Linux Kernel Configuration"
 
 define_bool CONFIG_X86 y
Index: 5.54/arch/cris/config.in
--- 5.54/arch/cris/config.in Wed, 20 Jun 2001 13:07:10 +1000 kaos (linux-2.4/m/d/45_config.in 1.2.1.5 644)
+++ 5.54(w)/arch/cris/config.in Sat, 30 Jun 2001 21:40:14 +1000 kaos (linux-2.4/m/d/45_config.in 1.2.1.5 644)
@@ -2,8 +2,12 @@
 # For a description of the syntax of this configuration file,
 # see the Configure script.
 #
+
+source arch/config.in
+
 mainmenu_name "Linux/CRIS Kernel Configuration"
 
+define_bool CONFIG_ARCH_CRIS y
 define_bool CONFIG_UID16 y
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
Index: 5.54/arch/s390x/config.in
--- 5.54/arch/s390x/config.in Sun, 22 Apr 2001 08:14:43 +1000 kaos (linux-2.4/q/d/3_config.in 1.3 644)
+++ 5.54(w)/arch/s390x/config.in Sat, 30 Jun 2001 21:27:53 +1000 kaos (linux-2.4/q/d/3_config.in 1.3 644)
@@ -3,6 +3,8 @@
 # see Documentation/kbuild/config-language.txt.
 #
 
+source arch/config.in
+
 define_bool CONFIG_ISA n
 define_bool CONFIG_EISA n
 define_bool CONFIG_MCA n
Index: 5.54/arch/um/config.in
--- 5.54/arch/um/config.in Sat, 16 Jun 2001 09:05:21 +1000 kaos (linux-2.4/U/d/26_config.in 1.4 644)
+++ 5.54(w)/arch/um/config.in Sat, 30 Jun 2001 21:29:42 +1000 kaos (linux-2.4/U/d/26_config.in 1.4 644)
@@ -1,5 +1,6 @@
-define_bool CONFIG_USERMODE y
+source arch/config.in
 
+define_bool CONFIG_USERMODE y
 mainmenu_name "Linux/Usermode Kernel Configuration"
 
 define_bool CONFIG_ISA y

