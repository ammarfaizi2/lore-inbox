Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbVBTLn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVBTLn4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 06:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVBTLn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 06:43:56 -0500
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:57483 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S261815AbVBTLnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 06:43:49 -0500
Message-ID: <42187819.5050808@uni-muenster.de>
Date: Sun, 20 Feb 2005 12:44:25 +0100
From: Martin Drohmann <m_droh01@uni-muenster.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Why does printk helps PCMCIA card to initialise?
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
 
After updating to a new kernel (>2.6.8) my PCMCIA ISDN did not work 
anymore.

My test system now looks like this:

 > uname -s -r -v -m
Linux 2.6.11-rc4 #5 Sun Feb 20 05:19:02 CET 2005 x86_64
 > lspci | grep CardBus
0000:02:07.0 CardBus bridge: Texas Instruments PCI4510 PC card Cardbus 
Controller (rev 02)
 > cardctl info
cardctl info
PRODID_1="SEDLBAUER"
PRODID_2="ISDN-Adapter"
PRODID_3=" (c) 93-96 VK&CB"
PRODID_4="26.01.96"
MANFID=0000,0000
FUNCID=6

The initialisation of my ISDN always failed with the following error 
messages:

...
kernel: HiSax: LinkLayer Revision 2.59.2.4 
kernel: cs: pcmcia_socket0: read_cis_mem(1, 0x3f, 5) 
kernel: cs: pcmcia_socket0: 0x01 0x07 0x00 0x02 ... 
kernel: cs: pcmcia_socket0: read_cis_mem(1, 0x46, 13) 
kernel: cs: pcmcia_socket0: 0xc1 0x81 0x19 0x01 ... 
kernel: cs: pcmcia_socket0: odd IO request: base 0x260 align 0x8 
kernel: cs: pcmcia_socket0: read_cis_mem(1, 0x55, 7) 
kernel: cs: pcmcia_socket0: 0x02 0x08 0xaa 0x60 ... 
kernel: cs: pcmcia_socket0: odd IO request: base 0x270 align 0x8 
kernel: cs: pcmcia_socket0: read_cis_mem(1, 0x5e, 7) 
kernel: cs: pcmcia_socket0: 0x03 0x08 0xaa 0x60 ... 
kernel: cs: pcmcia_socket0: odd IO request: base 0x280 align 0x8 
kernel: cs: pcmcia_socket0: read_cis_mem(1, 0x67, 7) 
kernel: cs: pcmcia_socket0: 0x04 0x08 0xaa 0x60 ... 
kernel: cs: pcmcia_socket0: odd IO request: base 0x2e8 align 0x8 
kernel: cs: pcmcia_socket0: read_cis_mem(1, 0x70, 7) 
kernel: cs: pcmcia_socket0: 0x05 0x08 0xaa 0x60 ... 
kernel: cs: pcmcia_socket0: odd IO request: base 0x2f8 align 0x8 
kernel: cs: pcmcia_socket0: read_cis_mem(1, 0x79, 7) 
kernel: cs: pcmcia_socket0: 0x06 0x08 0xaa 0x60 ... 
kernel: cs: pcmcia_socket0: odd IO request: base 0x350 align 0x8 
kernel: cs: pcmcia_socket0: read_cis_mem(1, 0x82, 7) 
kernel: cs: pcmcia_socket0: 0x07 0x08 0xaa 0x60 ... 
kernel: cs: pcmcia_socket0: odd IO request: base 0x3e8 align 0x8 
kernel: 0.0: GetNextTuple: No more items
...

So obviously, the kernel fails to allocate an io port window for the 
PCMCIA adapter, and complains about a bad request for such a window. 
However, if interprete these values as a request of an 8bit large IO 
Window starting at base, I don't know what's so odd about it. Maybe, 
this interpretation is wrong? Furthermore, /proc/ioports tells me that 
the requested IO addresses are NOT used.

Well, I browsed the sources and added simple debug messages to the code 
in order to find out, what function exactly returns an error and stops 
the initialisation of my card. This debug led me to the function 
"nonstatic_find_io_region" in drivers/pcmcia/rsrc_nonstatic.c that is 
used by yenta_socket. To my very surprise, the ISDN card suppenly worked 
after I added a "printk" that never executes. The file rsrc_nonstatic.c 
then changed like this: 
 
diff -u -U 7 /linux-2.6.11-rc4.changed/drivers/pcmcia/rsrc_nonstatic.c 
../linux-2.6.11-rc4/drivers/pcmcia/rsrc_nonstatic.c
--- /linux-2.6.11-rc4.changed/drivers/pcmcia/rsrc_nonstatic.c     
2005-02-20 11:37:39.000000000 +0100
+++ ../linux-2.6.11-rc4/drivers/pcmcia/rsrc_nonstatic.c     2005-02-20 
02:16:48.000000000 +0100
@@ -623,15 +623,14 @@
        down(&rsrc_sem);
 #ifdef CONFIG_PCI
        if (s->cb_dev) {
                ret = pci_bus_alloc_resource(s->cb_dev->bus, res, num, 1,
                                             min, 0, pcmcia_align, &data);
        } else
 #endif
-        printk("This line will never be printed, but it helps!!!");
                ret = allocate_resource(&ioport_resource, res, num, min, 
~0UL,
                                        1, pcmcia_align, &data);
        up(&rsrc_sem);
 
        if (ret != 0) {
                kfree(res);
                res = NULL;

Then sedlbauer_cs initialises with following debug messages:

...
kernel: HiSax: LinkLayer Revision 2.59.2.4
kernel: cs: pcmcia_socket0: read_cis_mem(1, 0x3f, 5)
kernel: cs: pcmcia_socket0:   0x01 0x07 0x00 0x02 ...
kernel: cs: pcmcia_socket0: read_cis_mem(1, 0x46, 13)
kernel: cs: pcmcia_socket0:   0xc1 0x81 0x19 0x01 ...
kernel: cs: pcmcia_socket0: odd IO request: base 0x260 align 0x8
kernel: cs: pcmcia_socket0: write_cis_mem(1, 0x100, 1)
kernel: cs: pcmcia_socket0: write_cis_mem(1, 0x101, 1)
kernel: sedlbauer: index 0x01: Vcc 5.0, irq 18, io 0x0260-0x0267
kernel: HiSax: Card 1 Protocol EDSS1 Id=HiSax (0)
kernel: HiSax: Sedlbauer driver Rev. 1.34.2.6
kernel: Sedlbauer: defined at 0x260-0x268 IRQ 18
kernel: Sedlbauer: testing IPAC version 0
kernel: Sedlbauer: speed star detected
...

So the io request stay odd, but now it works. If printk is not there, 
allocate_resource returns with error code EBUSY. I do not understand 
that at all. Maybe my printk irritates the semaphore that is set around 
the allocate_resource? However, then my "solution" won't be very safe, 
although my card works perfectly now. I have only a very basic 
understanding of those kernel functions, and wonder if someone can tell 
me, what this is all about. 
 
Thanks, 
Martin Drohmann

