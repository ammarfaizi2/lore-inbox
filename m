Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315469AbSEWBAP>; Wed, 22 May 2002 21:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315481AbSEWBAO>; Wed, 22 May 2002 21:00:14 -0400
Received: from rj.SGI.COM ([192.82.208.96]:8855 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S315469AbSEWBAN>;
	Wed, 22 May 2002 21:00:13 -0400
Date: Thu, 23 May 2002 10:59:47 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jan Kara <jack@suse.cz.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Quota patches
Message-ID: <20020523105947.A186660@wobbly.melbourne.sgi.com>
In-Reply-To: <20020520135530.GB9209@atrey.karlin.mff.cuni.cz> <87bsb86k4r.fsf@devron.myhome.or.jp> <20020523093009.T180298@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 09:30:10AM +1000, Nathan Scott wrote:
> ... but that should just about do the trick I think.

How does the patch below look Jan?

-- 
Nathan


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
