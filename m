Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292318AbSBBQe6>; Sat, 2 Feb 2002 11:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292319AbSBBQep>; Sat, 2 Feb 2002 11:34:45 -0500
Received: from smtp02.web.de ([217.72.192.151]:43802 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S292318AbSBBQeg>;
	Sat, 2 Feb 2002 11:34:36 -0500
Message-ID: <3C5C2136.5020202@web.de>
Date: Sat, 02 Feb 2002 17:26:14 +0000
From: Todor Todorov <ttodorov@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020201
X-Accept-Language: en-us
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.3-dj1: zisofs compile fix
Content-Type: multipart/mixed;
 boundary="------------060701080403040502070403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060701080403040502070403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello there,

I had the problem compiling 2.5.3-dj1 with zisofs included as other 
people on that list - same problem, undefined reference in fs/fs.o . I 
tried to use the EXPORTS_SYMBOL macro from modules.h and export the 
zisofs_cleanup in fs/isofs/compress.c and also added export-objs := 
compress.o in the Makefile. Didn't help. Searching for hints in other 
Makefiles which list objects exporting symbols, i noticed that all such 
objects are linked first into the target obj, which is not the case with 
compress.o. When I moved compress.o first in the obj-y list, the compile 
error was gone and this even without EXPORT_SYMBOL(zisofs_cleanup); in 
compress.c

Next to say is: I don't know anything about the linux kernel, so I'm not 
sure if this is the correct way to fix this issue. It just seems to 
work. So use at your own risk until the maintainer fixes it properly.

Cheers,
       Todor



--------------060701080403040502070403
Content-Type: text/plain;
 name="zisofs-compilefix-2.5.3-dj1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="zisofs-compilefix-2.5.3-dj1.patch"

--- linux-2.5.3-dj1/fs/isofs/Makefile	Sat Feb  2 10:59:07 2002
+++ linux/fs/isofs/Makefile	Sat Feb  2 16:52:59 2002
@@ -9,9 +9,16 @@
 
 O_TARGET := isofs.o
 
-obj-y  := namei.o inode.o dir.o util.o rock.o
+ifeq ( $(CONFIG_ZISOFS), y )
+	obj-y  := compress.o namei.o inode.o dir.o util.o rock.o
+endif
+
+ifeq ( $(CONFIG_ZISOFS), n )
+	obj-y  := namei.o inode.o dir.o util.o rock.o
+endif
+
 obj-$(CONFIG_JOLIET) += joliet.o
-obj-$(CONFIG_ZISOFS) += compress.o
+#obj-$(CONFIG_ZISOFS) += compress.o
 
 obj-m  := $(O_TARGET)
 

--------------060701080403040502070403--

