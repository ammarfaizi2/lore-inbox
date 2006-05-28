Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWE1Mdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWE1Mdy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 08:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWE1Mdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 08:33:53 -0400
Received: from 2-1-3-15a.ens.sth.bostream.se ([82.182.31.214]:51384 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S1750752AbWE1Mdx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 08:33:53 -0400
To: Nathan Laredo <laredo@gnu.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org,
       video4linux-list@redhat.com
Subject: Stradis driver conflicts with all other SAA7146 drivers
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 28 May 2006 14:33:52 +0200
Message-ID: <m3wtc6ib0v.fsf@zoo.weinigel.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[Nathan Laredo is the maintainer of the stradis driver but Jiri Slaby
submitted the PCI probing change that went into 2.6.16 so I'm Cc-ing
him too.  I'm not a member of the video4linux mailing list so please
Cc me on any responses.]

The stradis driver in the 2.6.16 kernel only looks at the SAA7146
vendor and product ID and binds to any SAA7146 based device even if it
is not a stradis card.  This stops all other SAA7146 drivers from
working, for example my WinTV Nova-T card using the budget-ci driver
doesn't work any longer.  A lot of other people have also been bitten
by this.

So could you please modify your driver so that it only binds to real
stradis cards?  If stradis cards have a subvendor and subdevice ID you
could just modify the pci_device_id table to look something like this:

static struct pci_device_id stradis_pci_tbl[] = {
        { 
                .vendor = PCI_VENDOR_ID_PHILIPS, 
                .device = PCI_DEVICE_ID_PHILIPS_SAA7146,
                .subvendor = 0xdead,
                .subdevice = 0xbeef,
        },
        { 0 }
};

>From the code it looks as if some boards don't have a good subsystem
vendor and device ID:

        if (!pdev->subsystem_vendor)
                dev_info(&pdev->dev, "%d: rev1 decoder\n", saa_num);
        else
                dev_info(&pdev->dev, "%d: SDM2xx found\n", saa_num);

Are those rev1 boards out in the real world or are they just
prototypes?  If they are prototypes, can you add the subvendor ID
anway and add a module parameter so that your driver only binds to
unspecified vendor IDs if you use that module parameter?  Something
like this:

static int bind_to_anything = 0;
module_param(bind_to_anything, int, 0);

int __init stradis_init(void)
{
        ...
	if (bind_to_anything) {   
		stradis_pci_tbl[0].subvendor = PCI_ANY_ID;
		stradis_pci_tbl[0].subdevice = PCI_ANY_ID;
        }
        ...
        pci_register_driver(&stradis_driver);
        ...
}

For anyone submitting a new SAA7146 driver to the kernel in the
future, please be aware that your card isn't the only one that uses
that chip, so always add a subvendor/subdevice to your drivers.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
