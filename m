Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262437AbUKDVoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbUKDVoY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 16:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbUKDVoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 16:44:23 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:10169 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262437AbUKDVn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 16:43:56 -0500
Date: Thu, 4 Nov 2004 13:44:14 -0800
From: Maneesh Soni <maneesh@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, cohuck@de.ibm.com
Subject: Re: kernel BUG at fs/sysfs/dir.c:20!
Message-ID: <20041104214414.GA2555@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20041104205238.GA11885@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104205238.GA11885@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 12:52:38PM -0800, Greg KH wrote:
> Hi,
> 
> I get the following BUG in the sysfs code when I do:
> 	- plug in a usb-serial device.
> 	- open the port with 'cat /dev/ttyUSB0'
> 	- unplug the device.
> 	- stop the 'cat' process with control-C
> 
> This used to work just fine before your big sysfs changes.
> 
> Anything I should look at testing?
> 

Hi Greg,

I was about to talk to you. There is a similar problem reported by
s390 people where we see parent kobject (directory) going away before
child kobject (sub-directory). It seems kobject code is able to handle
this, but not the sysfs. What could be happening that in sysfs_remove_dir()
of parent directory, we try to remove its contents. It works well with
the regular files as it is the final removal for sysfs_dirent corresponding
to the files. But in case of sub-directory we are doing an extra sysfs_put().
Once while removing parent and the other one being the one from when 
sysfs_remove_dir() is called for the child. 

The following patch worked for the s390 people, I hope same will work in
this case also.


o Do not remove sysfs_dirents corresponding to the sub-directory in 
  sysfs_remove_dir(). They will be removed in the sysfs_remove_dir() call
  for the specific sub-directory.

Signed-off-by: <maneesh@in.ibm.com>
---

 linux-2.6.10-rc1-bk14-maneesh/fs/sysfs/dir.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/sysfs/dir.c~parent-before-child-removal-fix fs/sysfs/dir.c
--- linux-2.6.10-rc1-bk14/fs/sysfs/dir.c~parent-before-child-removal-fix	2004-11-04 13:37:32.000000000 -0800
+++ linux-2.6.10-rc1-bk14-maneesh/fs/sysfs/dir.c	2004-11-04 13:37:32.000000000 -0800
@@ -277,7 +277,7 @@ void sysfs_remove_dir(struct kobject * k
 	pr_debug("sysfs %s: removing dir\n",dentry->d_name.name);
 	down(&dentry->d_inode->i_sem);
 	list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
-		if (!sd->s_element)
+		if (!sd->s_element || !(sd->s_type & SYSFS_NOT_PINNED))
 			continue;
 		list_del_init(&sd->s_sibling);
 		sysfs_drop_dentry(sd, dentry);
_



-- 
Maneesh Soni
Linux Technology Center, 
IBM Austin
email: maneesh@in.ibm.com
Phone: 1-512-838-1896 Fax: 
T/L : 6781896
