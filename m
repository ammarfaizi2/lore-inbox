Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316538AbSFDSsO>; Tue, 4 Jun 2002 14:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316456AbSFDSsN>; Tue, 4 Jun 2002 14:48:13 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60939 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316235AbSFDSrv>; Tue, 4 Jun 2002 14:47:51 -0400
Date: Tue, 4 Jun 2002 11:47:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Chris Mason <mason@suse.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 12/16] fix race between writeback and unlink
In-Reply-To: <3CFBEDEE.EE74C5B1@zip.com.au>
Message-ID: <Pine.LNX.4.44.0206041142390.954-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 3 Jun 2002, Andrew Morton wrote:
>
> But why does ext2_put_inode() even exist?  We're already throwing
> away the prealloc window in ext2_release_file?  I guess for
> shared mappings over spares files: if all file handles have
> closed off, we still need to make allocations against that
> inode, yes?

Shared mappings still hold the "struct file" open (you have
"vma->vm_file->f_dentry->d_inode"), so you still have the file handle
while the mapping is open.

I assume that the reason is that _any_ block allocation will trigegr
pre-alloc, which means that we have preallocation for things like
directories etc too - which really do not have a "struct file" associated
with them.

Whether that is really worth it is unclear, but it also means that ext2
doesn't have to pass down the "struct file" to the lower levels at all, as
it keeps all pre-alloc stuff in the inode.

On the whole it's probably a mistake, but my point is that it's likely a
mistake that is hard to fix. Which is why I didn't even try to fix ext2 to
not use "put_inode" and the prealloc dropping there..

		Linus

