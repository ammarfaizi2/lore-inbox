Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267648AbRGNOwQ>; Sat, 14 Jul 2001 10:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267650AbRGNOwG>; Sat, 14 Jul 2001 10:52:06 -0400
Received: from flounder.icase.edu ([192.42.142.130]:41103 "EHLO
	flounder-t.icase.edu") by vger.kernel.org with ESMTP
	id <S267648AbRGNOv6>; Sat, 14 Jul 2001 10:51:58 -0400
Message-ID: <3B505CBE.898A717B@icase.edu>
Date: Sat, 14 Jul 2001 10:52:46 -0400
From: Josip Loncaric <josip@icase.edu>
Reply-To: josip@icase.edu
Organization: ICASE
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PCI: Failed to allocate resource 0 for PCI device 1011:0019
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upon installing Red Hat 7.1 w/kernel 2.4.3-12 on an IBM ThinkPad i1460
laptop, the pcmcia network card (NetGear FA510C) does not work.  The
problem is caused by PCI:

PCI: Failed to allocate resource 0 for PCI device 1011:0019

and further investigation ('cat /proc/pci', 'lspci -vvv') indicates that
although I/O port base is correctly identified, the size is not (lspci
shows no size, /proc/pci has end address lower than start address).

I've checked mailing list archives and even compared source differences
between 2.4.6 and 2.4.3 versions of drivers/pci/pci.c, but this problem
does not seem to have been addressed yet.

BTW, the suggestion to scan all subordinate busses instead of just
leaving 4 bus numbers produces mixed results.  The change (see below)
helps (the card is finally seen) but the card does not work right (it
generates tons of Rx traffic which gets discarded).  Also, with the
change, a bootup message "PCI: Unable to handle 64-bit address for
device..." shows up (unmodified kernel does not have this problem).

Any ideas?  Sorry, until the network becomes operational, I cannot
download more detailed information from the laptop...

Sincerely,
Josip

P.S.  The change to linux-2.4.3-12/drivers/pci/pci.c I tested was:

-                if (!is_cardbus) {
+                if (is_cardbus) {
                      /* Now we can scan all subordinate buses... */
                        max = pci_do_scan_bus(child);
                } else {
                        /*
                         * For CardBus bridges, we leave 4 bus numbers
                         * as cards with a PCI-to-PCI bridge can be
                         * inserted later.
                         */
                        max += 3;
                }
