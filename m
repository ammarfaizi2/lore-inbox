Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261277AbREQATm>; Wed, 16 May 2001 20:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbREQATX>; Wed, 16 May 2001 20:19:23 -0400
Received: from hera.cwi.nl ([192.16.191.8]:59381 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261277AbREQATT>;
	Wed, 16 May 2001 20:19:19 -0400
Date: Thu, 17 May 2001 02:18:20 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105170018.CAA30316.aeb@vlet.cwi.nl>
To: rgooch@ras.ucalgary.ca, torvalds@transmeta.com
Subject: Re: LANANA: To Pending Device Number Registrants
Cc: alan@lxorguk.ukuu.org.uk, geert@linux-m68k.org, hpa@transmeta.com,
        ingo.oeser@informatik.tu-chemnitz.de, jgarzik@mandrakesoft.com,
        linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au, viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The LANANA discussion has forked into a forest of vaguely related
discussions.  If I am not mistaken the only real question is
how user space and kernel space communicate device identities.

Here "user space" is very different from "users".
Devices have a device path and device contents.

For the user it is very desirable to recognize things by contents.
One invents labels and similar schemes, both readable with the eye
and readable with software.
But devices vary quite a lot and labeling schemes vary quite a lot
and user needs vary quite a lot.
Clearly, recognizing a device by contents is something that belongs
to user space.

Of course the kernel can make functions available to simplify
the work of a device manager, but the actual work of making the
correspondence between the identity of a device as seen by the user
and the device path belongs to user space. Be it a boot-time setup
script working from a data base, or a daemon.

(A somewhat weaker function also belongs to user space:
Even if the user has not specified a name for a device
it may be that the device has a serial number or other
recognizable information, so that user space can guess
or be sure that a certain device is the same as something
seen earlier, perhaps before the last reboot.)

That was the user. She thinks about "my boot partition".
And mount sees "UUID=e70bde8e-34d7-11d... /boot ext2 ..."
or "LABEL=Boot /boot ext2 ..." and searches /proc/partitions for
things that, when interpreted as an ext2 filesystem, have
the specified UUID or label.

The communication between user space and kernel is not in terms
of device "contents", since the kernel doesnt know about such
things. The kernel knows only one thing: the device path.
(the driver used, together with all parameters, the port address,
the SCSI ID, the disk subinterval, ...)

But this path is a very complicated object. Moreover, it contains
a lot of items that the user has never heard of. It is a bad idea
to try to use such paths.

So we have: user space has file names and uses open() or mount().
Kernel space has device paths.

In principle the kernel could just number the devices it sees 1,2,...
and export information about them, so that user space can choose
the right number.
The part about exporting information is good. User space needs to
be able to ask if a certain beast is a CD reader, and if so what
manufacturer and model.
But the part about numbering 1,2,... may not be good enough, e.g.
because it does not survive reboots. If we remain Unix-like and use
device nodes in user space to pair a file name with a number, then
it would be very nice if the number encoded the device path uniquely.
Many programs expect this.
It cannot be done in all cases, but a good approximation is obtained
if the number is a hash of the device path. In so far the hash is
collision free we obtain numbers that stay unique over a reboot.

Andries

