Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264898AbSJ3Unz>; Wed, 30 Oct 2002 15:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264900AbSJ3Unz>; Wed, 30 Oct 2002 15:43:55 -0500
Received: from h-64-105-137-87.SNVACAID.covad.net ([64.105.137.87]:11757 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264898AbSJ3Uny>; Wed, 30 Oct 2002 15:43:54 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 30 Oct 2002 12:50:04 -0800
Message-Id: <200210302050.MAA02204@adam.yggdrasil.com>
To: sdake@mvista.com, torvalds@transmeta.com
Subject: Re: [PATCH] SCSI and FibreChannel Hotswap for linux 2.5.44-bk2
Cc: linux-kernel@vger.kernel.org, randy.dunlap@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	The usage messages and the corresponding routines are clutter.
They're cut when someone does this once because the incremental cost
is small, but people don't appreciate it adding up.  I think that if
every kernel facility did the same, it would undermine kernel
maintainability substantially.  So, as with spending other resources,
if you want to be frugal overall, you have to do things that seem more
disciplined than necessary on the small scale.

	If your interface were adding a usage message merely added a
literal string in the code and the this were an interface that people
without documentation handy were likely to use by hand a lot, I might
feel differently.  But this is an interface that is just going to be
accessed automatically by hotplug scripts with access to
documentation, and the interface that adds these messages adds 19
lines (including blank lines) per message to your source tree (4 to
declare the string, 1 to add a struct initializer to point to it, 14
for a separate _show routine), which comes to 114 lines for your
current six messages.  That's about two screens of source code in an
xterm that goes from the top the bottom of a monitor.

	Your answer to Randy Dunlap about why you're parsing device
ID, unit ID, etc. from user space is unconvincing.  I don't understand
why it should take anywhere near 10 milliseconds to open a file in
driverfs, procfs or devfs or any other file system that is completely
in RAM, given if you already know the full path.

	By the way, I also do not see why you really need to respond
within this time limit anyhow.  Hotplug removal generally has to
assume that it has been notified after the fact (i.e., it should not
try to touch the hardware).  So, even if there were a pressing time
limit, the task that is subject to that limit probably really is "turn
on an LED" or something similar.

	Although, I expect that the loops that covert from
<host#,id#,lun#> to pointers be eliminated totally if this interface
were hung off of some existing driverfs or procfs node corresponding
to the SCSI controller (for the _by_wnn interfaces) and SCSI device
(for _by_lun interfaces).  Failing that, however, the loops are
currently repetetive and at least be consolidated into common
routines (find_by_wnn, find_by_lun?).

	Thank you for writing the code though.  I hope this does
not discourage you from finding the energy to fix it.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
