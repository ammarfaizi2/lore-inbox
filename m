Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262536AbTCMUwJ>; Thu, 13 Mar 2003 15:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262542AbTCMUwJ>; Thu, 13 Mar 2003 15:52:09 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:11941 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S262536AbTCMUwI>;
	Thu, 13 Mar 2003 15:52:08 -0500
Date: Fri, 14 Mar 2003 00:01:44 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@redhat.com, linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: [2.4] init/do_mounts.c::rd_load_image() memleak
Message-ID: <20030313210144.GA3542@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   rd_load_image() leaks some memory if it cannot determine source device size,
   if it cannot close or open source for ramdisk device.

   Probably this is not all that critical, since we most likely panic after
   failure to load initrd, but still there is chance that we have valid
   root device too, from which we can try to continue to boot.

   Found with help of smatch + enhanced unfree script.

Bye,
    Oleg

===== init/do_mounts.c 1.35 vs edited =====
--- 1.35/init/do_mounts.c	Wed Jan 15 09:42:29 2003
+++ edited/init/do_mounts.c	Thu Mar 13 23:56:18 2003
@@ -551,7 +551,7 @@
 	int in_fd, out_fd;
 	unsigned long rd_blocks, devblocks;
 	int nblocks, i;
-	char *buf;
+	char *buf = 0;
 	unsigned short rotate = 0;
 #if !defined(CONFIG_ARCH_S390) && !defined(CONFIG_PPC_ISERIES)
 	char rotator[4] = { '|' , '/' , '-' , '\\' };
@@ -648,7 +648,6 @@
 #endif
 	}
 	printk("done.\n");
-	kfree(buf);
 
 successful_load:
 	res = 1;
@@ -656,6 +655,8 @@
 	close(in_fd);
 noclose_input:
 	close(out_fd);
+	if (buf)
+		kfree(buf);
 out:
 	sys_unlink("/dev/ram");
 #endif
