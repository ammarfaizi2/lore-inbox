Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317078AbSFKObe>; Tue, 11 Jun 2002 10:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317077AbSFKObd>; Tue, 11 Jun 2002 10:31:33 -0400
Received: from adsl-63-205-245-1.dsl.snfc21.pacbell.net ([63.205.245.1]:60891
	"EHLO amboise.dolphin") by vger.kernel.org with ESMTP
	id <S317078AbSFKOba>; Tue, 11 Jun 2002 10:31:30 -0400
Date: Tue, 11 Jun 2002 07:31:32 -0700 (PDT)
From: Francois Gouget <fgouget@free.fr>
X-X-Sender: fgouget@amboise.dolphin
To: linux-kernel@vger.kernel.org
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
Message-ID: <Pine.LNX.4.43.0206110712290.7449-100000@amboise.dolphin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This looks like a bad idea. The reason is that the VFAT driver is the
wrong abstraction layer to support the '.lnk' files:

 * on Windows if you open("foo.lnk") you get the .lnk file, not the file
it 'links' to. On Linux you would get the file it points to instead
which is a different behavior.

 * Windows supports .lnk files on FAT, VFAT, NTFS, ISO9660, etc. So if
such support is added in the Linux kernel, it should be added to all of
the above filesystems. And then, there is no reason not to add it to
ext2, NFS, etc!

Other issues:

 * what happens if a Unix program tries to create a file called
'foo.lnk' that is not a .lnk file? I could create a text file called
'mylinks.lnk' to store bookmark stuff for instance.

 * there is no such thing as a dead .lnk file. If the specified path is
not found, Windows will use the file date, file size and whatnot to try
to find where the target went. Is it planned to add any such support
planned?

 * it has been mentionned that this makes it possible to extract source
tarballs that contain symlinks on a VFAT filesystem. While this sounds
cool I am not sure it is so useful.
   - for VFAT one could use the UMSDOS filesystem to do the same thing,
     and get many other features at the same time (at least while in
     Linux)
   - again, if it is useful on VFAT, then it would be useful for CD+RW
     filesystems (UDF?) (e.g. for archival), on NTFS (assuming write is
     well supported one day, etc.
   - if you switch back to Windows, no compiler is going to be able to
     use the '.lnk' files. That's because no compilers that I know of
     uses shell32.dll to read source files. So this would only work
     while on the Linux side and maybe in cygwin too.


This would also hurt Wine as:

 * it would prevent wine from reading the information in the '.lnk'
file... at least for 'supported' '.lnk' files

 * it's not entirely clear to me what is done with unsupported '.lnk'
files. Are they just dead symlinks (again !=windows) or can one read
their contents? In the first case Wine is dead in the water again, and
in the latter case we'll have to play games to know which kind we got.

 * it was suggested to implement a hack to let Wine access the '.lnk'
data. Why implement a hack which is going to be Linux specific when
doing nothing works just fine and on any Unix system? Plus this is going
to require Linux specific code in Wine if it is to be supported.

 * making it an option does not help Wine at all, especially if it is a
default one. Then we have to keep telling users that they have to modify
their fstab if they want Wine to work.


The right level to implement symlink support is:

 * in Wine. Of course! There we know what the drive mappings are, we
have access to the registry and can even use the native shell library.

 * in an LD_PRELOAD library. Then they would work for all filesystems,
be selectable on a per-user or even per-process basis. Of course it
would most likely not work with Wine (ld_preload libraries seldom do)
but we can at least easily disable such libraries using a wrapper
script.

 * as an option in the KDE/Gnome file browsers and related file access
methods. That's the layer which seems closest to the Windows shell
'layer'.


This looks like it could be the next 'unhide' thing. See:

 * isofs unhide option:  troubles with Wine
   http://www.uwsg.indiana.edu/hypermail/linux/kernel/0205.3/0267.html
   http://www.uwsg.indiana.edu/hypermail/linux/kernel/0206.0/0411.html
   http://www.uwsg.indiana.edu/hypermail/linux/kernel/0206.1/0246.html


--
Francois Gouget         fgouget@free.fr        http://fgouget.free.fr/
                Linux: It is now safe to turn on your computer.

