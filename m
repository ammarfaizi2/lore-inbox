Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154194AbQC3XNX>; Thu, 30 Mar 2000 18:13:23 -0500
Received: by vger.rutgers.edu id <S154179AbQC3XHU>; Thu, 30 Mar 2000 18:07:20 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:36968 "EHLO math.psu.edu") by vger.rutgers.edu with ESMTP id <S154237AbQC3XFS>; Thu, 30 Mar 2000 18:05:18 -0500
Date: Thu, 30 Mar 2000 18:08:32 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Dave Jones <dave@denial.force9.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.rutgers.edu>, Linux/m68k <linux-m68k@lists.linux-m68k.org>, Linux/APUS <linux-apus@sunsite.auc.dk>
Subject: Re: [PATCH] AFFS fixes v1
In-Reply-To: <Pine.LNX.4.21.0003302317200.1069-100000@nemesis.local>
Message-ID: <Pine.GSO.4.10.10003301742340.25071-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu



On Thu, 30 Mar 2000, Dave Jones wrote:

> 
> Wanted: Several lunatics prepared to try potentially
> dangerous patches to Amiga filesystem.
> 
> Before going on further, let it be known that this patch is
> possibly DANGEROUS. Do _not_ try this on an Amiga partition
> that you don't have extensive backups of.
> 
> I've mounted workbench disk images using loopback thus:
> 
> 	mount workbench.adf /mnt/test -o loop,ro
> 
> *NOTE the readonly part.*
> There appears to be a problem with loopback in 2.3.99pre3,
> which means I haven't tested the abilities of writing to disks.
> As I only have a PC available to test on, and I can't mount
> anything other than diskimages, I don't have a way to test this,
> so please give me any feedback on this..
> Anything from 'It works' to 'It ate my fs', anything..
> I'm coding without tools to test this, so I need help from the
> people who are going to be using this..
> 
> I'd also appreciate feedback from other filesys/vfs guys
> about anything in this patch that just 'doesn't look right'
> I've gone from knowing nothing about fs/VFS to this diff
> in four days, and now my head hurts. I wouldn't be at all
> surprised if I've done _something_ wrong somewhere.

The real problems with AFFS are different. I'll bring the pre-patch I've
done back in September from backups tomorrow and then you'll get more
detailed description, but right now I can recall the following:
	1.  AFFS handles links horribly. It has pseudo-inodes for all
links and they point to the real one. Unfortunately, that "real" inode
_must_ belong to some directory. Which means that if you create a link to
file and remove the original link you are in for pain. You can't just
remove the original entry from its hash chain. So the bloody thing finds
some other link, moves the name into original one, inserts the original
into hash chain of the other and kills other. It means that unlink() in
one directory may reshuffle another. And you've got _no_ protection by
i_sem on another directory - any attempt to get it will lead to easy
deadlocks. Consequence: _easy_ races.
	2.  You have to account for situations when link() and unlink()
race with each other. Again, not done in the current code.
	3.  Links on directories easily kill VFS. Don't.
	4.  Since some operations (e.g. rename) involve a _lot_ of hash
chains walking and pointers switching - beware of the failure modes when
you abort in the middle of modification. It may easily leave you with
fucked up filesystem.

It's a lot of crap to fix and I gave up on that when I got more pressing
things to do. I can pass you the patch along with notes. I can remove the
swearwords - you will reinsert them as soon as you'll play with this beast
yourself.

The bottom line: AFFS design is a festering pile of dung and attempts to
make it look like UNIX filesystem only made it uglier. Judging by dejanews
search, AmigaOS itself doesn't handle it well. Hell knows what had stopped
them from replacing it with decent filesystem - with the thing outside of
kernel it wasn't that hard to do... Damnit, FAT is not so braindead
compared to that abortion.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
