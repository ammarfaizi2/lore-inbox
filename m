Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262542AbUKEA7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbUKEA7v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 19:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbUKEA5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 19:57:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:11999 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262535AbUKEAtc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 19:49:32 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] More Driver Core patches for 2.6.10-rc1
In-Reply-To: <10996157064167@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 4 Nov 2004 16:48:26 -0800
Message-Id: <10996157062058@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2462, 2004/11/04 14:44:35-08:00, maneesh@in.ibm.com

[PATCH] fix kernel BUG at fs/sysfs/dir.c:20!

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

There is a similar problem reported by s390 people where we see parent
kobject (directory) going away before child kobject (sub-directory). It
seems kobject code is able to handle this, but not the sysfs. What could
be happening that in sysfs_remove_dir() of parent directory, we try to
remove its contents. It works well with the regular files as it is the
final removal for sysfs_dirent corresponding to the files. But in case
of sub-directory we are doing an extra sysfs_put().  Once while removing
parent and the other one being the one from when sysfs_remove_dir() is
called for the child.

The following patch worked for the s390 people, I hope same will work in
this case also.


o Do not remove sysfs_dirents corresponding to the sub-directory in
  sysfs_remove_dir(). They will be removed in the sysfs_remove_dir() call
  for the specific sub-directory.

Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 fs/sysfs/dir.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/fs/sysfs/dir.c b/fs/sysfs/dir.c
--- a/fs/sysfs/dir.c	2004-11-04 16:29:54 -08:00
+++ b/fs/sysfs/dir.c	2004-11-04 16:29:54 -08:00
@@ -277,7 +277,7 @@
 	pr_debug("sysfs %s: removing dir\n",dentry->d_name.name);
 	down(&dentry->d_inode->i_sem);
 	list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
-		if (!sd->s_element)
+		if (!sd->s_element || !(sd->s_type & SYSFS_NOT_PINNED))
 			continue;
 		list_del_init(&sd->s_sibling);
 		sysfs_drop_dentry(sd, dentry);

