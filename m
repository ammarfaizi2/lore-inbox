Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275818AbRJCEGI>; Wed, 3 Oct 2001 00:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275819AbRJCEF6>; Wed, 3 Oct 2001 00:05:58 -0400
Received: from rj.SGI.COM ([204.94.215.100]:10922 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S275818AbRJCEFj>;
	Wed, 3 Oct 2001 00:05:39 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: fdavis@si.rr.com
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.10-ac3: fs/cramfs/Makefile 
In-Reply-To: Your message of "Tue, 02 Oct 2001 18:14:38 -0400."
             <3BBA3C4E.6020604@si.rr.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 Oct 2001 14:05:49 +1000
Message-ID: <30965.1002081949@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Oct 2001 18:14:38 -0400, 
Frank Davis <fdavis@si.rr.com> wrote:
>    The attached patch against 2.4.10-ac3 addresses the following issue 
>since 2.4.9-ac17:
>
>depmod: *** Unresolved symbols in 
>/lib/modules/2.4.9-ac17/kernel/fs/cramfs/cramfs/cramfs.o
>depmod:  zlib_fs_inflateInit_
>depmod:  zlib_fs_inflateEnd
>depmod:  zlib_fs_inflate_workspacesize
>depmod:  zlib_fs_inflate
>depmod:  zlib_fs_inflateReset
>
>--- fs/cramfs/Makefile.old	Tue Oct  2 17:44:56 2001
>+++ fs/cramfs/Makefile	Tue Oct  2 17:46:51 2001
>@@ -4,7 +4,7 @@
> 
> O_TARGET := cramfs.o
> 
>-obj-y  := inode.o uncompress.o
>+obj-y  := inode.o uncompress.o ../inflate_fs/inflate_fs.o

Double plus ungood!  The failing combinations are
  CONFIG_CRAMFS=m
  CONFIG_ISO9660_FS=y
  CONFIG_ZISOFS=y
cramfs.o has unresolved references, or
  CONFIG_CRAMFS=y
  CONFIG_ISO9660_FS=m
  CONFIG_ZISOFS=y
isofs.o has unresolved references.  Any mixture of built in and modular
users of zlib results in zlib symbols not being available to modules.
The correct fix is

Index: 10.30/fs/inflate_fs/inflate_syms.c
--- 10.30/fs/inflate_fs/inflate_syms.c Sat, 22 Sep 2001 14:41:20 +1000 kaos (linux-2.4/o/f/51_inflate_sy 1.1 644)
+++ 10.30(w)/fs/inflate_fs/inflate_syms.c Wed, 03 Oct 2001 13:58:59 +1000 kaos (linux-2.4/o/f/51_inflate_sy 1.1 644)
@@ -19,10 +19,3 @@ EXPORT_SYMBOL(zlib_fs_inflateSync);
 EXPORT_SYMBOL(zlib_fs_inflateReset);
 EXPORT_SYMBOL(zlib_fs_adler32);
 EXPORT_SYMBOL(zlib_fs_inflateSyncPoint);
-
-static int __init init_zlib_fs(void)
-{
-	return 0;
-}
-
-module_init(init_zlib_fs)
Index: 10.30/fs/inflate_fs/Makefile
--- 10.30/fs/inflate_fs/Makefile Sat, 22 Sep 2001 14:41:20 +1000 kaos (linux-2.4/p/f/9_Makefile 1.1 644)
+++ 10.30(w)/fs/inflate_fs/Makefile Wed, 03 Oct 2001 13:58:57 +1000 kaos (linux-2.4/p/f/9_Makefile 1.1 644)
@@ -25,7 +25,7 @@ O_TARGET    := inflate_fs.o
 export_objs := inflate_syms.o
 
 obj-y := adler32.o infblock.o infcodes.o inffast.o inflate.o \
-	 inftrees.o infutil.o
+	 inftrees.o infutil.o inflate_syms.o
 obj-m := $(O_TARGET)
 
 include $(TOPDIR)/Rules.make

