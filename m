Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267162AbTAFVBL>; Mon, 6 Jan 2003 16:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267164AbTAFVBL>; Mon, 6 Jan 2003 16:01:11 -0500
Received: from air-2.osdl.org ([65.172.181.6]:60099 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267162AbTAFVBI>;
	Mon, 6 Jan 2003 16:01:08 -0500
Date: Mon, 6 Jan 2003 13:06:27 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Tom Rini <trini@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
       <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>,
       <szepe@pinerecords.com>
Subject: Re: [PATCH] configurable LOG_BUF_SIZE
In-Reply-To: <Pine.LNX.4.33L2.0301061119400.15416-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33L2.0301061257160.15416-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2003, Randy.Dunlap wrote:

| On Mon, 6 Jan 2003, Linus Torvalds wrote:
|
| |
| | On Mon, 6 Jan 2003, Tom Rini wrote:
| | >
| | > > Linus also told me that he's not crazy about this change.
| | >
| | > Maybe he would be, if it was cleaner than the current code in the end.
| | > :)
| |
| | No, the reason I'm not crazy about it is that I simply _hate_ having too
| | many user knobs to tweak. I don't like tweaking like that, it's just
| | disturbing.
| |---------------------------------------------------------------------------
| | I'd probably be happier if the current one didn't even _ask_ the user (or|
| | only asked the user if kernel debugging is enabled), and just silently   |
| | defaulted to the normal values.                                          |
| |---------------------------------------------------------------------------
|
| I'll be happy to move it there (later today)...

Hm.  Roman, Tomas, Sam-

Do any of you know how to write a kconfig item like Linus described
above (in the box)?

It's simple enough to have a config option that isn't available if
DEBUG_KERNEL is false, but how do I make default values for it
when it's false?
The config option must still exist in this case, but not be presented
to the user as a choice.

My attempt (for i386) is attached.  Applies to 2.5.54 + yesterday's
patch.  Are there better ways to do this?

Thanks,
-- 
~Randy




--- ./arch/i386/Kconfig%LGBUF	Wed Jan  1 19:21:10 2003
+++ ./arch/i386/Kconfig	Mon Jan  6 12:37:54 2003
@@ -1624,6 +1624,31 @@
 	  If you don't debug the kernel, you can say N, but we may not be able
 	  to solve problems without frame pointers.

+config LOG_BUF_SHIFT
+	int "Kernel log buffer size"
+	depends on DEBUG_KERNEL
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+	help
+	  Select kernel log buffer size as a power of 2.
+	  Defaults and Examples:
+	  	     17 (=> 128 KB for S/390)
+		     16 (=> 64 KB for x86 NUMAQ or IA-64)
+	             15 (=> 32 KB for SMP)
+	             14 (=> 16 KB for uniprocessor)
+		     13 (=>  8 KB)
+		     12 (=>  4 KB)
+
+config LOG_BUF_SHIFT
+	int
+	depends on !DEBUG_KERNEL
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+
 config X86_EXTRA_IRQS
 	bool
 	depends on X86_LOCAL_APIC || X86_VOYAGER
--- ./init/Kconfig%LGBUF	Mon Jan  6 11:52:14 2003
+++ ./init/Kconfig	Mon Jan  6 11:55:00 2003
@@ -98,51 +98,6 @@
 	  building a kernel for install/rescue disks or your system is very
 	  limited in memory.

-choice
-	prompt "Kernel log buffer size"
-	default LOG_BUF_SHIFT_17 if ARCH_S390
-	default LOG_BUF_SHIFT_16 if X86_NUMAQ || IA64
-	default LOG_BUF_SHIFT_15 if SMP
-	default LOG_BUF_SHIFT_14
-	help
-	  Select kernel log buffer size from this list (power of 2).
-	  Defaults:  17 (=> 128 KB for S/390)
-		     16 (=> 64 KB for x86 NUMAQ or IA-64)
-	             15 (=> 32 KB for SMP)
-	             14 (=> 16 KB for uniprocessor)
-
-config LOG_BUF_SHIFT_17
-	bool "128 KB"
-	default y if ARCH_S390
-
-config LOG_BUF_SHIFT_16
-	bool "64 KB"
-	default y if X86_NUMAQ || IA64
-
-config LOG_BUF_SHIFT_15
-	bool "32 KB"
-	default y if SMP
-
-config LOG_BUF_SHIFT_14
-	bool "16 KB"
-
-config LOG_BUF_SHIFT_13
-	bool "8 KB"
-
-config LOG_BUF_SHIFT_12
-	bool "4 KB"
-
-endchoice
-
-config LOG_BUF_SHIFT
-	int
-	default 17 if LOG_BUF_SHIFT_17=y
-	default 16 if LOG_BUF_SHIFT_16=y
-	default 15 if LOG_BUF_SHIFT_15=y
-	default 14 if LOG_BUF_SHIFT_14=y
-	default 13 if LOG_BUF_SHIFT_13=y
-	default 12 if LOG_BUF_SHIFT_12=y
-
 endmenu



