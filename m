Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262625AbUKEHto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbUKEHto (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 02:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbUKEHto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 02:49:44 -0500
Received: from sullivan.realtime.net ([205.238.132.76]:42766 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id S262625AbUKEHtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 02:49:39 -0500
Date: Fri, 5 Nov 2004 01:49:34 -0600 (CST)
Message-Id: <200411050749.iA57nXlP076996@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
To: (Maneesh Soni) maneesh@in.ibm.com, (Greg KH) greg@kroah.com
Cc: (Andrew Morton) akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: sysfs backing store error path confusion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 3, 2004, at 3:42 PM, Greg KH wrote:

|On Tue, Nov 02, 2004 at 10:03:34AM -0600, Maneesh Soni wrote:
||On Tue, Nov 02, 2004 at 02:46:58AM -0600, Milton Miller wrote:
|||sysfs_new_dirent returns ERR_PTR(-ENOMEM) if kmalloc fails but the callers
|||were expecting NULL.  
||
||Thanks for spotting this. But as you said, I will prefer to change the callee.
||How about this patch? 
..
||-		return -ENOMEM;
||+		return NULL;
|
|Actually, this needs to be a 0, not NULL, otherwise the compiler
|complains with a warning.  I've fixed it up and applied it.
|
|thanks,
|
|greg k-h

I wondered why greg thought the type was wrong.   After it was merged I 
realized that the wrong function was changed.  Here's an attempt to fix
both errors.

milton

===== fs/sysfs/dir.c 1.27 vs edited =====
--- 1.27/fs/sysfs/dir.c	2004-11-04 22:37:32 +01:00
+++ edited/fs/sysfs/dir.c	2004-11-05 08:10:54 +01:00
@@ -38,7 +38,7 @@ static struct sysfs_dirent * sysfs_new_d
 
 	sd = kmalloc(sizeof(*sd), GFP_KERNEL);
 	if (!sd)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	memset(sd, 0, sizeof(*sd));
 	atomic_set(&sd->s_count, 1);
@@ -56,7 +56,7 @@ int sysfs_make_dirent(struct sysfs_diren
 
 	sd = sysfs_new_dirent(parent_sd, element);
 	if (!sd)
-		return 0;
+		return -ENOMEM;
 
 	sd->s_mode = mode;
 	sd->s_type = type;

