Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966484AbWKTTbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966484AbWKTTbl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 14:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966491AbWKTTbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 14:31:41 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:54981 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S966484AbWKTTbk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 14:31:40 -0500
Date: Mon, 20 Nov 2006 14:31:39 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: linux1394-devel@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: deadlock in "modprobe -r ohci1394" shortly after "modprobe
 ohci1394"
In-Reply-To: <4560D2CA.9050000@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.44L0.0611201425380.7569-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2006, Stefan Richter wrote:

> > Knowing nothing at all about ieee1394, I get the feeling that the culprit
> > here is a strange subsystem design.  In fact, I don't understand exactly
> > what's going wrong.  Evidently the rmmod thread owns the locks for both
> > the host being removed and its parent, and it wants to stop knodemgrd,
> > which is waiting to acquire the host's parent's lock because it is
> > attempting to rescan the parent.  Is that right?
> 
> That's right.
> 
> > It doesn't make sense.  If knodemgrd is rescanning the parent then the 
> > parent must not have a driver.  If it doesn't have a driver, how can it 
> > have children?
> 
> Well, I don't fully understand the reasoning behind it. (But even less
> do I grasp the driver core.) Short story: It may indeed be possible to
> get rid of the parent relationship to the host device and of the
> rescanning of the host device. Long story:

Wait a minute.  Above you agreed that the problem was caused by knodemgrd 
attempting to rescan the host's _parent_.  So which is the focus of the 
deadlock: the host or its parent?

> ieee1394 has:
>  - struct hpsb_host (contains a struct device and a struct class_device)
> ieee1394's nodemgr in addition has:
>  - struct node_entry (ditto)
>  - struct unit_directory (ditto)
> 
> nodemgr also provides different .release callbacks for each of these
> devices and class_devices, an .uevent callback for unit_directory
> class_devices and the struct bus_type for the three kinds of device.
> 
> All of the existing protocol drivers bind only to unit_directories, so
> these are the most important ones as far as driver matching is
> concerned. (There is only a little out-of-tree driver, mem1394 for
> forensics, which binds differently because it doesn't require any actual
> protocol on a remote node.)
> 
> A hpsb_host is merely access to controllers; each one controls a bus. On
> a bus live a few node_entries, as many as there are nodes with an active
> link layer controller. This includes the local host, therefore there is
> always at least one node_entry per bus. A node may implement 0, 1 or
> more units and presents them in a hierarchical manner. A unit talks a
> protocol; and our protocol drivers access such a unit and, if the
> protocol has this necessity, the unit's node. (While doing so, it also
> accesses the hpsb_host in front of the node.)
> 
> If support for eth1394 is configured in, our drivers add a unit to each
> of the local nodes which indicate IP over 1394 capability to external
> nodes. This unit_directory also matches the eth1394 when the driver core
> scans the ieee1394_bus_type.
> 
> So in short, I think we could actually live with a minimum sysfs
> implementation which exposes only unit directories. (But I may be
> missing something --- I'm not quite familiar with the sysfs interfacing
> tools, that is udev and hald.) At least device file naming of SBP-2
> units wouldn't suffer because udev takes the unique name of SBP-2 units
> from a sysfs attribute of the SCSI device, not from the unit_directory's
> device.
> 
> The /sys/class/net/eth?/device links of eth1394 class devices currently
> point to the hpsb_host devices i.e. fw-host devices; maybe they could as
> well point to respective unit directories.
> 
> So maybe a simple, flat sysfs representation without node_entry devices,
> perhaps also without fw-host devices --- or at least a representation
> (1) without parent relationship to the fw-host devices and (2) without
> ieee1394_bus_type in fw-host devices --- is possible without breaking
> userspace. It probably would eliminate the problem which we are
> discussing here. This would mean that we loose the ability to bind
> protocol drivers to a hpsb_host (and depending on how far the
> respresentation is cut down, also the ability to bind protocol drivers
> to a node_entry). But as I said I see no actual need for this ability.

If I understand all this, you've got an hpsb_host, directly below which 
are one or more node_entry's, below each of which may be some 
unit_directory's.  Right?

But how is this relevant if the problem is caused by knodemgrd trying to 
rescan the hpsb_host's parent?

Is the problem caused by the fact that some of these struct device's 
aren't bound to a driver?  Remember, bus_rescan_devices() will skip over 
anything that already has a driver.  Could you solve your problem by 
adding a do_nothing driver that would bind to these otherwise unused 
devices?

Alan Stern

