Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280629AbRKFWXS>; Tue, 6 Nov 2001 17:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280630AbRKFWXK>; Tue, 6 Nov 2001 17:23:10 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:48708 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S280629AbRKFWW5>; Tue, 6 Nov 2001 17:22:57 -0500
Date: Tue, 6 Nov 2001 21:45:56 +0000
From: Stephen Tweedie <sct@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alexander Viro <viro@math.psu.edu>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Mike Fedyk <mfedyk@matchmail.com>, lkml <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] disk throughput
Message-ID: <20011106214556.M4137@redhat.com>
In-Reply-To: <3BE647F4.AD576FF2@zip.com.au> <Pine.GSO.4.21.0111050904000.23204-100000@weyl.math.psu.edu> <3BE71131.59BA0CFC@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BE71131.59BA0CFC@zip.com.au>; from akpm@zip.com.au on Mon, Nov 05, 2001 at 02:22:41PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 05, 2001 at 02:22:41PM -0800, Andrew Morton wrote:

> For some workloads we want the subdirectories close to the
> parent as well.  Failing to do so is horridly wrong.

If you apply that recursively, then _all_ the directories in a
filesystem end up in the same place.  ext2 has traditionally been
extremely resistant to fragmentation degradation over time, and the
spreading out of the directory tree over the filesystem is part of
that.

> What has changed since Kirk's design?
> 
> - The relative cost of seeks has increased.  Device caching
>   and readahead and increased bandwidth make it more expensive
>   to seek away.

I'm not convinced about that.  Modern disks are so fast at streaming
that _any_ non-sequential access is a major cost.  Track-to-track
seeks are typically well under the average rotational cost.  It's not
seeking to a distant location that's particularly expensive: any seek
is, whether to the the same track or not.

> I don't think I buy the fragmentation argument, really.

Recent experiments showed that reiserfs, which starts off allocating
files quite close together, was significantly faster than ext2 on
mostly-empty filesystems but got hugely slower as you approached 90%
full or more.  I don't buy the argument that you can ignore
fragmentation.  There must be a balance between short-term performance
when allocating files and long-term performance when ensuring you've
got enough free space inside a directory tree to cope with new files.

Even kernel builds may show this up.  If you try to keep a directory
tree compact, then you may get excellent performance when unpacking
the kernel tarball.  But once you've applied a few large patch sets
and set the kernel build going, your new files, .c.orig patch backups,
and .o files will have nowhere nearby to get allocated in.

Cheers,
 Stephen
