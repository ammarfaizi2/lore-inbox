Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271981AbRIIOqz>; Sun, 9 Sep 2001 10:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271977AbRIIOqp>; Sun, 9 Sep 2001 10:46:45 -0400
Received: from morrison.empeg.co.uk ([193.119.19.130]:11253 "EHLO
	fatboy.internal.empeg.com") by vger.kernel.org with ESMTP
	id <S271978AbRIIOqe>; Sun, 9 Sep 2001 10:46:34 -0400
Message-ID: <3B9B80E2.C9D5B947@riohome.com>
Date: Sun, 09 Sep 2001 15:46:58 +0100
From: John Ripley <jripley@riohome.com>
X-Mailer: Mozilla 4.5 [en] (X11; I; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: COW fs (Re: Editing-in-place of a large file)
In-Reply-To: <20010902152137.L23180@draal.physics.wisc.edu> <318476047.20010903002818@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VDA wrote:
> 
> Sunday, September 02, 2001, 11:21:37 PM, Bob McElrath wrote:
> BM> I would like to take an extremely large file (multi-gigabyte) and edit
> BM> it by removing a chunk out of the middle.  This is easy enough by
> BM> reading in the entire file and spitting it back out again, but it's
> BM> hardly efficent to read in an 8GB file just to remove a 100MB segment.

> BM> Is there another way to do this?

> BM> Is it possible to modify the inode structure of the underlying
> BM> filesystem to free blocks in the middle?  (What to do with the half-full
> BM> blocks that are left?)  Has anyone written a tool to do something like
> BM> this?

> BM> Is there a way to do this in a filesystem-independent manner?

> A COW fs is a far more useful and cool. A fs where a copy of a file
> does not duplicate all blocks. Blocks get copied-on-write only when
> copy of a file is written to. There could be even a fs compressor
> which looks for and merges blocks with exactly same contents from
> different files.
> 
> Maybe ext2/3 folks will play with this idea after ext3?
> 
> I'm planning to write a test program which will scan my ext2 fs and
> report how many duplicate blocks with the same contents it sees (i.e
> how many would I save with a COW fs)

I've tried this idea. I did an MD5 of every block (4KB) in a partition
and counted the number of blocks with the same hash. Only about 5-10% of
blocks on several filesystem were actually duplicates. This might be
better if you reduced the block size to 512 bytes, but there's a
question of how much extra space filesystem structures would then take
up.

Basically, it didn't look like compressing duplicate blocks would
actually be worth the extra structures or CPU.

On the other hand, a COW fs would be excellent for making file copying
much quicker. You can do things like copying the linux kernel tree using
'cp -lR', but the files do not act as if they are unique copies - and
I've been bitten many times when I forgot this. If you had COW, you
could just copy the entire tree and forget about the fact they're
linked.

The problem is this needs a bit of userland support, which could only be
done automatically if you did this:

- Keep a hash of the contents of blocks in the buffer-cache.
- The kernel compares the hash of each block write to all blocks already
in the buffer-cache.
- If a duplicate is found, the kernel generates a COW link instead of
writing the block to disk.

Obviously this would involve large amounts of CPU. I think a simple
userland call for 'COW this file to this new file' wouldn't be too
hideous a solution.

-- 
John Ripley
