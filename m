Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbTJFI7A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 04:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbTJFI7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 04:59:00 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:36087 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261659AbTJFI66
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 04:58:58 -0400
Date: Mon, 6 Oct 2003 14:29:15 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>, Greg KH <gregkh@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Dipankar Sarma <dipankar@in.ibm.com>
Subject: [RFC 0/6] Backing Store for sysfs
Message-ID: <20031006085915.GE4220@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The following patch set(mailed separately) provides a prototype for a backing 
store mechanism for sysfs. Currently sysfs pins all its dentries and inodes in 
memory there by wasting kernel lowmem even when it is not mounted. 

With this patch set we create sysfs dentry whenever it is required like 
other real filesystems and, age and free it as per the dcache rules. We
now save significant amount of Lowmem by avoiding un-necessary pinning. 
The following numbers were on a 2-way system with 6 disks and 2 NICs with 
about 1028 dentries. The numbers are just indicative as they are system
wide collected from /proc and are not exclusively for sysfs.

				2.6.0-test6		With patches.
Right after system is booted
---------------------------
dentry_cache (active)		2343			1315
inode_cache (active)		1058			30
LowFree				875096 KB		875900 KB

After mounting sysfs
-------------------
dentry_cache (active)		2350			1321
inode_cache (active)		1058			31
LowFree				875096 KB		875836 KB

After "find /sys"
-----------------
dentry_cache (active)		2520			2544
inode_cache (active)		1058			1050
LowFree				875032 KB		874748 KB

After un-mounting sysfs
-----------------------
dentry_cache (active)		2363			1319
inode_cache (active)		1058			30
LowFree				875032 KB		875836 KB


The main idea is not create the dentry in sysfs_create_xxx calls but create
the dentry when it is first lookup. We now have lookup() inode_operation, 
open and close file_operations for sysfs directory inodes. 

The backing store is based on the kobjects which are always there in memory.
sysfs lookup is based on hierarchy of kobjects. As the current kobject 
infrastructure donot provide any means to traverse the kobject's children or 
siblings, two-way hierarchy lookup was not possible. For this new fields 
are added to kobject structure. This ended up increasing the size of kobject
from 52 bytes to 108 bytes but saving one dentry and inode per kobject.

The details of the patches are in the following mails. For testing please
apply all the patches as they are splitted just for ease of review.

Please send me comments on the approach, implementation, missed things and 
suggestions to improve them.

Thanks,
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
