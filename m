Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbRADVVF>; Thu, 4 Jan 2001 16:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129737AbRADVUp>; Thu, 4 Jan 2001 16:20:45 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:11535 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129348AbRADVUn>; Thu, 4 Jan 2001 16:20:43 -0500
Message-ID: <3A54F743.E04052A4@t-online.de>
Date: Thu, 04 Jan 2001 23:20:51 +0100
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-prerelease i686)
X-Accept-Language: en
MIME-Version: 1.0
To: twaugh@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: PCI serial card (VScom): BARs+Offset mix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

this mapping must be hardcoded like I did for Timedia serial:

serial.c: get_pci_port
e.g.
	/* Timedia/SUNIX uses a mixture of BARs and offsets */
        if(dev->vendor == PCI_VENDOR_ID_TIMEDIA )  /* 0x1409 */
                switch(idx) {
                        case 0: base_idx=0;
                                break;
                        case 1: base_idx=0; offset=8;
                                break;
                        case 2: base_idx=1;
                                break;
                        case 3: base_idx=1; offset=8;
                                break;
                        case 4: /* BAR 2*/
                        case 5: /* BAR 3 */
                        case 6: /* BAR 4*/
                        case 7: base_idx=idx-2; /* BAR 5*/
                }
--->    /* VScom uses another mixture */
        if(VScom)
                  YOUR CODE HERE PLEASE
...

This maps:  idx -> (base_idx, offset),
where idx:      goes from 0 to number_of_serial_ports,
      base_idx: BAR,
      offset:   added to the BAR IO-address to find actual port.

BAR mapping is set by a flag, here you need "SPCI_FL_BASE_TABLE":
e.g.    {       PCI_VENDOR_ID_TIMEDIA, PCI_DEVICE_ID_TIMEDIA_1889,
                PCI_VENDOR_ID_TIMEDIA, PCI_ANY_ID,
                SPCI_FL_BASE_TABLE, 1, 921600,
                0, 0, pci_timedia_fn },
 Footnote: This entry is fixed up at detect time and num_ports set by pci_timedia_fn,
           Ted fixed my table to a nice collapsed data structure for subids.

Hope this helps,
Gunther
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
