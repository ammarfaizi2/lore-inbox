Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271975AbRHVSer>; Wed, 22 Aug 2001 14:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272074AbRHVSej>; Wed, 22 Aug 2001 14:34:39 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:26636 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S271975AbRHVSe0>; Wed, 22 Aug 2001 14:34:26 -0400
Message-ID: <3B83FB3F.A0BDC056@zip.com.au>
Date: Wed, 22 Aug 2001 11:34:39 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Filling holes in ext2
In-Reply-To: <3B83E9FD.6020801@humboldt.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Cox wrote:
> 
> I've been looking at generic_file_write() a lot recently, and I'm a
> little bothered by this section, as mangled here by Mozilla:
> 
> status = mapping->a_ops->prepare_write(file, page, offset, offset+bytes);
> if (status)
>         goto unlock;
> status = __copy_from_user(kaddr+offset, buf, bytes);
> flush_dcache_page(page);
> if (status)
>         goto fail_write;
> status = mapping->a_ops->commit_write(file, page, offset, offset+bytes);
> 
> If the __copy_from_user() does fail when writing to a hole or extending
> a file on ext2, disk blocks get added to the file, but are never
> cleared. The result is that data from a free block appears in the file.

Yup.

> I've not managed to trigger this in a real system, but I have explored
> the failure path by running UML under gdb. I filled the filesystem with
> data as root (yes > /mnt/test), deleted the files, then triggered this
> path on an application running as a normal user. The result was that
> root's old data appeared in the user file.
> 
> So:
> Can this really happen on the mainstream kernel? (The kernel I tested on
>   was 2.4.7 with the corresponding UML patch.)

Yes, it can.

> Can this actually be exploited?  I assume the test on __copy_from_user()
> is there in case another thread changes memory mappings while
> generic_file_write() is running. My attempts to do this haven't yet
> succeeded.

I'd expect it to occur if you simply pass an unmapped address
to write()?
 
> If this can happen, does it matter?

It matters.  -ac kernels handle this by clearing out the blocks
on the error path in __block_prepare_write().  If you retest with
-ac kernels, you should just see zeroes.

> Should ext2 have an abort_write() operation like ext3() has?

abort_write() is an expediency - it was (much) easier and safer
to add a new operation rather than running all over the kernel
and redefining the commit_write() API.

ext3 definitely needs to know about prepare/commit imbalance in
lo_send() and generic_file_write(), and in block_symlink() if that
is ever changed to error out after the prepare_write().

But long-term, we need to change the commit_write() definition so
that it is called even in the error case, thus informing the
underlying fs of the partial write.

-
