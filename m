Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292783AbSBVKef>; Fri, 22 Feb 2002 05:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292797AbSBVKe0>; Fri, 22 Feb 2002 05:34:26 -0500
Received: from mxout2.netvision.net.il ([194.90.9.21]:20986 "EHLO
	mxout2.netvision.net.il") by vger.kernel.org with ESMTP
	id <S292783AbSBVKeN>; Fri, 22 Feb 2002 05:34:13 -0500
Date: Fri, 22 Feb 2002 12:42:03 +0200
From: Gadi Oxman <gadio@netvision.net.il>
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
To: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <00a201c1bb8d$90dd2740$0300a8c0@lemon>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com>
 <3C723B15.2030409@evision-ventures.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

ide_module_t was designed to conceptually divide the code to multiple
layers,
whether one actually uses modules or compiles all the IDE code into the
kernel,
and in the future, to alow several parallel implementations of the same
functionality
which could reside in the kernel simultaneously.

The job was not finished, but the original idea was to have:

1. Core IDE code.
2. Chipset modules.
3. Probe modules.
4. Subdriver modules.

ide_module_t was created so that the core IDE code could track all the
modules
currently available to it, and to be able to have several chipset drivers
for the same
chipset simultaneously, several probe modules simultaneously, and several
subdrivers
for the same device type (so that one could choose the one which works
best).

The last example was actually used in ide-scsi.c. The intention in
ide_module_t was
that one would be able to have, for example, ide-cdrom + ide-scsi or
ide-tape + ide-scsi
in the kernel simultaneously (either compiled in or as modules), known to
the
core IDE code, and one could then change drivers for a single drive on the
fly using
something like "cat driver_name > /proc/ide/hdx/driver".

Upon receiving such a command, the IDE core could call the cleanup code of
the driver which was originally assigned to hdx, the cleanup code would
de-attach
the driver from hdx without unloading the module and without affecting the
other drives which are currently supported by it. The core code could then
call the init code of the other driver to attach to the device.

The reason ide-probe was splitted to a different module is that in most of
the
time, one doesn't need the probe code in the kernel. It is needed during
boot, and
each time one "hot swaps" an IDE device. In addition, it could provide the
framework
for having several probe modules simultaneously, altough that never
materialized.

Cheers,

Gadi

----- Original Message -----
From: "Martin Dalecki" <dalecki@evision-ventures.com>
To: "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Tuesday, February 19, 2002 1:46 PM
Subject: [PATCH] 2.5.5-pre1 IDE cleanup 9


> The attached patch does the following:
>
> 1.  Kill the ide-probe-mod by merging it with ide-mod. There is *really*
>      no reaons for having this stuff split up into two different
>     modules unless you wan't to create artificial module dependancies
> and waste space
>     of page boundaries during memmory allocation for the modules
>
> 2. Kill the ide_module_t - which is unnecessary and presents a
> "reimplementation"
>    of module handling inside the  ide driver. This is achieved by
> attaching the
>    initialization routine ot the ide_driver_t, which will be gone next
> time,
>    since there is no sane reason apparently, which this couldn't be done
>    during the module-generic initialization of the corresponding driver
> module.
>
> 3. Kill unnecessary tagging of "subdriver" with IDE_SUBDRIVER_VERSION - we
>    have plenty of other mechanisms for module consistency checking. And
> anyway
>    the ide code didn't any consistence checks on this  value at all.
>
> NOTE: The ide_(un)register_module() functions will be killed in next
round.
>
> This patch should apply to mainstream, however it waws created on top of
> the others.
>
>
>



