Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269677AbTGJW76 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 18:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269678AbTGJW76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 18:59:58 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:53408 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S269677AbTGJW7j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 18:59:39 -0400
Date: Fri, 11 Jul 2003 01:13:55 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Samuel Flory <sflory@rackable.com>
cc: Steven Dake <sdake@mvista.com>,
       Chad Kitching <CKitching@powerlandcomputers.com>,
       <linux-kernel@vger.kernel.org>, <andre@linux-ide.org>
Subject: Re: IDE/Promise 20276 FastTrack RAID Doesn't work in 2.4.21,
 patchattached to fix
In-Reply-To: <3F0DEDFD.5040805@rackable.com>
Message-ID: <Pine.SOL.4.30.0307110102220.6781-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It shouldn't matter.

Look at the code in setup-pci.c:

                ide_pci_enablebit_t *e = &(d->enablebits[port]);

If CONFIG_PDC202XX_FORCE=y d->enablebits will be { 0x00, 0x00, 0x00 }
for both ports, now look at drivers/ide/setup-pci.c:

                /*
                 * If this is a Promise FakeRaid controller,
                 * the 2nd controller will be marked as
                 * disabled while it is actually there and enabled
                 * by the bios for raid purposes.
                 * Skip the normal "is it enabled" test for those.
                 */
                if (((d->vendor == PCI_VENDOR_ID_PROMISE) &&
                     ((d->device == PCI_DEVICE_ID_PROMISE_20262) ||
                      (d->device == PCI_DEVICE_ID_PROMISE_20265))) &&
                    (secondpdc++==1) && (port==1))
                        goto controller_ok;

                if (e->reg && (pci_read_config_byte(dev, e->reg, &tmp) ||
                    (tmp & e->mask) != e->val))
                        continue;       /* port not enabled */

controller_ok:

So if e = { 0x00, 0x00, 0x00 } test above (for enabled port) should fail,
no need for your patch.

Can you put printks inside this code to see what are values
of e->reg, e->mask and e->val?

On Thu, 10 Jul 2003, Samuel Flory wrote:

> Steven Dake wrote:
>
> > Even with special fasttrack feature enabled, my disk devices on the
> > PDC20276 is not found.  There is code in pci-setup.c which blocks
> > other PDC controllers, why not the 20276?  Is that code for some other
> > purpose, or orthagonal to the force option?
>
>   The comments would seem to indicate that this is only needed if you
> have a second controller.  Which leads me to wonder what if I have 3 or
> 4 pdc controllers.
>
>         for (port = 0; port <= 1; ++port) {
>                 ide_pci_enablebit_t *e = &(d->enablebits[port]);
>
>                 /*
>                  * If this is a Promise FakeRaid controller,
>                  * the 2nd controller will be marked as
>                  * disabled while it is actually there and enabled
>                  * by the bios for raid purposes.
>                  * Skip the normal "is it enabled" test for those.
>                  */
>                 if (((d->vendor == PCI_VENDOR_ID_PROMISE) &&
>                      ((d->device == PCI_DEVICE_ID_PROMISE_20262) ||
>                       (d->device == PCI_DEVICE_ID_PROMISE_20265))) &&
>                     (secondpdc++==1) && (port==1))
>                         goto controller_ok;

I think this workaround was added before "Special FastTrack Feature"
option. Andre?
--
Bartlomiej


