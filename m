Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWCCU2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWCCU2f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 15:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWCCU2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 15:28:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25730 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932339AbWCCU2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 15:28:34 -0500
Message-ID: <4408A6EA.70501@redhat.com>
Date: Fri, 03 Mar 2006 15:28:26 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] possible DoS attack using nfsservctl()
Content-Type: multipart/mixed;
 boundary="------------050706040409010305050702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050706040409010305050702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Attached is a patch which addresses a possible DoS attack using the
nfsservctl() system call.  A user can use this system call to fill
up the file system which stores kernel messages, thus causing potential
problems and/or hiding more valuable messages.

This can happen because the arguments to the nfsservctl() system call
are versioned.  This is a good thing.  However, when a bad version is
detected, the kernel prints a message and then returns an error.  I
presume that this message was meant to be used to help to detect mis-
matches between the kernel and nfs-utils, but the message does not
really contain enough information to be useful in this fashion.

The solution is to remove the message and just return the error.  A
mis-match between the kernel and nfs-utils can be determined in other
ways, ways that don't lead to DoS attacks.

While I was there, I corrected some error handling on the compat
version of the nfsservctl() system.  It was detecting errors while
copying in the arguments from user space, but then attempting to use
the arguments anyway.  This didn't seem so good.

    Thanx...

       ps

Signed-off-by: Peter Staubach <staubach@redhat.com>

--------------050706040409010305050702
Content-Type: text/plain;
 name="nfsservctl.devel"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nfsservctl.devel"

--- linux-2.6.15.x86_64/fs/nfsctl.c.org
+++ linux-2.6.15.x86_64/fs/nfsctl.c
@@ -98,10 +98,8 @@ asmlinkage sys_nfsservctl(int cmd, struc
 	if (copy_from_user(&version, &arg->ca_version, sizeof(int)))
 		return -EFAULT;
 
-	if (version != NFSCTL_VERSION) {
-		printk(KERN_WARNING "nfsd: incompatible version in syscall.\n");
+	if (version != NFSCTL_VERSION)
 		return -EINVAL;
-	}
 
 	if (cmd < 0 || cmd >= sizeof(map)/sizeof(map[0]) || !map[cmd].name)
 		return -EINVAL;
--- linux-2.6.15.x86_64/fs/compat.c.org
+++ linux-2.6.15.x86_64/fs/compat.c
@@ -2168,9 +2168,12 @@ asmlinkage long compat_sys_nfsservctl(in
 
 	default:
 		err = -EINVAL;
-		goto done;
+		break;
 	}
 
+	if (err)
+		goto done;
+
 	oldfs = get_fs();
 	set_fs(KERNEL_DS);
 	/* The __user pointer casts are valid because of the set_fs() */

--------------050706040409010305050702--
