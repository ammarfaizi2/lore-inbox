Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313739AbSDPQLv>; Tue, 16 Apr 2002 12:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313747AbSDPQLE>; Tue, 16 Apr 2002 12:11:04 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:29778 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S313755AbSDPQKL>; Tue, 16 Apr 2002 12:10:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: badblocks, sector/bit copies and other musings
Date: Tue, 16 Apr 2002 18:09:45 +0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <E7D41DF26971D51197F100B0D020EFF856076C@kashmir.silverbacktech.com> <3CB2A947.7FDAD55F@aitel.hist.no>
Cc: Noah White <nwhite@silverbacktech.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020416160945.F22B7A3F@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[sorry for jumpimg in this late]

On Tuesday, 9. April 2002 10:41, Helge Hafting wrote:
> Noah White wrote:
> > Greetings,
> >
> > I had some general questions regarding how the kernel/fs handle bad
> > blocks and such and how that relates to various copying techniques such
> > as Norton Ghost, hardware disk duplicators (the old octopus's) and such.

> 3) dd if=/dev/hda of=/dev/hdb
>
> > How will the bad blocks be mapped? From the file system perspective will
> > drive B think its bad blocks are the same as drive A thus setting drive B
> > up for possible errors because its bad block mappings are incorrect?
>
> Disks handle bad blocks themselves - to some extent.  You never see
> that,

hopefully

> the drive simply remaps a sector to some other location with spare
> sectors.

> You can use non-fs aware copy techniques as long as you haven't run
> out of spare sectors.  You start getting io errors when you do run
> out - and then the fs have to mark blocks as bad.  (You may even need
> a fsck or badblocks run to get this right.)

Not always true. Remember the ibm ide hd shame last autumn... They throw
hard sector errors, triggered by dirty spin down from power loss :-((( 
I had to suffer from that not too long ago...

> You _need_ a fs-aware way of copying once this happens.  such as "cp -a"
> or similiar.  A non-fs aware copy of a fs with bad blocks will give
> you a fs on hdb that have some sectors marked bad who aren't bad -
> because
> you copied the bad block list from the other drive.  This is no good.

Sure about this one? IMHO, a sector copy wouldn't transfer the bad sector 
mapping. It's a drive internal mapping.

> Even worse if hdb actually had bad blocks of its own - then you get
> bad blocks marked as good.
>
> If you really intent to copy stuff onto a blank drive that has bad
> blocks,
> do this:
>
> 1. Use mkfs to create an empty fs on the B fs.  Use the option that
> checks
>    for bad blocks.  Possibly also use badblocks for a more thorough
>    test, i.e. a write test.  Now you have a fs with all the bad blocks
>    mapped.
> 2. Use fsck -i or badblocks on the A fs as well. This so you'll
>    avoid unexpected bad blocks during the copy.  That might stop
>    the copy somewhere in the middle and is no fun.
> 3. copy from one fs to another using a fs-aware copy like "cp".  A nice
>    side effect is that the copy gets defragmented.
>    This way do not mess up bad block information, as you're simply
>    reading files from one fs and writing them on the other.  And
>    the fs will not try to write to known bad blocks.

The problem with this in the above mentioned scenario is, that cp will
fall over, when running into failures. At least it will truncate
the file, which is not always desired... I had most success with Kurt
Garloff's dd_rescue. In my case, I was able to rescue a reiserfs 
partition with 8 hard sector errors with minimum loss, although one
of them was in a meta data sector (with _current_ reiserfsck).
I wrote a little script to locate the zeroed sectors, which were mainly
in some ml mbox files. Rest was a matter of vi ;).

> > This leads to my ultimate question which is what is the safest and
> > fastest way to dup a linux/ext-2 drive?
>
> The non-fs aware copy may be faster if the fs is almost full.  The
> fs aware way is the safe one in precence of bad blocks, and may
> be faster too if there's lots of free space.  The fs-aware ways
> don't copy "free space", the non-fs aware ways do!

and sometimes, it's not that easy...

> Helge Hafting

Cheers,
  Hans-Peter
