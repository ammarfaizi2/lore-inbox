Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316414AbSEWIxI>; Thu, 23 May 2002 04:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316420AbSEWIxH>; Thu, 23 May 2002 04:53:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:46348 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316414AbSEWIxG>; Thu, 23 May 2002 04:53:06 -0400
Date: Thu, 23 May 2002 10:53:06 +0200
From: Jan Kara <jack@ucw.cz>
To: torvalds@transmeta.com
Cc: Nathan Scott <nathans@wobbly.melbourne.sgi.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: Quota patches
Message-ID: <20020523085306.GA1677@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020523154249.X180298@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, May 23, 2002 at 09:30:10AM +1000, Nathan Scott wrote:
> > ... but that should just about do the trick I think.
> 
> How does the patch below look Jan?
> 
  The patch is OK with me. Can you apply it Linus?

								Thanks
  									Honza

diff -Naur pristine-linux-2.5.17/fs/Config.in quota-linux-2.5.17/fs/Config.in
--- pristine-linux-2.5.17/fs/Config.in	Tue May 21 15:07:31 2002
+++ quota-linux-2.5.17/fs/Config.in	Thu May 23 10:33:32 2002
@@ -8,10 +8,13 @@
 dep_tristate '  Old quota format support' CONFIG_QFMT_V1 $CONFIG_QUOTA
 dep_tristate '  VFS v0 quota format support' CONFIG_QFMT_V2 $CONFIG_QUOTA
 dep_mbool '  Compatible quota interfaces' CONFIG_QIFACE_COMPAT $CONFIG_QUOTA
-if [ "$CONFIG_QUOTA" = "y" -a "$CONFIG_QIFACE_COMPAT" = "y" ]; then
-   choice '    Compatible quota interfaces' \
-	"Original	CONFIG_QIFACE_V1 \
-	 VFSv0		CONFIG_QIFACE_V2" Original
+if [ "$CONFIG_QUOTA" = "y" ]; then
+   define_bool CONFIG_QUOTACTL y
+   if [ "$CONFIG_QIFACE_COMPAT" = "y" ]; then
+       choice '    Compatible quota interfaces' \
+		"Original	CONFIG_QIFACE_V1 \
+		 VFSv0		CONFIG_QIFACE_V2" Original
+   fi
 fi
 tristate 'Kernel automounter support' CONFIG_AUTOFS_FS
 tristate 'Kernel automounter version 4 support (also supports v3)' CONFIG_AUTOFS4_FS
diff -Naur pristine-linux-2.5.17/fs/Makefile quota-linux-2.5.17/fs/Makefile
--- pristine-linux-2.5.17/fs/Makefile	Tue May 21 15:07:30 2002
+++ quota-linux-2.5.17/fs/Makefile	Thu May 23 10:43:00 2002
@@ -15,7 +15,7 @@
 		namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o iobuf.o dnotify.o \
 		filesystems.o namespace.o seq_file.o xattr.o libfs.o \
-		fs-writeback.o quota.o
+		fs-writeback.o
 
 ifneq ($(CONFIG_NFSD),n)
 ifneq ($(CONFIG_NFSD),)
@@ -81,9 +81,10 @@
 
 obj-$(CONFIG_BINFMT_ELF)	+= binfmt_elf.o
 
-obj-$(CONFIG_QUOTA) += dquot.o
-obj-$(CONFIG_QFMT_V1) += quota_v1.o
-obj-$(CONFIG_QFMT_V2) += quota_v2.o
+obj-$(CONFIG_QUOTA)		+= dquot.o
+obj-$(CONFIG_QFMT_V1)		+= quota_v1.o
+obj-$(CONFIG_QFMT_V2)		+= quota_v2.o
+obj-$(CONFIG_QUOTACTL)		+= quota.o
 
 # persistent filesystems
 obj-y += $(join $(subdir-y),$(subdir-y:%=/%.o))
