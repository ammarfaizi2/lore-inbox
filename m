Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbUDBADg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 19:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263215AbUDBADd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 19:03:33 -0500
Received: from mail.shareable.org ([81.29.64.88]:27285 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262797AbUDBADb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 19:03:31 -0500
Date: Fri, 2 Apr 2004 01:02:22 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@suse.de>
Cc: Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>, gcc@gcc.gnu.org,
       linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
Message-ID: <20040402000222.GA28520@mail.shareable.org>
References: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de> <20040401220957.5f4f9ad2.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401220957.5f4f9ad2.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> > However, I'd say that this should probably be fixed in the kernel,
> > e.g. by not reporting high-precision time stamps in the first
> > place if the file system cannot store them ...
> 
> Interesting. We discussed the case as a theoretical possibility when
> the patch was merged, but it seemed to unlikely to make it worth
> complicating the first version.
> 
> The solution from back then I actually liked best was to just round
> up to the next second instead of rounding down when going from 1s 
> resolution to ns.

Files spontaneously getting newer is also problem, although the
consequence is usually less severe than spontaneously getting older.

> -	raw_inode->i_atime = cpu_to_le32(inode->i_atime.tv_sec);
> -	raw_inode->i_ctime = cpu_to_le32(inode->i_ctime.tv_sec);
> -	raw_inode->i_mtime = cpu_to_le32(inode->i_mtime.tv_sec);
> +	/* round up because we cannot store nanoseconds. This avoids
> +	   the time jumping back when the inode is loaded again. */
> +	raw_inode->i_atime = cpu_to_le32(inode->i_atime.tv_sec + 1);
> +	raw_inode->i_ctime = cpu_to_le32(inode->i_ctime.tv_sec + 1);
> +	raw_inode->i_mtime = cpu_to_le32(inode->i_mtime.tv_sec + 1);

The patch always increments the stored seconds by one.  If an inode
is read, dirtied, then stored, the seconds fields will all be
incremented by 1 every time that happens, won't they?  I.e. every
change to atime interleaved by a flush will increment the seconds
field of ctime and mtime, won't it?

To round up the time properly, I think you need to change the code
that reads the inode, so that newly read inodes get a tv_nsec value of
999999999, and leave the writing code alone.

-- Jamie
