Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279548AbRKASvW>; Thu, 1 Nov 2001 13:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279561AbRKASvN>; Thu, 1 Nov 2001 13:51:13 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:55497 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S279548AbRKASu5>; Thu, 1 Nov 2001 13:50:57 -0500
Date: Thu, 1 Nov 2001 19:50:56 +0100
From: Honza Pazdziora <adelton@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: [Patch,RFC] Symlinks on VFAT using .lnk shortcut files
Message-ID: <20011101195056.B17069@anxur.fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, on URL

http://www.fi.muni.cz/~adelton/linux/vfat-symlink/linux-2.4.13-vfat-symlink-0.90.patch

there's a patch that provides support for symlinks of VFAT partition,
using Windows .lnk shortcut files, in a similar fashion Cygwin does.
I saw other patches that added support for symlinks in one way or
another but I thought it might be good to try to be compatible with
the Cygwin notion of symlinks.

I'm including the description on the approach and would appreciate any
comment or suggestion you might have.

Symlink support for VFAT filesystem for Linux 2.4

Jan Pazdziora, adelton@fi.muni.cz

October 31, 2001.

In Windows, there are so called shortcuts that provide ways of
referencing other files. We will use these to support symlinks on VFAT
partitions under Linux. This patch adds the support to fat/vfat
filesystem source.

Shortcuts are normal files with extension .lnk. That means that from
now on, no regular file on VFAT with symlinks support will be allowed
to have this extension.

The .lnk files not only point to other files but can also hold
information about ways of starting the referenced file, with which
program and parameters. Something like .pif was. The format is
rather complex, and is described by Jesse Hager at
http://www.wotsit.org/download.asp?f=shortcut. 

There are three plus one fields of interest here:

1) Relative path -- if it is present we will use it to mean relative
   symlink, and when writing relative symlink, we will fill this
   field.
2) Network location, in a form \\hostname\path. We won't try to
   resolve it, except one special case, \\localhost\path, which will
   mean /path, absolute symlink.
3) Local location, in a form C:\path. We won't try to resolve this and
   we will never write this kind of link, because we don't know what
   the driver letters are.
4) Description field -- Cygwin seems to use it to store the absolute
   symlinks, we will write it to contain the symlink path (relative or
   absolute).

This patch makes symlink resolving the default. You can mount the
filesystem with an option -o nosymlinks, that will switch the symlink
support off and you will see the base .lnk files.

This patch was tested on Linux kernel 2.4.13 and on Windows ME.

Questions, requests for comment:

If we had the information about drive letter available, we would be
able to resolve the C:\Windows links correctly as well. Note that
inside one drive (shortcut from D: to some other location on D:), the
relative path seems to always be present, so it only starts to be
needed and interesting with links that go accross the Windows drive
boundary. Perhaps some /etc/windrives.conf file? Or a /proc support?
Suggestions welcome.

Cygwin doesn't seem to support the network and local symlinks under
Windows well. It is unhappy with the Network/local part. I believe
that it is a problem of Cygwin (do they do their own symlink
resolution?) and I might be able to get a patch to make Cygwin work
properly as well.

The patch adds minor tweaks into some common code, and also some
bigger functions for symlink creating and resolving. These could be
moved into separate file, from vfat/namei.c and fat/file.c. But due to
a way the fat/vfat/msdos filesystem sypport is structured, the support
(at least partial) will probably always need to be in the common fat
base.

Comments welcome.

-- 
------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
   .project: Perl, DBI, Oracle, MySQL, auth. WWW servers, DBD::XBase.
------------------------------------------------------------------------
