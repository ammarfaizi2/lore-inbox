Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263750AbUDZF62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263750AbUDZF62 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 01:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264442AbUDZF62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 01:58:28 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:41093 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263750AbUDZF6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 01:58:24 -0400
Date: Mon, 26 Apr 2004 14:58:08 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [Pcihpd-discuss] [RFC] New sysfs tree for hotplug
In-reply-to: <20040423200751.GA7990@kroah.com>
To: Greg KH <greg@kroah.com>
Cc: tokunaga.keiich@jp.fujitsu.com, linux-kernel@vger.kernel.org
Message-id: <20040426145808.4ed2a7b0.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20040415170939.0ff62618.tokunaga.keiich@jp.fujitsu.com>
 <20040416223436.GB21701@kroah.com>
 <20040423211816.152dc326.tokunaga.keiich@jp.fujitsu.com>
 <20040423200751.GA7990@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Apr 2004 13:07:51 -0700, Greg KH <greg@kroah.com> wrote:
> On Fri, Apr 23, 2004 at 09:18:16PM +0900, Keiichiro Tokunaga wrote:
> > Greg KH wrote:
> > > > 2. Problem
> > > 
> > > There is no problem :)
> > > 
> > > >  Recent large machines have many PCI devices and some boards that
> > > > contain devices (e.g. CPU, memory, and/or I/O devices).  A certain PCI
> > > > device (PCI1) might be connected with other one (PCI2), which means that
> > > > there is a dependency between PCI1 and PCI2.
> > > 
> > > You have this today?  On what platform?  This is the first I have heard
> > > of this.  If needed, we can merely change the pci hotplug core to allow
> > > a hierarchy of pci slots.  Will that solve your problem?
> > 
> > 
> > I meant that a P2P bridge (that has hotpluggable slots) and a PCI device would
> > have such a dependency.
> 
> But you don't need to show that for any reason, right?   Today, pci
> slots behind a pluggable P2P bridge work just fine.  I can remove the
> entire drawer full of pci slots and they all go away properly, and if I
> add a new drawer of pci slots, they all show up.
> 
> Why do you want to show that hierarchy?  Who cares about it?
> 
> > As you suggeted, if the PCI hotplug core is changed that way, the
> > dependency would be represented in sysfs quite well:)
> 
> I don't think the PCI Hotplug core needs to change today to support
> these kinds of devices based on the hardware I have seen.  I have spoken
> to some people from other companies, and they also agree with me.  But
> if you have some different kind of hardware that really needs this, I'm
> open to ideas.

I have to say two things here.  First of all, I misunderstood that
PCI slots behind a pluggable P2P bridge didn't work.  I'm sorry
about it.  Second of all, I proposed the hierarchy just because I
thought it's nice for user, but I don't push this any more:).  I agree
with you that the PCI Hotplug core doesn't need to change.
 
> > However, a board that contains CPU, memory and/or I/O devices still
> > doesn't have a directory in sysfs to represent dependencies...
> 
> Why would it need to?

Please see my comment on this part below.
 
> Right now you can determine the CPU that a pci bus is attached to
> through sysfs.  As for the CPU and memory depiction, talk to the NUMA
> developers.  They have been trying for years now to come up with a way
> to do this in a portable and proper manner, and so far have failed :(
> 
> > 
> > That's right.  /sys/devices/hotplug/ACPI/ tree becomes hard-wired one.  I was
> > thinking to define the board by using ACPI (as a "generic container device" in
> > ACPI namespace).  Therefore, if there is the new tree I proposed in the kernel,
> > it would be easy to represent the hierarchy, and a directory for the board
> > appears in the new tree.  So I thought that we could put an control file to
> > invoke the board hotplug and an information file under the directory.
> > (Actually, I've made a rough patch for the new tree and it seems to work fine:)
> 
> Patches are better seen than spoken about in the abstract :)  Please
> post them if you have them...
> 
> > I also thought that interface for hotplug could be unified so that it would become
> > easier for user to use.
> 
> But the user doesn't care about ACPI.  Actually they want nothing to do
> with ACPI namespaces :)  They just want to be able to add and remove
> their different devices, be them memory, cpus, or pci slots, right?
> 
> I'd point you to the recent ACPI sysfs patches on linux-kernel for more
> information on what people are trying to do in that area.
> 
> > However, it's a hard-wired way and the current sysfs trees work fine for all of
> > devices as you mentioned.  Now I have just one thing necessary to sysfs.
> > That's a directory and files for the board.  Should I abstract the "board" and
> > introduce a new directory for board under /sys/devices/system/, like NUMA
> > node directory? (e.g. /sys/devices/system/board/)  The control file, the
> > information file, and etc could be created under the directory, like
> > /sys/devices/hotplug/board/board0/eject.  If it's possible, there might be less
> > impact to the kernel.  I'd appreciate it if you would comment on this :)
> 
> But writing to that "eject" file would not be able to go and turn off
> the different CPU's, memory sticks, and pci slots, right?  That still
> needs to be done from userspace.

I think it depends on a hotplug driver that is invoked when writing to
a "eject" file.  In the board case, a board hotplug driver (I'm making) 
handles those CPUs, memory, and PCI slots on the board.  So my
story for board hotplug is:

  - user checks/knows what resources are on the board (dependency)
  - user writes to the "eject" file of the board properly (invocation)

I'm expecting the first one would be available with sysfs (e.g. a hierarchy,
an information file, etc). Plus, the "eject" file would be created in sysfs.

Thanks,
Kei
