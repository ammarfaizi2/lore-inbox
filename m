Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbTAYUFv>; Sat, 25 Jan 2003 15:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261963AbTAYUFv>; Sat, 25 Jan 2003 15:05:51 -0500
Received: from angband.namesys.com ([212.16.7.85]:22917 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S261900AbTAYUFu>; Sat, 25 Jan 2003 15:05:50 -0500
Date: Sat, 25 Jan 2003 15:36:07 +0300
From: Oleg Drokin <green@namesys.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, hch@lst.de, jack@suse.cz, mason@suse.com
Subject: Re: ext2 FS corruption with 2.5.59.
Message-ID: <20030125153607.A10590@namesys.com>
References: <20030123153832.A860@namesys.com> <20030124023213.63d93156.akpm@digeo.com> <20030124153929.A894@namesys.com> <20030124225320.5d387993.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030124225320.5d387993.akpm@digeo.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Jan 24, 2003 at 10:53:20PM -0800, Andrew Morton wrote:
> > Ok, So far simplest way of reproducing for me was this:
> > mkdir /mnt
> > fsstress -p 10 -n1000000 -d /mnt &
> > fsx -c 1234 testfile
> > Now look at fsx output. When it says about "truncating to largest ever: 0x3ffff",
> > wait 10 more seconds and if nothing happens, ^C the fsx,
> > run "rm -rf testfile*"
> > now run fsx again
> > and so on until it fails.
> > Last time it took me three iterations to reproduce.
> Well I've been running this for a couple of hours:
> 	#!/bin/sh
> 	while true
> 	do
> 	        fsstress -p 10 -n1000000 -d . &
> 	        fsx-linux -c 1234 testfile &
> 	        sleep 180
> 	        killall fsx-linux fsstress
> 	        sleep 1
> 	done

Hm. I do not kill my fsstress.
Here is my version:

#!/bin/bash
mke2fs /dev/hdb2
mount /dev/hdb2 /mnt -t ext2
cd /mnt
/tests/fsstress -p10 -n 1000000 -d . &
while /tests/fsx -c 1234 -N60309 testfile ; do rm -rf testfile*; done

> So I'm going to have to ask you to investigate further.  Does it happen on
> other machines?  Other filesystems?  Older kernels?  That sort of thing.

Ok. I am able to reproduce that same thing on dual Pentium4 2.2GHz (HT enabled), 512M RAM.
My testing reveals that 2.5.50, 2.5.52 and 2.5.53 do not have the problem.
2.5.54, 2.5.55, 2.5.59 have the problem.
ext3 and reiserfs do not show this problem.
Looking through 2.5.54, I found that changeset named "[PATCH] quota locking update" forwarded by you
is the cause for the problem.
(also by reviewing the changeset it became clear that in order to succesfully reproduce the
problem one must have CONFIG_QUOTA to be disabled).
This small patch below fixes the problem for me (just reverts back part of quota locking patch in fact).
Also I think that taking BKL just to update some inode accounting stuff is kind of expensive,
so certainly better solution must exist.

===== include/linux/quotaops.h 1.13 vs edited =====
--- 1.13/include/linux/quotaops.h	Wed Jan  1 05:44:36 2003
+++ edited/include/linux/quotaops.h	Sat Jan 25 14:52:57 2003
@@ -175,7 +175,9 @@
 #define DQUOT_TRANSFER(inode, iattr)		(0)
 extern __inline__ int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
+	lock_kernel();
 	inode_add_bytes(inode, nr);
+	unlock_kernel();
 	return 0;
 }
 
@@ -188,7 +190,9 @@
 
 extern __inline__ int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
+	lock_kernel();
 	inode_add_bytes(inode, nr);
+	unlock_kernel();
 	return 0;
 }
 
@@ -201,7 +205,9 @@
 
 extern __inline__ void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
+	lock_kernel();
 	inode_sub_bytes(inode, nr);
+	unlock_kernel();
 }
 
 extern __inline__ void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)

Bye,
    Oleg
