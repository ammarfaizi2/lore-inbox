Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbTIRVpZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 17:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbTIRVpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 17:45:24 -0400
Received: from mail5.intermedia.net ([206.40.48.155]:62724 "EHLO
	mail5.intermedia.net") by vger.kernel.org with ESMTP
	id S262117AbTIRVpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 17:45:12 -0400
Subject: [PATCH] OOPS in sysfs, call_trace in sound/pci/ens1370.c
From: Ranjeet Shetye <ranjeet.shetye2@zultys.com>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Cc: greg@kroah.com, ambx1@neo.rr.com
Content-Type: multipart/mixed; boundary="=-vY5PU0p2pgd/voqJZDyn"
Organization: Zultys Technologies Inc.
Message-Id: <1063921738.1586.6.camel@ranjeet-pc2.zultys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 18 Sep 2003 14:48:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vY5PU0p2pgd/voqJZDyn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Hi,

Adam, I never got your patch bcos our company's ISP got onto an RBL and
I lost many emails after that happened. Greg got me back on track
regarding your patch.

It worked well. Here's the new listing for /sys/bus/pci/drivers/

drwxr-xr-x    2 root     root            0 Sep 18 14:28 Ensoniq 1371/
drwxr-xr-x    2 root     root            0 Sep 18 14:28 Ensoniq 1370/

I was wondering if sound/pci/ens1370.c needs cosmetic changes related to
the "Ensoniq AudioPCI" string.

Greg, thanks a lot for your patience.

I've attached Andrew Morton's patch for the OOPS fix and Adam's patch
for fixing the call_trace due to the Ensoniq name clash. This is the
second time I am sending in Andrew's fix to the kernel mailing list; so
whoever's applying these patches to the main tree, please acknowledge so
that I know these patches aren't being dropped.

thanks,
Ranjeet.


-- 

Ranjeet Shetye
Senior Software Engineer
Zultys Technologies
Ranjeet dot Shetye2 at Zultys dot com
http://www.zultys.com/
 
The views, opinions, and judgements expressed in this message are solely
those of the author. The message contents have not been reviewed or
approved by Zultys.


--=-vY5PU0p2pgd/voqJZDyn
Content-Disposition: attachment; filename="akpm@osdl.org-sysfs.OOPS.diff"
Content-Type: text/x-patch; name="akpm@osdl.org-sysfs.OOPS.diff"; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: fs/sysfs/dir.c
===================================================================
RCS file: /home/cvs/linux-2.5/fs/sysfs/dir.c,v
retrieving revision 1.8
diff -d -u -r1.8 dir.c
--- fs/sysfs/dir.c	5 Sep 2003 21:17:55 -0000	1.8
+++ fs/sysfs/dir.c	17 Sep 2003 22:15:21 -0000
@@ -24,10 +24,11 @@
 static struct dentry * 
 create_dir(struct kobject * k, struct dentry * p, const char * n)
 {
-	struct dentry * dentry;
+	struct dentry * dentry, * ret;
 
 	down(&p->d_inode->i_sem);
 	dentry = sysfs_get_dentry(p,n);
+	ret = dentry;
 	if (!IS_ERR(dentry)) {
 		int error = sysfs_create(dentry,
 					 S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO,
@@ -36,11 +37,11 @@
 			dentry->d_fsdata = k;
 			p->d_inode->i_nlink++;
 		} else
-			dentry = ERR_PTR(error);
+			ret = ERR_PTR(error);
 		dput(dentry);
 	}
 	up(&p->d_inode->i_sem);
-	return dentry;
+	return ret;
 }
 
 

--=-vY5PU0p2pgd/voqJZDyn
Content-Disposition: attachment; filename="ambx1@neo.rr.com-Ensoniqs.diff"
Content-Type: text/plain; name="ambx1@neo.rr.com-Ensoniqs.diff"; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- a/sound/pci/ens1370.c	2003-09-13 19:28:45.000000000 +0000
+++ b/sound/pci/ens1370.c	2003-09-13 19:30:02.000000000 +0000
@@ -2354,7 +2354,11 @@
 }

 static struct pci_driver driver = {
-	.name = "Ensoniq AudioPCI",
+#ifdef CHIP1371
+	.name = "Ensoniq 1371",
+#else
+	.name = "Ensoniq 1370",
+#endif
 	.id_table = snd_audiopci_ids,
 	.probe = snd_audiopci_probe,
 	.remove = __devexit_p(snd_audiopci_remove),

--=-vY5PU0p2pgd/voqJZDyn--

