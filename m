Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266452AbTGERJz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 13:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266456AbTGERJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 13:09:54 -0400
Received: from arbi.Informatik.uni-oldenburg.de ([134.106.1.7]:15890 "EHLO
	arbi.Informatik.Uni-Oldenburg.DE") by vger.kernel.org with ESMTP
	id S266452AbTGERJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 13:09:34 -0400
Subject: PATCH 2.4.21 nfsroot.c buffercheck
To: linux-kernel@vger.kernel.org (kernel linux)
Date: Sat, 5 Jul 2003 19:24:01 +0200 (MEST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E19YqlV-000ITc-00@grossglockner.Informatik.Uni-Oldenburg.DE>
From: "Walter Harms" <Walter.Harms@Informatik.Uni-Oldenburg.DE>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liste,
this patches fixes a wrong bordercheck  and simplifies it.
Strings with NFS_MAXPATHLEN would pass in the old code.

walter


--- fs/nfs/nfsroot.c.org        2003-07-03 23:23:18.000000000 +0200
+++ fs/nfs/nfsroot.c    2003-07-03 23:36:51.000000000 +0200
@@ -207,7 +207,8 @@
 {
        char buf[NFS_MAXPATHLEN];
        char *cp;
-
+       int ret;
+
        /* Set some default values */
        memset(&nfs_data, 0, sizeof(nfs_data));
        nfs_port          = -1;
@@ -230,14 +231,15 @@
        /* Override them by options set on kernel command-line */
        root_nfs_parse(name, buf);
 
-       cp = system_utsname.nodename;
-       if (strlen(buf) + strlen(cp) > NFS_MAXPATHLEN) {
-               printk(KERN_ERR "Root-NFS: Pathname for remote directory too long.\n");
-               return -1;
-       }
-       sprintf(nfs_path, buf, cp);
+       ret=snprintf(nfs_path,NFS_MAXPATHLEN, buf, system_utsname.nodename);
 
-       return 1;
+       if (ret < NFS_MAXPATHLEN) 
+               return 1;
+        else {
+               printk(KERN_ERR "Root-NFS: Pathname for remote directory too long.\n");
+               return -1;
+       }
+
 }
 

