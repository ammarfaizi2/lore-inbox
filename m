Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314326AbSDRLuB>; Thu, 18 Apr 2002 07:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314327AbSDRLuA>; Thu, 18 Apr 2002 07:50:00 -0400
Received: from salmon.maths.tcd.ie ([134.226.81.11]:8715 "HELO
	salmon.maths.tcd.ie") by vger.kernel.org with SMTP
	id <S314326AbSDRLt7>; Thu, 18 Apr 2002 07:49:59 -0400
Date: Thu, 18 Apr 2002 12:47:39 +0100
From: Timothy Murphy <tim@birdsnest.maths.tcd.ie>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: linux-2.5.8
Message-ID: <20020418124739.A16076@birdsnest.maths.tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two tiny errors, probably noted already:

1. Missing quotes in drivers/ide/Config.in,
causing "make xconfig" to fail:

=========================================================
--- linux-2.5.8.orig/drivers/ide/Config.in	Sun Apr 14 20:18:56 2002
+++ linux-2.5.8/drivers/ide/Config.in	Thu Apr 18 00:38:19 2002
@@ -49,7 +49,7 @@
 	 define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PCI
 	 dep_bool '    ATA tagged command queueing' CONFIG_BLK_DEV_IDE_TCQ $CONFIG_BLK_DEV_IDEDMA_PCI
 	   dep_bool '      TCQ on by default' CONFIG_BLK_DEV_IDE_TCQ_DEFAULT $CONFIG_BLK_DEV_IDE_TCQ
-	   if [ $CONFIG_BLK_DEV_IDE_TCQ_DEFAULT != "n" ]; then
+	   if [ "$CONFIG_BLK_DEV_IDE_TCQ_DEFAULT" != "n" ]; then
 		int '      Default queue depth' CONFIG_BLK_DEV_IDE_TCQ_DEPTH 32
 	   fi
 	 dep_bool '    ATA Work(s) In Progress (EXPERIMENTAL)' CONFIG_IDEDMA_PCI_WIP $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_EXPERIMENTAL
=========================================================

2. Missing definition of setup_per_cpu_areas() in init/main.c (in non-SMP case):

=========================================================
--- linux-2.5.8.orig/init/main.c	Sun Apr 14 20:18:46 2002
+++ linux-2.5.8/init/main.c	Thu Apr 18 00:41:33 2002
@@ -272,6 +272,8 @@
 #define smp_init()	do { } while (0)
 #endif
 
+static inline void setup_per_cpu_areas(void) { }
+
 #else
 
 #ifdef __GENERIC_PER_CPU
=========================================================

3. With these changes the kernel compiles and seems to run OK
on my Crusoe-based Sony PictureBook (C1VFK),
except that it bombs out when halting (or rebooting) --

"Unable to handle kernel paging request
at virtual address c785a428
/etc/rc6.d/S01reboot: line  1 8113 Segmentation fault"

eip: c01f353f
*pde = 06f56067
*pfe = 00000000
Oops: 0000
CPU: 0
EIP: 0010: [<c01f353f>]
EFLAGS: 00010286
eax: bffff4c0
ebx: bffff4c0
ecx: 00000000
edx: c7864388
esi: 00000002
edi: 00000000
ebp: bffff4b8
esp: c6603ed4
Process reboot (pid 2356,...)

-- 
Timothy Murphy  
e-mail: tim@birdsnest.maths.tcd.ie
tel: 086-233 6090
s-mail: School of Mathematics, Trinity College, Dublin 2, Ireland
