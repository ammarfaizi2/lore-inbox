Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317265AbSFLAaS>; Tue, 11 Jun 2002 20:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317268AbSFLAaR>; Tue, 11 Jun 2002 20:30:17 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:52497 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317265AbSFLAaP>;
	Tue, 11 Jun 2002 20:30:15 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200206120030.g5C0UDF139852@saturn.cs.uml.edu>
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
To: fgouget@free.fr (Francois Gouget)
Date: Tue, 11 Jun 2002 20:30:13 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.43.0206110712290.7449-100000@amboise.dolphin> from "Francois Gouget" at Jun 11, 2002 07:31:32 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Gouget writes:

> This looks like a bad idea. The reason is that the VFAT driver is the
> wrong abstraction layer to support the '.lnk' files:
>
>  * on Windows if you open("foo.lnk") you get the .lnk file, not the file
> it 'links' to. On Linux you would get the file it points to instead
> which is a different behavior.

That's a common Windows app bug which exists exactly because
the Microsoft implementation is at the wrong abstraction layer.

>  * Windows supports .lnk files on FAT, VFAT, NTFS, ISO9660, etc. So if
> such support is added in the Linux kernel, it should be added to all of
> the above filesystems. And then, there is no reason not to add it to
> ext2, NFS, etc!

As long as a default ext2 mount doesn't get hit, I won't complain.

>  * what happens if a Unix program tries to create a file called
> 'foo.lnk' that is not a .lnk file? I could create a text file called
> 'mylinks.lnk' to store bookmark stuff for instance.

You get about the same as when creating ":" I'd imagine.

>  * there is no such thing as a dead .lnk file. If the specified path is
> not found, Windows will use the file date, file size and whatnot to try
> to find where the target went. Is it planned to add any such support
> planned?

I really doubt that! Calling out to userspace, as kmod and the
hotplug stuff do, might be... not extremely unreasonable.

>  * it has been mentionned that this makes it possible to extract source
> tarballs that contain symlinks on a VFAT filesystem. While this sounds
> cool I am not sure it is so useful.
>    - for VFAT one could use the UMSDOS filesystem to do the same thing,
>      and get many other features at the same time (at least while in
>      Linux)

not Cygwin compatible

>  * it would prevent wine from reading the information in the '.lnk'
> file... at least for 'supported' '.lnk' files

It's fixable.

>  * it was suggested to implement a hack to let Wine access the '.lnk'
> data. Why implement a hack which is going to be Linux specific when
> doing nothing works just fine and on any Unix system? Plus this is going
> to require Linux specific code in Wine if it is to be supported.

Wine already has Linux-specific code. The "doing nothing" option
doesn't get us what we want: symlinks.

>  * making it an option does not help Wine at all, especially if it is a
> default one. Then we have to keep telling users that they have to modify
> their fstab if they want Wine to work.

Making it an option is NOT to help Wine, except perhaps as
a temporary work-around until Wine is updated.

> The right level to implement symlink support is:
>
>  * in Wine. Of course! There we know what the drive mappings are, we
> have access to the registry and can even use the native shell library.

This won't help with compiling Linux on a vfat partition which
happens to have plenty of free space for a big compile.

This won't help make a vfat root work.

>  * in an LD_PRELOAD library. Then they would work for all filesystems,
> be selectable on a per-user or even per-process basis. Of course it
> would most likely not work with Wine (ld_preload libraries seldom do)
> but we can at least easily disable such libraries using a wrapper
> script.

This is the TOTAL CRAP option. Clearly you've never used LD_PRELOAD.
You're not going to get that working with static linked executables,
setuid, setgid, very old executables, very new executables, stuff
written in FreePascal, etc., etc., etc.

>  * as an option in the KDE/Gnome file browsers and related file access
> methods. That's the layer which seems closest to the Windows shell
> 'layer'.

Does anybody actually use a GUI file browser??? Eeeew.
Hacking everything from awk to zsh would be required.

> This looks like it could be the next 'unhide' thing. See:

That was botched.

1. no backdoor
2. no Wine patch to use the backdoor

The info really needs to be passed via stat() and
the directory reading calls, same as we do for the
file type info today. Then JFS, NTFS, FAT, and many
other filesystems could use it.


