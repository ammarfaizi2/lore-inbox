Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbUDBBOZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 20:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbUDBBOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 20:14:25 -0500
Received: from mail.shareable.org ([81.29.64.88]:33941 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263484AbUDBBOR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 20:14:17 -0500
Date: Fri, 2 Apr 2004 02:14:11 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Paul Eggert <eggert@gnu.org>
Cc: Andi Kleen <ak@suse.de>, gcc@gcc.gnu.org, linux-kernel@vger.kernel.org,
       bug-coreutils@gnu.org
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
Message-ID: <20040402011411.GE28520@mail.shareable.org>
References: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de> <20040401220957.5f4f9ad2.ak@suse.de> <7w3c7nb4jb.fsf@sic.twinsun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7w3c7nb4jb.fsf@sic.twinsun.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Eggert wrote:
> There are two basic principles here.  First, ordinary files should not
> change spontaneously: hence a file's timestamp should not change
> merely because its inode is no longer cached.  Second, a file's
> timestamp should never be "in the future": hence one should never
> round such timestamps up.

We can resolve the second requirement (but not the first) in a
different way, by adjusting the timestamp when the inode is re-read
from disk.

When re-reading an inode, rounding the time up is done by setting the
tv_nsec field to 999999999.

If the on-disk timestamp is "now", i.e. the current second if it's a
1-second resolution, then we can avoid setting the timestamp to a
future time by setting the tv_nsec field to the current wall time's
nanosecond value.  There is no need to round the time up any more than that.

However, sponteneous mtime changes are not polite.  So I broadly agree
with the principle of:

> The only way I can see to satisfy these two principles is to truncate
> the timestamp right away, when it is first put into the inode cache.
> That way, the copy in main memory equals what will be put onto disk.
> This is the approach taken by other operating systems like Solaris,
> and it explains why parallel GCC builds won't have this problem on
> these other systems.

> How long has the current Linux+ext3 behavior been in place?  If it's
> widespread, I'll probably have to think about adding a workaround to
> coreutils.  Does the behavior affect all Linux filesystems, or just
> ext3?

All Linux filesystems - the nanoseconds field is retained on in-memory
inodes by the generic VFS code.  The stored resolution varies among
filesystems, with the coarsest being 2 seconds (FAT), and some do
store nanoseconds.  AFAIK there is no way to determine the stored
resolution using file operations alone.

This behaviour was established in 2.5.48, 18th November 2002.

The behaviour might not be restricted to Linux, because non-Linux NFS
clients may be connected to a Linux NFS server which has this behaviour.

-- Jamie
