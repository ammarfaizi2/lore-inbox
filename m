Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262180AbREQCrl>; Wed, 16 May 2001 22:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262181AbREQCrb>; Wed, 16 May 2001 22:47:31 -0400
Received: from simba.xos.nl ([192.87.153.226]:56146 "EHLO simba.xos.nl")
	by vger.kernel.org with ESMTP id <S262180AbREQCrQ>;
	Wed, 16 May 2001 22:47:16 -0400
Message-Id: <200105170246.EAA12820@rabbit.xos.nl>
To: linux-kernel@vger.kernel.org
cc: Andries.Brouwer@cwi.nl
Subject: Re: LANANA: To Pending Device Number Registrants 
In-Reply-To: Your message of "Thu, 17 May 2001 02:18:20 +0200."
             <UTC200105170018.CAA30316.aeb@vlet.cwi.nl> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12808.990067593.1@rabbit.xos.nl>
Date: Thu, 17 May 2001 04:46:33 +0200
From: Willem Konynenberg <wfk@xos.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
[lots of sensible comments to get this discussion "on track"]

> So we have: user space has file names and uses open() or mount().
> Kernel space has device paths.
> 
> In principle the kernel could just number the devices it sees 1,2,...
> and export information about them, so that user space can choose
> the right number.
> The part about exporting information is good. User space needs to
> be able to ask if a certain beast is a CD reader, and if so what
> manufacturer and model.
> But the part about numbering 1,2,... may not be good enough, e.g.
> because it does not survive reboots. If we remain Unix-like and use
> device nodes in user space to pair a file name with a number, then
> it would be very nice if the number encoded the device path uniquely.
> Many programs expect this.
> It cannot be done in all cases, but a good approximation is obtained
> if the number is a hash of the device path. In so far the hash is
> collision free we obtain numbers that stay unique over a reboot.

I think here we might learn from the comments that people made
about how AIX and OSF/1/Tru64 have been doing this.

You want the relation between a given /dev/xyz node and the
corresponding device in the kernel to be relatively stable from
the perspective of the user, so you can use it to implement device
naming and access policies.  What "stable" means technically is a
matter of policy, since it depends very much on the perspective
of the user.

You also want the relation between a given /dev/xyz node and the
major/minor number of the related device to be "fixed", so you
don't need to recreate all device nodes on every boot.

The issue is then how to establish the relation between major/minor
numbers and (potentially very dynamic) kernel-internal device
entities, in such a way that the type of stability desired by
the user is provided.

As people noted, the mechanism used by AIX and Tru64 is essentially
to have this relationship established by a user-level tool using
a configuration file with policy information, and a status file
to maintain state information across reboots.
This tool can implement any policy it likes, which means we can
avoid all the policy discusions where the kernel is concerned,
and can instead focus on methods.

For the people who want things to be backward compatible, it
would be sufficient to implement a default tool that will
set all the major/minor numbers exactly like they are now,
so all existing device nodes will keep working as they did.

In order to support hot plugging of devices, I suppose this
tool should either run as a daemon, or set itself up to be
called by the kernel whenever something happens.  (I think
I would prefer the daemon...)   Sort of like /sbin/hotplug.

The next issue to discuss is then how to shape the mechanism by
which the device manager tool and the kernel exchange information
on what devices are out there, and what major/minor numbers each
should be assigned.
The sort of information that a device manager might want to
use, depending on how it is implemented and configured, would
include such things as: device driver id, I/O bus, I/O port,
IRQ nr, SCSI card/bus/id/lun, partition id, serial number,
device model/type, filesystem label, filesystem UUID, phase of
the moon, etc, etc.
Basically, anything that a driver or related subsystem can come
up with that might help identify a device or resource in any
particular situation, depending on user preferences.
I think this may fit somewhere in /proc/sys/dev or thereabout.


The big advantage of this approach is basically that we can
continue to use the good old device nodes in the filesystem
as we have done for the last 30 years, with all the advantages,
but without the major/minor number allocation troubles.


Hmm, this all sounds too simple.
I must be talking nonsense.   Please wake me up.  ;-)



-- 
     Willem Konynenberg <wfk@xos.nl>
I am not able rightly to apprehend the kind of confusion of ideas
that could provoke such a question  --  Charles Babbage
