Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264894AbSKEVPc>; Tue, 5 Nov 2002 16:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264909AbSKEVPc>; Tue, 5 Nov 2002 16:15:32 -0500
Received: from bozo.vmware.com ([65.113.40.131]:58378 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id <S264894AbSKEVPa>; Tue, 5 Nov 2002 16:15:30 -0500
Date: Tue, 5 Nov 2002 13:24:16 -0800
From: chrisl@vmware.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Ext2 devel <ext2-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] bug in ext3 htree rename: doesn't delete old name, leaves ino with bad nlink
Message-ID: <20021105212415.GB1472@vmware.com>
References: <1036471670.21855.15.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036471670.21855.15.camel@ixodes.goop.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks again for the nice bug report.

I think I understand the problem now. What happen was, in ext3_rename,
it will first add the new entry to directory and then remove the
old entry. In this case, when add a new entry to the directory
cause a leaf node split. And the old entry is in the very same
leaf node. After split, the old entry have been move to another
leaf node. But ext3_rename still holding the old pointer and bh
to the old leaf node.

It will try to delete the entry from old leaf node, and of course,
it can't find it.

You know the rest of the story then.

The old ext3 code is OK because it only append new blocks, it
will not change the previous block.

This also raise an interesting question, after split leave node,
do we need to update the dentry cache for the change?

I will try to post a patch tonight (pacific time) to fix this problem.

Cheers.

Chris

On Mon, Nov 04, 2002 at 08:47:50PM -0800, Jeremy Fitzhardinge wrote:
> I've isolated the problem to rename not removing the old name under some
> circumstances, leaving two names for a file with an nlink of 1.  This
> will reliably reproduce the problem for me, under 2.4.19-ac4 and 2.4.19
> (stock) w/ patch-ext3-dxdir-2.4.19-4.
> 
> Generate a new filesystem: this will create htree-bug.fs
> $ sh genfs
> 
> # mkdir m
> # mount -o loop htree-bug.fs m
> 
> $ gcc -o tickle tickle.c
> $ ./tickle m/test
> *** rename("drivers/scsi/psi240i.h", "drivers/scsi/psi240i.h.orig") failure:
> stating drivers/scsi/psi240i.h
>   ino=294
>   nlink=1
> stating drivers/scsi/psi240i.h.orig
>   ino=294
>   nlink=1
> *** rename("drivers/scsi/sun3_scsi.h", "drivers/scsi/sun3_scsi.h.orig") failure:
> stating drivers/scsi/sun3_scsi.h
>   ino=350
>   nlink=1
> stating drivers/scsi/sun3_scsi.h.orig
>   ino=350
>   nlink=1
> 
> # umount m
> 
> $ e2fsck -f htree-bug.fs
> e2fsck 1.30-WIP (30-Sep-2002)
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Inode 294 ref count is 1, should be 2.  Fix<y>? yes
> 
> Inode 350 ref count is 1, should be 2.  Fix<y>? yes
> 
> Pass 5: Checking group summary information
> 
> htree-bug.fs: ***** FILE SYSTEM WAS MODIFIED *****
> htree-bug.fs: 541/10240 files (0.2% non-contiguous), 1369/10240 blocks
> exit status 1
> $ debugfs htree-bug.fs 
> debugfs 1.30-WIP (30-Sep-2002)
> debugfs:  ncheck 294
> Inode   Pathname
> 294     /test/drivers/scsi/psi240i.h
> debugfs:  ncheck 350
> Inode   Pathname
> 350     /test/drivers/scsi/sun3_scsi.h
> 
> 
> I've put all the bits needed to reproduce the bug (genfs, tickle) at
> http://www.goop.org/~jeremy/htree/
> 
> 
>         J
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: ApacheCon, November 18-21 in
> Las Vegas (supported by COMDEX), the only Apache event to be
> fully supported by the ASF. http://www.apachecon.com
> _______________________________________________
> Ext2-devel mailing list
> Ext2-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ext2-devel


