Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132203AbRC1BD0>; Tue, 27 Mar 2001 20:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132212AbRC1BDR>; Tue, 27 Mar 2001 20:03:17 -0500
Received: from hibernia.clubi.ie ([212.17.32.129]:21897 "EHLO hibernia.jakma.org") by vger.kernel.org with ESMTP id <S132203AbRC1BDH>; Tue, 27 Mar 2001 20:03:07 -0500
Date: Wed, 28 Mar 2001 02:03:01 +0100 (IST)
From: Paul Jakma <paul@jakma.org>
To: Dan Hollis <goemon@anime.net>
cc: "H. Peter Anvin" <hpa@transmeta.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@transmeta.com>, <Andries.Brouwer@cwi.nl>, <linux-kernel@vger.kernel.org>, <tytso@MIT.EDU>
Subject: Re: Larger dev_t
In-Reply-To: <Pine.LNX.4.30.0103271454190.2234-100000@anime.net>
Message-ID: <Pine.LNX.4.33.0103280126170.11627-100000@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2001, Dan Hollis wrote:

> On Tue, 27 Mar 2001, H. Peter Anvin wrote:
> > c) Make sure chown/chmod/link/symlink/rename/rm etc does the right thing,
> > without the need for "tar hacks" or anything equivalently gross.
>
> write-through filesystem, like overlaying a r/w ext2 on top of an iso9660
> fs.

functionality to do this is in devfs and devfsd already.

there are 2 ways:

1. devfs on /dev, maintain state in /dev-state.
2. regular ext2 (devfs naming style) /dev and devfs mounted on, eg,
   /devfs for hotplug and module load/unload updates

1:

/dev-state -> regular ext2
/dev -> devfs

use the CREATE, CHANGE and REGISTER hooks that devfs has to
allow devfsd to transparently copy changes in /dev to the ext2
/dev-state. See the example devfsd.conf for appropriate entries, eg:

REGISTER       .*              COPY    /dev-state/$devname $devpath
CHANGE         .*              COPY    $devpath /dev-state/$devname
CREATE         .*              COPY    $devpath /dev-state/$devname

2:

/dev -> regular ext2
/devfs -> devfs

use the devfs hooks for REGISTER and UNREGISTER to have devfsd update
the static /dev whenever hotplug events occur. Eg:

REGISTER        .*              COPY    ${mntpnt}/$devname /dev/$devname
UNREGISTER      .*              CFUNCTION GLOBAL unlink /dev/$devname

seems to work for me:

[root@fogarty /devfs]# ls -l /dev{,fs}/misc/nvram
ls: /dev/misc/nvram: No such file or directory
ls: /devfs/misc/nvram: No such file or directory
[root@fogarty /devfs]# modprobe nvram
[root@fogarty /devfs]# ls -l /dev{,fs}/misc/nvram
crw-r-----    1 root     root      10, 144 Jan  1  1970 /devfs/misc/nvram
crw-r-----    1 root     root      10, 144 Mar 28 01:56 /dev/misc/nvram
[root@fogarty /devfs]# rmmod nvram
[root@fogarty /devfs]# ls -l /dev{,fs}/misc/nvram
ls: /dev/misc/nvram: No such file or directory
ls: /devfs/misc/nvram: No such file or directory

> -Dan

i prefer option 2 as /dev state is then not dependent on devfsd being
there and it just sidesteps the whole permissions issue. if devfsd
doesn't start then i still have a fully functional /dev.

but anyway... there seems to be loads of scope to do lots of
different things with devfsd, plus NIS support. :)

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org
PGP5 key: http://www.clubi.ie/jakma/publickey.txt
-------------------------------------------
Fortune:
Premature optimization is the root of all evil.
		-- D.E. Knuth

