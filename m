Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264463AbUAVJWn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 04:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266005AbUAVJWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 04:22:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:55508 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264463AbUAVJWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 04:22:41 -0500
Date: Thu, 22 Jan 2004 01:23:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] sisfb update 2.6.1
Message-Id: <20040122012312.1f26fad8.akpm@osdl.org>
In-Reply-To: <400F9055.5050206@winischhofer.net>
References: <400F0F8C.8070900@winischhofer.net>
	<20040121160309.2fd26f0a.akpm@osdl.org>
	<400F9055.5050206@winischhofer.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Winischhofer <thomas@winischhofer.net> wrote:
>
> > It still has floating point stuff in sis_init().  Could you please
>  > review, integrate and test the below patch?
> 
>  sis_init()? You probably mean sis/init.c?
> 
>  Anyway: Irrelevant. This code part isn't even being compiled for the 
>  linux kernel (See line 4304 - #ifdef LINUX_XF86).

Well darn, that patch fixed the wrong bit and we still have float in there.
allmodconfig doesn't pick this up.


drivers/built-in.o: In function `sisfb_do_set_var':
//drivers/video/sis/sis_main.c:654: undefined reference to `__floatsidf'
...
drivers/built-in.o: In function `sisfb_init':
//drivers/video/sis/sis_main.c:4450: undefined reference to `__floatsidf'

Search for "1E12" in sis_main.c


Here's the patch which adds -msoft-float to the kernel build, which picks
up these things.

--- 25/arch/i386/Makefile~use-soft-float	2004-01-07 10:36:36.000000000 -0800
+++ 25-akpm/arch/i386/Makefile	2004-01-07 10:36:36.000000000 -0800
@@ -19,7 +19,7 @@ LDFLAGS		:= -m elf_i386
 OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
 LDFLAGS_vmlinux :=
 
-CFLAGS += -pipe
+CFLAGS += -pipe -msoft-float
 
 # prevent gcc from keeping the stack 16 byte aligned
 CFLAGS += $(call check_gcc,-mpreferred-stack-boundary=2,)

_

