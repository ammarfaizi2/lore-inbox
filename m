Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbULBLX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbULBLX4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 06:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbULBLX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 06:23:56 -0500
Received: from [61.48.53.101] ([61.48.53.101]:57842 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261588AbULBLXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 06:23:53 -0500
Date: Thu, 2 Dec 2004 03:14:08 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200412021114.iB2BE8928358@adam.yggdrasil.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [Patch?] Teach sysfs_get_name not to use a dentry
Cc: akpm@osdl.org, chrisw@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, maneesh@in.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2004 07:00:22 +0000 Al Viro wrote:
>On Wed, Dec 01, 2004 at 10:41:08PM -0800, Adam J. Richter wrote:
>> Hi Maneesh,
>> 
>> 	The following patch changes syfs_getname to avoid using
>> sysfs_dirent->s_dentry for getting the names of directories (as
>> this pointer may be NULL in a future version where sysfs would
>> be able to release the inode and dentry for each sysfs directory).
>> It does so by defining different sysfs_dirent.s_type values depending
>> on whether the diretory represents a kobject or an attribute_group.
>> 
>> 	This patch is ground work for unpinning the struct inode
>> and struct dentry used by each sysfs directory.  The patch also may
>> facilitate eliminating the sysfs_dentry for each member of an
>> attribute group.  The patch has no benefits by itself, but I'm posting
>> it now separately in the hopes of making it easier for people
>> to spot problems, and, also, because if it is integrated, I think
>> it will make the rest of the change to unpin directories (which
>> I have not yet written) easier to understand.

>Vetoed until you show an acceptable locking scheme for the latter.
>I do not believe that it's feasible; feel free to prove me wrong,
>but until then you'll have to carry the patchset on your own.

	I will try to code it up, but first I expect to post a couple
more incremental changes along the way that,  unlike this change,
are useful in their own right even if the unpinning the sysfs
directories are not implemented.  In particular, I expect to post
a patch to move the sysfs_dirent and the sysfs_dirent.s_type values
from the public include/linux/sysfs.h to fs/sysfs/sysfs.h, and
a patch to eliminate sysfs_dirent.s_children for non-directories.

	When I do get around to posting a patch to unpin the sysfs
directories, I think it would be incumbent upon anyone claiming
that they are "vetoed" to describing the problem including at least
a hypothetical example, as you haven't really defined "acceptable"
if you haven't shown there to be problem.  By the same token, it's
reasonable if you want to wait and see an implementation before
complaining, although if there is some problem scenario you can
already think of, I'd be interested in hearing about it.

	Here are a few basic points to check if you already see
a locking problem that you think would really be hard to address.

	1. The only renames in sysfs (as far as I know) are within
	   the same directory for an unusual use by the network
	   code, which I suspect could probably be eliminated anyhow.

	2. sysfs_dirent does not maintain a parallel "parent" pointer.

	3. I intended to replace kobject->dentry with kobject->sysfs_dir.

	4. Is the race you see unique to directories?

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
