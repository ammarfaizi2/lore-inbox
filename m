Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272252AbRHWMzI>; Thu, 23 Aug 2001 08:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272253AbRHWMy7>; Thu, 23 Aug 2001 08:54:59 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:41478 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S272252AbRHWMyq>;
	Thu, 23 Aug 2001 08:54:46 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: kraxel
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: yenta_socket hangs sager laptop in kernel 2.4.6-> PNPBIOS life saver
Date: 23 Aug 2001 12:50:33 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrn9o9v0p.p2.kraxel@bytesex.org>
In-Reply-To: <E15Zca4-0001z2-00@the-village.bc.nu> <20010823111122.B1143@bytesex.org>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 998571033 833 127.0.0.1 (23 Aug 2001 12:50:33 GMT)
User-Agent: slrn/0.9.7.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  But it seems they are _not_ reserved by the pnp bios code, at least they
>  are not listed in /proc/ioports

I've hacked up a small piece of code which does the ressource
registering:

----------------- cut here ------------------
#include <linux/config.h>
#include <linux/module.h>
#include <linux/init.h>

#include <asm/io.h>
#include <asm/dma.h>
#include <asm/uaccess.h>

#include <linux/pnp_bios.h>

static void register_stuff(struct pci_dev *dev)
{
	struct resource *res;
	int i;

	for (i = 0; i < DEVICE_COUNT_RESOURCE &&
		    (dev->resource[i].start || dev->resource[i].end); i++) {
		if (dev->resource[i].start <= 0xffff) {
			res = request_region(dev->resource[i].start,
				dev->resource[i].end - dev->resource[i].start,
				dev->name);
			printk("mboard: alloc io: 0x%04lx-0x%04lx [%s,%s]\n",
				dev->resource[i].start,
				dev->resource[i].end,
				dev->name, res ? "ok" : "failed");
		}
	}
	if (i == DEVICE_COUNT_RESOURCE)
		printk("mboard: warning: >= %d resources\n",
			DEVICE_COUNT_RESOURCE);
}

static int mboard_init(void)
{
	struct pci_dev *dev;
	int found;

	dev = NULL;
	found = 0;
	while ((dev=pnpbios_find_device("PNP0c01",dev))) {
		register_stuff(dev);
		found++;
	}
	if (found)
		MOD_INC_USE_COUNT;
	return 0;
}

static void mboard_fini(void)
{
}

module_init(mboard_init);
module_exit(mboard_fini);

----------------- cut here ------------------

A full patch with this + pnpbios support (pulled out of -ac) for 2.4.9
is available from http://bytesex.org/notebook/pnpbios-2.4.9.diff

Now I have this in my /proc/ioports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
0090-009f : PNPBIOS
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0230-0233 : PNPBIOS
02f8-02ff : nsc-ircc
0398-0399 : PNPBIOS
03c0-03df : vesafb
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-103f : PNPBIOS
1100-110f : Intel Corporation 82440MX EIDE Controller
  1100-1107 : ide0
1200-121f : Intel Corporation 82440MX USB Universal Host Controller
  1200-121f : usb-uhci
1400-140f : PNPBIOS
1500-153f : Intel Corporation 82440MX AC'97 Audio Controller
  1500-153f : Intel 440MX
1600-16ff : Intel Corporation 82440MX AC'97 Audio Controller
  1600-16ff : Intel 440MX
1700-177f : PCI device 8086:7196 (Intel Corporation)
1800-18ff : PCI device 8086:7196 (Intel Corporation)
1c00-1cff : PCI CardBus #01
2000-20ff : PCI CardBus #01
3000-30ff : ATI Technologies Inc 3D Rage P/M Mobility
3810-381f : PNPBIOS
3e00-3eff : Realtek Semiconductor Co., Ltd. RTL-8139
  3e00-3eff : 8139too

Note that DEVICE_COUNT_RESOURCE == 12 is too small to hold all the
resources, so I've bumped that to 16.

  Gerd

-- 
Damn lot people confuse usability and eye-candy.
