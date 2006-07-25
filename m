Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWGYLZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWGYLZv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 07:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWGYLZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 07:25:51 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:969 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932315AbWGYLZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 07:25:50 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: swsusp status report
Date: Tue, 25 Jul 2006 13:25:14 +0200
User-Agent: KMail/1.9.3
Cc: Linux PM <linux-pm@osdl.org>, Pavel Machek <pavel@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607251325.14747.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following document describes the current state of the development of
swsusp: how it works, what known problems there are in it, which of them
are worked on and where some help is needed.

If there are no disasters, an updated report will be released in 3-4 months.

If you have any questions, comments, suggestions, please let me know.

Greetings,
Rafael


--
swsusp Status Report

I. Introduction

As you probably know, swsusp is the part of the kernel that deals with the
suspend to disk.  In other words, it is what gets compiled if you set
CONFIG_SOFTWARE_SUSPEND=y in .config.  However, the name 'software suspend'
does not mean it is independent of devices and, most importantly, device
drivers.  Moreover, swsusp is not an entirely autonomous subsystem, as it
shares some code with the other parts of the kernel.

This document is intended as an introductory presentation of the swsusp
design, the current (ie. as in the 2.6.18-rc2 kernel) state of the code,
the known problems with it etc.  For this reason I will first explain
how swsusp works and identify all of the distinct parts of it.  Then I will
describe each of these parts in detail and discuss the problems related to
it.

II. Outline

Currently there are two possible ways of carrying out a suspend to disk.
The first of them is entirely kernel-driven and the second one requires
a userland task that will drive the suspend procedure calling the kernel
to perform specific, more or less atomic, actions.  In this document
I will only cover the first method, because it is generally simpler
and the actions of the kernel are pretty much the same in both cases.

The kernel-driven method of suspending to disk is initiated by writing
'disk' to /sys/power/state.  Then, the kernel performs the following
actions:

(1) non-boot CPUs are taken off-line
(2) tasks are frozen
(3) some memory is released, if necessary
(4) devices are frozen
(5) atomic copy of the memory (aka suspend image) is created
(6) devices are woken up
(7) the suspend image is written to a swap partition
(8) the system is powered off

Of course all of this happens if there are no errors in the way.  However,
for example, if one of the devices refuses to freeze, we need to wake up
all of the devices that have already been frozen, thaw processes, and enable
non-boot CPUs.

The kernel-driven resume procedure may be started by booting the kernel with
the 'resume=<swap_partition>' command line parameter, where <swap_partition>
is the one the suspend image has been written to in step (7).  Then, the
following actions are performed:

(9) the suspend image is read into RAM
(10) devices are prepared to resume
(11) system memory state is restored from the suspend image
(12) devices are woken up
(13) tasks are thawed
(14) non-boot CPUs are enabled

Almost each of the steps (1)-(14) above is carried out by a separate part of
swsusp.

III. Handling of non-boot CPUs

Steps (1) and (14) above are completed with the help of the CPU hotplug
infrastructure which basically is external with respect to swsusp.  There were
some problems with this mechanism in the past, but currently it is generally
reported to work, even on 4-way machines.  Of course, it has not been tested
very much yet, as the number of SMP notebooks is quite limited, but this
is going to change shortly.  Anyway, if you have a problem with swsusp
that only appears for SMP kernels, please report it.

IV. Freezing and thawing tasks

Steps (2) and (13) are done by the code which is shared with the
suspend-to-RAM infrastructure on the majority of architectures that support
it (ppc is the only exception known to me) and which is called 'the freezer'.
It 'freezes' tasks by sending them fake 'freeze' signals in reaction to which
they should enter special function called 'the refrigerator' where they are
doing nothing in the TASK_UNINTERRUPTIBLE state, waiting for the freezer to
let them run again.  Userland processes are made enter the refrigerator by the
kernel's signal-handling code, but kernel threads should enter the
refrigerator voluntarily, by calling the function try_to_freeze() where
it is appropriate.  Moreover, kernel threads are only 'asked' to enter the
refrigerator after all of the userland processes have been frozen and sync()
is called before freezing any kernel threads.  A 'frozen' task is allowed
to return from the refrigerator when the freezer resets the PF_FROZEN flag for
it.

It follows from the above description that uninterruptible tasks cannot be
frozen.  Consequently, it is impossible to suspend, either to disk or to RAM,
if there are any uninterruptible tasks in the system (for this reason the
freezer has to wait for all of the vfork completions to be completed).

This mechanism generally works, although there are some known problems with
it.  First, there is an issue related to cifsd that refuses to freeze if it
has lost the connection to the server before suspend (eg. the network cable
has been disconnected) which is currently worked on (please refer to
http://bugzilla.kernel.org/show_bug.cgi?id=6811 for details).  There also is a
problem with the freezing of traced tasks that are waiting on breakpoints, but
this seems to have been nailed down already (please see
http://bugzilla.kernel.org/show_bug.cgi?id=6787).  Finally, it is reported
that calling sync() after userland processes have been frozen is not enough
to prevent some filesystems from writing data afterwards (apparently XFS does
this).  This currently is a pending issue.

If you know of any other problems with the freezer, please report them.

V. Freeing memory

Step (3) of the suspend procedure is completed by calling the same
functions that are normally used by kswapd, but in a slightly different way.
The part of swsusp responsible for that is referred to as 'the memory
shrinker' and it may sometimes be called by the suspend-to-RAM code as well,
so it should be treated as a shared piece of code.  It generally works (there
have been some bug fixes regarding it merged after 2.6.17), but it seems to be
inefficient if there are lots of slab objects to free.  Currently I do not know
how to fix this, so if you have any ideas, please help.

VI. Handling of devices

Steps (4), (6), (10), and (12) of the suspend-resume cycle are completed
in a large part by device drivers.  Thus as far as fixing problems related to
these steps is concerned, we have to rely on driver authors and maintainers.

Unfortunately the vast majority of reported problems with swsusp is related
the the freezing and/or waking up of devices.  The problems of this type
are also quite difficult to debug and fix, particularly because they are
often almost impossible to take care of without access to the hardware on
which they appear.  Worse yet, sometimes they only appear in specific hardware
configurations.  Therefore, if you report a problem related to the freezing or
waking up devices, or preparing them to resume, please always make sure that
the report will go to the appropriate driver maintainer and/or author.

The 'core' code responsible for the completion of steps (4), (6), (10),
and (12) is going to change.  Namely, step (10), i.e. the preparation of
devices for resume, is currently done in the same way as step (4), the
freezing of devices.  However, David Brownell noticed that in fact this was
not exactly correct, because it introduced an additional operation between
the freezing of devices in step (4) (before suspend) and waking them up
in step (12) (after resume).  For this reason he proposed to treat step (10)
in a different way and submitted patches that implement his idea.  These
patches are currently in the -mm tree.  Fortunately, the new approach will not
require any changes to the vast majority of drivers, because they do not need
to differentiate step (4) from step (10) anyway.  Still, there appear to be
some drivers that do need this and they will have to be modified in accordance
with the new core code.

The code that performs steps (4), (6), (10), and (12) of the suspend-resume
cycle is generally shared between swsusp and the suspend-to-RAM
infrastructure, but the suspend-to-RAM calls to the device drivers' suspend
routines are made with a different parameter value (PMSG_SUSPEND instead of
PMSG_FREEZE).  Also, since step (10) is not necessary for the suspend to RAM,
there generally are some swsusp-specific pieces of code in the device
drivers.

I must admit that there are many suspend-related or resume-related problems
with device drivers.  On almost every box I have recently tested, I have
had such problems with at least one device driver.  Still, we cannot do
very much about it without the help of the drivers' authors, unless the
drivers in question are very simple.

There also is one major limitation related to the code that freezes devices.
Namely, if some filesystems are mounted out of removable devices before
suspend, they will not be accessible after resume and the users may lose
data.  The problem is that for removable, or rather 'hotpluggable', devices
the 'freezing' or 'suspending' operation causes the device to disconnect,
as though it were physically disconnected from the system.  This currently is
a pending issue.

VII. Snapshotting memory and restoring its state

The snapshotting of memory, step (5), is completed by making a copy of each
memory page that needs to be saved.  For this purpose swsusp uses the
indentity kernel mapping which is a limitation on i386, because the high
memory cannot be accessed in the process.  Moreover, on i386 swsusp either
releases the highmem pages or copies their contents to the normal zone before
creating the suspend image.  This is inefficient, because for one saved
highmem page swsusp needs two pages in the normal zone, but I am going
to change this shortly.

Since each saveable page has to be copied, swsusp needs as much as 50% of
free RAM, or free normal zone on i386, to create the image.  This also is a
limitation, as it generally affects the system responsiveness after resume
and sometimes requires swsusp to free quite a lot of memory in step (3).
Still, there are many saveable pages in the system that will not be accessed
when processes are frozen, and in principle these pages could be included in
the suspend image without copying.  Unfortunately, however, I do not know
how to identify these pages in a reliable and fast way, so if you have any
ideas and/or hints, please help.

The code that restores the memory state from the suspend image in step
(11) also uses the kernel identity mapping to address memory, so it cannot
access highmem pages on i386, but it practically has no other limitations as
far as the image size is concerned.  In other words, it would be possible to
restore suspend images as big as 80% or even 90% of RAM, or the normal zone
on i386, if the 'snapshotting' code were able to create them.

The code that performs steps (5) and (11) of the suspend-resume cycle is
quite robust and there is only one known problem with it, which seems to
be x86_64-specific.  Namely, on x86_64 machines with more than 2 GB of RAM
there are memory gaps and/or reserved memory areas between the 2nd and 3rd
Gbyte of physical memory and swsusp tries to save these areas as though
they were RAM which leads to oopses.  This issue is now being worked on.

VIII. Saving and loading the suspend image

The suspend image is saved to a swap partition in step (7) of the
suspend-resume cycle and loaded from it in step (9) with the help of standard
block IO callbacks and/or functions designed for accessing swap devices and/or
swap files.  This code has not changed for a long time, but recently Andrew
Morton has made it use asynchronous IO (the patches are waiting in the -mm
tree now).

There are almost no problems with this part of swsusp.  There have been only
a couple of minor bugs found in it, and fixed, for the last 6 months.  Yet,
it has one major limitation which is that it can only use swap partitions
for saving the suspend image and only one swap partition can be used at a
time.  To overcome this limitation I am considering the addition of support
for swap files to this part of swsusp.

IX. Userland interface

Some users of the suspend-to-disk subsystem want it to be able to perform
certain transformations of the suspend image, like encryption and/or
compression, before it is saved.  Moreover, some of them would like the
suspend and resume code to use splash screens and display graphical
progress meters.  Still the idea of implementig these operations in the
kernel space is questionable, so it has been made possible to export the
suspend image out of the kernel.  This is the basic role of the swsusp
userland interface, which also allows a userland process to drive the
entire suspend and resume procedure.

The swsusp userland interface has been implemented as a special software
character device with appropriate file operations and some special ioctls.
It is described quite thoroughly in Documentation/power/userland-swsusp.txt,
so please refer to this document for details.  A reference implementation
of the userland tools that use this interface is available from
http://suspend.sf.net.

X. Reporting bugs and problems

If you find a bug in swsusp or have a problem related to it, please report
it, preferably on LKML with a Cc to suspend-devel@sourceforge.net.  You can
also use the kernel bugzilla in which case please add my e-mail address,
rjwysocki@sisk.pl, to the Cc list of your bug report.
