Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262782AbUJ1Fsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbUJ1Fsp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 01:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbUJ1Fsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 01:48:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14241 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262782AbUJ1Fse
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 01:48:34 -0400
Date: Thu, 28 Oct 2004 06:48:33 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: massive cross-builds without too much PITA
Message-ID: <20041028054833.GP24336@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Contrary to popular beliefs, crosscompiling and full builds for a
bunch of platforms are not hard and not particulary time-consuming.  Below
are my notes on the setup and practices; I hope it will be useful and I
_really_ hope that people will start doing similar things.

On my boxen full rebuild for 6 platforms (allmodconfig on each) takes about 
an hour and normally is done once per new upstream tree; build-and-compare
after making changes usually takes less than a minute total (again, for
all these targets).  IOW, it's fairly tolerable.

	Requirements to sane setup:

1) source tree should be common for as many platforms as possible; and
I mean physically common, not just cp -rl'ed.  Rationale: applying a
patch (or using emacs and similar inferior editors) would break links.
Propagating fixes between a bunch of partially shared trees is a PITA.

2) there should be an easy way to get a diff'able build logs before and
after a change and do that without heavy massage of logs and without forcing
full rebuild.  There should also be an easy way to carry a patchset _and_
get new changes into the patchset without having them turn into a huge
lump that would need to be split afterwards.
	A way to do that: have a forest of cp -rl'ed trees, starting from the
baseline one, carrying the changes we'd done to source tree.  Common sequence
of events is
	<work with source tree>
	diff -urN <last tree in forest> <source> > delta
	cp -rl <last tree in forerst> <new tree>
	(cd <new tree> && patch -p1 -E) <delta
Note that this gives a fast way to see build log changes:
	cd <source>
	patch -p1 -E -R <delta
	make			# now it's uptodate
	patch -p1 -E <delta
	make <whatever arguments> >../log-new 2>&1
	patch -p1 -E -R <delta
	make <whatever arguments> >../log-old 2>&1
	patch -p1 -E <delta
and now we have build logs for *exact* *same* *part* *of* *tree* in old and
new trees.  Ready to be compared.  Of course, for multiplatform work we want
to do each of these for all platforms involved.  It's not going to be a lot
of rebuilds, though - we are only rebuilding the stuff we'd been changing.

3) change of baseline version should be easy.  Note that aforementioned
forest takes care of most of these problems - we can easily convert it
to sequence of patches (script doing diff between cp -rl'ed trees; fast
enough) and we can easily convert a series into the forest (cp -rl + patch
done by another script).  Porting to new baseline mostly consists of
folding the forest into patchset and applying it to new tree.

4) there should be an easy way to spread the builds between several boxen
_and_ keep the trees in sync.  What I'm doing looks so:
	1) master box where I'm doing most of the work on patchset (not
particulary fast CPU, preferably enough memory and fast disk).
	2) slave boxen where the builds are done - these are heavily
CPU-bound [see below] and where editing is going on.  Layout:
	* clean tree (right now - RC10-rc1-bk6) on each.
	* base - clean + combined patchset applied to it (RC10-rc1-bk6-base;
cp -rl'ed from clean)
	* forest (RC10-rc1-bk6-<name>; cp -rl'ed starting from base, that's
where additions to patchset go)
	* source (RC10-rc1-bk6-current; originally cp -a from base, that's
where editing and builds are done)
	* linux-<arch> - object trees
	* patches/... - NFS-exported by master and shared by all slaves.
It's easier to move stuff around that way (scp gets annoying real soon)

Note that sharing the trees between slaves (e.g. by NFS) is not practical -
too damn slow.  Propagating changes is not hard, provided that slaves are
few.

*NOTE*: one thing you definitely want to do is to turn CONFIG_DEBUG_INFO
off.  That changes the builds from IO-bound to CPU-bound and saves a *lot*
of space.  When you work with several platforms the last part gets really
important - we are talking about nearly 2Gb per target.

Splitup of initial patchset lives on master; no point duplicating potentially
very large forest on slaves.  What we have on slaves is the tail of patchset -
the stuff we'd added.  From time to time we can move the beginning of that
tail to master, collapsing more stuff on slaves.

5) cross-toolchains themselves and not wearing your fingers by nightmare
make invokations.  I've done a trivial script that takes target name as
its first argument, sets ARCH, O, CROSS_COMPILE and CHECK (for cross-sparse)
depending on it and passes them and the rest of arguments to make.  It
also sanitizes stderr a bit (see ftp.linux.org.uk/pub/people/viro/kmk for
what I'm using right now).  That takes care of make side of that mess -
something like
$ for i in i386 alpha ppc; do kmk $i C=2 drivers/net/ >../$i-net15 & done
is done a lot (and history helps enough to make further scripting a non-issue).

Building cross-toolchain is surprisingly easy these days; I'm using debian
on build boxen and cross-compilers are not hard to do:
	apt-get build-dep binutils
	apt-get build-dep gcc-3.3
	apt-get install dpkg-cross
	apt-get source binutils
	get binutils-cross-... patch from bugs.debian.org/231707
	cd binutils-...
	apply patch
	TARGET=<target>-linux fakeroot debian/rules binary-cross
	cd ..
	dpkg -i binutils-<target>-....deb
	got linux-kernel-headers, libc6, libc6-dev and libdb1-compat for target
	dpkg-cross -a <target> -b on all of those
	dpkg -i resulting packages
	apt-get source gcc-3.3
	cd gcc-3.3-...
	GCC_TARGET=<gcc_target> debian/rules control
	GCC_TARGET=<gcc_target> debian/rules build
	GCC_TARGET=<gcc_target> fakeroot debian/rules binary
	cd ..
	dpkg -i resulting packages.
One note: <target> here is debian platform name (e.g. ppc), but <gcc_target>
is *gcc* idea of what that bugger is called (e.g. powerpc).

IIRC, Nikita Youshchenko had pre-built debs somewhere, but they were not
for the host I'm using (amd64/sid).

In any case, that's a one-time work (OK, once per target).  Major limitation
here is that one needs several debs for target (AFAICS all we really need
is a bunch of headers).  In practical terms it means no ppc64.  However,
it's not too bad a problem - breaking ppc64 means breaking a box Linus is
playing with, so problems on that platform are noticed fast enough as it
is ;-)

6) cross-sparse: sparse snapshots live on
http://www.codemonkey.org.uk/projects/bitkeeper/sparse/;  I'm probably doing
more work than necessary since I build a separate binary for each target.
What it means is
	a) editing pre-process.h to point to cross-gcc headers (e.g.
/usr/lib/gcc-lib/alpha-linux/3.3.4/include) and
	b) editing target.c (probably not needed these days)
make CFLAGS=-O3
mv ~/bin/sparse-<arch>{,-old}
cp check ~/bin/sparse-<arch>
does the build-and-install.

When switching to new version of sparse (and it's changing pretty fast):
make for all platforms to make sure that no compiling will get in a way,
followed by
	kmk <arch> C=2 CHECK=sparse-<arch>-old >../<arch>-sparse-old
	kmk <arch> C=2 >../<arch>-sparse-new
for everything (works fine in parallel), followed by comparing logs and
looking for regressions.  About 20 minutes for all (well, 20 minutes plus
whatever it takes to fix the breakage if we get one, obviously).

7) useful tricks:
	a) I'm carrying a patch that allows to add to CHECKFLAGS from command
line (CF=-Wbitwise in make/kmk arguments instead of editing makefile).  It's
probably worth merging at some point.
	b) I'm carrying a kludge that teaches allmodconfig to take a given
set of options from a file and pin them down; Roman has a cleaner patch and
IIRC he was going to merge it at some point.  Anyway, that allows to do
such things as "allmodconfig on i386, but have CPU type set to K7 and disable
SMP first, so we'll get all UP-only drivers into the build".  Or "do PPC build
for that sub-architecture", etc.
	See ftp.linux.org.uk/pub/people/viro/patchset/XK* for that stuff.

8) Random notes:

Of course, all that stuff can be done on a single box; however, having a
bunch of compiles run in parallel will get painful since too many of them
== guaranteed way to trash all caches around.  I've ended up using
a two-years-old K7 box as a master (since that was where I was doing most
of the kernel work anyway) and put two amd64 3400+, both with 512Mb and
10krpm SATA as slaves.  I considered spreading build on other local boxen;
maybe I'll do that when I add more targets to active set, but that's not
obvious.  The main problem here is doing resyncs between the boxen without
too much PITFingers - and getting around to doing it, of course.  So far
existing setup had been more than enough for my needs - so much that
all further scripting, etc. remains theory.

IME this stuff is *heavily* CPU-bound.  Parallel builds on the same source
make IO load almost a non-issue, as long as you are not spewing gigabytes of
crap all over the disk (== have CONFIG_DEBUG_INFO turned off; again, it's
a must-do unless you are reading this posting by mistake, having confused
your linux-kernel and masochists-r-us mailboxen).

ext2 works fine for build boxen - you are not dealing with hard-to-recreate
data there (diffs are going to master and you want them carved into small
chunks from the very beginning anyway).  So journalling, etc. is a pointless
overhead in this situation.  Keep in mind that forest of cp -rl'ed kernel
trees gets hard on caches once it grows past ~60 copies regardless of the
fs involved; if your patchset gets bigger than that, fragment it and do
porting, etc. group-by-group.

Currently i386, amd, sparc32, sparc64, alpha and ppc all survive allmodconfig
with relatively few patches; amount of new breakage showing up is not too
bad and so far didn't take much time to deal with.  Bringing in new targets...
hell knows - parisc probably will be the next one (which will mean adding
delta between Linus' and parisc trees into -bird), arm going after it (that
will mean untangling the mess around drivers/net/8390.c first ;-/)  After
getting the target to build (and barring the acts of Cthulhu or Ingo) it
doesn't add a lot of overhead...

Hardware: well, whatever you have, obviously.  Parallel builds *do* scale
nicely, so SMP with relatively slow CPUs can do fine.  Out of something
recent...  I went with UP amd64, simply because a couple of UP boxen was
actually cheaper than equivalent SMP one (~$600 per box, counting disks
and cases) and everything else would be too far overpriced.
