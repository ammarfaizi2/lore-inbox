Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267117AbTBDDim>; Mon, 3 Feb 2003 22:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267120AbTBDDim>; Mon, 3 Feb 2003 22:38:42 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57350 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267117AbTBDDik> convert rfc822-to-8bit; Mon, 3 Feb 2003 22:38:40 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: isofs hardlink bug (inode numbers different)
Date: 3 Feb 2003 19:48:06 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b1nd5m$rhp$1@cesium.transmeta.com>
References: <20030126235556.GA5560@paradise.net.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id h143m7F12478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030126235556.GA5560@paradise.net.nz>
By author:    Volker Kuhlmann <list0570@paradise.net.nz>
In newsgroup: linux.dev.kernel
>
> I am trying to back up directory trees on CD, preserving hard links.
> newer versions of mkisofs are supposedly able to do this, but although
> the data is written to the isofs only once, the resulting directory
> entries have differing inode numbers thus making restore operations
> impossible.
> 
> When I sent a bug report to the author of mkisofs, Jörg Schilling, I
> got the reply
> 
> >>mkisofs 2.01a01 (i686-pc-linux-gnu)
> >>mkisofs 2.0 (i686-pc-linux-gnu)
> >>mkisofs 1.15a27 (i686-suse-linux)
> >
> >>Google shows no reference to anything which tells me that this is not
> >>supposed to work, therefore I assume it's a bug.
> >
> >Nachdenken hilft wie in vielen Fällen auch hier:
> >
> >Der Bug auch hier ist da, wo es wegen schlechter SW Qualität wahrscheinlicher
> >ist: Im Linux Kernel.
> 
> (Translation: thinking helps here too, like in many other cases: the bug
> is in the linux kernel, where it is more likely to be due to lower
> software quality.)

[FWIW, Jörg is well-known for thinking that anything that isn't
Solaris is complete crap.  He's entitled to his opinions.]

> Insults aside, is it true that the kernel's isofs can't produce correct
> inode numbers for hardlinked files? If that is the case it would
> somewhat reduce the usefulness of isofs for backups.

It's sort of true.

There are inode numbers stored in RockRidge attributes, but using them
comes with some humongous caveats:

First: You have absolutely no guarantee that they are actually
unique.  Broken software could easily have written them with all
zeroes.

Second: If there are files on the CD-ROM *without* RockRidge
attributes, you can get collisions with the synthesized inode numbers
for non-RR files.

Third: If you actually rely on inode numbers to be able to find your
files, like most versions of Unix including old (but not current)
versions of Linux, then they are completely meaningless.

The basic problem is that the RR attributes are arbitrary numbers,
instead of any kind of pointer saying "I'm a hard link to this other
file over here."

There is another way to generate consistent inodes for hard links,
which is to use the data block pointer as the "inode number."  This,
however, has the problem that *ALL* zero-lenght files become "hard
links" to each other.

I have been trying to come up with a solution to this, and have pretty
much failed.  Hopefully the UDF filesystem doesn't have this
problem...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: cris ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
