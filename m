Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288059AbSADNVv>; Fri, 4 Jan 2002 08:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288503AbSADNVm>; Fri, 4 Jan 2002 08:21:42 -0500
Received: from hera.cwi.nl ([192.16.191.8]:31936 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S288582AbSADNVa>;
	Fri, 4 Jan 2002 08:21:30 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 4 Jan 2002 13:21:27 GMT
Message-Id: <UTC200201041321.NAA210580.aeb@cwi.nl>
To: alessandro.suardi@oracle.com, andries.brouwer@cwi.nl,
        jgarzik@mandrakesoft.com, torvalds@transmeta.com
Subject: Re: 2.5.2-pre7 still missing bits of kdev_t
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote [on reiserfs]:

> granted you can stick a kdev_to_nr in there but it's still an FS policy
> decision at that point, IMHO...

Yes, for today we stick a kdev_t_to_nr in there and preserve
old behaviour, that is, nothing changes and no policy decisions
have been made. It should have been there from the start.

For next week, when larger-than-16-bit device numbers are
introduced, the proper code everywhere (on all interfaces
with the outside world: stat, mknod with user space and
special device nodes on disk and network filesystems)
would unpack the kdev_t into major and minor, and pack
again to the dev_t required by this interface (and vice versa).
That is, in principle, there is no global, unique, kdev_t_to_nr.

This is done already in most places, but reiserfs is one
of the exceptions, and they'll need a policy decision
on how to pack. In fact ext2 needs precisely the same
policy decision.

The details are rather unimportant - device numbers are
nonportable, so if we transport an ext2 disk to some
other OS and it sees different major,minor pairs, there
is no big catastrophe. Still, I have heard many a complaint
from sysadmins who needed to do _mknod foo x ma mi_
on some NFS mounted filesystem and had to make some
computations to decide on the right ma' mi' to use.
Installation scripts fail over NFS.

That is, even though a device number must be regarded
as a cookie, the fact that the mknod command separates
that cookie into two parts means that the way the
on-disk dev_t is separated belongs to the definition
of the on-disk filesystem format.
Now that 8+24, 12+20, 14+18, 32+32 all occur, the easy
way to solve all problems for a filesystem is to use 32+32.
That is what NFSv3 does, and isofs, etc.
If it is possible, the right policy no doubt is to store 32+32.
If there is no room for that then one just has to live with
the fact that the filesystem image is somewhat less portable.

Andries
