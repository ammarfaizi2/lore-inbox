Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUGXQoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUGXQoe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 12:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUGXQoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 12:44:34 -0400
Received: from odin.allegientsystems.com ([208.251.178.227]:47879 "EHLO
	pegasus.lawaudit.com") by vger.kernel.org with ESMTP
	id S261610AbUGXQoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 12:44:32 -0400
Message-ID: <41029215.1030406@optonline.net>
Date: Sat, 24 Jul 2004 12:45:09 -0400
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: device_suspend() levels [was Re: [patch] ACPI work on aic7xxx]
References: <40FD38A0.3000603@optonline.net> <20040720155928.GC10921@atrey.karlin.mff.cuni.cz> <40FD4CFA.6070603@optonline.net> <20040720174611.GI10921@atrey.karlin.mff.cuni.cz> <40FD6002.4070206@optonline.net> <1090347939.1993.7.camel@gaston> <40FD65C2.7060408@optonline.net> <1090350609.2003.9.camel@gaston> <40FD82B1.8030704@optonline.net> <1090356079.1993.12.camel@gaston> <40FD85A3.2060502@optonline.net> <1090357324.1993.15.camel@gaston> <410280E9.5040001@optonline.net> <1090684826.1963.6.camel@gaston>
In-Reply-To: <1090684826.1963.6.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> sysfs only takes care about the bus hierarchy as far as suspend/resume
> is concerned (which is the only sane way to do it imho)

I saw comments in one of the PCI IDE driver pcidev->suspend routines 
that say "we don't need to iterate over the list of drives, sysfs does 
that for us."

> No, the ordering cannot be dictated by the upper layer, but by the
> physical bus hierarchy. The low level driver gets the suspend callback
> and need to notify the parent. The md/multipath must keep track that one
> of the device it relies on is going away and thus block the queues.
> 
> That is at least for machine suspend/resume.

We're talking past each other. I'm saying you take into consideration 
the physical bus hierarchy: PCI bus x is a parent of SCSI bus y which is 
a parent of SCSI disk drive z. Suspend disk z, with involvement from the 
block layer and scsi midlayer, before even calling the actual 
pcidev->suspend routine on the SCSI bus adapter. Shouldn't require more 
than minimal LLD involvement.

>>Looking in /sys/devices shows that sysfs already knows that 'host0' is a 
>>child of a SCSI PCI device.
> 
> 
> Yes, but the PM herarchy is the bus hierarchy, I don't see a simple way
> of going through both in this case ...

In the case of IDE, IDE is registered as a bus_type and has generic 
suspend code for the whole bus that is unrelated to the pcidev. The PIIX 
IDE (Intel chipsets) PCI pcidev struct doesn't even have suspend and 
resume callbacks filled in, but it works fine!

