Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264962AbSJPIos>; Wed, 16 Oct 2002 04:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264964AbSJPIor>; Wed, 16 Oct 2002 04:44:47 -0400
Received: from angband.namesys.com ([212.16.7.85]:23171 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S264962AbSJPIoq>; Wed, 16 Oct 2002 04:44:46 -0400
Date: Wed, 16 Oct 2002 12:50:37 +0400
From: Oleg Drokin <green@namesys.com>
To: Jeff Dike <jdike@karaya.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: UML and 2.5.43
Message-ID: <20021016125037.A6413@namesys.com>
References: <200210151717.MAA02888@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200210151717.MAA02888@ccure.karaya.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

    I noticed that in 2.5.43 ubd does not work anymore until
    you enable devfs support, since devfs_register is now only
    return meaningful values if devfs is compiled, otherwise it
    just returns NULL, and ubd treats this as error. Since UML
    itself only uses that value for subsequent freeing of devfs node,
    it is quite safe (returned NULL means nothing should be freed
    later ;) )

    Probably attached patch is one of the right things to do.
    As additional bonus it fixes uninitialised variable usage ;)

Bye,
    Oleg

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.859   -> 1.860  
#	arch/um/drivers/ubd_kern.c	1.10    -> 1.11   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/16	green@angband.namesys.com	1.860
# do not look at return values from devfs_register stuff
# --------------------------------------------
#
diff -Nru a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
--- a/arch/um/drivers/ubd_kern.c	Wed Oct 16 12:41:24 2002
+++ b/arch/um/drivers/ubd_kern.c	Wed Oct 16 12:41:24 2002
@@ -469,9 +469,7 @@
 			      MAJOR_NR, n << UBD_SHIFT,
 			      S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP |S_IWGRP,
 			      &ubd_blops, NULL);
- 	if(real == NULL) 
- 		goto out;
- 	ubd_dev[n].real = real;
+	ubd_dev[n].real = real;
 
 	if (fake_major) {
 		fake = devfs_register(ubd_fake_dir_handle, name, 
@@ -479,20 +477,16 @@
 				      n << UBD_SHIFT, 
 				      S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP |
 				      S_IWGRP, &ubd_blops, NULL);
- 		if(fake == NULL)
-			goto out_unregister;
 
- 		ubd_dev[n].fake = fake;
+		ubd_dev[n].fake = fake;
 		add_disk(fake_disk);
+		
 	}
  
 	add_disk(disk);
 	make_ide_entries(disk->disk_name);
 	return(0);
 
- out_unregister:
-	devfs_unregister(real);
-	ubd_dev[n].real = NULL;
  out:
 	return(-1);
 }
@@ -700,6 +694,6 @@
 {
 	int n = DEVICE_NR(inode->i_rdev);
 	struct ubd *dev = &ubd_dev[n];
-	int err;
+	int err = -EISDIR;
 	if(dev->is_dir == 1)
 		goto out;
