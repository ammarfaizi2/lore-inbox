Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWGMHHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWGMHHE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 03:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWGMHHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 03:07:04 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:13491 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750960AbWGMHHC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 03:07:02 -0400
Date: Thu, 13 Jul 2006 00:04:31 -0700
To: Dave Hansen <haveblue@us.ibm.com>
Cc: viro@ftp.linux.org.uk, serue@us.ibm.com, linux-kernel@vger.kernel.org,
       linuxram@us.ibm.com
Subject: Re: [RFC][PATCH 00/27] Mount writer count and read-only bind mounts (v4)
Message-ID: <20060713070431.GA12953@RAM>
References: <20060712181709.5C1A4353@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060712181709.5C1A4353@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
From: linuxram@us.ibm.com (Ram Pai)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 11:17:09AM -0700, Dave Hansen wrote:
> Tries to incorporate comments from Al:
> http://article.gmane.org/gmane.linux.kernel/421029
> 
> Al wrote:
> >  b) figuring out what (if anything) should be done with
> >  propagation when we have shared subtrees... (not trivial at all)
> 
> Talked with Ram:  Shared subtrees are about having identical views
> into the filesystem.  Changing the mount permissions doesn't affect
> the view of the filesystem, so it should not be propagated.  


I think shared subtrees propagates mount/unmount events only.
This is a case where we are just changing the access permission
for a mount instance. So it should not be treated as a propagation event.

Lets say we propagated the event. In that case we would end up with a
awkward situation.

1) mount --make-shared /mnt
2) mount --bind /mnt /tmp
3) mount --make-slave /tmp
4) mount -o remount,rw /tmp
5) mount -o remount,ro /mnt

In step (5) all of a sudden the mount at /tmp which was readwrite will
be downgraded to read-only. There must have been a reason why /tmp was
mounted rw in the first place. Also there would be no way for /mnt to be
made 'ro' without effecting /tmp.

Hence I feel the readwrite semantics must be decoupled from the
sharedsubtree semantics,

RP


> 
> The things that probably need the heaviest review in here are the
> i_nlink monitoring patch (including the inode state flag patches 03
> and 06) and the new MNT_SB_WRITABLE flag (patch 05).  
> 
> ---
> 
> The following series implements read-only bind mounts.  This feature
> allows a read-only view into a read-write filesystem.  In the process
> of doing that, it also provides infrastructure for keeping track of
> the number of writers to any given mount.  In this version, if there
> are writers on a superblock, the filesystem may not be remounted 
> r/o.  The same goes for MS_BIND mounts, and writers on a vfsmount.
> 
> This has a number of uses.  It allows chroots to have parts of
> filesystems writable.  It will be useful for containers in the future
> and is intended to replace patches that vserver has had out of the
> tree for several years.  It allows security enhancement by making
> sure that parts of your filesystem read-only, when you don't want
> to have entire new filesystems mounted, or when you want atime
> selectively updated.
> 
> This set makes no attempt to keep the return codes for these
> r/o bind mounts the same as for a real r/o filesystem or device.
> It would require significantly more code and be quite a bit more
> invasive.
> 
> Using this feature requires two steps:
> 
> 	mount --bind /source /dest
> 	mount -o remount,ro  /dest
> 
> Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
