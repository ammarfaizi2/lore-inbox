Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWG3OBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWG3OBR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 10:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWG3OBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 10:01:17 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:13972 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S932318AbWG3OBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 10:01:16 -0400
Message-ID: <44CCBBC7.3070801@free.fr>
Date: Sun, 30 Jul 2006 16:01:43 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.4) Gecko/20060405 SeaMonkey/1.0.2
MIME-Version: 1.0
To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
CC: Andrew Morton <akpm@osdl.org>, andrew.j.wade@gmail.com,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: Kubuntu's udev broken with 2.6.18-rc2-mm1
References: <20060727015639.9c89db57.akpm@osdl.org> <20060727125655.f5f443ea.akpm@osdl.org> <20060727201255.GA9515@suse.de> <200607281033.06111.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
In-Reply-To: <200607281033.06111.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 28.07.2006 16:33, Andrew James Wade a écrit :
> On Thursday 27 July 2006 16:12, Greg KH wrote:
>> On Thu, Jul 27, 2006 at 12:56:55PM -0700, Andrew Morton wrote:
>>> On Fri, 28 Jul 2006 15:46:08 -0400
>>> Andrew James Wade <andrew.j.wade@gmail.com> wrote:
>>>
>>>> Hello,
>>>>
>>>> Some change between -rc1-mm2 and -rc2-mm1 broke Kubuntu's udev
>>>> (079-0ubuntu34). In particular /dev/mem went missing, and /dev/null had
>>>> bogus permissions (crw-------). I've kludged around the problem by
>>>> populating /lib/udev/devices from a good /dev, but I'm assuming the
>>>> breakage was unintentional.
>>>>
>>> /dev/null damage is due to a combination of vdso-hash-style-fix.patch and
>>> doing the kernel build as root (don't do that).
>>>
>>> I don't know what happened to /dev/mem.
>> Me either.  Look in /sys/class/mem/  Is it full of symlinks or real
>> directories?
> 
> Symlinks.
> 
>> If symlinks, your version of udev should be able to handle it properly,
>> but might have a bug somehow.
>>
>> Try running udevmonitor and echo a "1" to /sys/class/mem/mem/uevent and
>> see if udev creates the device properly or not.
> 
> udevmonitor prints the received event from the kernel [UEVENT]
> and the event which udev sends out after rule processing [UDEV]
> 
> UEVENT[1154093169.330045] add@/devices/mem
> UDEV  [1154093169.331914] add@/devices/mem
> 
> The device node was not created.
> 
> udev.log for 2.6.18-rc1-mm2 (which does work) has these lines:
> 
> UEVENT[1154105360.092631] add@/class/mem/mem
> ACTION=add
> DEVPATH=/class/mem/mem
> SUBSYSTEM=mem
> SEQNUM=589
> MAJOR=1
> MINOR=1
> 
> ...
> 
> UDEV  [1154105363.575086] add@/class/mem/mem
> UDEV_LOG=3
> ACTION=add
> DEVPATH=/class/mem/mem
> SUBSYSTEM=mem
> SEQNUM=589
> MAJOR=1
> MINOR=1
> UDEVD_EVENT=1
> DEVNAME=/dev/mem
> 
> The Changelog for udev v081 has:
> "prepare moving of /sys/class devices to /sys/devices"
> Is this related? 
> 
> Thanks,
> Andrew Wade

gregkh-driver-mem-devices.patch seems to be the culprit.

With this patch, /sys/class/mem/ looks like this:

/sys/class/mem/
|-- full -> ../../devices/full
|-- kmem -> ../../devices/kmem
|-- kmsg -> ../../devices/kmsg
|-- mem -> ../../devices/mem
|-- null -> ../../devices/null
|-- port -> ../../devices/port
|-- random -> ../../devices/random
|-- urandom -> ../../devices/urandom
`-- zero -> ../../devices/zero

9 directories, 0 files

And /sys/class/mem/*/ look like this:

/sys/class/mem/full/
|-- dev
|-- power
|   |-- state
|   `-- wakeup
|-- subsystem -> ../../class/mem
`-- uevent
/sys/class/mem/kmem/
|-- dev
|-- power
|   |-- state
|   `-- wakeup
|-- subsystem -> ../../class/mem
`-- uevent
/sys/class/mem/kmsg/
|-- dev
|-- power
|   |-- state
|   `-- wakeup
|-- subsystem -> ../../class/mem
`-- uevent
/sys/class/mem/mem/
|-- dev
|-- power
|   |-- state
|   `-- wakeup
|-- subsystem -> ../../class/mem
`-- uevent
/sys/class/mem/null/
|-- dev
|-- power
|   |-- state
|   `-- wakeup
|-- subsystem -> ../../class/mem
`-- uevent
/sys/class/mem/port/
|-- dev
|-- power
|   |-- state
|   `-- wakeup
|-- subsystem -> ../../class/mem
`-- uevent
/sys/class/mem/random/
|-- dev
|-- power
|   |-- state
|   `-- wakeup
|-- subsystem -> ../../class/mem
`-- uevent
/sys/class/mem/urandom/
|-- dev
|-- power
|   |-- state
|   `-- wakeup
|-- subsystem -> ../../class/mem
`-- uevent
/sys/class/mem/zero/
|-- dev
|-- power
|   |-- state
|   `-- wakeup
|-- subsystem -> ../../class/mem
`-- uevent

18 directories, 36 files

In this situation, udev (version 096 here) is unable to create these
device files (/dev/full, /dev/kmem, /dev/kmsg, etc.). /dev/null does
exist (with wrong permissions) because it has been created by the
initrd script.

In order to get back the device files, I have to run the following
command:
# for f in /sys/class/mem/*/uevent; do echo 1 > $f; done

After gregkh-driver-mem-devices.patch been reverted, all is working
fine and /sys/class/mem/ looks like this:

/sys/class/mem/
|-- full
|   |-- dev
|   |-- subsystem -> ../../../class/mem
|   `-- uevent
|-- kmem
|   |-- dev
|   |-- subsystem -> ../../../class/mem
|   `-- uevent
|-- kmsg
|   |-- dev
|   |-- subsystem -> ../../../class/mem
|   `-- uevent
|-- mem
|   |-- dev
|   |-- subsystem -> ../../../class/mem
|   `-- uevent
|-- null
|   |-- dev
|   |-- subsystem -> ../../../class/mem
|   `-- uevent
|-- port
|   |-- dev
|   |-- subsystem -> ../../../class/mem
|   `-- uevent
|-- random
|   |-- dev
|   |-- subsystem -> ../../../class/mem
|   `-- uevent
|-- urandom
|   |-- dev
|   |-- subsystem -> ../../../class/mem
|   `-- uevent
`-- zero
    |-- dev
    |-- subsystem -> ../../../class/mem
    `-- uevent

18 directories, 18 files

~~
laurent
