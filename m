Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263793AbUD0GFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbUD0GFQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 02:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263799AbUD0GFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 02:05:15 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:13715 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S263793AbUD0GFD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 02:05:03 -0400
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0404262116510.19703@ppc970.osdl.org>
References: <408DC0E0.7090500@gmx.net>
	 <Pine.LNX.4.58.0404262116510.19703@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1083045844.2150.105.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 27 Apr 2004 16:04:06 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-27 at 14:31, Linus Torvalds wrote:
> Anyway, I suspect that rather than blacklist bad people, I'd much prefer
> to have the module tags be done as counted strings instead. It should be
> easy enough to do by just having the macro prepend a "sizeof(xxxx)"  
> thing or something.
> 
> Hmm. At least with -sdt=c99 it should be trivial, with something like
> 
> 	#define __MODULE_INFO(tag, name, info)		\
> 	static struct { int len; const char value[] }	\
> 	__module_cat(name,__LINE__) __attribute_used__	\
> 	__attribute__((section(".modinfo"),unused)) =	\
> 		{ sizeof(__stringify(tag) "=" info),	\
> 		__stringify(tag) "=" info }
> 
> doing the job.

Cute, but breaks the "modinfo" tool unfortunately.  I'd prefer not to do
that.  Since they want to circumvent this, almost anything we want to do
is a waste of time.

Rusty.

Name: Stop most obvious abuse of MODULE_LICENSE
Status: Tested on 2.6.6-rc2-bk4

Arms race forces bloat upon module users.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31262-linux-2.6.6-rc2-bk4/include/linux/module.h .31262-linux-2.6.6-rc2-bk4.updated/include/linux/module.h
--- .31262-linux-2.6.6-rc2-bk4/include/linux/module.h	2004-04-22 08:03:55.000000000 +1000
+++ .31262-linux-2.6.6-rc2-bk4.updated/include/linux/module.h	2004-04-27 15:52:19.000000000 +1000
@@ -16,6 +16,9 @@
 #include <linux/kmod.h>
 #include <linux/elf.h>
 #include <linux/stringify.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/compiler.h>
 #include <asm/local.h>
 
 #include <asm/module.h>
@@ -61,7 +64,14 @@ void sort_main_extable(void);
 #ifdef MODULE
 #define ___module_cat(a,b) __mod_ ## a ## b
 #define __module_cat(a,b) ___module_cat(a,b)
+/* Some sick fucks embeded NULs in MODULE_LICENSE to circumvent checks. */
+#define __MODULE_INFO_CHECK(info)					  \
+	static void __init __attribute_used__				  \
+	__module_cat(__mc_,__LINE__)(void) {				  \
+		BUILD_BUG_ON(__builtin_strlen(info) + 1 != sizeof(info)); \
+	}
 #define __MODULE_INFO(tag, name, info)					  \
+__MODULE_INFO_CHECK(info);						  \
 static const char __module_cat(name,__LINE__)[]				  \
   __attribute_used__							  \
   __attribute__((section(".modinfo"),unused)) = __stringify(tag) "=" info


-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

