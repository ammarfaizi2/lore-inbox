Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbUCWCj3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 21:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUCWCj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 21:39:29 -0500
Received: from mail.inter-page.com ([12.5.23.93]:36364 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S262103AbUCWCjX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 21:39:23 -0500
From: "Robert White" <rwhite@casabyte.com>
To: "=?iso-8859-1?Q?'J=F6rn_Engel'?=" <joern@wohnheim.fh-wedel.de>,
       "'Horst von Brand'" <vonbrand@inf.utfsm.cl>
Cc: "'Chris Friesen'" <cfriesen@nortelnetworks.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: unionfs
Date: Mon, 22 Mar 2004 18:38:57 -0800
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAac2dcWbI6EqDnR1VbPQ6CwEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20040316173146.GB27046@wohnheim.fh-wedel.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgetting his purposes, here are my valuable cases.  Note that none of
these cases are about source control or versioning.  (IMHO that is what
version control is for, and that task has been dealt with in its place.)  I
have thought about this a lot because of my direct need a-la scenario 1.
This is a fairly direct description, and the utility has become painfully
desirable by its absence.

Scenario 1:  (my real world)

I have a product where there is a central (full sized PC) controller and
some number of satellite boxes.  The satellites are small custom hardware
jobbies running a linux instance of their own.  The number and disposition
of these sub-boxes varies by installation.

Ideally I would use dhcp and provide one single root image for the satellite
boxes to nfs-mount regardless of their dynamically assigned host names or IP
addresses.  The boxes are small enough that transcribing an initrd (etc)
into ram is too resource hungry even with busybox.

Right now, it is not possible to do this because if two running instances
share the same image they will share some critically variable files.  (It is
disasterous to have two boxes share an image containing /etc/ld.so.cache
{and hugely problematic for them to share /var/run/ and /var/log/} but I
want them to have all the rest of /etc held in common.

I have used various tricks to overcome most of this, but it would be (would
have been) ideal to be able to mount host:/export/satellite/root as the root
directory.  Then the startup script could union that root under a ramfs
partition.  (I have no need to maintain the changes between boots, so in
this case discarding the changes is ideal.)


Scenario 2: (theoretical)

Take scenario 1 and re-cast it in a manufacturing or test/maintenance
environment.  The target machines are (network) booted anonymously into a
test network.  The test are performed, the results are logged to an
infrastructure machine, and the box is powered off and removed to its next
location.  Again, the single image is used, and the union overlay is
discarded after use.


Scenario 3: (theoretical, from my two-back previous employer)

Take scenario 1 again and apply it to education.  A lab full of student
machines.  Students are expected to either supply their own home directories
on USB/FireWire hard disks they bring with them; or their home directories
are mounted across a network from a homing farm.  These lab machines need to
be quite accessible but you don't want the students to corrupt the installs.
Again the union overlay is discarded after use.


OK so I have been discarding the overlays.  But are their scenarios that
where someone would want to keep the overlays or analyze them separately?
You can tell by the way I asked that I think the answer is yes, can't you?
8-)


Scenario 4: (past, real world trauma 8-)

You want to install/replace a package on your existing box.  You would like
to try it "in place" but you don't want to hammer your install.  You mount
up the union with a "spare" partition, and pivot that in as root.  Now you
do the install and try things out.  (Think system wide utilities like a new
init, or glibc.)  If things don't work well you want to reboot or pivot back
to your real root and then look through just what the install task did to
your machine.  In this scenario the preservation of the binaries in the
"original" location, as reflected on the now dis-unioned partition provides
important information.  You can check log fragments, partial deletes, and so
on.  You can also tweak the dis-unioned image and then try it out to see if
your problems are addressed.  With this information, and once you are
satisfied you have an install/replace that will work for you, you can
proceed to perform the install "for real" on your root.  Then you can
double-check against the dis-unioned overlay.


Scenario 5: (theoretical)

You want to roll your own distribution, or build package images (rpm's etc)
out of packages that don't have build semantics that allow build-for-root
install-to-scratch construction.  Take your near-virgin machine, pivot the
union over the root, do the install, pivot back or reboot, pack the
dis-unioned image up as the package tree.


I would say that to do these tasks you would need to meet the following
requirements:

1) Overlay trump semantics.  Any file with a given name in the overlay must
completely hide the same file in the backing file system.  It must be
possible to remove a file and then create a directory of that same 

2) copy whole-file on write.  This would probably require a kernel daemon.
Files opened read-only are used in place.  Files opened for writing need to
wholly migrate from the backing file system to the overlay, either at open
time or on first write.  This would involve waits and stuff of potentially
extreme severity, hence the daemon.  Block-differences are not interesting,
that is what later diffs are for anyway.  Block-wise copying would make mmap
(etc) just painfully impossible anyway.  So all-or-nothing migration is the
ticket 8-).

3) White-out list.  There would need to be a database, by path name, of
files that had been "removed" (unlinked but not "overwritten") and that
database would need to be expressed in an accessible format when the overlay
file system was not part of the union.  Presumably there would be a file
existent on the overlay, that was opened by the kernel daemon at mount time
and which didn't appear in the resulting mounted image.  This file would be
the white-out list.  The natural effect would be that a file of that name in
the backing file system would be inaccessible.  If that name were a
mount-time option (etc) then this one point of contention could be worked
around on a mount-by-mount basis, making it immaterial.  Being available at
open() time, this white-out list removes the need for invisible inodes in
the exceptional sense.  We don't care what "/bob" used to be, there is now
no file or directory (etc) named "/bob" and there will persist in being no
such thing until "/bob" is created in the overlay or through the union.
Thanks for playing... 8-)

4) A dumb-guy-gets-the-shaft provision would be that changes to the backing
file system, or mounting an overlay that doesn’t match the backing file
system produces exactly the mess that you get from overlaying the overlay
(with its white out list) over the backing system.  The Cartesian product of
possible combinations is interesting but not pejorative.  If I have a
directory in the overlay that doesn't exist in the backing system, then I
have a directory with exactly those elements from the overlay.  If I
white-out "/bob" then there is no /bob whether the backing system wants one
there or not.

5) No backing-fs updates at all.  Under no circumstances is there to be any
requirement of writing to the backing file system to keep things current.

6) No write-through.  No checks are made for the write-through case.  All
writes take place as per item 2 and on the overlay fs regardless of the
writeability of the backing file system.

7) The MMap conundrum... In the case of a read-only mmap of a file, the file
should *probably* be speculatively "coppied" to the overlay file system.
The user will expect that the overlay file system remains consistent on
update, so you don't want under-writes of the backing file system to make
give you a moving target.  Such copies would take place as if a write were
going to happen, but the inode would be unlinked-after-open (or more
accurately unlinked at close if not written) in the overlay file system so
that in the zero-change case you don't produce excessively large
dis-union(ed) image sizes.  (In truth this speculative copy behavior would
be done via cached semi-inodes in the union driver itself, the real inode
only being written to the overlay in the update case.  This is practical
since we are writing these specialized open/release/write/etc routines
anyway.  So you are doing in the phantom inode thing just like
unlink-after-open in all the other file systems anyway, but you will later
link-down the inode if it warrants saving instead of doing things the other
way around.

8) Speculative copy thresholds.  There probably needs to be some tunable(s)
for sizes and types of speculative copying into the phantom inodes.  I is
just bound to come up.


None of these requirements are particularly complex or onerous.  Some of the
actions are potentially expensive, but in the foreseeable uses, they would
not be prohibitively so.

Rob.




