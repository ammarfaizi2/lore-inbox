Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264968AbRFVKCp>; Fri, 22 Jun 2001 06:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265200AbRFVKCg>; Fri, 22 Jun 2001 06:02:36 -0400
Received: from Expansa.sns.it ([192.167.206.189]:56081 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S264968AbRFVKC0>;
	Fri, 22 Jun 2001 06:02:26 -0400
Date: Fri, 22 Jun 2001 12:02:18 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: "D. Stimits" <stimits@idcomm.com>
cc: kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: Is this part of newer filesystem hierarchy?
In-Reply-To: <3B324F1B.5AFA437B@idcomm.com>
Message-ID: <Pine.LNX.4.33.0106221142470.20662-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do not know if this is a new filesystem hierarchy, it should not be,
at less untill lsb finishes all discussion (anyway it is similar to lsb
standard). Your mail is a little confusing for me. Let's see if i can
clarify my ideas.

On Thu, 21 Jun 2001, D. Stimits wrote:

> I found on my newer Redhat 7.1 distribution that glibc is being placed
> differently than just /lib/. Here is the structure I found:
>
> /lib/ has:
> libc-2.2.2.so (hard link)
> libc.so.6     (sym link to above)
>
> A new directory appears, /lib/i686/ (uname -m is i686):
> libc-2.2.2.so (a full hard link copy of /lib/ version)
> libc.so.6     (sym link to hard link in this directory)
>
> The file size of /lib/libc-2.2.2.so is around 1.2 MB, while the size of
> /lib/i686/libc-2.2.2.so is over 5 MB. The 5 MB version has symbols,
> while the 1.2 MB version is stripped.
>
> Here is the peculiar part that I need to find out about. My
> /lib/ld.so.conf does not contain the i686 directory in its path. Nor do
> any local LD environment variables. Even so, "ldconfig -p" lists *only*
> the libc.so.6 sym link, not the libc-2.2.2.so, and the one listed is for
> the i686 subdirectory, not the /lib/ directory. How is it possible that
> the i686 directory is being checked if it is not listed in ld.so.conf
> and not part of any LD path variable? I am using a non-Redhat kernel
> (patched 2.4.6-pre1), so I know it isn't a Redhat-ism related to the
> kernel itself. My ld version:
excuse, but if you do something like,
ldd /bin/ls

what do you get, which libc is loaded?

have you got a file like /etc/ld.so.preload??
basically you can use the stripped glibc (faster), but then,
if you have troubles and you need to debug, just set the preload file,
or use LD_PRELOAD variable to use
the non stripped library. In princip it is not a stupid idea,
not that i like it, but it is not stupid.

> ~# ld --version
> GNU ld 2.10.91
> Copyright 2001 Free Software Foundation, Inc.
> This program is free software; you may redistribute it under the terms
> of
> the GNU General Public License.  This program has absolutely no
> warranty.
>   Supported emulations:
>    elf_i386
>    i386linux
>    elf_i386_glibc21
>
> Possibly Redhat altered ld? According to the man page, this directory
> should not be found since it is not part of ld.so.conf, and also the
> /lib/ version *should* be found (but isn't). What has changed, is it a
> standard for filesystem hierarchy, or is it something distribution
> specific? (I need to pass the answer along to someone working on
> customized boot software that is currently being confused by this
> distinction; there is a need to find a proper means to detect libc and
> linker information)
ld links dynamic libraries if the final extension is .so (usually a link),
and uses the soname (usually a link too, created by ldconfig), for
the binaries it generates, otherway it will use .a library archives.
/usr/lib/libc.so (the file used by ld to link glibc), is a script. There
are good reason for that, with libc5 it was a link to /lib/libc.so.5
(soname).
ld loocks for .so files as is configured
inside of the files in /usr/<arch/host name>/lib/ldscripts

please note that usually for klibraries inside of /lib, the .so link is in
/usr/lib, or at less it should.

syntax is like:
SEARCH_DIR(/lib); SEARCH_DIR(/usr/lib); SEARCH_DIR(/usr/local/lib); \
SEARCH_DIR(/usr/i386-slackware-linux/lib);

(that is why you need to pass -L/usr/X11R6/lib to link X11 apps
at runtime) anyway to load shared libraries is managed by
/lib/ld-2.XXX.so, using
the db created by ldconfig that uses /etc/ld.so.conf
as its configuration file.

Luigi Genoni


