Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266322AbUBDLd1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 06:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUBDLd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 06:33:27 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:749 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266322AbUBDLdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 06:33:24 -0500
Date: Wed, 4 Feb 2004 17:07:58 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "Martin J. Bligh" <mjbligh@us.ibm.com>, Matt Mackall <mpm@selenic.com>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>
Subject: [RFC/T 0/6] sysfs backing store (with symlink)
Message-ID: <20040204113758.GA4234@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Please find following patches for sysfs-backing store. This version has
support for putting symlinks also on backing store. Earlier it has support
for text/binary attribute files. 

http://marc.theaimsgroup.com/?l=linux-kernel&m=107269078726254&w=2

Apart from a few bug fixes, the main change in this version is for symlinks. 
sysfs_create_link() now does not create dentry/inode for the link, but 
allocates a sysfs_dirent and adds it the parent sysfs_dirent's s_children 
list. dentry/inode for the link is created when the symlink is first looked up. 

I request Martin and Mackall to _replace_ the old patch set with the 
new one in their trees.

With this we save approx 75-80% of lowmem requirements of sysfs. Symlinks 
support is needed for S390 linux people as they create lots of symlinks. I 
have some numbers collected on S390 machine after creating 4096 ctc devices.
This created around 62433 sysfs entries. Backing store saves around 145 MB
of Lowmem when sysfs files are not in use.

---------------------------------------------------------------------------
Without sysfs backing store 
# cat /proc/sys/fs/dentry-state
66733   4100    45      0       0       0

# grep LowFree /proc/meminfo
LowFree:         20984 kB

# grep dentry /proc/slabinfo; grep -w inode_cache /proc/slabinfo
dentry_cache       66750  66750    256   15    1 : tunables  120   60    8 : slabdata   4450   4450      0
inode_cache        62480  62480    768    5    1 : tunables   54   27    8 : slabdata  12496  12496      0

---------------------------------------------------------------------------
---------------------------------------------------------------------------
With sysfs backing store 
# cat /proc/sys/fs/dentry-state 
8783    155     45      0       0       0

# grep LowFree /proc/meminfo
LowFree:        166416 kB

# grep dentry /proc/slabinfo; grep -w inode_cache /proc/slabinfo
dentry_cache        8795   8880    256   15    1 : tunables  120   60    8 : slabdata    592    592      0
inode_cache         8495   8495    768    5    1 : tunables   54   27    8 : slabdata   1699   1699      0

**** Savings of around 145 MB of Lowmem *****
---------------------------------------------------------------------------

Thanks
Maneesh
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
