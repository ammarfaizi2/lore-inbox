Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbULBHrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbULBHrO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 02:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbULBHrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 02:47:13 -0500
Received: from [61.48.53.101] ([61.48.53.101]:49130 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261227AbULBHrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 02:47:09 -0500
Date: Wed, 1 Dec 2004 23:37:27 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200412020737.iB27bR826761@adam.yggdrasil.com>
To: chrisw@osdl.org
Subject: Re: [Patch?] Teach sysfs_get_name not to use a dentry
Cc: akpm@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       maneesh@in.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
>* Adam J. Richter (adam@yggdrasil.com) wrote:
>> -static int create_dir(struct kobject * k, struct dentry * p,
>> -		      const char * n, struct dentry ** d)
>> +static int create_dir(void *element, struct dentry * p,
>> +		      const char * n, struct dentry ** d, int type)

>Hmm, I did not look closely, but moving from well-typed to untyped void *
>doesn't look nice.

	The reason for the change comes from the fact that there are
two different kinds of directories in a sysfs tree: one representing
a kobject, and one representing an attribute_group.  Previously, both
types of directories saved a pointer to the kobject (in the case of
the attribute group, the parent directory is a kobject).  Now, however,
the attribute group saves a pointer to the struct attribute group,
so that the name of the attribute group can be accessed without
referencing the dentry.  So, the value that create_dir sets
sysfs_dirent.s_element to really can be to more than one type
depending on who is calling create_dir (and, by the way,
sysfs_dirent.s_element is used to point to a few different
data types, not just these two, and setting sysfs_dirent.s_element
is the only thing that create_dir does with that parameter).

	You might wonder how an attribute group's kobject is
determined within sysfs, if we are no longer saving that pointer in
sysfs_dirent.s_element.  It turns out that cases where the parent
kobject needs to be determined from the attribute group in sysfs
only occur in when the attribute group's dentry is available, so
the kobject is available as sysfs_dirent->s_dentry->d_parent->s_fsdata.

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
