Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131829AbQKVAFi>; Tue, 21 Nov 2000 19:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131886AbQKVAF2>; Tue, 21 Nov 2000 19:05:28 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:11794 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131829AbQKVAFW>;
	Tue, 21 Nov 2000 19:05:22 -0500
Message-ID: <3A1B06B7.610AEE5A@mandrakesoft.com>
Date: Tue, 21 Nov 2000 18:35:19 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: linux-kernel@vger.kernel.org, zab@zabbo.net
Subject: Re: Patch: linux-2.4.0-test11/drivers/sound/maestro.c port to new PCI 
 interface
In-Reply-To: <20001121150246.A5608@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> 
> Here is a patch which ports drivers/sound/maestro.c to the new PCI
> interface, which Zach Brown asked me to post here for comments.
> This patch includes Zach's changes eliminating the ioctl lockups which
> he posted separately, just to make it easier to generate the final
> product from pristine 2.4.0-test11.  I could actually divide this
> patch into three phases if need be:
>         (a) The ioctl lockup fix which Zach has already submitted for
>             (presumably) the next "-pre" release.
>         (b) The pci_device_id table declaration and MODULE_DEVICE_TABLE.
>         (c) Moving to the new PCI interface.  If I were to conform to
>             Jeff Garzick's requests on __initdata and __devinitdata, this would
>             include changes that would change an __initdata delcaration in
>             (b) to __devinitdata.

hmmm.  I'm not so sure that the locking is correct...  if the intention
was to serialize access to the mixer, there are surely better ways to do
it.  Why are interrupts disabled?  In any case it will probably change
when maestro goes ac97_codec (tested patches in gkernel CVS)... which it
needs to do <nudge nudge> ;-)

This driver needs __devxxx, I've heard mention of some hotpluggable
audio that is based on the maestro chipset (which chip I don't remember)

The formatting of pci_device_id data is awful.  Named initializers
-reduce- the readability of the code here, are highly redundant, and its
usage is totally inconsistent with -all- other PCI drivers in the
kernel.

To make Zab's life a little easier, use pci_{get,set}_drvdata to make it
easier to port the code back to 2.2.x.  Since pci_dev::driver_data
doesn't exist on 2.2.x, you have to ugly up the code with ifdefs, or use
a compatibility macro (like, say, pci_xxx_drvdata.. :))

Unrelated to your change:  the maestro reboot notifier shouldn't need to
unregister all that stuff.  Who cares if the sound devices are freed,
since we are rebooting.  free_irq+maestro_power seems sufficient.  or
maybe stop_dma+free_irq+poweroff.

Unrelated to your change:  Feel free to submit patches to update
Documentation/pci.txt if you feel it is missing information.

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
