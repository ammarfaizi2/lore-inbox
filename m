Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275548AbTHMUzI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 16:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275549AbTHMUzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 16:55:08 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:23019 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S275548AbTHMUzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 16:55:01 -0400
Date: Wed, 13 Aug 2003 13:58:18 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Sam Ravnborg <sam@ravnborg.org>, George Anzinger <george@mvista.com>
cc: Thomas Schlichter <schlicht@uni-mannheim.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test3-mm1
Message-ID: <947680000.1060808298@flay>
In-Reply-To: <20030813201829.GA15012@mars.ravnborg.org>
References: <20030809203943.3b925a0e.akpm@osdl.org> <200308101941.33530.schlicht@uni-mannheim.de> <3F37DFDC.6080308@mvista.com> <20030813201829.GA15012@mars.ravnborg.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, August 13, 2003 22:18:29 +0200 Sam Ravnborg <sam@ravnborg.org> wrote:

> On Mon, Aug 11, 2003 at 11:26:36AM -0700, George Anzinger wrote:
>> > that patch sets DEBUG_INFO to y by default, even if whether DEBUG_KERNEL 
>> > nor KGDB is enabled. The attached patch changes this to enable DEBUG_INFO 
>> > by default only if KGDB is enabled.
>> 
>> Looks good to me, but.... just what does this turn on?  Its been a 
>> long time and me thinks a wee comment here would help me remember next 
>> time.
> 
> DEBUG_INFO add "-g" to CFLAGS.
> Main reason to introduce this was that many architectures always use
> "-g", so a config option seemed more appropriate.
> I do not agree that this should be dependent on KGDB.
> To my knowledge -g is useful also without using kgdb.

I have this in my tree (from Dave Hansen). Slightly twisted, but there's
no better way I can see. Goes on top of the kgdb patch.

M.

diff -purN -X /home/mbligh/.diff.exclude 520-queuestat/Makefile 550-config_debug/Makefile
--- 520-queuestat/Makefile	2003-07-28 18:30:57.000000000 -0700
+++ 550-config_debug/Makefile	2003-07-28 19:02:06.000000000 -0700
@@ -308,7 +308,7 @@ ifndef CONFIG_FRAME_POINTER
 CFLAGS		+= -fomit-frame-pointer
 endif
 
-ifdef CONFIG_X86_REMOTE_DEBUG
+ifdef CONFIG_DEBUG_SYMBOLS 
 CFLAGS += -g
 endif
 
diff -purN -X /home/mbligh/.diff.exclude 520-queuestat/arch/i386/Kconfig 550-config_debug/arch/i386/Kconfig
--- 520-queuestat/arch/i386/Kconfig	2003-07-28 18:59:00.000000000 -0700
+++ 550-config_debug/arch/i386/Kconfig	2003-07-28 19:02:06.000000000 -0700
@@ -1350,6 +1350,14 @@ config DEBUG_KERNEL
 	  Say Y here if you are developing drivers or trying to debug and
 	  identify kernel problems.
 
+config DEBUG_SYMBOLS_PROMPT
+	bool "Get debug symbols (turns on -g)"
+	depends on DEBUG_KERNEL
+
+config DEBUG_SYMBOLS
+	bool
+	depends on DEBUG_SYMBOLS_PROMPT || X86_REMOTE_DEBUG
+
 config DEBUG_STACKOVERFLOW
 	bool "Check for stack overflows"
 	depends on DEBUG_KERNEL

