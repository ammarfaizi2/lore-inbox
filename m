Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292863AbSBVNqd>; Fri, 22 Feb 2002 08:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292864AbSBVNqX>; Fri, 22 Feb 2002 08:46:23 -0500
Received: from [195.63.194.11] ([195.63.194.11]:33033 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292863AbSBVNqR>; Fri, 22 Feb 2002 08:46:17 -0500
Message-ID: <3C764B7C.2000609@evision-ventures.com>
Date: Fri, 22 Feb 2002 14:45:32 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Gadi Oxman <gadio@netvision.net.il>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com> <3C723B15.2030409@evision-ventures.com> <00a201c1bb8d$90dd2740$0300a8c0@lemon>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gadi Oxman wrote:
> Hi Martin,
> 
> ide_module_t was designed to conceptually divide the code to multiple
> layers,
> whether one actually uses modules or compiles all the IDE code into the
> kernel,
> and in the future, to alow several parallel implementations of the same
> functionality
> which could reside in the kernel simultaneously.
> 
> The job was not finished, but the original idea was to have:
> 
> 1. Core IDE code.
> 2. Chipset modules.
> 3. Probe modules.
> 4. Subdriver modules.
> 
> ide_module_t was created so that the core IDE code could track all the
> modules
> currently available to it, and to be able to have several chipset drivers
> for the same
> chipset simultaneously, several probe modules simultaneously, and several
> subdrivers
> for the same device type (so that one could choose the one which works
> best).

The normal linux way using multiple driver implementations are
aliases in /etc/modules.conf - see for example ALSA vers. OSS sound 
drivers for the same hardware.

> The last example was actually used in ide-scsi.c. The intention in

ide-scsi is intendid to be gone in 2.5.x.

> ide_module_t was
> that one would be able to have, for example, ide-cdrom + ide-scsi or
> ide-tape + ide-scsi
> in the kernel simultaneously (either compiled in or as modules), known to
> the
> core IDE code, and one could then change drivers for a single drive on the
> fly using


> something like "cat driver_name > /proc/ide/hdx/driver".

See above that is *not* the proper interface for implementation choice,
which is *user* policy anyway and can be handled fine by the
existing generic module interface infrastructure.

For the sake of modularization. I have already at home a version
of ide-pci.c, where the signatures of chipset initialization
source code modules match the singature of a normal pci device
initialization hook. This should enable it to make them true modules
RSN.

The chipset drivers will register lists of PCI-id's they can handle
instead of the single only global list found in ide-pci.c.

> Upon receiving such a command, the IDE core could call the cleanup code of
> the driver which was originally assigned to hdx, the cleanup code would
> de-attach
> the driver from hdx without unloading the module and without affecting the
> other drives which are currently supported by it. The core code could then
> call the init code of the other driver to attach to the device.
> 
> The reason ide-probe was splitted to a different module is that in most of
> the
> time, one doesn't need the probe code in the kernel. It is needed during
> boot, and
> each time one "hot swaps" an IDE device. In addition, it could provide the
> framework
> for having several probe modules simultaneously, altough that never
> materialized.

It's inventing too many races (in esp. in the hot plug case) and the
module would be too small for beeing worth it:

[root@kozaczek ide]# size ide-probe.o
    text    data     bss     dec     hex filename
    8445      16       0    8461    210d ide-probe.o
[root@kozaczek ide]# size ide.o
    text    data     bss     dec     hex filename
   30951     521    9376   40848    9f90 ide.o
[root@kozaczek ide]#

(BTW.> I hate the ALSA OSS emultaion module splitup as well.)

As it goes about the possibility of multiple different probe
implementatoins - please show me a different one.


