Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262290AbSJVI22>; Tue, 22 Oct 2002 04:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262314AbSJVI22>; Tue, 22 Oct 2002 04:28:28 -0400
Received: from zok.sgi.com ([204.94.215.101]:65163 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S262290AbSJVI21>;
	Tue, 22 Oct 2002 04:28:27 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: David Mansfield <lkml@dm.cobite.com>
Cc: linux-kernel@vger.kernel.org, kdb@oss.sgi.com
Subject: Re: [OOPS] in kdb v2.3 on top of 2.5.44 
In-reply-to: Your message of "Sun, 20 Oct 2002 14:46:05 -0400."
             <Pine.LNX.4.44.0210201440150.30018-100000@admin> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 22 Oct 2002 18:34:24 +1000
Message-ID: <6307.1035275664@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2002 14:46:05 -0400 (EDT), 
David Mansfield <lkml@dm.cobite.com> wrote:
>EIP is at kdba_setjmp+0x4/0x50
>eax: 00000000   ebx: c044a000   ecx: 00000001   edx: 00000000
>esi: 00000004   edi: c034409f   ebp: c044a000   esp: c044be1c

A kbuild change in 2.5.41 moved the initial setting of CFLAGS before
the include of .config.  Now the global CFLAGS must not depend on any
config settings (totally undocumented, of course).  kdba_setjmp was
compiled with CONFIG_FRAME_POINTERS=y from config.h, but gcc flags were
set to -fomit-frame-pointer, the mismatch generated bad code.

Will be fixed in next kdb patch, in the meantime, apply this over
kdb-v2.3-2.5.53-common-1.

Index: 43.2/Makefile
--- 43.2/Makefile Thu, 17 Oct 2002 15:02:15 +1000 kaos (linux-2.5/I/d/12_Makefile 1.41.1.10 444)
+++ 43.2(w)/Makefile Tue, 22 Oct 2002 18:17:22 +1000 kaos (linux-2.5/I/d/12_Makefile 1.41.1.10 444)
@@ -159,9 +159,6 @@ CPPFLAGS	:= -D__KERNEL__ -Iinclude
 CPPFLAGS	+= $(patsubst %,-I%,$(CROSS_COMPILE_INC))
 CFLAGS 		:= $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
 	  	   -fno-strict-aliasing -fno-common
-ifndef CONFIG_FRAME_POINTER
-CFLAGS		+= -fomit-frame-pointer
-endif
 AFLAGS		:= -D__ASSEMBLY__ $(CPPFLAGS)
 
 export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION KERNELRELEASE ARCH \
@@ -212,6 +209,10 @@ include-config := 1
 
 endif
 
+ifndef CONFIG_FRAME_POINTER
+CFLAGS		+= -fomit-frame-pointer
+endif
+
 include arch/$(ARCH)/Makefile
 
 core-y		+= kernel/ mm/ fs/ ipc/ security/

