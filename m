Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbTIRTJG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 15:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbTIRTJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 15:09:06 -0400
Received: from mailnw.centurytel.net ([209.206.160.237]:57276 "EHLO
	mailnw.centurytel.net") by vger.kernel.org with ESMTP
	id S262046AbTIRTI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 15:08:59 -0400
Message-ID: <00b101c37e18$65574980$1e140a0a@romulus>
From: "Robert Currey" <avalonforest@centurytel.net>
To: <linux-kernel@vger.kernel.org>
Subject: Timedia MultiFunction Card Support
Date: Thu, 18 Sep 2003 12:09:07 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm trying to ready a patch (off of 2.6.0-test5) to 8250_pci.c,
parport_pc.c, and parport_serial.c to cleanup and support the Timedia based
serial, parallel, and serial/parallel combo cards.  It appears some cleanup
is in order here, and I'd appreciate opinions on how I should proceed. This
is the first time I've prepared a patch for submission, so prepare for some
noobness ....

My goal is to get a Timedia 4089 (2 serial/2 parallel multi-function card)
to be recognized. What I've found is ...

1) Insmodding 8250_pci alone gets the driver to probe and find the serial
ports. It then proceeds to init them wrong (at least for multi-function
cards).
2) Insmodding parport_pc alone gets the driver to recognize the parallel
ports and config them correctly.
3) Once either 8250_pci or parport_pc inits, the other doesn't get a chance
to setup the card (hence the need for parport_serial).
4) Insmodding parport_serial is a problem since either parport_pc or
8250_pci get to the card first.

So, It seems to me that 8250_pci and parport_pc should *not* be trying to
init these mutifunction cards (that's the job of parport_serial).

Currently I have things working where the pci_timedia_init() returns an
error for multiport cards (which keeps the 8250_pci from initting the card).
In parport_pc, I can remove the 18 table entries corresponding to the
multifunction cards.

The last task is to fix this ...
        /* Timedia/SUNIX uses a mixture of BARs and offsets */
        /* Ugh, this is ugly as all hell --- TYT */
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
Yup, ugly as hell, and broken for multifunction cards. I only have my one
2s/2p card, so figuring the correct algorithm may be tricky. I'm guessing
that this works for the pure serial cards, and can be left alone in
8250_pci.c. For parport_serial, this is simply wrong (unless I'm really
missing something).

Now for the questions ...

1) Should I put in ifdef CONFIG_PARPORT_SERIAL to keep the definitions of
multifunction cards out of 8250_pci and parport_pc, or just whack them
completely? The ifdef seems nicer, but retains broken cruft.

2) Any insight on the best means to patch the multifunction cards from
getting recognized by the 8250_pci? Having pci_timedia_init() return an
error keeps the patch small, but a purist may prefer just filling out the
table entries.

3) Anyone have Timedia PCI cards (serial only, parallel only,
multifunction), that I could gather some info for?

Thanks for reading through this. Since I'm doing this, I'd rather get it
"right".

Rob Currey
avalonforest @ centurytel.net

Just FYI ... (and future googlers)

00:09.0 Serial controller: Timedia Technology Co Ltd PCI2S550 (Dual 16550
UART) (rev 01) (prog-if 02 [16550])
        Subsystem: Timedia Technology Co Ltd: Unknown device 4089
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at 9400 [size=32]
        Region 2: I/O ports at 9000 [size=8]              <==== Parallel
port (external)
        Region 3: I/O ports at 8800 [size=8]              <==== Serial port
(external)
        Region 4: I/O ports at 8400 [size=8]              <==== Parallel
port (internal)
        Region 5: I/O ports at 8000 [size=8]              <==== Serial port
(internal)



