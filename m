Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbTLVCts (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 21:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbTLVCts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 21:49:48 -0500
Received: from eastgate.starhub.net.sg ([203.116.1.189]:14598 "EHLO
	eastgate.starhub.net.sg") by vger.kernel.org with ESMTP
	id S264286AbTLVCtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 21:49:45 -0500
Date: Mon, 22 Dec 2003 10:52:17 +0800
From: Richard Chan <rspchan@starhub.net.sg>
Subject: [KBUILD] External modules,
 SUBDIRS=<absolute path> => really odd include directories
To: linux-kernel@vger.kernel.org
Cc: sam@ravnborg.org
Message-id: <3FE65C61.5010507@starhub.net.sg>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When building external modules with SUBDIRS on the command line set to 
an absolute path, there
are really odd includes in the gcc command line.

Example:

I am building alsa-cvs against a current kernel tree.  I have built the 
kernel+modules once using

make -C /usr/src/linux-2.6.0-1.R  O=/usr/obj/2.6.0-1.R  EXTRAVERSION=-1.R

Now I want to build the latest alsa-kernel modules from CVS:

EXTMODDIR=/usr/src/alsa/alsa-kernel-20031220
make -C /usr/src/linux-2.6.0-1.R O=/usr/obj/2.6.0-1.R 
SUBDIRS=$EXTMODDIR  V=1 modules

Here is an excerpt

gcc -Wp,-MD,/usr/src/alsa/alsa-kernel-20031220/core/.hwdep.o.d -nostdinc 
-iwithprefix include -D__KERNEL__
   -Iinclude -Iinclude2 -I/usr/src/linux-2.6.0-1.R/include 
-I/usr/src/alsa/alsa-kernel-20031220/core
   -I/usr/src/linux-2.6.0-1.R//usr/src/alsa/alsa-kernel-20031220/core  
-D__KERNEL__
  -I/usr/src/linux-2.6.0-1.R/include  -I/usr/src/linux-2.6.0-1.R/include2
  -I/usr/src/linux-2.6.0-1.R//usr/src/linux-2.6.0-1.R/include  -Wall  
-Wstrict-prototypes
 -Wno-trigraphs  -O2  -fno-strict-aliasing  -fno-common  -pipe  
-mpreferred-stack-boundary=2  -march=athlon
 -I/usr/src/linux-2.6.0-1.R/include/asm-i386/mach-default  
-fomit-frame-pointer
 -Wdeclaration-after-statement -DMODULE -DKBUILD_BASENAME=hwdep
 -DKBUILD_MODNAME=snd_hwdep -c
  -o /usr/src/alsa/alsa-kernel-20031220/core/hwdep.o 
/usr/src/alsa/alsa-kernel-20031220/core/hwdep.c

Note two weird paths where an absolute path is concatenated with $(srctree)

   -I/usr/src/linux-2.6.0-1.R//usr/src/alsa/alsa-kernel-20031220/core
  -I/usr/src/linux-2.6.0-1.R//usr/src/linux-2.6.0-1.R/include

The first one looks like $(srctree)/<current build directory>, the 
second one looks like
$(srctree)/$(srctree)/include which is  odd.

Is it a feature of the system that SUBDIRS is best specified as a 
relative path to $(srctree)?
How to account for the fact that $(srctree)/include is concatenated to 
$(srctree)?

2nd question: How do you get an include directory to precede 
$(obj)/{include, include2}, $(srctree)/include?
You see in this case I need to use the sound/*.h files from Alsa CVS so 
I need my directory to win in the
include path race. Currently, I copy the include files to 
$(obj)/include/sound. Is there a more elegant way
to specify an include directory that will precede both $(obj)/include 
and $(srctree)/include?

Cheers
Richard













