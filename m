Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316705AbSGHBTj>; Sun, 7 Jul 2002 21:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316709AbSGHBTi>; Sun, 7 Jul 2002 21:19:38 -0400
Received: from rj.SGI.COM ([192.82.208.96]:58586 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S316705AbSGHBTh>;
	Sun, 7 Jul 2002 21:19:37 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug] 2.5.25 build as one user and install as root 
In-reply-to: Your message of "Sun, 07 Jul 2002 23:25:32 +0200."
             <3D28B1CC.9070002@oracle.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Jul 2002 11:22:06 +1000
Message-ID: <12962.1026091326@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Jul 2002 23:25:32 +0200, 
Alessandro Suardi <alessandro.suardi@oracle.com> wrote:
>Keith Owens wrote:
>>>>2.5.25 existing build system has a nasty bug.  Build as one user then
>>>>make install as root.  It does supurious recompiles of some files and
>>>>leaves them owned as root.  All of these files are now owned by root
>>>>and cause problems when the build user wants to rebuild.
>
>I'm saying "doesn't happen for me" because it doesn't happen.
>
>I've been compiling kernel as non-root (and well, of course
>  installing as root) since 1996.

Apply this patch to fix a bug with CONFIG_NET=n, CONFIG_LLC= which
shows up with allnoconfig.

Index: 25.1/net/core/Makefile
--- 25.1/net/core/Makefile Wed, 19 Jun 2002 14:11:35 +1000 kaos (linux-2.5/p/c/50_Makefile 1.4 444)
+++ 25.1(w)/net/core/Makefile Sat, 06 Jul 2002 18:27:16 +1000 kaos (linux-2.5/p/c/50_Makefile 1.4 444)
@@ -16,7 +16,7 @@ obj-$(CONFIG_FILTER) += filter.o
 
 obj-$(CONFIG_NET) += dev.o dev_mcast.o dst.o neighbour.o rtnetlink.o utils.o
 
-ifneq ($(CONFIG_LLC),n)
+ifneq ($(subst n,,$(CONFIG_LLC)),)
 obj-y += ext8022.o
 endif

Then
  make allnoconfig
  make dep
  make bzImage
  su
  make install

These files are rebuilt for make install, and are now owned by root.
'su' or 'su -' makes no difference.

include/linux/compile.h
arch/i386/boot/compressed/vmlinux.bin
arch/i386/boot/compressed/piggy.o
arch/i386/boot/compressed/vmlinux
arch/i386/boot/.setup.o.cmd
arch/i386/boot/setup.o
arch/i386/boot/setup
arch/i386/boot/vmlinux.bin
init/init.o
init/version.o
init/.version.o.cmd
.version
vmlinux

