Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264796AbUDWMSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264796AbUDWMSm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 08:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264791AbUDWMSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 08:18:42 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:61910 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S264790AbUDWMSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 08:18:25 -0400
Date: Fri, 23 Apr 2004 21:18:16 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [Pcihpd-discuss] [RFC] New sysfs tree for hotplug
In-reply-to: <20040416223436.GB21701@kroah.com>
To: Greg KH <greg@kroah.com>
Cc: tokunaga.keiich@jp.fujitsu.com, lhcs-devel@lists.sourceforge.net,
       lhms-devel@lists.sourceforge.net,
       linux-hotplug-devel@lists.sourceforge.net,
       pcihpd-discuss@lists.sourceforge.net, lhns-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       acpi-largesys-devel@lists.sourceforge.net
Message-id: <20040423211816.152dc326.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20040415170939.0ff62618.tokunaga.keiich@jp.fujitsu.com>
 <20040416223436.GB21701@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for the comments:)

Greg KH wrote:
> > 2. Problem
> 
> There is no problem :)
> 
> >  Recent large machines have many PCI devices and some boards that
> > contain devices (e.g. CPU, memory, and/or I/O devices).  A certain PCI
> > device (PCI1) might be connected with other one (PCI2), which means that
> > there is a dependency between PCI1 and PCI2.
> 
> You have this today?  On what platform?  This is the first I have heard
> of this.  If needed, we can merely change the pci hotplug core to allow
> a hierarchy of pci slots.  Will that solve your problem?


I meant that a P2P bridge (that has hotpluggable slots) and a PCI device would
have such a dependency.  As you suggeted, if the PCI hotplug core is changed
that way, the dependency would be represented in sysfs quite well:)  However,
a board that contains CPU, memory and/or I/O devices still doesn't have a
directory in sysfs to represent dependencies... Actually, I'm focusing on hotplug
features for that kind of the boards, and making a patch that enables it. That
patch will be coming out soom.

 
> > 3. Suggestion
> > -------------
> >  To solve the problem, I'd like to propose the following idea.
> > 
> > ["hotplug" directory]
> >    This directory is to represent a hierarchy of hotpluggable devices.
> 
> Hm, no.  What about usb, firewire, scsi and any other future bus that
> can be "hotpluggable".  The kernel doesn't treat them differently, and
> we shouldn't either.
> 
> >   "hotpluggable device" means a device that can be powered off and
> >   removed physically from the system running.  The hierarchy describes a 
> >   dependency between each device.  This directory would be placed, like:
> > 
> >       /sys/devices/hotplug
> > 
> >   Any systems that enable hotplug (e.g. ACPI, DLPAR) can create their
> >   own directory right under the "hotplug" directory, like:
> > 
> >       /sys/devices/hotplug/acpi
> >       /sys/devices/hotplug/dlpar
> > 
> >   Each of systems can create directories and files under the own directory,
> >   and these directories should be easy for user to use.
> > 
> > 
> > [ACPI based Hotplug Case]
> >    I think that ACPI is one of the systems tha know dependencies of devices.
> 
> But it doesn't know about all devices in the system (like USB, firewire
> and others), so this would quickly break down.  I also don't like
> creating a solution that is so hard-wired for one firmware type like
> ACPI.  What about Open Firmware based machines?  Pure BIOS machines?  No
> firmware at all machines?  The current sysfs trees work just fine for
> all of them, without users having to figure out what the access type the
> kernel uses to get to the devices.


That's right.  /sys/devices/hotplug/ACPI/ tree becomes hard-wired one.  I was
thinking to define the board by using ACPI (as a "generic container device" in
ACPI namespace).  Therefore, if there is the new tree I proposed in the kernel,
it would be easy to represent the hierarchy, and a directory for the board
appears in the new tree.  So I thought that we could put an control file to
invoke the board hotplug and an information file under the directory.
(Actually, I've made a rough patch for the new tree and it seems to work fine:)
I also thought that interface for hotplug could be unified so that it would become
easier for user to use.

However, it's a hard-wired way and the current sysfs trees work fine for all of
devices as you mentioned.  Now I have just one thing necessary to sysfs.
That's a directory and files for the board.  Should I abstract the "board" and
introduce a new directory for board under /sys/devices/system/, like NUMA
node directory? (e.g. /sys/devices/system/board/)  The control file, the
information file, and etc could be created under the directory, like
/sys/devices/hotplug/board/board0/eject.  If it's possible, there might be less
impact to the kernel.  I'd appreciate it if you would comment on this :)


Thanks,
Kei
