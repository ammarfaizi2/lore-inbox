Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264673AbTBET6z>; Wed, 5 Feb 2003 14:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbTBET6w>; Wed, 5 Feb 2003 14:58:52 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:9964 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id <S264628AbTBET6t>;
	Wed, 5 Feb 2003 14:58:49 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] don't swapon mounted devices
Date: Wed, 5 Feb 2003 13:08:14 -0700
User-Agent: KMail/1.4.3
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200302051308.14925.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch against 2.4.21-pre3 fixes a problem in sys_swapon.
Previous behavior:

	* boot kernel with "root=/dev/sda3 init=/bin/bash" (ext3 root)
	* mount -t proc proc /proc
	* /sbin/swapon /dev/sda3    <--- NOTE: same as root!
	* mount -n -o remount,rw /
	* oops in __make_request because superblock buffer_head is
	  no longer mapped (via sys_swapon -> set_blocksize ->
	  kill_bdev-> truncate_inode_pages -> do_flushpage ->
	  block_flushpage -> discard_bh_page -> discard_buffer)

I think 2.5 avoids this problem by attempting to get exclusive
use of the device with bd_claim (see
http://linux.bkbits.net:8080/linux-2.5/cset@1.369.32.10?nav=index.html|src/.|src/mm|related/mm/swapfile.c)

bd_claim is not in 2.4, so this seems next-best. 

Bjorn


--- 1.25/mm/swapfile.c	Sat Dec 28 16:18:13 2002
+++ edited/mm/swapfile.c	Wed Feb  5 10:32:27 2003
@@ -915,6 +915,11 @@
 		struct block_device_operations *bdops;
 		devfs_handle_t de;
 
+		if (is_mounted(dev)) {
+			error = -EBUSY;
+			goto bad_swap_2;
+		}
+
 		p->swap_device = dev;
 		set_blocksize(dev, PAGE_SIZE);
 		

