Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266809AbTAIQP6>; Thu, 9 Jan 2003 11:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266810AbTAIQP6>; Thu, 9 Jan 2003 11:15:58 -0500
Received: from air-2.osdl.org ([65.172.181.6]:4996 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266809AbTAIQP4>;
	Thu, 9 Jan 2003 11:15:56 -0500
Date: Thu, 9 Jan 2003 08:20:36 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5 patch] correct help text for LOG_BUF_SHIFT
In-Reply-To: <20030109121132.GP6626@fs.tum.de>
Message-ID: <Pine.LNX.4.33L2.0301090818510.9978-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2003, Adrian Bunk wrote:

| On Thu, Jan 09, 2003 at 12:04:46PM +0100, Geert Uytterhoeven wrote:
| > On Wed, 8 Jan 2003, Linus Torvalds wrote:
| > > Andrew Morton <akpm@digeo.com>:
| > >   o move LOG_BUF_SIZE to header/config
| >
| > I find the config a bit confusing:
| >
| > | Kernel log buffer size (128 KB, 64 KB, 32 KB, 16 KB, 8 KB, 4 KB) [16 KB] (NEW) ?
| > | Select kernel log buffer size from this list (power of 2).
| > | Defaults:  17 (=> 128 KB for S/390)
| > |            16 (=> 64 KB for x86 NUMAQ or IA-64)
| > |            15 (=> 32 KB for SMP)
| > |            14 (=> 16 KB for uniprocessor)
| > |
| > | Kernel log buffer size (128 KB, 64 KB, 32 KB, 16 KB, 8 KB, 4 KB) [16 KB] (NEW)
| >
| > E.g. should I enter `14' or `16 KB' (or `16') for `16 KB'?

Sorry about that.

| After reading init/Kconfig it seems the following was intended:
|
| --- linux-2.5.55/init/Kconfig.old	2003-01-09 13:06:43.000000000 +0100
| +++ linux-2.5.55/init/Kconfig	2003-01-09 13:08:44.000000000 +0100
| @@ -89,11 +89,11 @@
|  	default LOG_BUF_SHIFT_15 if SMP
|  	default LOG_BUF_SHIFT_14
|  	help
| -	  Select kernel log buffer size from this list (power of 2).
| -	  Defaults:  17 (=> 128 KB for S/390)
| -		     16 (=> 64 KB for x86 NUMAQ or IA-64)
| -	             15 (=> 32 KB for SMP)
| -	             14 (=> 16 KB for uniprocessor)
| +	  Select kernel log buffer size from this list.
| +	  Defaults:  128 KB for S/390
| +		     64 KB for x86 NUMAQ or IA-64
| +	             32 KB for SMP
| +	             16 KB for uniprocessor
|
|  config LOG_BUF_SHIFT_17
|  	bool "128 KB"

I'd prefer the change that I sent Monday and is appended below.
It only asks for a shift value, and only if DEBUG_KERNEL is enabled,
like Linus asked for.

-- 
~Randy



--- ./init/Kconfig%LGBUF	Mon Jan  6 16:01:55 2003
+++ ./init/Kconfig	Mon Jan  6 16:38:35 2003
@@ -82,50 +82,21 @@
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
 config LOG_BUF_SHIFT
-	int
-	default 17 if LOG_BUF_SHIFT_17=y
-	default 16 if LOG_BUF_SHIFT_16=y
-	default 15 if LOG_BUF_SHIFT_15=y
-	default 14 if LOG_BUF_SHIFT_14=y
-	default 13 if LOG_BUF_SHIFT_13=y
-	default 12 if LOG_BUF_SHIFT_12=y
+	int "Kernel log buffer size" if DEBUG_KERNEL
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+	help
+	  Select kernel log buffer size as a power of 2.
+	  Defaults and Examples:
+	  	     17 => 128 KB for S/390
+		     16 => 64 KB for x86 NUMAQ or IA-64
+	             15 => 32 KB for SMP
+	             14 => 16 KB for uniprocessor
+		     13 =>  8 KB
+		     12 =>  4 KB

 endmenu


