Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267426AbTAVLSs>; Wed, 22 Jan 2003 06:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267427AbTAVLSs>; Wed, 22 Jan 2003 06:18:48 -0500
Received: from nas-cbv-5-62-147-146-111.dial.proxad.net ([62.147.146.111]:9600
	"HELO lagavulin.satm.airfrance.fr") by vger.kernel.org with SMTP
	id <S267426AbTAVLSq> convert rfc822-to-8bit; Wed, 22 Jan 2003 06:18:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Sylvain Goletto <sylvain-af@goletto.net> (by way of Sylvain Goletto
	<m330415@satm.airfrance.fr>)
Organization: Air France
Subject: [Bug] Timedia support in serial driver
Date: Wed, 22 Jan 2003 12:27:43 +0100
User-Agent: KMail/1.4.3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301221227.43098.m330415@satm.airfrance.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am using a timedia pci 2 ports serial card
Vendor ID :1409
Device ID:7168
SubSystem ID: 4036

This device is not recognized by auto_configure procedure after a quick look
in the serial.c file and few mods for more debug printk, I noticed that the
get_pci_port doesn't see the 2 ports as it doesn't read the base address
correctly. There is a specific piece of code for Timedia cards in the
procedure but it sets a wrong base_idx in my case.

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

The get_pci_port procedure is called by start_pci_pnp_board for each ports of
the board like this:

        for (k=0; k < board->num_ports; k++) {
                serial_req.irq = get_pci_irq(dev, board, k);
                if (get_pci_port(dev, board, &serial_req, k))
                        break;

So K is starting from 0.

but the serial_pci_guess_board procedure detects the following:
num_port = 2
first_port = 2

So when get_pci_port is called for the first port with k=0, base_idx is set
 to 0 and offset is set to 0 so the pci_resource_start returns the base
 address for resource 0 and the first port is at resource 2 so get_pci_port 
 always return 0 for port address (wrong).

I wonder if the PB comes from Timedia specific piece of code (bad base_idx)
or if it comes from the fact that the board->first_port is never set/used

if the board->first_port is set, the start_pci_pnp_board  loop should become:

--   for (k=0; k < board->num_ports; k++) {
++  for (k=board->first_port; k < board->first_port+board->num_ports; k++)  {
            serial_req.irq = get_pci_irq(dev, board, k);
            if (get_pci_port(dev, board, &serial_req, k))
                    break;
...

starting at board->first_port and not always 0

Tank you

Sylvain

