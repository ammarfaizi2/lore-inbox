Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314609AbSEUOLp>; Tue, 21 May 2002 10:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314634AbSEUOLo>; Tue, 21 May 2002 10:11:44 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:4268 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S314609AbSEUOLo>; Tue, 21 May 2002 10:11:44 -0400
Date: Tue, 21 May 2002 09:11:42 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: A Guy Called Tyketto <tyketto@wizard.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.17: hfs no go
In-Reply-To: <20020521063757.GA16181@wizard.com>
Message-ID: <Pine.LNX.4.44.0205210909100.10815-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2002, A Guy Called Tyketto wrote:

> gcc -D__KERNEL__ -I/usr/src/linux-2.5.15/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
> -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -DMODULE 
> -DMODVERSIONS -include /usr/src/linux-2.5.15/include/linux/modversions.h 
> -DKBUILD_BASENAME=inode -c -o inode.o inode.c
> inode.c: In function `hfs_prepare_write':
> inode.c:242: dereferencing pointer to incomplete type
> gcc -D__KERNEL__ -I/usr/src/linux-2.5.15/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
> -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -DMODULE 
> -DMODVERSIONS -include /usr/src/linux-2.5.15/include/linux/modversions.h 
> -DKBUILD_BASENAME=mdb -c -o mdb.o mdb.c

Okay, I think Christoph Hellwig already gave you the right hint on how to 
fix the actual problem in inode.c.

However, this snippet also shows a glitch I introduced, i.e. make 
wouldn't stop the build on error immediately, as it used to.

So here's the fix for that one.

--Kai


# --------------------------------------------
# 02/05/21	kai@tp1.ruhr-uni-bochum.de	1.584
# kbuild: Stop immediately on error
# 
# This patch restores the previous behavior of stopping the build
# immediately on error (unless the -k option is given to make)
# --------------------------------------------
#
diff -Nru a/Rules.make b/Rules.make
--- a/Rules.make	Tue May 21 09:08:38 2002
+++ b/Rules.make	Tue May 21 09:08:38 2002
@@ -380,5 +380,5 @@
 if_changed = $(if $(strip $? \
 		          $(filter-out $($(1)),$(cmd_$(@F)))\
 			  $(filter-out $(cmd_$(@F)),$($(1)))),\
-	       @echo $($(1)); $($(1)); echo 'cmd_$(@F) := $($(1))' > $(@D)/.$(@F).cmd)
+	       @echo $($(1)); $($(1)) || exit $$?; echo 'cmd_$(@F) := $($(1))' > $(@D)/.$(@F).cmd)
 

