Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315182AbSFIUyA>; Sun, 9 Jun 2002 16:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315200AbSFIUx7>; Sun, 9 Jun 2002 16:53:59 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:53518 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S315182AbSFIUx6>;
	Sun, 9 Jun 2002 16:53:58 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200206092053.g59Krsl506602@saturn.cs.uml.edu>
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
To: nmiell@attbi.com (Nicholas Miell)
Date: Sun, 9 Jun 2002 16:53:54 -0400 (EDT)
Cc: phillips@bonn-fries.net (Daniel Phillips),
        adelton@informatics.muni.cz (Jan Pazdziora), christoph@lameter.com,
        linux-kernel@vger.kernel.org, adelton@fi.muni.cz
In-Reply-To: <1023648813.1188.19.camel@entropy> from "Nicholas Miell" at Jun 09, 2002 11:53:32 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Miell writes:

> Putting shortcut support into the VFAT driver is as bad a decision as
> the automatic text-file CRLF->LF conversions was, for several reasons.

No, NOTHING done with VFAT is as bad as the text conversion.
That one was not implementable in any sane way, unless you
think sequential read-only access (like /proc) is sane.

> First of all, some programs (WINE) will actually want to use the .lnk
> files, and transparently converting them to symlinks will complicate
> that.

WINE needs to be able to handle a symlink on ext2, so it can
damn well convert back. It's OK to give WINE some hack to get at
the content; it's not OK to hack bash to interpret .lnk files.

> More importantly, shortcuts are a hell of a lot more complicated than
> has been implied. Not only can they point to local files or UNCs (the
> \\server\share\path notation), they can also point to any object in the
> (Windows) shell's namespace, which includes lots of virtual objects that
> don't actually exist on disk.

One can live with an occasional broken symlink:
"foo" --> "[UNIMPLEMENTED LINK TYPE]"

> Finally, I haven't seen any justification for why symlinks on VFAT are
> needed, beyond some vague statements that it's useful when dual booting.
> Face it, VFAT isn't a Unix filesystem and introducing ugly hacks to make
> it more similar to one will only cause problems in the long run. If you
> want symlinks, use a real filesystem or use umsdos on your favorite FAT
> filesystem. (Assuming that umsdos still works...).

Umsdos is evil.

1. the /DOS thing, done iff mounted on /
2. the fake "hard links" that any user can mess up

Umsdos did help with Linux acceptance though. Lots of people
installed Linux for the first time as Slackware on umsdos.
It's sad that modern installers no longer have this ability.
It was this, and support for crap hardware, that gave Linux
the edge over BSD in the early days.

Today the situation is a little different. We have devfs,
so we don't need device files on the root filesystem.
vfat gives us long filenames. We have per-process namespaces
that could be used to assign a separate /tmp to each user,
thus keeping files separated by UID. It would be pretty
reasonable to create an almost-normal Linux system on vfat.
Copy the setuid stuff to ramfs at boot, use "mount --bind"
and the namespaces to write-protect stuff a user shouldn't
be able to touch, etc. It all works out great. Best of all,
the FAT32 data structures can support the phase-tree
algorithm for perfect data integrity.

System start up is like this:

mount -t vfat /dev/hda1 /     # done by kernel
mount -t devfs none /dev      # done by kernel
mount -t ramfs none /linux/setuid
tar zxf linux/setuid.tgz
mount --bind /linux/setuid/su /bin/su
mount --bind /linux/setuid/passwd /usr/bin/passwd
mount --bind /linux/setuid/chfn /usr/bin/chfn
...

Then for a login, create a new namespace.
Remount _everything_ read-only to protect it.
(or implement a per-mount uid/gid feature)
Overmount stuff that a normal user shouldn't
even be able to read, or abuse a DOS attribute
bit for this purpose. Mount a per-user /tmp and
home directory. Deliver mail to home directories.

Don't bother commenting on the above unless
you know about the per-process namespaces.
They are critical to doing multi-user on vfat.

The only thing left is to make sure every app
can handle failure to create a hard link.

