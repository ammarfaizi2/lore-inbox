Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265621AbRFWEhd>; Sat, 23 Jun 2001 00:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265623AbRFWEhX>; Sat, 23 Jun 2001 00:37:23 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:40118 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S265621AbRFWEhF>; Sat, 23 Jun 2001 00:37:05 -0400
Message-ID: <3B341D4D.D54103B9@idcomm.com>
Date: Fri, 22 Jun 2001 22:38:37 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-4 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: Is this part of newer filesystem hierarchy?
In-Reply-To: <Pine.LNX.4.33.0106222328100.24168-100000@Expansa.sns.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luigi Genoni wrote:
> 
> Again i am confused.
> 
> /usr/bin/ld is linker at compilation time, at it works how i told in
> second part
> of my mail, (just try to compile it, it comes with binutils,
> ftp.kernel.org/pub/linux/devel/binutils).
> 
> /lib/d-2.2.X.so  is what you are talking about.
> So should i think os an hack to ld-2.2.3.so ??

The RH 7.1 comes with:
:~# ld --version
GNU ld 2.10.91
Copyright 2001 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms
of
the GNU General Public License.  This program has absolutely no
warranty.
  Supported emulations:
   elf_i386
   i386linux
   elf_i386_glibc21

The glibc rpm is version 2.2.2-10.

> 
> to see how it works loock at /usr/bin/ldd, it's an interesting script.
> 
> I can understand why old glibc 2.1 is not isered in the directories
> where ldconfig has to loock to create its db for loader, but there should
> be a corrispective /usr/i386-(redhat/glibc2.2???)-linux/ (with its
> subdirectories)
> for glibc 2.2, since it is necessary at compilation
> time.

There is *no* /usr/i386-xxx except for:
/usr/i386-glibc21-linux/

No glibc22 version exists.

> This do not change the problem which is related to /lib/ld-2.2.X.so.
> doing a strings /lib/ld-2.XXX
> you will find also
> 
> info[19]->d_un.d_val == sizeof (Elf32_Rel)
> info[20]->d_un.d_val == 17
> /lib/
> /usr/lib/
> {ORIGIN}
> {PLATFORM}
> expand_dynamic_string_token
> dl-load.c

"i686" is visible on a line by itself, but so are i386, i486, and i586.
The full path of /lib/i686/ is not mentioned anywhere. So it looks like
strings of /lib/ld-2* does not offer any hints as to how the i686
subdirectory is being chosen without it being specified anywhere else. I
think this will end up just being one of those mysteries, and the boot
software coder will have to find some non-trivial workaround. It sounds
like the /lib/i686/ path was hardcoded in the linker when it was
compiled, which means there are no simple config file checks.

D. Stimits, stimits@idcomm.com

> 
> this is the interesting section of the output. This way you can check for
> an hack to the loader, but I think to something else instead of an hack.
> 
> I do not have a red hat here around, since i do prefer another style for
> my linux systems, so i cannot check by person.
> 
> Luigi Genoni
> 
> On Fri, 22 Jun 2001, D. Stimits wrote:
> 
> > Luigi Genoni wrote:
> > >
> > > I do not know if this is a new filesystem hierarchy, it should not be,
> > > at less untill lsb finishes all discussion (anyway it is similar to lsb
> > > standard). Your mail is a little confusing for me. Let's see if i can
> > > clarify my ideas.
> > >
> > > On Thu, 21 Jun 2001, D. Stimits wrote:
> > >
> > > > I found on my newer Redhat 7.1 distribution that glibc is being placed
> > > > differently than just /lib/. Here is the structure I found:
> > > >
> > > > /lib/ has:
> > > > libc-2.2.2.so (hard link)
> > > > libc.so.6     (sym link to above)
> > > >
> > > > A new directory appears, /lib/i686/ (uname -m is i686):
> > > > libc-2.2.2.so (a full hard link copy of /lib/ version)
> > > > libc.so.6     (sym link to hard link in this directory)
> > > >
> > > > The file size of /lib/libc-2.2.2.so is around 1.2 MB, while the size of
> > > > /lib/i686/libc-2.2.2.so is over 5 MB. The 5 MB version has symbols,
> > > > while the 1.2 MB version is stripped.
> > > >
> > > > Here is the peculiar part that I need to find out about. My
> > > > /lib/ld.so.conf does not contain the i686 directory in its path. Nor do
> > > > any local LD environment variables. Even so, "ldconfig -p" lists *only*
> > > > the libc.so.6 sym link, not the libc-2.2.2.so, and the one listed is for
> > > > the i686 subdirectory, not the /lib/ directory. How is it possible that
> > > > the i686 directory is being checked if it is not listed in ld.so.conf
> > > > and not part of any LD path variable? I am using a non-Redhat kernel
> > > > (patched 2.4.6-pre1), so I know it isn't a Redhat-ism related to the
> > > > kernel itself. My ld version:
> > > excuse, but if you do something like,
> > > ldd /bin/ls
> > >
> > > what do you get, which libc is loaded?
> >
> > :~# ldd /bin/ls
> >   libtermcap.so.2 => /lib/libtermcap.so.2 (0x4002a000)
> >   libc.so.6 => /lib/i686/libc.so.6 (0x4002e000)
> >   /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)
> >
> > The i686 subdirectory version is visible to the linker. I don't know
> > how.
> >
> > >
> > > have you got a file like /etc/ld.so.preload??
> >
> > No. Nor are any preload or LD environment variables set. Something
> > Redhat has done is making the i686 subdirectory visible. Maybe ld
> > searches recursively?
> >
> > > basically you can use the stripped glibc (faster), but then,
> > > if you have troubles and you need to debug, just set the preload file,
> > > or use LD_PRELOAD variable to use
> > > the non stripped library. In princip it is not a stupid idea,
> > > not that i like it, but it is not stupid.
> >
> > Without any preload, it appears the linker is by default choosing the
> > debug version in the i686 subdirectory. Redhat must have mucked with it,
> > otherwise I don't see how it could be searching the i686 subdirectory
> > without any configuration customization (no preload, no LD environment
> > variables). But this is what I want to verify...where the "mucking" has
> > occurred, it is important to find out for some software that is used to
> > create custom and/or rescue disks. (alternately, to find out if there is
> > a predictable scheme, such as knowning ld is searching recursively, or
> > searches for /lib/{uname -m})
> >
> > >
> > > > ~# ld --version
> > > > GNU ld 2.10.91
> > > > Copyright 2001 Free Software Foundation, Inc.
> > > > This program is free software; you may redistribute it under the terms
> > > > of
> > > > the GNU General Public License.  This program has absolutely no
> > > > warranty.
> > > >   Supported emulations:
> > > >    elf_i386
> > > >    i386linux
> > > >    elf_i386_glibc21
> > > >
> > > > Possibly Redhat altered ld? According to the man page, this directory
> > > > should not be found since it is not part of ld.so.conf, and also the
> > > > /lib/ version *should* be found (but isn't). What has changed, is it a
> > > > standard for filesystem hierarchy, or is it something distribution
> > > > specific? (I need to pass the answer along to someone working on
> > > > customized boot software that is currently being confused by this
> > > > distinction; there is a need to find a proper means to detect libc and
> > > > linker information)
> > > ld links dynamic libraries if the final extension is .so (usually a link),
> > > and uses the soname (usually a link too, created by ldconfig), for
> > > the binaries it generates, otherway it will use .a library archives.
> > > /usr/lib/libc.so (the file used by ld to link glibc), is a script. There
> > > are good reason for that, with libc5 it was a link to /lib/libc.so.5
> > > (soname).
> > > ld loocks for .so files as is configured
> > > inside of the files in /usr/<arch/host name>/lib/ldscripts
> >
> > Interesting that there is a /usr/i386-glibc21-linux/ directory, but
> > glibc 2.2 is used. In /usr/i386-glibc21-linux/lib/ is file
> > libc-2.1.3.so, which matches this particular naming, but ldconfig -p
> > does not indicate this directory is searched. There is no ldscripts,
> > either as a file name or a directory name. The visible directory tree
> > there is:
> > /usr/i386-glibc21-linux/ as base, then these:
> > -- lib
> >     `-- gcc-lib
> >         `-- i386-redhat-linux
> >             `-- 2.96
> >                 `-- include
> > ->../../../../../lib/gcc-lib/i386-glibc21-linux/egcs-2.91.66/include
> >
> >
> >
> > >
> > > please note that usually for klibraries inside of /lib, the .so link is in
> > > /usr/lib, or at less it should.
> > >
> > > syntax is like:
> > > SEARCH_DIR(/lib); SEARCH_DIR(/usr/lib); SEARCH_DIR(/usr/local/lib); \
> > > SEARCH_DIR(/usr/i386-slackware-linux/lib);
> > >
> > > (that is why you need to pass -L/usr/X11R6/lib to link X11 apps
> > > at runtime) anyway to load shared libraries is managed by
> > > /lib/ld-2.XXX.so, using
> > > the db created by ldconfig that uses /etc/ld.so.conf
> > > as its configuration file.
> >
> > There must be something more, since the i686 subdirectory is being
> > searched without ld.so.conf and without environment variables pointing
> > at it (e.g., recursive search from any named directory).
> >
> > D. Stimits, stimits@idcomm.com
> >
> > >
> > > Luigi Genoni
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
