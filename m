Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbUKVJ6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbUKVJ6w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 04:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbUKVJ6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 04:58:52 -0500
Received: from [61.51.204.161] ([61.51.204.161]:13815 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S262007AbUKVJ6s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 04:58:48 -0500
Date: Mon, 22 Nov 2004 17:54:38 +0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200411220954.iAM9sc002402@freya.yggdrasil.com>
To: gjwucherpfennig@gmx.net, greg@kroah.com
Subject: Re: Kernel thoughts of a Linux user
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-11-18 18:50:11, Greg KH wrote:
>On Thu, Nov 18, 2004 at 06:59:27PM +0100, Gerold J. Wucherpfennig wrote:
>> 
>> - Make sysfs optional and enable to publish kernel <-> userspace data
>> especially the kernel's KObject data across the kernel's netlink interface as
>> it has been summarized on www.kerneltrap.org. This will avoid the
>> deadlocks sysfs does introduce when some userspace app holds an open file
>> handle of an sysfs object (KObject) which is to be removed. An importrant side 
>> effect for embedded systems will be that the RAM overhead introduced by sysfs
>> will vaporize.
>
>What RAM overhead?  With 2.6.10-rc2 the memory footprint of sysfs has
>been drasticly shrunk.

	Looking through 2.6.10-rc2-bk6/fs/sysfs/, it appears to me that
sysfs unswappable memory usage for this desktop system with two
hard disks and a couple of USB devices attached is over 600kB, even
if I do not count the underlying attribute or kobject structures that
are being registered in sysfs.

	Please correct me if I am wrong, but, as far as I can tell,
in 2.6.10-rc2-bk6, a struct dentry is held for each node in the sysfs
tree at all times.  I infer this from noticing that sysfs_drop_dentry
and sysfs_hash_and_remove in fs/sysfs/inode.c only seem to be called
on operations to delete a node.  If I've missed something and the dentry
structures are all or mostly released, I would love to be corrected about
it as that would be really good news to me.

	Here is a partial tally of what I believe are the bytes used for
each sysfs file in the old and new versions (using sizes on my 32-bit
x86 box; your sizes may vary depending on architecture and file system
options that you've enabled).

				Old		New
	dentry			144		144
	inode			344		---
	sysfs_dirent		---		 36
	
	Total			488		180

	There is also an underlying struct attribute (12 bytes) for
sysfs files and struct kobject (52 bytes for sysfs directories), but
let's assume that all of those would still be useful without sysfs.

	The desktop computer on which I am writing this email has
3405 nodes.  So, it's pinned memory consumption has presumbably
dropped from over 1.6 megabytes in the old version to something
over 600kB.

	This is a huge improvement _over the old memory consumption_,
and may also mark the point where most of the rest of the memory
shrink could come from outside of sysfs (for example, by splitting
struct dentry into the part that virtual file systems want to
keep and the part that is only useful when the VFS layer wants
to hold the dentry, or perhaps by making struct dentry and
struct kobject use the same name string), but I would not look at
600kB and say "What RAM overhead?"

	Am I missing something?  Are the dentries being freed
dynamically (for nodes that have not been deleted) in sysfs
in version 2.6.10-rc2-bk6?

                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
