Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129596AbQKUFTz>; Tue, 21 Nov 2000 00:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129604AbQKUFTp>; Tue, 21 Nov 2000 00:19:45 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:46384 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129596AbQKUFTd>; Tue, 21 Nov 2000 00:19:33 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Matthew Vanecek <linux4us@home.com>
cc: linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Assembler warnings 
In-Reply-To: Your message of "Mon, 20 Nov 2000 22:11:04 MDT."
             <3A19F5D8.38BF5384@home.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 21 Nov 2000 15:49:20 +1100
Message-ID: <5600.974782160@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2000 22:11:04 -0600, 
Matthew Vanecek <linux4us@home.com> wrote:
>Hi.  I see these warnings while compiling modules in 2.4.0-test10.  This
>is with RH 7.0's kgcc (why-oh-why did they base their system on
>2.96!!).  It doesn't seem to break anything--I'm just curious as to what
>the warnings signify.
>
>{standard input}: Assembler messages:
>{standard input}:8: Warning: Ignoring changed section attributes for
>.modinfo

Firstly you should not be compiling the kernel with gcc 2.96, you
should be using kgcc.  Search recent l-k archives for kgcc.

Secondly that is a warning that section .modinfo was initially created
without the allocation bit but later usage of the section implies that
the allocation bit should be set.  Creating .modinfo as non-allocated
was an old kludge to stop the module descriptive data being loaded into
memory as part of the module.  modutils 2.3.19 onwards force .modinfo
to be non-allocated (and hence not loaded into kernel memory), even if
the allocate bit is set.  Feel free to try this patch, it is not urgent
so I have not sent it to Linus "code freeze" Torvalds yet.

Against 2.4.0-test11-pre6, it might fit 2.4.0-test11.

Index: 0-test11-pre6.1/include/linux/module.h
--- 0-test11-pre6.1/include/linux/module.h Sun, 12 Nov 2000 14:59:01 +1100 kaos (linux-2.4/W/33_module.h 1.1.2.1.2.1.2.1.2.1.1.3 644)
+++ 0-test11-pre6.1(w)/include/linux/module.h Tue, 21 Nov 2000 15:46:58 +1100 kaos (linux-2.4/W/33_module.h 1.1.2.1.2.1.2.1.2.1.1.3 644)
@@ -247,12 +247,6 @@ static const struct gtype##_id * __modul
   __attribute__ ((unused)) = name
 #define MODULE_DEVICE_TABLE(type,name)		\
   MODULE_GENERIC_TABLE(type##_device,name)
-/* not put to .modinfo section to avoid section type conflicts */
-
-/* The attributes of a section are set the first time the section is
-   seen; we want .modinfo to not be allocated.  */
-
-__asm__(".section .modinfo\n\t.previous");
 
 /* Define the module variable, and usage macros.  */
 extern struct module __this_module;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
