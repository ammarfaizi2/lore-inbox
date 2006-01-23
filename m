Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWAWKoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWAWKoq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 05:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWAWKoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 05:44:46 -0500
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:10181 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932455AbWAWKoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 05:44:46 -0500
Message-ID: <43D4B358.7050604@comcast.net>
Date: Mon, 23 Jan 2006 05:43:36 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       Ubuntu Users List <ubuntu-users@lists.ubuntu.com>,
       ubuntu-devel <ubuntu-devel@lists.ubuntu.com>,
       autopackage-dev@sunsite.dk
Subject: Need insight on designing a package manager
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

As a learning project, I'm designing my own package manager.  Naturally,
I dislike wasting time; the package manager I'm designing will fill some
gaps in current package management design, and is in reality aimed at
being a "final" implementation of this many-reinvented wheel.  To this
end, I need help; I've never made a functional package manager, and so I
don't likely have ALL of the insight I'll need to do it right the first
time.  So those of you who have studied, maintained, or created package
managers, please help me?

The working project name is "Project Coon Fox," and will be later
discarded for a real name.  It is designed to replace dpkg/apt, rpm/yum,
and autopackage in functionality; it is not designed to be a source
build system, as Gentoo portage is.

The original idea for Project Coon Fox was to create a package manager
which did not use preinstall/postinstall scripts freely executed as root
in a fully open security context.  The following (long and boring)
discussion will explain where I'm going with this, and what other design
contingencies I've taken into account so far.  If you don't care, you
can stop reading here.  If you don't care *much*, go ahead and skim.  :)



The problem with both dpkg (deb) and rpm (rpm) is that they execute bash
scripts in the system administration context (root, full caps,
sysadmin_r, etc); portage attempts to use a sandbox library, but this
can be evaded by bringing your own syscall() code, as the sandbox only
wrappers glibc functions.  As you may guess, this can allow any
malicious package to destroy the system; in fact, upon attempt to
install Sun Java on Debian, I found that clicking "no" on the license
permenantly alters the system in ways dpkg can't track and roll back,
assuring you can never try to install the package again.

The only real way to control and audit the installation process is to
have the package manager interpret the installation scripts.  Project
Coon Fox will do exactly that.  I've settled on writing a description in
XML and using libxml2 to parse it; this is crude, but effective, and
extensible via plug-ins.  I allow for querying the user and making
policy decisions in this script (i.e. file permissions, control of SUID,
associations, mime types... any block of script can basically be
controlled by user input).  Policy integration will be implimented as
well; policy plug-ins for SELinux are planned, and "meta-native"
policies will allow a policy file to have chunks modified based on user
query.

Project Coon Fox will be able to audit the changes fully and partially.
 A "basic audit" mode will compare a set of rules to the changes and
raise specific concerns to the user, allowing the installation to be
aborted or the package to be modified, i.e. by removing SUID/SGID bits.
 This goes for specific policy as well; the final SELinux policy, for
example, could be audited for "grants permissions beyond r_default in
this given policy."  Reactions could be to remove excess permissions.
And of course, as all of this is tracked and logged, any of these
changes can be easily reviewed later and undone.

Install script handling will be modular.  Plug-ins can add new install
script descriptions, such as mime type handling, file associations,
entries into scrollkeeper, registering of plug-ins or extensions for
certain programs, etc.  Such plug-ins are extremely dangerous; they need
the control to make low-level system modifications.  Random third
parties should have no need to add a plug-in here; and if they do, there
should be no need to make any part of its execution enter a closed
source code block.

Plug-ins will also allow for policy extensions, to understand SELinux
and GrSecurity policy files and how to activate them in the system.
These policy plug-ins will also translate policies written in a built-in
meta-policy language to the native format of the target backend.



I quickly made the decision to use SQLite for the back-end data store.
I have already written some of the related code here; I refuse to write
more until I have a clear view of what I am doing.  Writing and
rewriting code over and over because of minor changes in the way I'm
going to handle things is not a good idea.  SQLite was, of course,
chosen for performance.  Running a full RDBMS like MySQL or PostGreSQL
is out of the question; embedded MySQL is out because it's not object
oriented (SQLite lets me sqlite3_open() a database and get a handle to
use; I can work on 100 db's if I want, all at once).  Evidently the
MySQL folk don't understand that C can be used for object oriented
programming; it just doesn't do it in the language, as in C++ or Obj-C.

This is one dilema point; I don't know all the information to store in
the database.  I'm working on this; could use some help.



I decided to separate the concept of "Package" and "Install."  The
package portion of the program will consist of a library that creates a
temporary directory tree representing the package, including the install
scripts and system installation image.  The install end will take a
directory and act on it, installing its contents to the system.  The
install end will be capable of triggering callbacks to handle queries
and auditing concerns.

In effect, the core program will call the package end to unpack a
package file; and then call the install end to execute the installation.
 The install portion in its final stages gives a complete audit of the
changes, as well as a little extra data to identify the packages and
some other control information; this all can then be stored.
Effectively, as long as the APIs are the same and various other
considerations are taken, mindful programmers can randomly replace any
of the package, install, or database components with completely new code.

Changes to how packages are handled can be made by modifying the package
component of this model.  In this component, I'm implimenting a
contingency for LiveCDs.  Packages can contain either files; or control
information with a hash of individual files, their ownership,
permissions, size, and path in the native package format.  By giving the
package component a base path to use, it will be possible to take a
mounted image file i.e. from a LiveCD and a set of packages made by
comparing full packages to this image file, and reconstruct the
original, unpacked contents from this union.  This would allow for
packages on a LiveCD to count 20-50KiB on average, letting an install
base of 1000 packages require about 50MiB.  This will fit on a good
LiveCD (i.e. the Ubuntu LiveCD can take it), allowing for a system to be
"working" before it is even installed.



My current largest dilema is dependency checking.  I want a
file-interface dependency model, handled by the install module.  This
means looking for either a program /bin/foo or /usr/bin/foo or "InPath
foo" (a la autopackage IIRC) and comparing its command line interface;
or finding a library in the same way and comparing its API.

As we're not taking the massively insecure habit of allowing
not-yet-installed programs to tell us to execute random bits of code
that already exist on our system, this will probably require interface
description control information to be packaged with everything about
everything, including library interfaces, plug-in system versions and
interfaces, shell command switches, shell command style (BSD vs GNU),
etc.  Anything pre-existing that would work properly here would be
great; but I feel this may be one of those things where in order to
really do it right (as in, aim for correctness instead of ease of
implimentation), we're just going to have to bite the bullet and tell
people that they simply have to maintain this information.



OK so anyway if you read this far into all that BS, you must somewhat
care.  Any insight is appreciated, go ahead and mail me.  There's no
site yet; I document this stuff deeply in a mediawiki run inside qemu on
my computer.  If there's a good handfull of interested individuals who
really want to have a go at it, have some really qualifying experience,
and most importantly actually have the available time AND the will to
commit to this project (this does not mean you're a CS student looking
for a way to get experience; this means you're like a Gnome hacker or
something and have extra time to spare on other projects, and like this
one), I'll consider opening a project page on Sourceforge and
transferring all current design documentation proper.

One last thing, I'm a businessman, I think like a businessman, I make
decisions like a businessman.  I will be placing strict considerations
that may not make sense to you into this project; for example some
people just don't get that Live/Install DVDs are not "The Answer"
because some of us don't want to download 1.2 gigs of data for something
that could have been done in half that.  Some of the considerations are
designed around advanced security systems with strict requirements for
program behavior, i.e. no runtime generated code.  I would not run my
business on compromises "because it's easier this way for the short run"
or "we probably can get away with not doing that," and I won't run a
project based on these shoddy and hackish practices either.  Things need
to be done right, they need to be done durable, and 30 years from now we
need to look back on the designs we put down today and say, "You know,
we hit that ALMOST dead on; but it didn't take very long or very much
work to get it perfect from there."  If you want to see a system built
on hack after hack after hack of what "looks good now" changing over the
years, install Windows ME.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD1LNWhDd4aOud5P8RAgH7AJ9oikeE2BLmhyaHq4/V3+qvKZqSJgCfaYJA
3InZfNm9g1bCPAb0xlp3nZ8=
=3s/Q
-----END PGP SIGNATURE-----
