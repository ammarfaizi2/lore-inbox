Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264365AbUEMSMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264365AbUEMSMM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 14:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264367AbUEMSMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 14:12:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:35217 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264365AbUEMSMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 14:12:08 -0400
Date: Thu, 13 May 2004 11:12:07 -0700
From: Chris Wright <chrisw@osdl.org>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1: nameif causes oops
Message-ID: <20040513111207.A22989@build.pdx.osdl.net>
References: <20040513172849.GA2188@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040513172849.GA2188@middle.of.nowhere>; from thunder7@xs4all.nl on Thu, May 13, 2004 at 07:28:49PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jurriaan (thunder7@xs4all.nl) wrote:
> In my untainted 2.6.6-mm1 kernel, I see an oops (the one with the turtle
> graphics) when booting, caused by the usage of nameif (which renames
> ethernet interfaces from 'eth0' to 'adsl' for example).

This has been reported a few other times and Maneesh Soni <maneesh@in.ibm.com>
posted a patch already.  I added it below.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net


ok it is sysfs related and because of the backing store patches from me.

And here is the fix. Hope this solves your problem. 


Thanks
Maneesh

o Fix sysfs_rename_dir(). The sysfs_lookup() does not hash
  negative dentries so just hash it before calling d_move

 fs/sysfs/dir.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN fs/sysfs/dir.c~sysfs-backing-store-sysfs_rename_dir-fix fs/sysfs/dir.c
--- linux-2.6.6-mm1/fs/sysfs/dir.c~sysfs-backing-store-sysfs_rename_dir-fix	2004-10-06 15:21:37.000000000 +0530
+++ linux-2.6.6-mm1-maneesh/fs/sysfs/dir.c	2004-10-06 15:22:03.000000000 +0530
@@ -314,6 +314,7 @@ void sysfs_rename_dir(struct kobject * k
 	new_dentry = sysfs_get_dentry(parent, new_name);
 	if (!IS_ERR(new_dentry)) {
 		if (!new_dentry->d_inode) {
+			d_add(new_dentry, NULL);
 			d_move(kobj->dentry, new_dentry);
 			kobject_set_name(kobj,new_name);
 		}

