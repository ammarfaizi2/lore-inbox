Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbUKVWzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbUKVWzB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbUKVWyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:54:05 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:40947 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261205AbUKVWxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:53:39 -0500
Date: Mon, 22 Nov 2004 16:53:09 -0600
From: Maneesh Soni <maneesh@in.ibm.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Delete sysfs_dirent.s_count, saving ~100kB on my system
Message-ID: <20041122225309.GB12858@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <200411221917.iAMJHXg02123@freya.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411221917.iAMJHXg02123@freya.yggdrasil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 03:17:33AM +0800, Adam J. Richter wrote:
> 	The following patch against linux-2.6.10-rc2-bk6 removes
> the s_count field from sysfs_dirent.  This reduces sizeof(sysfs_dirent)
> from 36 to 32 bytes on 32-bit machines, resulting in big space
> savings because it reduces the size that kmalloc actually uses for
> the allocation from 64 to 32 bytes, and there is one of these for
> every node in sysfs, of which there are 3405 on the modest desktop
> machine that I'm using to compose this email.  That's a savings of
> 108,960 bytes of unswappable kernel memory in this case.
> 
> 	Reference counting appears to me to be unnecessary on this
> data structure.  sysfs_dirent exists when a node name is registered in
> sysfs, and it does not exist when the node name is not registered.
> It does not matter if a program is still holding a reference to the
> struct inode when sysfs_dirent is deleted, since sysfs_dirent is only
> relevant to directory lookup operations.  It also should not matter if the
> system is freeing the struct inode and the struct dentry to save
> space.  As long as the file is registered in sysfs, the sysfs_dirent
> is not freed.
> 
> 	Removing sysfs_dirent.s_count results in the removal of other
> supporting code, including sysfs_dentry_ops, for a net deletion of
> 39 lines of code.
> 
> 	I have only tested this patch by mounting /sys, and running
> some "find" commands on it, plugging and unplugging a USB device,
> and verifying that the number of entries in sysfs increased and
> decreased accordingly.  I am running it on the system on which I
> am composing this email.
> 

The idea for having ref count for sysfs_dirent was to keep the sysfs_dirents
around as long as there are live dentries corresponding to sysfs objects.
There can be open files (live dentries) but files getting removed. IMO,
without having ref count for sysfs_dirent, we could end up loosing the 
sysfs_dirent and end up in inconsistent sysfs_dirent tree with respect to
dentry tree. If we could maintain the consistency without refcounts then
it is good to reduce the size of sysfs_dirent structure.

Could you also test the patch like this, on an SMP box. Basically
opening/closing sysfs files and simultaneously inserting & removing dummy
module. This is just to make sure that we don't have any races 
particularly in dir and file operations. I will also test the patch tonight.

# while true; do find /sys/class/net/ | xargs cat; done
# while true; do insmod dummy.ko; rmmod dummy; done
# while true; do ls -lR /sys > /dev/null; done


Thanks
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM Austin
email: maneesh@in.ibm.com
Phone: 1-512-838-1896 Fax: 
T/L : 6781896
