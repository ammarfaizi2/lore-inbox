Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbVKAIke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbVKAIke (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVKAIke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:40:34 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:50062
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S964815AbVKAIkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:40:33 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: jonathan@jonmasters.org
Subject: Re: [PATCH] fix floppy.c to store correct ro/rw status in underlying gendisk
Date: Tue, 1 Nov 2005 01:21:53 -0600
User-Agent: KMail/1.8
Cc: Evgeny Stambulchik <Evgeny.Stambulchik@weizmann.ac.il>,
       linux-kernel@vger.kernel.org
References: <4363B081.7050300@jonmasters.org> <200510311717.21676.rob@landley.net> <35fb2e590510311836j4c7fbdf2u77a72ebbfd53790c@mail.gmail.com>
In-Reply-To: <35fb2e590510311836j4c7fbdf2u77a72ebbfd53790c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511010121.53889.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 20:36, Jon Masters wrote:
> On 10/31/05, Rob Landley <rob@landley.net> wrote:
> > On Monday 31 October 2005 05:57, Evgeny Stambulchik wrote:
> > > Jon Masters wrote:
> > > > Let me know if this fixes it for you - should bomb out now if you
> > > > try. The error isn't the cleanest (blame mount), but it does fail.
> > >
> > > This works fine, thanks! For what it worth, though, mount -o remount,rw
> > > says remounting read-only yet still returns success. (Opposite to
> > > busybox, which now says "Permission denied" - rather misleading, but at
> > > least it fails).
> >
> > That sounds like the string translation of EPERM returned by libc's
> > strerror().  (At busybox we're frugal bastards; we don't include text
> > messages when we can get the C library to provide them for us. :)
>
> Indeed. Reminds me that I should clean up and send a form parser I
> wrote for busybox to handle multi-part mime form posts in its
> webserver while I'm at it. That's something it could do with even if
> it's being frugal.

Oh we'll accept a suprising amount of functionality as long as it's the 
smallest possible implementation and you can easily configure it out if you 
don't want it.

We're starting to draw the line at servers, though.  I personally think our 
existing httpd/dhcpd/telnetd servers should probably be broken off into a 
separate package.  (We've wandered a touch beyond the mandate of standard 
command line utilities, in places.  An agenda item for version 1.2...)

> > But yeah, we're sticklers for correct behavior, and only attempt to
> > remount readonly if we get EACCES or EROFS, not _just_ because we
> > attempted a read/write mount and it failed.  (And yes, I personally
> > tested this corner case.  We haven't started on an automated regression
> > test script for mount yet because running it would require root access,
> > but it's on the todo list as we upgrade the test suite in our Copious
> > Free Time...)
>
> You looked at running this inside a qemu environment (scratchbox), huh?

I use User Mode Linux, actually.  (I finally downloaded qemu a couple days 
ago, to test non-x86 builds.  But I could only build a crippled version at 
the time, because ubuntu doesn't have the SDL headers installed either.  It's 
sort of development whack-a-mole...)

No, I'm building my own distro from source code, based on busybox and uClibc.  
(And when I mean "based on busybox" I mean I'm using it to completely replace 
bzip2, coreutils, e2fsprogs, file, findutils, gawk, grep, gzip, inetutils, 
less, modutils, net-tools, patch, procps, sed, shadow, sysklogd, sysvinit, 
tar, util-linux, and vim.)  And yes, this is a complete self-hosting 
development environment.  (By self-hosting I mean capable of rebuilding 
itself from source.)

You can download the build script here:
http://www.landley.net/code/firmware

Untar it and run build.sh (as a normal user, not as root), and it'll download 
all the software packages it needs, build User Mode Linux, and run the rest 
of the build under UML.  The result is a self-contained "firmware-uml" you 
can run to try it out.  It's a User Mode Linux kernel with appended squashfs 
root partion, which automatically loopback mounts itself during initramfs.  A 
bootable version is in the works.  (I already have a patched lilo that'll 
boot it, the hard part is making an installer.)

I've only got two gnu packages left other than development tools: I still need 
to untangle busybox's command shell mess so I can stop using bash, and I need 
to add "diff -u" so I can drop diffutils.  (And while I'm at it, I need to 
find another compiler to replace gcc and binutils, and find another make 
implementation, at least as an _option_.  Then I can ask Richard Stallman if 
the resulting system is still "GNU/Linux", despite not using any GNU packages 
or libraries even to build it.  Ooh, software development to advance a 
political agenda, a _totally_ unfair thing to pull on RMS...)

And yes, I've found (and fixed) eight gazillion bugs over the past two years 
working on this system.  You want to shake out all the bugs and weird corner 
cases an implementation of sed/awk/sort?  I mean after you've read through 
the relevant Open Group base standard, line by line taking copious notes, and 
implemented everything you can see?  Try to get it to handle the ./configure 
of binutils and gcc.  Those suckers are _evil_.

And by evil I mean I had to add this to busybox sed to get the darn thing to 
actually use it:

#define LIE_TO_AUTOCONF
#ifdef LIE_TO_AUTOCONF
    if(argc==2 && !strcmp(argv[1],"--version")) {
        printf("This is not GNU sed version 4.0\n");
        exit(0);
    }
#endif

You guessed it: the configure regexp checks for _GNU_ sed.  Grrr...

> Jon.

Rob
