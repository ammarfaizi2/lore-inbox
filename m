Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266179AbUAQUi7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 15:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266184AbUAQUi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 15:38:59 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:13574 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S266179AbUAQUiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 15:38:52 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Greg KH <greg@kroah.com>
Subject: Re: Does sysfs really provides persistent hardware path to devices?
Date: Sat, 17 Jan 2004 23:34:13 +0300
User-Agent: KMail/1.5.3
Cc: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
References: <E19odOM-000NwL-00.arvidjaar-mail-ru@f22.mail.ru> <200308311453.00122.arvidjaar@mail.ru> <20030924211823.GA11234@kroah.com>
In-Reply-To: <20030924211823.GA11234@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401172334.13561.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 September 2003 01:18, Greg KH wrote:
> On Sun, Aug 31, 2003 at 02:54:06PM +0400, Andrey Borzenkov wrote:
> > On Tuesday 19 August 2003 00:42, Greg KH wrote:
> > > On Mon, Aug 18, 2003 at 10:21:22AM +0400, "Andrey Borzenkov"  wrote:
> > > > just to show what I expected from sysfs - here is entry from Solaris
> > > > /devices:
> > > >
> > > > brw-r-----   1 root     sys       32,240 Jan 24  2002
> > > > /devices/pci@16,4000/scsi@5,1/sd@0,0:a
> > > >
> > > > this entry identifies disk partition 0 on drive with SCSI ID 0, LUN 0
> > > > connected to bus 1 of controller in slot 5 of PCI bus identified
> > > > by 16. Now you can use whatever policy you like to give human
> > > > meaningful name to this entry. And if you have USB it will continue
> > > > further giving you exact topology starting from the root of your
> > > > device tree.
> > > >
> > > > and this path does not contain single logical id so it is not subject
> > > > to change if I add the same controller somewhere else.
> > > >
> > > > hopefully it clarifies what I mean ...
> > >
> > > Hm, a bit.  First, have you looked at what sysfs provides?  Here's one
> > > of my machines and tell me if it has all the info you are looking for:
> > >
> > > $ tree /sys/bus/scsi/
> > > /sys/bus/scsi/
> > >
> > > |-- devices
> > > |   `-- 0:0:0:0 ->
> > > | ../../../devices/pci0000:00/0000:00:1e.0/0000:02:05.0/host0/0:0:0:0
> >
> >                                                               ^ ^unstable
>
> Heh, so are the pci ids in that link too :)
>

I am not sure if you are just making fun here. No, in _this_ link pci ids are 
not unstable because I do not have hotpug PCI. But SCSI hosts are unstable:

{pts/0}% LC_ALL=C ll /sys/class/scsi_host/*/device
lrwxrwxrwx    1 root     root           71 Jan 17 22:59 
/sys/class/scsi_host/host7/device -> 
../../../devices/pci0000:00/0000:00:1f.4/usb2/2-2/2-2.4/2-2.4:1.0/host7/
lrwxrwxrwx    1 root     root           29 Jan 17 23:19 
/sys/class/scsi_host/host8/device -> ../../../devices/legacy/host8/

after unplugging and replugging USB stick:

pts/0}% LC_ALL=C ll /sys/class/scsi_host/*/device
lrwxrwxrwx    1 root     root           29 Jan 17 23:19 
/sys/class/scsi_host/host8/device -> ../../../devices/legacy/host8/
lrwxrwxrwx    1 root     root           71 Jan 17 23:25 
/sys/class/scsi_host/host9/device -> 
../../../devices/pci0000:00/0000:00:1f.4/usb2/2-2/2-2.4/2-2.4:1.0/host9/

host7 became host9

[... skipped as obsolete now...]
>
> And yes, we should add wild card matching for topology rules, it's on
> the todo list, I haven't had much time to work on udev lately.
>
> > > Hope this helps,
> >
> > Well, we did not move a tiny bit since the beginning of this thread :)
> > You still did not show me namedev configuration that implements
> > persistent name for a device based on its physical location :)))
>
> Ok, do you have any other ideas of how to do this?
>

given current sysfs implementation - using wildcards remains the only 
solution. I for now am using this trivial script:

pts/0}% cat /etc/udev/scripts/removables
#!/usr/bin/perl

my $devpath, $base;

$base = $1 if ($ARGV[0] =~ /(.*\D)\d*$/);
$devpath = readlink "/sys/block/$base/device";

if ($devpath =~ 
m|/devices/pci0000:00/0000:00:1f.4/usb2/2-2/2-2.4/2-2.4:1.0/host\d+/\d+:0:0:0|) 
{
        print "flash0";
} elsif ($devpath =~ 
m|/devices/pci0000:00/0000:00:1f.4/usb2/2-2/2-2.1/2-2.1:1.0/host\d+/\d+:0:0:0|) 
{
        print "flash1";
} elsif ($devpath =~ m|/devices/legacy/host\d+/\d+:0:4:0|) {
        print "jaz";
} else {
        exit(1);
}

1;

with config

KERNEL="sd*" PROGRAM="/etc/udev/scripts/removables %k" SYMLINK="%c/%D"

> And patches for udev are always welcome :)
>

as example shows it probably can be done without serious patches. The only 
problem is to make devpath available; at this point udev already computed it. 
If you think it makes sense, patch will follow.

regards

-andrey

