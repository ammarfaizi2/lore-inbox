Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbUKHSTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbUKHSTW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 13:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbUKHSQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 13:16:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:28574 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261167AbUKHSNq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 13:13:46 -0500
Date: Mon, 8 Nov 2004 10:13:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christian Kujau <evil@g-house.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alsa-devel@lists.sourceforge.net, linux-sound@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: Oops in 2.6.10-rc1
In-Reply-To: <418F6E33.8080808@g-house.de>
Message-ID: <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org>
References: <4180F026.9090302@g-house.de> <Pine.LNX.4.58.0410281526260.31240@pnote.perex-int.cz>
 <4180FDB3.8080305@g-house.de> <418A47BB.5010305@g-house.de>
 <418D7959.4020206@g-house.de> <Pine.LNX.4.58.0411062244150.2223@ppc970.osdl.org>
 <20041107130553.M49691@g-house.de> <418E4705.5020001@g-house.de>
 <Pine.LNX.4.58.0411070831200.2223@ppc970.osdl.org> <20041107182155.M43317@g-house.de>
 <418EB3AA.8050203@g-house.de> <Pine.LNX.4.58.0411071653480.24286@ppc970.osdl.org>
 <418F6E33.8080808@g-house.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Nov 2004, Christian Kujau wrote:
> 
> > Anyway, now that the _other_ driver also oopses, and with a very similar 
> > oops too, so it looks like they both depended on some undocumented (or 
> > changed) detail in the PCI layer. Next step would be to see if the thing 
> > that breaks is this merge:
> 
> may i ask how you come to this conclusion? by technical knowledge or could
> this be deduced by some bk magic too?

No, just gut feel. If the pre-merge ALSA works, and the post-merge one 
doesn't, and the oops in both cases happen somewhere close to where it 
does "pci_enable_device()", there's not a lot left. There are interrupts, 
and there is the PCI layer...

> > 	ChangeSet@1.2463, 2004-11-04 17:07:16-08:00, torvalds@ppc970.osdl.org
> > 	  Merge bk://kernel.bkbits.net/gregkh/linux/driver-2.6
> > 	  into ppc970.osdl.org:/home/torvalds/v2.6/linux
> > 
> > which merges Greg's PCI/driver model changes.
> > 
> > It's all the same steps you took with the ALSA merge, you're a
> > professional by now ;)
> 
> i did "bk undo -a1.2463" from a current -BK tree and it oopses:

Note that "bk undo -axxx" will _leave_ xxx in place, and undo everything 
after. 

So what you did still has the merge in the tree, and that it still oopses 
is thus to be expected. BUT, we're getting closer.

> next i wanted to do "bk undo -r1.2463" now to see if it does *not* break
> without this ChangeSet (because i already know it *breaks* with this
> ChangeSet) but that would leave some parentless child deltas. i read in
> the BK docs that "bk cset -x<version>" would help here. but "bk cset
> - -x1.2463" aborts:

"cset -x" only works on patches, not on complex operations. You still want 
"bk undo", but you want to use "bk revtool" to see what the merge point 
was, and tell _which_ of the merged top-of-trees you want to get to. 

In other words, you can't just undo a merge, you need to tell which _way_
to undo it. See? It does actually make sense, and "bk revtool" will show 
you the relationships of merges (at least if the time range is big enough 
to show enough info).

Anyway, if you have the top-of-tree-is-1.2463, then go to "bk revtool", 
and select that node in the graph by clicking on it. Notice how those 
edges turned white, and you can now easily see which children were 
pre-merge.

In this case, the top-of-tree tree _without_ the PCI merge is 1.2642:

	ChangeSet@1.2462, 2004-11-04 17:06:13-08:00, torvalds@ppc970.osdl.org
	  Merge bk://kernel.bkbits.net/gregkh/linux/usb-2.6
	  into ppc970.osdl.org:/home/torvalds/v2.6/linux

(you won't see it in "bk changes", since it's a trivial merge: use "bk 
changes -a" to see it). So just before I merged Greg's PCI changes, I 
merged his USB changes.

Now, that's fine - the USB merge is likely to be ok, so try doing

	bk undo -a1.2462

and you will now have a tree that is exactly the same as before, except it 
does _not_ have the PCI merge from Greg.

And if this one does not oops, you can now officially blame Greg.

Now, if you want to get _really_ fancy, you can now look at each changeset 
that differed, with something like

	bk set -n -d -r1.2462 -r1.2463 | bk -R prs -h -d'<:P:@:HOST:>\n$each(:C:){\t(:C:)\n}\n' -

which is black magic that does a set operation and shows all the changes 
in between the sets of "bk at 1.2462" and "bk at 1.2463".

(This is _not_ the same as "bk changes -r1.2462..1.2463", because that one 
just shows the single merge change that is on the direct _path_ from one 
changeset to another. The black magic thing shows the set difference of 
changesets that comes from the full graph at two points).

Then you can look at each change individually and see if they matter.

And once you can do the set operations, you're officially a BK poweruser.  
Me, I just have a script, I'm a BK dabbler.

Looking at the list (appended), I don't see anything obvious, but hey, if 
it was obvious it wouldn't have been merged in the first place. 

Thanks for your willingness to pursue this thing,

		Linus

-----
<maneesh@in.ibm.com>
	[PATCH] sysfs: fix sysfs backing store error path confusion
	
	o sysfs_new_dirent to retrun 0 if kmalloc fails. Thanks to Milton Miller
	  for spotting this.
	
	Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
	Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

<bunk@stusta.de>
	[PATCH] small sysfs cleanups
	
	The patch below does the following cleanups for the sysfs code:
	- remove the unused global function sysfs_mknod
	- make some structs and functions static
	
	Please check whether this patch is correct, or whether some of the
	things I made static should be used globally in the forseeable future.
	
	
	Signed-off-by: Adrian Bunk <bunk@stusta.de>
	Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

<kay.sievers@vrfy.org>
	[PATCH] add the physical device and the bus to the hotplug environment
	
	Add the sysfs path of the physical device to the hotplug event of class
	and block devices. This should solve the userspace issue not to know if
	the device is a virtual one and the "device" symlink will never be created,
	but we sit there and wait for it to show up not knowing when we should
	give up.
	
	Also the bus name is added to the hotplug event, so we don't need to
	reverse lookup in the /sys/bus/* directory which bus our physical
	device belongs to. This is e.g. the value matched against the BUS= key,
	that may be used in an udev rule.
	
	This is a PCI network card:
	  ACTION=add
	  SUBSYSTEM=net
	  DEVPATH=/class/net/eth0
	  PHYSDEVPATH=/devices/pci0000:00/0000:00:1e.0/0000:02:01.0
	  PHYSDEVBUS=pci
	  INTERFACE=eth0
	  SEQNUM=827
	  PATH=/sbin:/bin:/usr/sbin:/usr/bin
	  HOME=/
	
	This is a IDE CDROM:
	  ACTION=add
	  SUBSYSTEM=block
	  DEVPATH=/block/hdc
	  PHYSDEVPATH=/devices/pci0000:00/0000:00:1f.1/ide1/1.0
	  PHYSDEVBUS=ide
	  SEQNUM=1017
	  PATH=/sbin:/bin:/usr/sbin:/usr/bin
	  HOME=/
	
	This is an USB-stick partition:
	  ACTION=add
	  SUBSYSTEM=block
	  DEVPATH=/block/sda/sda1
	  PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.1/usb3/3-1/3-1:1.0/host1/target1:0:0/1:0:0:0
	  PHYSDEVBUS=scsi
	  SEQNUM=1032
	  PATH=/sbin:/bin:/usr/sbin:/usr/bin
	  HOME=/
	
	
	Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
	Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

<tj@home-tj.org>
	[PATCH] driver-model: comment fix in bus.c
	
	 df_01_driver_attach_comment_fix.patch
	
	bus_match() was renamed to driver_probe_device() but the comment for
	device_attach() wasn't updated.  This patch updates it.
	
	
	Signed-off-by: Tejun Heo <tj@home-tj.org>
	Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

<tj@home-tj.org>
	[PATCH] driver-model: bus_recan_devices() locking fix
	
	 df_02_bus_rescan_devcies_fix.patch
	
	 bus_rescan_devices() eventually calls device_attach() and thus
	requires write locking the corresponding bus.  The original code just
	called bus_for_each_dev() which only read locks the bus.  This patch
	separates __bus_for_each_dev() and __bus_for_each_drv(), which don't
	do locking themselves, out from the original functions and call them
	with read lock in the original functions and with write lock in
	bus_rescan_devices().
	
	
	Signed-off-by: Tejun Heo <tj@home-tj.org>
	Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

<tj@home-tj.org>
	[PATCH] driver-model: sysfs_release() dangling pointer reference fix
	
	 df_03_sysfs_release_fix.patch
	
	Some attributes are allocated dynamically (e.g. module and device
	parameters) and are usually deallocated when the assoicated kobject is
	released.  So, it's not safe to access attr after putting the kobject.
	
	
	Signed-off-by: Tejun Heo <tj@home-tj.org>
	Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

<tj@home-tj.org>
	[PATCH] driver-model: kobject_add() error path reference counting fix
	
	 df_04_kobject_add_ref_fix.patch
	
	In kobject_add(), @kobj wasn't put'd properly on error path.  This
	patch fixes it.
	
	
	Signed-off-by: Tejun Heo <tj@home-tj.org>
	Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

<tj@home-tj.org>
	[PATCH] driver-model: device_add() error path reference counting fix
	
	 df_05_device_add_ref_fix.patch
	
	 In device_add(), @dev wan't put'd properly when it has zero length
	bus_id (error path).  Fixed.
	
	
	Signed-off-by: Tejun Heo <tj@home-tj.org>
	Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

<greg@kroah.com>
	kevent: fix build error if CONFIG_KOBJECT_UEVENT is not selected.
	
	Thanks to Serge Hallyn <serue@us.ibm.com> for pointing this out.
	
	Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

<rml@novell.com>
	[PATCH] kobject_uevent: fix init ordering
	
	Looks like kobject_uevent_init is executed before netlink_proto_init and
	consequently always fails.  Not cool.
	
	Attached patch switches the initialization over from core_initcall (init
	level 1) to postcore_initcall (init level 2).  Netlink's initialization
	is done in core_initcall, so this should fix the problem.  We should be
	fine waiting until postcore_initcall.
	
	Also a couple white space changes mixed in, because I am anal.
	
	Signed-Off-By: Robert Love <rml@novell.com>
	Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

<rml@novell.com>
	[PATCH] kobject_uevent: add MAINTAINER entry
	
	Attached patch adds a MAINTAINER entry for the kernel event layer.
	
	
	Signed-Off-By: Robert Love <rml@novell.com>
	Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

<greg@kroah.com>
	Merge kroah.com:/home/greg/linux/BK/bleed-2.6
	into kroah.com:/home/greg/linux/BK/driver-2.6

<maneesh@in.ibm.com>
	[PATCH] fix kernel BUG at fs/sysfs/dir.c:20!
	
	On Thu, Nov 04, 2004 at 12:52:38PM -0800, Greg KH wrote:
	> Hi,
	>
	> I get the following BUG in the sysfs code when I do:
	> 	- plug in a usb-serial device.
	> 	- open the port with 'cat /dev/ttyUSB0'
	> 	- unplug the device.
	> 	- stop the 'cat' process with control-C
	>
	> This used to work just fine before your big sysfs changes.
	
	There is a similar problem reported by s390 people where we see parent
	kobject (directory) going away before child kobject (sub-directory). It
	seems kobject code is able to handle this, but not the sysfs. What could
	be happening that in sysfs_remove_dir() of parent directory, we try to
	remove its contents. It works well with the regular files as it is the
	final removal for sysfs_dirent corresponding to the files. But in case
	of sub-directory we are doing an extra sysfs_put().  Once while removing
	parent and the other one being the one from when sysfs_remove_dir() is
	called for the child.
	
	The following patch worked for the s390 people, I hope same will work in
	this case also.
	
	
	o Do not remove sysfs_dirents corresponding to the sub-directory in
	  sysfs_remove_dir(). They will be removed in the sysfs_remove_dir() call
	  for the specific sub-directory.
	
	Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
	Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

<torvalds@ppc970.osdl.org>
	Merge bk://kernel.bkbits.net/gregkh/linux/driver-2.6
	into ppc970.osdl.org:/home/torvalds/v2.6/linux

