Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSDLAFb>; Thu, 11 Apr 2002 20:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313080AbSDLAFa>; Thu, 11 Apr 2002 20:05:30 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:56075 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S313060AbSDLAFa>; Thu, 11 Apr 2002 20:05:30 -0400
Message-ID: <3CB6163B.EAC8F633@zip.com.au>
Date: Thu, 11 Apr 2002 16:03:23 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
CC: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [prepatch] address_space-based writeback
In-Reply-To: <3CB5FFB5.693E7755@zip.com.au> <Pine.SOL.3.96.1020411235415.24708A-100000@virgo.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> 
> ...
> It would be great to be able to submit variable size "io entities" even
> greater than PAGE_CACHE_SIZE (by giving a list of pages, starting offset
> in first page and total request size for example) and saying write that to
> the device starting at offset xyz. That would suit ntfs perfectly. (-:
> 

Yes, I'll be implementing that.  Writeback will hit the filesystem
via a_ops->writeback_mapping(mapping, nr_pages).  The filesytem
will then call in to generic_writeback_mapping(), which will walk
the pages, assemble BIOs and send them off.

The filesystem needs to pass a little state structure into the
generic writeback function.  An important part of that is a
semaphore which is held while writeback is locking multiple
pages.  To avoid ab/ba deadlocks.

The current implementation of this bio-assembler is for no-buffer
(delalloc) fileystems only.  It need to be enhanced (or forked)
to also cope with buffer-backed pages. It will need to peek
inside the buffer-heads to detect clean buffers (maybe.  It
definitely needs to skip unmapped ones).  When such a buffer
is encountered the BIO will be sent off and a new one will be started.
The code for this is going to be quite horrendous.  I suspect
the comment/code ratio will exceed 1.0, which is a bad sign :)

One thing upon which I am undecided:  for syncalloc filesystems
like ext2, do we attach buffers at ->readpages() time, or do
we just leave the page bufferless?

That's a hard call.  It helps the common case, but in the uncommon
case (we overwrite the file after reading it), we need to run
get_block again.

-
