Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129535AbQLUH1n>; Thu, 21 Dec 2000 02:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129752AbQLUH1e>; Thu, 21 Dec 2000 02:27:34 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:5740 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129535AbQLUH1V>;
	Thu, 21 Dec 2000 02:27:21 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jesper Juhl <juhl@eisenstein.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Strange warnings about .modinfo when compiling 2.2.18 on Alpha 
In-Reply-To: Your message of "Tue, 19 Dec 2000 15:20:17 GMT."
             <20001219.15201700@jju.hyggekrogen.dk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 21 Dec 2000 17:56:40 +1100
Message-ID: <5806.977381800@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2000 15:20:17 GMT, 
Jesper Juhl <juhl@eisenstein.dk> wrote:
>I just compiled 2.2.18 for my AlphaServer 400 4/233, and noticed a lot of 
>messages like the following during the compile, they all contain the 
>'Ignoring changed section attributes for .modinfo' part:

The way .modinfo is created is a kludge to prevent the .modinfo section
being loaded as part of the module.  The initial reference to .modinfo
creates it as non-allocated, later references try to allocate data in
the section.  Older versions of gcc silently ignored the mismatch,
newer ones warn about the mismatch.

modutils >= 2.3.19 makes sure that .modinfo is not loaded so the kernel
kludge is no longer required.  Alan Cox (quite rightly) will not force
2.2 users to upgrade modutils, but if you jump to modutils 2.3.23 and
apply this patch against kernel 2.2.18 then the warnings will disappear.

Index: 18.1/include/linux/module.h
--- 18.1/include/linux/module.h Tue, 12 Sep 2000 13:37:17 +1100 kaos (linux-2.2/F/51_module.h 1.1.7.2 644)
+++ 18.1(w)/include/linux/module.h Thu, 21 Dec 2000 17:55:23 +1100 kaos (linux-2.2/F/51_module.h 1.1.7.2 644)
@@ -190,11 +190,6 @@ const char __module_parm_desc_##var[]		\
 __attribute__((section(".modinfo"))) =		\
 "parm_desc_" __MODULE_STRING(var) "=" desc
 
-/* The attributes of a section are set the first time the section is
-   seen; we want .modinfo to not be allocated.  */
-
-__asm__(".section .modinfo\n\t.previous");
-
 /* Define the module variable, and usage macros.  */
 extern struct module __this_module;
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
