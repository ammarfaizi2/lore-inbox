Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbTIXVux (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 17:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbTIXVux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 17:50:53 -0400
Received: from mail.kroah.org ([65.200.24.183]:3247 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261556AbTIXVuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 17:50:50 -0400
Date: Wed, 24 Sep 2003 14:18:23 -0700
From: Greg KH <greg@kroah.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: Does sysfs really provides persistent hardware path to devices?
Message-ID: <20030924211823.GA11234@kroah.com>
References: <E19odOM-000NwL-00.arvidjaar-mail-ru@f22.mail.ru> <20030818204218.GA3220@kroah.com> <200308311453.00122.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308311453.00122.arvidjaar@mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 02:54:06PM +0400, Andrey Borzenkov wrote:
> On Tuesday 19 August 2003 00:42, Greg KH wrote:
> > On Mon, Aug 18, 2003 at 10:21:22AM +0400, "Andrey Borzenkov"  wrote:
> > > just to show what I expected from sysfs - here is entry from Solaris
> > > /devices:
> > >
> > > brw-r-----   1 root     sys       32,240 Jan 24  2002
> > > /devices/pci@16,4000/scsi@5,1/sd@0,0:a
> > >
> > > this entry identifies disk partition 0 on drive with SCSI ID 0, LUN 0
> > > connected to bus 1 of controller in slot 5 of PCI bus identified
> > > by 16. Now you can use whatever policy you like to give human
> > > meaningful name to this entry. And if you have USB it will continue
> > > further giving you exact topology starting from the root of your
> > > device tree.
> > >
> > > and this path does not contain single logical id so it is not subject
> > > to change if I add the same controller somewhere else.
> > >
> > > hopefully it clarifies what I mean ...
> >
> > Hm, a bit.  First, have you looked at what sysfs provides?  Here's one
> > of my machines and tell me if it has all the info you are looking for:
> >
> > $ tree /sys/bus/scsi/
> > /sys/bus/scsi/
> >
> > |-- devices
> > |   `-- 0:0:0:0 ->
> > | ../../../devices/pci0000:00/0000:00:1e.0/0000:02:05.0/host0/0:0:0:0
>                                                               ^ ^unstable         

Heh, so are the pci ids in that link too :)

> Now I have to ask - do we discuss udev-0.2 (what I currently have) or 
> udev-as-it-can-be-in-fututure?

Either is fine with me.

> In udev-0.2 I cannot do it. I can say I want
> 
> TOPOLOGY, BUS="scsi", place="0.0.0.0", NAME="jaz"
> 
> but the next time I plug in SCSI card the host number changes. Even after I 
> unplug USB stick and plug it again it gets new host number.
> 
> And the same applies to USB, PCI and whatever. Sysfs exports entity numbers as 
> kernel enumerates them; while Solaris exports persistent device tree leaving 
> enumeration to user-level tools. Which means that if hardware changes for 
> whatever reason enumeration changes as well and your config becomes invalid. 

I agree.  That's why topology is only one part of the rules, and is so
low in the chain of hierarchy of what to match on.  To recap, here is
the hierarchy:
	1 - label or serial number
	2 - bus device number
	3 - topology on bus
	4 - replace name
	5 - kernel name

So, if you do not have something that matches for your device for rules
1 or 2, then use 3.  But yes, it can change.  So can any of these items,
that's why we have to be flexible.

And yes, we should add wild card matching for topology rules, it's on
the todo list, I haven't had much time to work on udev lately.

> > Hope this helps,
> >
> 
> Well, we did not move a tiny bit since the beginning of this thread :) You 
> still did not show me namedev configuration that implements persistent name 
> for a device based on its physical location :)))

Ok, do you have any other ideas of how to do this?

And patches for udev are always welcome :)

thanks,

greg k-h
