Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266452AbRGCGWk>; Tue, 3 Jul 2001 02:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266448AbRGCGWa>; Tue, 3 Jul 2001 02:22:30 -0400
Received: from mail.bmlv.gv.at ([193.171.152.34]:58256 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id <S266447AbRGCGWN>;
	Tue, 3 Jul 2001 02:22:13 -0400
Message-Id: <3.0.6.32.20010703082513.0091f900@pop3.bmlv.gv.at>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Tue, 03 Jul 2001 08:25:13 +0200
To: linux-kernel@vger.kernel.org
From: "Ph. Marek" <marek@bmlv.gv.at>
Subject: Ideas for TUX2
Cc: phillips@bonn-fries.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to give some of my thoughts regarding tux2 (phase-change-tree fs):


* FILES *


If a file's data has been changed, it suffices to update the inode and the
of free blocks bitmap (fbb).
But updating them in one go is not possible - the fbb is located at the
superblock, the inode can be (nearly) anywhere on disk.

- Updating another inode and rewriting the directory isn't possible.
This would change the inode number which can be referenced in more than one
directories; and some programs (nfs) rely on the inode number.

- So we have to have two inode spaces per inode, which are switched with
the superblock.
To do this we give a generation counter into the inode, which is checked
against the latest valid superblock.
(Alternatively, we could use the modification time of the inode and have a
modification time in the superblock).
Of two inode spaces we'd regard the one as active, which has a higher
generation counter/mtime than the other, but only if it's lower or equal
than the one of the superblock.



* FILESYSTEM STRUCTURE / SUPERBLOCKs *


As you wrote it's necessary to have several versions of superblocks around. 
As the fbb MUST be updated in sync with the superblocks, they should be
near to each other - and the superblock should be later on disk to be able
to write the fbb first and the mark this version as active without a seek.


Some calculation:
Let's assume a 4kB blocksize.
4kB are 32kBit, which multiplied with 4kB blocksize give 128MB of
adressable memory. So we need one 4kB block for every 128MB of fs size.

So 12.8GB would amount to 100 blocks or 400kB.



- Every copy/version (3 or 4) of the superblock has it's own fbb.
This amounts on the above example of 12.8 GB (with 4 versions) to 1/8192 of
the entire fs space - I think that's ok, especially if there will be more
space needed for the inodes and the partly duplicated other data.

- Every single fbb/sb version is (on the harddisk) a linked list with the
following structure:
  - fbb
    - magic number
    - reference to the next block (block number)
    - entries of fbb.
      This takes 2*32Bit or 2*64Bit of the 4kB.
  - sb: all normal sb entries, enlarged with 
    - a generation counter/mtime.
    - a reference to the next assumed fbb/sb location.


I'd like to make a linked list on the harddisk in order to have this
filesystem dynamically resizeable (at least enlargeable):
- a new phase is generated, with more fbb space and so on.
- a sufficiently large space is taken from the harddisk (which is easy,
since the harddisk is now bigger) - preferable continously
- the old phase is written to disk, with the sb "next reference" pointing
to the new space.
- if the old phase is completed, the new phase is populated like normal
operation OR immediately phased again.

As soon as this new fbb/sb block is written on disk, the newest version of
this filesystem says the new size - voila! Online resizing!



I think there are some loose ends in there.
All comments welcome.



Regards,

Phil


