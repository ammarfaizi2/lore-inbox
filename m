Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316229AbSEQOJM>; Fri, 17 May 2002 10:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316230AbSEQOJL>; Fri, 17 May 2002 10:09:11 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:44982 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S316229AbSEQOJJ>; Fri, 17 May 2002 10:09:09 -0400
Message-Id: <200205171408.g4HE8tK65272@d12relay02.de.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: Patrick Mochel <mochel@osdl.org>
Subject: driverfs problems
Date: Fri, 17 May 2002 18:08:57 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arndb@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to write a new bus driver for the s/390 channel subsystem and 
stumbled over a few problems.

- If I register 'struct device's for my devices and unregister them at 
module unload time with put_device, the memory for the d_entries
is never freed because the refcount is still '3' (or '7' for directories) at 
the beginning of  'driverfs_unlink()'. Consequently, 
'driverfs_d_delete_file()' never gets called at all. So far, I could not
find the place where the refcount is incremented and not decremented
again. Any idea?

- When using many devices, a lot of memory seems to be wasted by 
identical files. When I simulated 65536 devices, which would be the
architectural limit of the channel subsystem, my ~200MB free mem were 
immediately filled and the out of memory handler started killing my
user space programs. More investigation showed that each dummy devices
needs between 3 and 4 kb on a 31 bit s390 system. That is probably not too 
much if you assume that people who can afford thousands of devices typically 
also have much RAM, but I could imagine that there is still room for improval.
Would it be feasable to allocate the dentries for standard files 
(name/power/status plus the ones provided by architecture and bus driver) 
only when the parent directory is accessed?

- I'm not sure about how to name the device directories. I don't have anything
like a hierarchical structure (except for something like scsi devices behind
a channel device) but rather a flat list of up to 65536 devices that are 
accessed by a device number that was defined by the system administrator. 
Each device also has a control unit type, comparable to a PCI ID, and in the 
general case each device driver knows about one control unit type. A 
hypothetical system might have
- one console, control unit type 0x3215, device number 0x0000
- three network devices, control unit type  0x1732, devno 0x0100 to 0x0102
- 1024 storage devices, control unit type 0x3390, devno 0x1000 to 0x13ff

I have a.t.m. three different ideas for how to structure the driverfs, in 
this case:
a) flat listing:
/root/channel/{0000,0100,0103,0102,1000-13ff}
advantage: reflects the real physical layout, no policy
disadvantage: difficult to parse as a human (similar to pre-devfs /dev/*),
possible scalability problems when scanning through long lists in kernel

b) by control unit type:
/root/channel/1732/{0100,0101,0102}
/root/channel/3215/0000
/root/channel/3390/{1000-13ff}
advantage: easy to find e.g. the console if you don't know the devno
disadvantage: control unit type might be unknown in a few special cases,
a control unit type is not really a bus but a common property of the devices

c) split device number:
/root/channel/00/00
/root/channel/01/{00,01,02}
/root/channel/{10,11,12,13}/{00-ff}
advantage: no large directories
disadvantage: does not reflect physical structure but policy

I personally favour solution b), but I want to be consistent with other
architectures. Is there any other bus handling 'many' devices? How 
do they do it?

Arnd <><
