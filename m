Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313826AbSDIInM>; Tue, 9 Apr 2002 04:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313827AbSDIInL>; Tue, 9 Apr 2002 04:43:11 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:16398 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S313826AbSDIInK>; Tue, 9 Apr 2002 04:43:10 -0400
Message-ID: <3CB2A947.7FDAD55F@aitel.hist.no>
Date: Tue, 09 Apr 2002 10:41:43 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.7-dj3 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Noah White <nwhite@silverbacktech.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: badblocks, sector/bit copies and other musings
In-Reply-To: <E7D41DF26971D51197F100B0D020EFF856076C@kashmir.silverbacktech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Noah White wrote:
> 
> Greetings,
> 
> I had some general questions regarding how the kernel/fs handle bad blocks
> and such and how that relates to various copying techniques such as Norton
> Ghost, hardware disk duplicators (the old octopus's) and such.
> 
> Specifically, I'm curious as to how the following situation is handled. If I
> have:
> 
> drive A which is say a 30 GB IDE drive which I've built in a standard
> fashion with the 2.2.12-20 kernel and created two ext-2 partitions and one
> swap partition
> 
> drive b which is also the same model 30 GB IDE drive which is empty and has
> no file system on it OR has a windows file system (FAT or NTFS)
> 
> Now in the case of copying drive A onto drive B using a sector or bit copy
> technique and I:
> 
> 1) Use Ghost with sector copy mode OR
> 2) Use a hardware harness which does a straight bit copy of the drive (and
> is non-file system aware)

3) dd if=/dev/hda of=/dev/hdb
 
> How will the bad blocks be mapped? From the file system perspective will
> drive B think its bad blocks are the same as drive A thus setting drive B up
> for possible errors because its bad block mappings are incorrect?

Disks handle bad blocks themselves - to some extent.  You never see
that,
the drive simply remaps a sector to some other location with spare
sectors.
You can use non-fs aware copy techniques as long as you haven't run
out of spare sectors.  You start getting io errors when you do run
out - and then the fs have to mark blocks as bad.  (You may even need
a fsck or badblocks run to get this right.)

You _need_ a fs-aware way of copying once this happens.  such as "cp -a"
or similiar.  A non-fs aware copy of a fs with bad blocks will give
you a fs on hdb that have some sectors marked bad who aren't bad -
because
you copied the bad block list from the other drive.  This is no good.
Even worse if hdb actually had bad blocks of its own - then you get
bad blocks marked as good.
 
If you really intent to copy stuff onto a blank drive that has bad
blocks,
do this:

1. Use mkfs to create an empty fs on the B fs.  Use the option that
checks
   for bad blocks.  Possibly also use badblocks for a more thorough
   test, i.e. a write test.  Now you have a fs with all the bad blocks
   mapped.
2. Use fsck -i or badblocks on the A fs as well. This so you'll
   avoid unexpected bad blocks during the copy.  That might stop
   the copy somewhere in the middle and is no fun.
3. copy from one fs to another using a fs-aware copy like "cp".  A nice 
   side effect is that the copy gets defragmented.
   This way do not mess up bad block information, as you're simply
   reading files from one fs and writing them on the other.  And
   the fs will not try to write to known bad blocks.

> This leads to my ultimate question which is what is the safest and fastest
> way to dup a linux/ext-2 drive?

The non-fs aware copy may be faster if the fs is almost full.  The
fs aware way is the safe one in precence of bad blocks, and may
be faster too if there's lots of free space.  The fs-aware ways
don't copy "free space", the non-fs aware ways do!

Helge Hafting
