Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266763AbSKWJDq>; Sat, 23 Nov 2002 04:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266810AbSKWJDp>; Sat, 23 Nov 2002 04:03:45 -0500
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:20415 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id <S266763AbSKWJDn>; Sat, 23 Nov 2002 04:03:43 -0500
Date: Sat, 23 Nov 2002 04:09:32 -0500 (EST)
From: Support <masud@googgun.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: A linux kernel-based security module. Request for feedback/comments.
Message-ID: <Pine.LNX.4.33.0211230155560.3842-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there:

Well we've managed to develop and (hopefully) stabalize a kernel based
security system, that implements a user-level auditing and control
facilities for Linux 2.4.x.  (currently ia32 architecture only) that
requires _no_ kernel source patching.

We're hoping that the linux kdev community can test it out and give some
feed back.

Preamble
--------

The security system is implemented as a lightweight loadable module
that provides two main control facilities:

== the ability to define a mapping that allows or disallows system-calls
on a per-uid basis.

== the ability to define effective-capabilities map on a per uid basis,
so
that whenever a user runs a process this map is or'd with the process's
ecap map. This occurs during entry into the system call.

and one minor one:

== the ability to declare whether the effective capility map
corrosponding to the ruid or the euid of the process should be used to
grant/revoke privileges. (See footnote 1)

http://www.googgun.com/praetordocs/praetor-security-model.html

How to use it?
--------------

Well,

http://www.googgun.com/praetordocs/praetor-proc-interface.html

Advantages/Why do this; a.k.a. shameless plug to all of you to test it :^)
--------------------------------------------------------------------------


[[[ this is rather winded but please consider it ]]]

I am going to list a few reasons why praetor was developed and what
advantages it can offer to users.

Because of the way Praetor is designed and implemented, it provides very
interesting facilities to help secure a system at the kernel level.

*** Allowing/disallowing system calls ***

Praetor provides a very simple, effective and conceptually easy way
to approach system security.

Assuming 'pat' is a bad bad evil evil person when it comes to network
services then:

"Disallow 'pat' socketcalls"  is a lot more intuitive and straightforward
(not to mention downright non-bypassable by pat - we assume pat is a
tricky guy(gal?)) than to set up the operating environment where network
applications are not accessable by pat, which is definitely a non-trivial
excersize.

*** Allowing particular capabilities on uid basis ***

Well, if you grant the 'http' user NET_BIND_SERVICE capability during
webserver startup you no longer have to have even the primary web process
launched as root.

To that ofcourse you would object and say chattr the httpd; however that
is currently limited by various filesystem implementations (ext2 i believe
is the only one currently that supports capabilities attributes on
executables??).


**** time limited access ****

Praetor evaluates security access through every entry into KS. Which gives
a very interesting extension to the above; namely you can grant and
revoke access along some type of synchronization mechanism;

SYSTEM CALLS: You can simply extend a crontab that loads a different map
for morning and evening for the user 'pat' because pat behaves him/herself
during daytime but it's usually the night air that brings out her network
abuse tendencies.  because this affects the exiting processes as well as
any new processes lauched by pat, we are protected from patantics.

CAPABILITIES: For instance, an issue with chattr'd executables is that the
capability is permanently etched. On the other hand, if you are able to
grant that ability on the fly to the user and then revoke that capability
as soon as the well-known port is opened by the server you limit the
damage any one can do if they happen to obtain httpd user privileges.

Note that chattr'ing the file before and after exec is not sufficient,
especially for services where the caps are inheritable.

****  For kernel developers ****

- Well one of my goals in developing Praetor was to produce a security
system that is _not_ a kernel source patch; Two reasons dictated this
approach
	(1) need to be able to install and run this system without
	rebooting a system. Kmod interface exists, why not use it
	to its max???

	(2) more importantly, kernel code is tested, introducing yet
	another complication in the middle of source code tends to be
	cumbersome for everyone involved.

- This one occured to me and addresses the concern of upgrading because of
security patches in regard to the problem that creeped out a few days back
about the ptracing nested tasks.

Because this module can be loaded on stock kernels (i.e. requires no
kernel patching at all)  users who are not able to - or find it highly
undesirable to upgrade their kernels right away, could load this module
and simply disallow ptrace system call to all users that they distrust.
Effectively encapsulating DoS attack until they get around to upgrading
the kernel.

This in turn, can potentially take pressures off the kernel developers to
come up with a fix "right away" for a large class of security related
problems.  While the bug above only had a 3 line fix in in one file,
tracking down some of the more involved problems may take time, and this
can buy that time for every one.

Why test it?
------------

Well i need to know of potential issues with this approach and i would be
eternally greatful for any help in this regard.

And ofcourse it's a really really fun piece of code and brings happy
thoughts to all who test/use it. :-)

Known Issues
------------

1) After deactivation, the module still may not deactivate for a while,
this is because processes that are blocked in a system call will still
keep the module busy until they exit.

2) If there is a massive ammount of processes that die right away (a la
kill -9 -1 or something like that) the module will remain busy, and not
be unloadable, even though you can deactivate it completely.  (This is a
feature not a bug ??)

Links
-----

Kernel module source code is available from:

	http://www.googgun.com/downloads/praetor/praetorkm-1.0.tar.bz2

or if you prefer gzip

	http://www.googgun.com/downloads/praetor/praetorkm-1.0.tar.gz

Documentation link:

	http://www.googgun.com/praetordocs/praetor.html


Caveats and notes
-----------------

The core technology and the kernel module are open source and distributed
under a GPL'ish open source license. You can copy, modify, redistribute it
under the regular open source sense.  The entire security implement is
under covered by this license.

There is a commercial userspace tool which eases configuration, but please
understand that this tool is _NOT_ required to use the security module at
all. All the userspace tool essentially does is write strings or read
strings from the /proc interface.  However, (if) it will ease your testing
process, (so) please feel free to drop me a note and I will issue
a license to you allowing you to use it.



Foot notes
==========

1 - Currently the distinction between euid/ruid is only made when making a
decision about the effective/allowed cap map for a process. However it is
trivial to implement logic that also makes a distinction between the
system-call access map of a ruid or an euid.

Thank you all, best regards,

Ahmed Masud


-----------------------------------------------------------------------------
Googgun technologies inc.

http://www.googgun.com/



