Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291348AbSBSMWa>; Tue, 19 Feb 2002 07:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291345AbSBSMWV>; Tue, 19 Feb 2002 07:22:21 -0500
Received: from hera.cwi.nl ([192.16.191.8]:33412 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S291377AbSBSMWB>;
	Tue, 19 Feb 2002 07:22:01 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 19 Feb 2002 12:21:58 GMT
Message-Id: <UTC200202191221.MAA11940.aeb@cwi.nl>
To: hirofumi@mail.parknet.co.jp, josh@stack.nl
Subject: Re: VFS issues (was: Re: 2.5.5-pre1: mounting NTFS partitions -t VFAT)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Jos Hulzink <josh@stack.nl>

    On Mon, 18 Feb 2002, OGAWA Hirofumi wrote:

    > Jos Hulzink <josh@stack.nl> writes:
    >
    > > What lacks is a fingerprint detector, and iirc -long time ago- FAT has a
    > > very easy to detect fingerprint.
    > >
    > > I'll dig into FAT documentation tonight.
    >
    > I read the document repeatedly and did much tests. If you read the
    > document, you may use BS_OEMName or BS_FilSysType, however, these
    > don't have a meaning.

    Hmmm. You seem to be right there. In my OS (IBM PC only) I checked the
    partition table (see below).

    The first question I want answered: Should I just call myself stupid for
    trying to mount NTFS as VFAT, or should we consider this a real issue that
    needs fixing ? (I see the problem as a generic problem. There must be
    other combinations of filesystems and partition types that pass the
    test, but are wrong). IMHO the latter, for every lost partition makes an
    angry linux user.

    Anyway. I have already been thinking further. Maybe I'm talking nonsense,
    but I'll give it a try.

    The type of a partition is written in the partition table, or something
    similar. Maybe we should check that ?

No.

Letting mount guess is a dangerous business. There is no guarantee
it will guess right, and if mount guesses wrong and the filesystem
was mounted rw, then it may well be trashed.

Doing this right is impossible, and doing this better than today
is of questionable usefulness.

[When guessing reaches a 99.99% probability of success then before
you know it distributions will use guessing in their installation
scripts, and destroy the filesystem of only 1 in 10000 customers.
That single customer always turns out to be me.
When the probability is only 99% people are kept honest.]

FAT is one of the filesystems without really good magic.
But also with filesystems that have good magic one may make
mistakes: several filesystem types have magic in different
blocks, at different offsets. Thus, a partition can have the
magic of more than one filesystem type. This is especially likely
if it had a filesystem of one type before it was reformatted as
another type.
[Zeroing out the first few blocks upon a reformat helps a bit,
but will in some cases destroy a boot loader.]

Now about partition types. First look at
http://www.win.tue.nl/~aeb/partitions/partition_types-1.html
and then consider:
Several dozen types all imply FAT.
The Linux type 83 only says Linux but does not carry information
about the filesystem type. The NTFS type 7 is also the OS/2 type
for HPFS and other installable file systems, and is used by a
few other systems as well.
You see that this is a mess, and in reality no useful information
is to be found here, at most some vague heuristics.

Then consider that partitions can come from BSD slices or other
flavours of partition table or disk label, and that they can be
added by ioctl, so that no partition table need to be present
at all.

So, no, looking at partition types is a very bad idea.

Andries
