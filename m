Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbRCBSja>; Fri, 2 Mar 2001 13:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129409AbRCBSjU>; Fri, 2 Mar 2001 13:39:20 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:28251 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S129408AbRCBSjN>; Fri, 2 Mar 2001 13:39:13 -0500
Message-Id: <200103021839.f22Id1F32697@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Jeremy Hansen <jeremy@xxedgexx.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's 
In-Reply-To: Message from Jeremy Hansen <jeremy@xxedgexx.com> 
   of "Fri, 02 Mar 2001 12:42:48 EST." <Pine.LNX.4.33L2.0103021241550.14586-200000@srv2.ecropolis.com> 
Date: Fri, 02 Mar 2001 12:39:01 -0600
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> 
> We're doing some mysql benchmarking.  For some reason it seems that ide
> drives are currently beating a scsi raid array and it seems to be related
> to fsync's.  Bonnie stats show the scsi array to blow away ide as
> expected, but mysql tests still have the idea beating on plain insert
> speeds.  Can anyone explain how this is possible, or perhaps explain how
> our testing may be flawed?
> 

The fsync system call does this:

        down(&inode->i_sem);
        filemap_fdatasync(inode->i_mapping);
        err = file->f_op->fsync(file, dentry, 0);
        filemap_fdatawait(inode->i_mapping);
        up(&inode->i_sem);

the f_op->fsync part of this calls file_fsync() which does:

	sync_buffers(dev, 1);

So it looks like fsync is going to cost more for bigger devices. Given the
O_SYNC changes Stephen Tweedie did, couldnt fsync look more like this:

	down(&inode->i_sem);
        filemap_fdatasync(ip->i_mapping);
        fsync_inode_buffers(ip);
        filemap_fdatawait(ip->i_mapping);
	up(&inode->i_sem);

Steve Lord



