Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288623AbSAQMIN>; Thu, 17 Jan 2002 07:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288624AbSAQMIE>; Thu, 17 Jan 2002 07:08:04 -0500
Received: from zeus.kernel.org ([204.152.189.113]:1942 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S288623AbSAQMHv>;
	Thu, 17 Jan 2002 07:07:51 -0500
Date: Thu, 17 Jan 2002 03:49:23 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Gerald Champagne <gerald.champagne@esstech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Promise 20268 PCI register decoding
In-Reply-To: <3C462E5E.4020802@esstech.com>
Message-ID: <Pine.LNX.4.10.10201170302060.30663-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002, Gerald Champagne wrote:

> I just checked 2.5.3-pre1 and it still makes references to
> registers above 0x0f.   I see many references to registers
> at  0x11, 0x1b, 0x1f.  For example, the following:
> 
> unsigned long atapi_reg	= high_16 + (hwif->channel ? 0x24 : 0x00);
> 
> That assumes atapi_reg will be 0x24 beyond the base of bar4 (high_16).
> Is my PCI code showing me an incorrect size for bar4, or is this
> accessing registers beyond its limits?

Look in ide-pci.c

cat /proc/ioports | grep 20267
df00-df3f : Promise Technology, Inc. 20267
  df10-df3f : PDC20267
dfa0-dfa7 : Promise Technology, Inc. 20267
dfa8-dfab : Promise Technology, Inc. 20267
dfac-dfaf : Promise Technology, Inc. 20267
dfe0-dfe7 : Promise Technology, Inc. 20267

pci bus 0x0 cardnum 0x03 function 0x0000: vendor 0x105a device 0x4d30
 Device unknown
 CardVendor 0x105a card 0x4d39 (Card unknown)
  STATUS    0x0210  COMMAND 0x0007
  CLASS     0x01 0x04 0x00  REVISION 0x02
  BIST      0x00  HEADER 0x00  LATENCY 0x40  CACHE 0x00
  BASE0     0x0000dfe1  addr 0x0000dfe0  I/O
  BASE1     0x0000dfad  addr 0x0000dfac  I/O
  BASE2     0x0000dfa1  addr 0x0000dfa0  I/O
  BASE3     0x0000dfa9  addr 0x0000dfa8  I/O
  BASE4     0x0000df01  addr 0x0000df00  I/O
  BASE5     0xfeaa0000  addr 0xfeaa0000  MEM
  BASEROM   0xfeae0001  addr 0xfeae0000  decode-enabled
  MAX_LAT   0x00  MIN_GNT 0x00  INT_PIN 0x01  INT_LINE 0x0b



        {DEVID_PDC20246,"PDC20246",     PCI_PDC202XX,   NULL,
INIT_PDC202XX,  NULL,           {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
OFF_BOARD,
16 },
        {DEVID_PDC20262,"PDC20262",     PCI_PDC202XX,   ATA66_PDC202XX,
INIT_PDC202XX,  NULL,           {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
OFF_BOARD,
48 },
        {DEVID_PDC20265,"PDC20265",     PCI_PDC202XX,   ATA66_PDC202XX,
INIT_PDC202XX,  NULL,           {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
OFF_BOARD,
48 },
        {DEVID_PDC20267,"PDC20267",     PCI_PDC202XX,   ATA66_PDC202XX,
INIT_PDC202XX,  NULL,           {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
OFF_BOARD,
48 },
        {DEVID_PDC20268,"PDC20268",     PCI_PDC202XX,   ATA66_PDC202XX,
INIT_PDC202XX,  NULL,           {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
OFF_BOARD,
0 },
        {DEVID_PDC20268R,"PDC20270",    PCI_PDC202XX,   ATA66_PDC202XX,
INIT_PDC202XX,  NULL,           {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
OFF_BOARD,
0 },
        {DEVID_PDC20269,"PDC20269",     PCI_PDC202XX,   ATA66_PDC202XX,
INIT_PDC202XX, NULL,           {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
OFF_BOARD,
0 },
        {DEVID_PDC20275,"PDC20275",     PCI_PDC202XX,   ATA66_PDC202XX,
INIT_PDC202XX,  NULL,           {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
OFF_BOARD,
0 },


int pdc202xx_dmaproc (ide_dma_action_t func, ide_drive_t *drive)

        switch (dev->device) {
                case PCI_DEVICE_ID_PROMISE_20275:
                case PCI_DEVICE_ID_PROMISE_20269:
                case PCI_DEVICE_ID_PROMISE_20268R:
                case PCI_DEVICE_ID_PROMISE_20268:
                        newchip = 1;
                        break;
                case PCI_DEVICE_ID_PROMISE_20267:
                case PCI_DEVICE_ID_PROMISE_20265:
                case PCI_DEVICE_ID_PROMISE_20262:
                        hardware48hack = 1;
                        clock = IN_BYTE(high_16 + 0x11);
                default:
                        break;
        }

See above that 62/65/67 have 48 extra io registers.

This it is legal to touch and use them.

Cheers,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development


