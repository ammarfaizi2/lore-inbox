Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314600AbSEUNzU>; Tue, 21 May 2002 09:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314612AbSEUNzT>; Tue, 21 May 2002 09:55:19 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:43235 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S314600AbSEUNzS>; Tue, 21 May 2002 09:55:18 -0400
Message-Id: <200205211355.g4LDt8Z211864@d06relay02.portsmouth.uk.ibm.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: Patrick Mochel <mochel@osdl.org>
Subject: Re: driverfs problem
Date: Tue, 21 May 2002 17:52:27 +0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>, Arnd Bergmann <arndb@de.ibm.com>,
        Cornelia Huck <cohuck@de.ibm.com>
In-Reply-To: <Pine.LNX.4.33.0205200750490.820-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 May 2002 18:39, Patrick Mochel wrote:

> This is interesting. It appears that I need to do an extra dput() when
> removing files to push the refcount to 0. This counters the lookup_hash()
> that is done when creating the files and directories, and is analogous to
> the path_release() call in sys_unlink() and sys_rmdir(). Please try the
> attached patch, and let me know if it fixes the problem.
Yes, all files are correctly removed and the memory freed with that patch.

> Theoretically, I believe that's possible. Al Viro has also spoken of a
> per-device filesystem, which could help in that area. Althoygh, I have not
> pursued either option. Though I hate to say it, there is other progress to
> be made before I have a chance to seriously investigate these options.
That's ok. Right now its only a potential problem for us and if it becomes
a real one, I can investigate it further. My current idea is to have a
device_{create,remove}_{platform,bus}_file() interface that adds files
to all devices (*_platform_file) or all devices in that belong to one bus
subdir (*_bus_file). They would then shared a struct inode and thus 
appear hard linked. The space wasted by the dentries is a lot less than
what the dentries need.

> The control unit types are irrelevant at this point, as they dictate the
> type of device. You want to accurately represent the physical layout of
> the system.
Yes, I know. Unfortunately, the physical layout is not a tree and therefore
not easy to represent in a file system. The architecture is also trying
hard to hide the physical layout from the OS because 99% of the time,
we don't care.

> I honestly don't know how the controllers look on the s390, so I will go
> off what I do know about x86 PCI SCSI contollers. You typically have a
> hierarchy like:
>
> .
> `-- controller
>     |-- chan0
>     |   |-- 0
>     |   |-- 1
>     |   |-- 2
>     |   `-- 3
> 	...
>     `-- chan1
>         |-- 0
>         |-- 1
>         |-- 2
>         `-- 3
> 	...
>
> right? (Note: naming is fictional here) I would think the layout would
If it was that easy, I probably wouldn't have needed to ask ;-). The main 
problem is that a device can be connected to multiple control units 
(something vaguely like a bridge in PCI semantics) and each of these can 
itself be connected to multiple channel paths (i.e. connectors of the 
'channel subsystem', our root bus within driverfs).
The i/o driver in Linux can mostly ignore these details, because it is based
on 'subchannels', which are logical connections from the channel subsystem
to a single device, independent of the path(s) inbetween.

> similar, but that's only a guess. How many devices can be on a channel?
> Does splitting them up like this help with the large directories?
There can be 256 channel paths, each going to a control unit and each 
control unit can have a number of devices depending on its type, at least 
thousands of devices for certain types (actually, it's yet a bit more 
complicated than that ;-).

The total number of devices is currently limited to 65536, each device has 
one unique subchannel, irq (irq number equals subchannel number) and device 
number.
[Conny, please correct me if I've been telling nonsense]

It might be possible to list the devices by their channel path if I could
use symbolic links inside driverfs for devices that are accessed through
multiple channel paths, but I don't think there is much to gain from that
compared to the extra effort.

Thanks for your help,

Arnd <><
