Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272415AbTHNQm6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 12:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272435AbTHNQm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 12:42:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:9179 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272415AbTHNQmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 12:42:53 -0400
Date: Thu, 14 Aug 2003 09:39:36 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: thunder7@xs4all.nl
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: 2.6.0-test3-mm1 /proc/ikconfig/config adds space after numbers
Message-Id: <20030814093936.3832a1d4.rddunlap@osdl.org>
In-Reply-To: <20030814135609.GA29328@middle.of.nowhere>
References: <20030814135609.GA29328@middle.of.nowhere>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Aug 2003 15:56:09 +0200 Jurriaan <thunder7@xs4all.nl> wrote:

| 2.6.0-test3-mm1:
| After every number in /proc/ikconfig/config there's an extra space.
| 
| This leads to messages like
| 
| .config:244: symbol value '1 ' invalid for
| SCSI_SYM53C8XX_DMA_ADDRESSING_MODE
| 
| and lots more.

Hi,

Here's the complete patch that needs to be added to 2.6.0-test3-bk-current.
It contains 3 fixes as described in the patch metadata.

Linus, please apply to bk-current.

Thanks,
--
~Randy


patch_name:	ikconfig_260t3_update.patch
patch_version:	2003-08-14.09:38:17
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	fix space at end of line in config files;
		add error check on put_user();
		  (Daniele Bellucci <bellucda@tiscali.it>)
		add missing Kconfig piece for ikconfig;
product:	Linux
product_versions: 260-814
URL:		http://developer.osdl.org/rddunlap/patches/ikconfig/ikconfig_260t3_update.patch
maintainer:	rddunlap@osdl.org
diffstat:	=
 init/Kconfig      |   25 +++++++++++++++++++++++++
 kernel/configs.c  |    3 ++-
 scripts/mkconfigs |    4 ++--
 3 files changed, 29 insertions(+), 3 deletions(-)


diff -Naurp ./scripts/mkconfigs~ikc ./scripts/mkconfigs
--- ./scripts/mkconfigs~ikc	2003-08-14 09:27:13.000000000 -0700
+++ ./scripts/mkconfigs	2003-08-14 09:33:29.000000000 -0700
@@ -76,6 +76,6 @@ echo "#else"
 echo "static char *ikconfig_config __initdata __attribute__((unused)) = "
 echo "#endif"
 echo "\"CONFIG_BEGIN=n\\n\\"
-echo "`cat $config | sed 's/\"/\\\\\"/g' | grep "^#\? \?CONFIG_" | awk '{ print $0, "\\\\n\\\\" }' `"
-echo "CONFIG_END=n\";"
+echo "`cat $config | sed 's/\"/\\\\\"/g' | grep "^#\? \?CONFIG_" | awk '{ print $0 "\\\\n\\\\" }' `"
+echo "CONFIG_END=n\\n\";"
 echo "#endif /* _IKCONFIG_H */"
diff -Naurp ./kernel/configs.c~ikc ./kernel/configs.c
--- ./kernel/configs.c~ikc	2003-08-14 09:27:18.000000000 -0700
+++ ./kernel/configs.c	2003-08-14 09:37:04.000000000 -0700
@@ -64,7 +64,8 @@ ikconfig_output_current(struct file *fil
 	limit = (ikconfig_current_size > len) ? len : ikconfig_current_size;
 	for (i = file->f_pos, cnt = 0;
 	     i < ikconfig_current_size && cnt < limit; i++, cnt++) {
-		put_user(ikconfig_config[i], buf + cnt);
+		if (put_user(ikconfig_config[i], buf + cnt))
+			return -EFAULT;
 	}
 	file->f_pos = i;
 	return cnt;
diff -Naurp ./init/Kconfig~ikc ./init/Kconfig
--- ./init/Kconfig~ikc	2003-08-14 09:27:44.000000000 -0700
+++ ./init/Kconfig	2003-08-14 09:35:45.000000000 -0700
@@ -109,6 +109,31 @@ config LOG_BUF_SHIFT
 		     13 =>  8 KB
 		     12 =>  4 KB
 
+config IKCONFIG
+	bool "Kernel .config support"
+	---help---
+	  This option enables the complete Linux kernel ".config" file 
+	  contents, information on compiler used to build the kernel, 
+	  kernel running when this kernel was built and kernel version 
+	  from Makefile to be saved in kernel. It provides documentation 
+	  of which kernel options are used in a running kernel or in an 
+	  on-disk kernel.  This information can be extracted from the kernel 
+	  image file with the script scripts/extract-ikconfig and used as 
+	  input to rebuild the current kernel or to build another kernel. 
+	  It can also be extracted from a running kernel by reading 
+	  /proc/ikconfig/config and /proc/ikconfig/built_with, if enabled. 
+	  /proc/ikconfig/config will list the configuration that was used 
+	  to build the kernel and /proc/ikconfig/built_with will list 
+	  information on the compiler and host machine that was used to 
+	  build the kernel.
+
+config IKCONFIG_PROC
+	bool "Enable access to .config through /proc/ikconfig"
+	depends on IKCONFIG
+	---help---
+	  This option enables access to kernel configuration file and build
+	  information through /proc/ikconfig.
+
 
 menuconfig EMBEDDED
 	bool "Remove kernel features (for embedded systems)"
