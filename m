Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264593AbTF2URt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264792AbTF2URt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:17:49 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:35443 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264593AbTF2URn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:17:43 -0400
Date: Sun, 29 Jun 2003 16:29:45 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: File System conversion -- ideas
In-reply-to: <20030629200020.GH27348@parcelfarce.linux.theplanet.co.uk>
To: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Message-id: <200306291629450990.023BC35E@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
 <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl>
 <20030629192847.GB26258@mail.jlokier.co.uk>
 <20030629194215.GG27348@parcelfarce.linux.theplanet.co.uk>
 <200306291545410600.02136814@smtp.comcast.net>
 <20030629200020.GH27348@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 6/29/2003 at 9:00 PM viro@parcelfarce.linux.theplanet.co.uk wrote:

>On Sun, Jun 29, 2003 at 03:45:41PM -0400, rmoser wrote:
>
>> >> seen this written by many people who choose to use ext3.  Thus proving
>> >> that there is value in in-place filesystem conversion :)
>> >
>> >Uh-huh.  You want to get in-kernel conversion between ext* and reiserfs?
>> >With recoverable state if aborted?  Get real.
>>
>> no, in-kernel conversion between everything.  You don't think it can be
>done?
>> It's not that difficult a problem to manage data like that :D
>
>I think that I will believe it when I see the patchset implementing it.
>Provided that it will be convincing enough.  Other than that...  Not
>really.  You will need code for each pair of filesystems, since
>convertor will need to know *both* layouts.  No amount of handwaving
>is likely to work around that.  And we have what, something between
>10 and 20 local filesystems?  Have fun...

NO!  You're not getting the point at all!

You don't need a pair!  If you have 10 filesystems, you need 10 sets of
code in each direction, not 90.  You convert from the data/metadata set
in the first filesystem to a self-contained atom, and then back from the
atom to the data/metadata set in the new filesystem.  The atom is object
oriented, so anything that can't be moved over--like ACLs or Reiser4's
extended attributes that nobody else has, or permissions if converting to
vfat--is just lost.  Note that if the data has an attribute like "Compressed"
or "encrypted", it is expanded/decrypted and thus brought back to its
natural form before being stuffed into an atom.

You are thinking like this (direct):

EXT2 -> Reiserfs
EXT2 -> XFS
EXT2 -> JFS
Reiserfs -> EXT2
Reiserfs -> XFS
Reiserfs -> JFS
XFS -> EXT2
XFS -> Reiserfs
XFS -> JFS
JFS -> EXT2
JFS -> XFS
JFS -> Reiserfs

Total:  12

I am thinking like this (atom):

EXT2 -> atom
Reiserfs -> atom
XFS -> atom
JFS -> atom
atom -> Ext2
atom -> Reiserfs
atom -> XFS
atom -> JFS

total: 8

for 2 through 10, the direct:atom ratios are:

2:2 6:6 12:8 20:10 30:12 42:14 56:16 72:18 90:20

So with 10 filesystem types, N*(N-1) or 90 pairs to go directly from one
filesystem's datastructures to any other's; N*2 or 20 pairs to go from
Metadata/Data pair -> Self-contained object oriented possibly
compressed atom -> Metadata/Data pair.  That's N sets of code to go
FS_OBJECT -> atom and N sets to go from atom ->  FS_OBJECT, in
this case 10 and 10.

When we get to 20 filesystems, direct conversion needs 380 pieces of
code, whereas my method needs only 20 + 20 == 40.  I obviously put
more thought into this than you, but that's okay; it's an obscure idea and
I don't expect everyone to think before answering.

I might note that although it needs 40 pieces of code to handle all 20
filesystems, the filesystems may not all support it.  So, look at it as
2 pieces of code per filesystem: one to, one from.

>If you want your idea to be considered seriously - take reiserfs code,
>take ext3 code, copy both to userland and put together a conversion
>between them.  Both ways.  That, by definition, is easier than doing
>it in kernel - you have the same code available and none of the
>limitations/
>interaction with other stuff.  When you have it working, well, time to
>see what extra PITA will come from making it coexist with other parts
>of kernel (and with much more poor runtime environment).
>

That would be much harder to maintain as well.  It would have to be altered
every time the filesystem code in the kernel is changed.

>AFAICS, it is _very_ hard to implement.  Even outside of the kernel.
>If you can get it done - well, that might do a lot for having the
>idea considered seriously.  "Might" since you need to do it in a way
>that would survive transplantation into the kernel _and_ would scale
>better that O((number of filesystem types)^2).

I've beaten the O((FS_COUNT)^2) already.  And by the way, it's
O((FS_COUNT)*(FS_COUNT - 1_).  There's exactly O(2*FS_COUNT)
and o(2*FS_COUNT) sets of code needed total to be able to convert
between any two filesystems.

Now, what's impractical is maintaining two sets of code that do exactly
the same thing.  Why maintain code here to read the filesystems, and
also in the kernel?  Just do it in the kernel.  Don't lose sight of the fact
that the final goal (after all else is done) is to modify VFS to actually
run this thing as a filesystem.  THAT is what's going to be a bitch.  The
conversions are simple enough.

--Bluefox Icy

