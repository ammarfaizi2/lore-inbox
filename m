Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266040AbUBJTTr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 14:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266074AbUBJTTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 14:19:31 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:42891 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S266040AbUBJTSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 14:18:43 -0500
Subject: Re: ATARAID userspace configuration tool
From: Christophe Saout <christophe@saout.de>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
In-Reply-To: <40292246.2030902@backtobasicsmgmt.com>
References: <Pine.LNX.4.40.0402101405190.25784-100000@jehova.dsm.dk>
	 <1076425115.23946.18.camel@leto.cs.pocnet.net>
	 <40292246.2030902@backtobasicsmgmt.com>
Content-Type: text/plain
Message-Id: <1076440714.27328.8.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 10 Feb 2004 20:18:34 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di, den 10.02.2004 schrieb Kevin P. Fleming um 19:26:

> > I have a really bad idea :)
> > 
> > Try to combine it with udev. udev calls the ide script, the ide script
> > then calls the ataraid detector. If the device is non-ataraid, go on as
> > usual. If it is, build the device-mapper device and symlink (if it
> > doesn't already exist) and tell udev to not create anything.
> 
> This is not a bad idea, it's the future.

I was just joking. I said that because it's not complete.

> The hotplug mechanism is 
> exactly what should be used here. When a block-device hotplug ADD event 
> occurs, you look at that device to see if it's something you care about. 
> If not, just exit and leave it alone.

udev maintains a database of already created devices. And sysfs is some
sort of database of really existing devices. The "telling udev to not
create the device and instead create it ourself" is bad. We should be
able to tell udev that it should register and create another device
instead. Perhaps udev should know about compound devices.

I'm not sure but if udev knows about compound devices things get a bit
more complicated. A raid 1 setup would continue to work if one of the
devices is unplugged, a raid 0 setup fails to work if one device is
missing. Probably the device should be deleted only when both hard disks
are removed. Also it should be created if only one hard disk gets
plugged in. But on bootup if some script tells udev that one hard disk
is there and some seconds later that the second is also there the tool
shouldn't assume the raid has failed after seeing the first event.

Should we Cc an udev developer for an opinion?

> Now in the ATARAID case, where you need to see multiple devices before 
> you can do anything with them, this means you'd need to keep some 
> "state" somewhere about the devices you've seen so far, and the partial 
> ATARAID devices they represent. When you get the hotplug event for the 
> last piece of a particular ATARAID device, you use DM/MD to set up the 
> device and make it available.

As I said I think it is more complicated.

> The wonderful part of this is, when you do that last step, _another_ 
> block-device hotplug ADD event occurs for the new device you just 
> created, and if the hotplug scripts are set up to run dmpartx or its 
> equivalent for new block-devices, you are done.

Right. dmpartx should run on dm-[0-9]* and md[0-9]* events (but not
recursively of course ;)).

>  The partition tables 
> _inside_ the ATARAID device will be read, more DM calls will be made to 
> make those sub-devices available to userspace and everyone is thrilled 
> about the elegance of the solution :-)

Yes, sounds cool.


