Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264156AbSIQNG3>; Tue, 17 Sep 2002 09:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264157AbSIQNG3>; Tue, 17 Sep 2002 09:06:29 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:1974 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264156AbSIQNG2>;
	Tue, 17 Sep 2002 09:06:28 -0400
Date: Tue, 17 Sep 2002 09:11:26 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Anton Altaparmakov <aia21@cantab.net>
cc: ptb@it.uc3m.es, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: route inode->block_device in 2.5?
In-Reply-To: <5.1.0.14.2.20020917132943.00b239e0@pop.cus.cam.ac.uk>
Message-ID: <Pine.GSO.4.21.0209170845020.1645-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Sep 2002, Anton Altaparmakov wrote:

> At 17:22 12/09/02, Peter T. Breuer wrote:
> >Is there a pointer chain by which one can get to the struct
> >block_device of the underlying block device from an inode?
> 
> struct inode->i_sb (== struct super_block)->s_bdev (== struct block_device).

... is meaningful only for local filesystems that happen to live on a
single block device and even that only if said local filesystems want
to use the helper functions that expect ->s_bdev to be there.

IOW, upper layers have no business using that field - it's for the
filesystem-specific code and helper functions such code decides to
call.

There might be such thing as underlying block device of a <foofs> inode.
There is no such thing as underlying block device of an inode.  For
quite a few filesystems it simply makes no sense.  For some it does
and for many of them ->i_sb->s_bdev indeed would give you that, but
that's it - it _is_ fs-dependent and there is no guarantee that
e.g. minixfs in 2.6.4-pre2 won't change leaving ->s_bdev NULL and
storing pointer to block device elsewhere (at which point it will
have to switch from sb_bread() and friends to something else).

The point being, VFS doesn't know, doesn't care and shouldn't presume
anything about private details of fs implementation.  Notice that
VFS != "all stuff in fs/*.c" - the latter includes a pile of library
functions intended for use by filesystem code.  That stuff obviously
can make whatever assumptions about fs internals it wants - the callers
know what data structures they have and can decide what can be called.

