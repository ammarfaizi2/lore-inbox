Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbTCVD20>; Fri, 21 Mar 2003 22:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261875AbTCVD20>; Fri, 21 Mar 2003 22:28:26 -0500
Received: from h-64-105-35-91.SNVACAID.covad.net ([64.105.35.91]:40136 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261874AbTCVD2Y>; Fri, 21 Mar 2003 22:28:24 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 21 Mar 2003 19:39:06 -0800
Message-Id: <200303220339.TAA08444@adam.yggdrasil.com>
To: kpfleming@cox.net
Subject: Re: small devfs patch for 2.5.65, plan to replace /sbin/hotplug
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Mar 2003, Kevin P. Fleming wrote [lines rewrapped 
to fit 80 columns]:
>Adam J. Richter wrote:
>> 	I believe that the only change in this version of devfs is
>> moving the code to invoke the user level devfs_helper program to a
>> separate file, fs/devfs/notify.c.  This change will simplify a future
>> code shrink inspired by David Brownell's suggesting that I think about
>> unifying hotplug with devfs.  In the future I would like to lift
>> fs/devfs/notify.c out of devfs so that the code that currently invokes
>> user level helpers for hot plug events can be replaced with two calls
>> to a renamed devfs_event() on
>> /sys/bus/<bustype>/devices/<bus#>/<whatever>, one for insertion and
>> one for removal.
>
>Are you still considering smalldevfs for 2.6 inclusion?

	Yes.  Andrew Morton has been very supportive of it and
just wants some more support for backward compatible names, perhaps
something as simple as shipping devfs_helper with an optional tar file
that could be unpacked in /dev as part of the boot process (along with
some documentation on setting this up), or a sample /etc/devfs.conf
for creating legacy names dynamically as needed.

>If not, then
>I'd like to discuss with you (and Greg KH) the possibility of just
>eliminating devfs entirely, and moving to a userspace version that is
>driven entirely by /sbin/hotplug.

	Even though I expect small devfs to get into both 2.6 and 2.7,
I would still be interested in discussing a userspace scheme.  When and
if such a scheme became reasonably reliable working code, I might
suppport removing devfs, depending on how it turned out.

>There are already adequate hotplug events generated in 2.5.65+

	You need lookup events, so that you can, for example, load
the floppy driver when the user looks up "/dev/floppy/0".

	Also I believe that the "devfs_event(eventname, dentry)"
syntax will result in slightly smaller kernel code, and the
"/sbin/devfs_helper eventname path" program invocation will avoid
potential problems with environment variable name space pollution.

	So, while perhaps we could eliminate the devfs filesystem in
favor of something driven by /sys, I would like to see something
closer to devfs_event() become the standard for notifying user space
of these events.  Note also that making devfs_event() into some kind
of trap facility in the core fs code will not work, because, for
hotplug events, you want to send the event *after* the relevant
directory has been populated, rather than when the diretory has
initially been created and is still empty.

>to
>create and remove all necessary /dev entries, other than /dev/console
>(and that gets created by the initramfs being unpacked).

	/dev entries are created by other events than just physical
device insertion.  For example, in my version of loop.c, only
/dev/loop/0 is initially created.  /dev/loop/1 is created when you
open /dev/loop/0.  /dev/loop/2 is created when you open /dev/loop/1,
and so on.  There are no corresponding physical insert and remove
events.

>If the devfs
>concept of "devfs_only" (no major/minor access to device drivers) is
>truly gone (as it appears to be),

	I expect this to come back.  I have not complained about
Christoph's changes because I don't believe in leaving unused code
in the distribution tree, but I have deliberately kept the extra
parameters on devfs_register for this purpose.

>then the userspace variant of devfs
>would be quite simple: process the hotplug event and read the
>appropriate information out of sysfs to get the dev_t for the device,
>then follow user-specified policies to create /dev entries.

	1. There is a chicken-and-egg issue with the initial root device,
you need to be able to unmount and remount /dev without getting a new
instance so that "cd /newroot && exec chroot . ./sbin/init" will work

	2. I would like to someday eliminate dev_t and have devices
referenced by name to eliminate number assignment problems, among
other things.  Making user space more aware of dev_t would impede
that.  A physical device may have many or no dev_t values associted
with it, and a dev_t may be associated with a combination of physical
devices.  Also, there are logical devices that might not have a
corresponding physical device.

	I think a better approach to a user space devfs driven by /sys
events would be look things up based on file name rather than some
kind of dev_t entry.  Also, a /sys-driven approach should not be
specific to char and block /dev entries, but rather all registrations
of software interfaces (block device, char device, network interface,
filesystem, etc.) at some new central point, so that registering a
new network interface or a new socket type could also be caught.


>Unless I'm missing something obvious, "devfs" could be just a synonym
>for a specific tmpfs instance, with no built-in behavior at all.


	In fs/devfs, I split interface.c from fs.c for this reason.
There is nothing specific to the devfs filesystem implemention in
interface.c.  You could conceivably set devfs_vfsmnt to any valid
vfsmnt, and device nodes would be created and deleted in that file
system.  The only obstacle with doing that on a disk filesystem is the
bootstrapping problem of mounting the filesystem in the first place.
I can think of only three special properties that the ramfs variant
in fs/defs/fs.c implements:

	1. It calls /sbin/devfs_helper for certain events.
	2. It can be instantiated early.
	3. It implements a single instance filesystem, so that the
	   contents of devfs are remembered if you unmount devfs
	   and remount it somewhere else.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
