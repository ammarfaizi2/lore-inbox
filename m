Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316080AbSFDBw5>; Mon, 3 Jun 2002 21:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316088AbSFDBw4>; Mon, 3 Jun 2002 21:52:56 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:51558 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316080AbSFDBwz>; Mon, 3 Jun 2002 21:52:55 -0400
Message-Id: <5.1.0.14.2.20020604025121.02168350@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 04 Jun 2002 02:52:49 +0100
To: Andrew Morton <akpm@zip.com.au>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [patch] PCI device matching fix
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kees Bakker <kees.bakker@xs4all.nl>, Patrick Mochel <mochel@osdl.org>,
        Anton Blanchard <anton@samba.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3CFC0CC2.D69F2C57@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:41 04/06/02, Andrew Morton wrote:
>The new pci_device_probe() is always passing the zeroeth
>entry in the id_table to the device's probe method.  It
>needs to scan that table for the correct ID first.
>
>This fixes the recent 3c59x strangenesses.

Andrew,

Just as a heads up, this patch does indeed fix my 3c905 misdetection problem.

Thanks!!!

         Anton



>--- 2.5.20/drivers/pci/pci-driver.c~pci-scan    Mon Jun  3 17:37:59 2002
>+++ 2.5.20-akpm/drivers/pci/pci-driver.c        Mon Jun  3 17:38:03 2002
>@@ -38,12 +38,19 @@ pci_match_device(const struct pci_device
>  static int pci_device_probe(struct device * dev)
>  {
>         int error = 0;
>+       struct pci_driver *drv;
>+       struct pci_dev *pci_dev;
>
>-       struct pci_driver * drv = list_entry(dev->driver,struct 
>pci_driver,driver);
>-       struct pci_dev * pci_dev = list_entry(dev,struct pci_dev,dev);
>+       drv = list_entry(dev->driver, struct pci_driver, driver);
>+       pci_dev = list_entry(dev, struct pci_dev, dev);
>
>-       if (drv->probe)
>-               error = drv->probe(pci_dev,drv->id_table);
>+       if (drv->probe) {
>+               const struct pci_device_id *id;
>+
>+               id = pci_match_device(drv->id_table, pci_dev);
>+               if (id)
>+                       error = drv->probe(pci_dev, id);
>+       }
>         return error > 0 ? 0 : -ENODEV;
>  }
>
>
>-
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

