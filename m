Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbULCULd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbULCULd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 15:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbULCUEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 15:04:37 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:56575 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262498AbULCUBZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 15:01:25 -0500
Date: Fri, 3 Dec 2004 12:00:36 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] sysfs: fix sysfs_dir_close memory leak
Message-ID: <20041203200036.GC1178@kroah.com>
References: <20041203195908.GA1178@kroah.com> <20041203200003.GB1178@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041203200003.GB1178@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sysfs_dir_close did not free the "cursor" sysfs_dirent used for keeping
track of position in the list of sysfs_dirent nodes.  Consequently,
doing a "find /sys" would leak a sysfs_dirent for each of the 1140
directories in my /sys tree, or about 36kB each time.


From: "Adam J. Richter" <adam@yggdrasil.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


--- 1.34/fs/sysfs/dir.c	2004-11-22 10:42:02 -08:00
+++ edited/fs/sysfs/dir.c	2004-12-03 10:42:51 -08:00
@@ -351,6 +351,8 @@ static int sysfs_dir_close(struct inode 
 	list_del_init(&cursor->s_sibling);
 	up(&dentry->d_inode->i_sem);
 
+	release_sysfs_dirent(cursor);
+
 	return 0;
 }
 
