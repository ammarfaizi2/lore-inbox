Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319404AbSIFVzT>; Fri, 6 Sep 2002 17:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319405AbSIFVzT>; Fri, 6 Sep 2002 17:55:19 -0400
Received: from grace.speakeasy.org ([216.254.0.2]:35090 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S319404AbSIFVzS>; Fri, 6 Sep 2002 17:55:18 -0400
Date: Fri, 6 Sep 2002 16:59:56 -0500 (CDT)
From: Mike Isely <isely@pobox.com>
X-X-Sender: isely@grace.speakeasy.net
Reply-To: Mike Isely <isely@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
Subject: LBA48 still disabled on Promise 20265?
Message-ID: <Pine.LNX.4.44.0209061645380.26505-100000@grace.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan:

Though you did use the part of the patch that fixes the bad
PCI_DEVICE_ID_PROMISE_20246 comparison, you didn't pull in the part that
gets rid of the LBA48-disabling hack.  In 2.4.20-pre5-ac3 in
init_hwif_pdc202xx() the switch statement there still does:

   hwif->addressing = (hwif->channel) ? 0 : 1;

for cases PCI_DEVICE_ID_PROMISE_20265 and PCI_DEVICE_ID_PROMISE_20267.  
That line of code prevents probe_lba_addressing() from setting
addressing to 1 for the primary channel which kills LBA48 addressing
there.

In 2.4.20-pre5-ac4 in init_hwif_pdc202xx(), the switch has been changed 
to some if-statements but the effect is the same:

    if (hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20265)
	hwif->addressing = (hwif->channel) ? 0 : 1;

(and similarly for PCI_DEVICE_ID_PROMISE_20267).

Is there a good reason why LBA48 is still disabled here?  The only
reason I can think of should have been fixed in -pre5-ac3.

With LBA48 disabled anyone running 160GB drives on the primary channel
are going to experience more nasty disk corruption.

  -Mike


                        |         Mike Isely          |     PGP fingerprint
    POSITIVELY NO       |                             | 03 54 43 4D 75 E5 CC 92
 UNSOLICITED JUNK MAIL! |   isely @ pobox (dot) com   | 71 16 01 E2 B5 F5 C1 E8
                        |   (spam-foiling  address)   |


