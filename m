Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbUL3Ro2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUL3Ro2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 12:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUL3Ro2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 12:44:28 -0500
Received: from [61.49.235.157] ([61.49.235.157]:16883 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261681AbUL3RoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 12:44:22 -0500
Date: Thu, 30 Dec 2004 09:33:32 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200412301733.iBUHXW719876@adam.yggdrasil.com>
To: maneesh@in.ibm.com
Subject: Re: [Patch] Do not allocate sysfs_dirent.s_children for non-directories
Cc: akpm@osdl.org, chrisw@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2004 19:05:29 +0530, Maneesh Soni wrote:
>On Thu, Dec 02, 2004 at 07:20:35PM -0800, Adam J. Richter wrote:
>> 	The following patch, against a heavily hacked 2.6.10-rc2-bk15
>> sysfs tree, removes the s_children field from sysfs_dirent and
>> creates a new structure just for directories named sysfs_dir, which
>> embeds a sysfs_dirent and also adds s_children.  Directories allocate
>> a sysfs_dir; non-directories allocate a sysfs_dirent.  There are
>> two separate kmem caches for the different data types.
>> 
>> 	Not allocating s_children from each non-directory saves
>> two pointers (8 bytes) for each of the 2573 non-directory nodes
>> in my sysfs tree, or about 20kB on unswappable memory, but
>> having another kmem cache probably wastes an average of half
>> a page in memory fragmentation and then there is are few
>> bytes from the new code and the additional kmem_cache_t
>> structure, so I would guess it probably saves about 16kB in
>> practice.
>> 
>> 	In the future, I hope to make a similar change for symbolic
>> links.
>> 
>> 	By the way, this patch will also make it easier for me to
>> try to unpin sysfs directories because there are a few other
>> fields specific to directories that I would want to store
>> in sysfs_dir.
>> 


>Apart from a couple of diff'ing related comments, I feel the code looks 
>some what complicated. I think we can directly link sysfs_dir to 
>directory dentries and sysfs_dirent to non-directory dentries instead 
>of always linking sysfs_dirent to d_fsdata. To differentiate between the
>two types of structures linked to dentry's d_fsdata field, we can use
>S_ISDIR(dentry->d_inode->i_mode). This will avoid using container_of() and 
>the dentry_to_sysfs_dir() conversions.

>Most of the places we may not need to find what type of struct d_fsdata points
>to. Like in sysfs_make_dirent(), first param has to be sysfs_dir as the parent
>dentry corresponds to a sysfs directory.

>In sysfs_lookup() also, we know parent dentry corresponds to sysfs directory
>so dentry's d_fsdata will point to sysfs_dir instead of sysfs_dirent.

	In the future, I want to make a change so that attributes in
a named struct attribute_group do not each have a struct dirent.
In that case, it is possible that the attribute_group will only need
a struct sysfs_dirent, not a struct sysfs_dir.

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
