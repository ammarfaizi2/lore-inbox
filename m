Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286357AbRLJSk6>; Mon, 10 Dec 2001 13:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286359AbRLJSkm>; Mon, 10 Dec 2001 13:40:42 -0500
Received: from ns.ithnet.com ([217.64.64.10]:46852 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S286357AbRLJSkV>;
	Mon, 10 Dec 2001 13:40:21 -0500
Date: Mon, 10 Dec 2001 19:40:03 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Christian Laursen <xi@borderworlds.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NULL pointer dereference in moxa driver
Message-Id: <20011210194003.1cb9f54a.skraw@ithnet.com>
In-Reply-To: <m3zo4rm05v.fsf@borg.borderworlds.dk>
In-Reply-To: <m3zo4rm05v.fsf@borg.borderworlds.dk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Dec 2001 18:53:48 +0100
Christian Laursen <xi@borderworlds.dk> wrote:

> I have a problem when trying to use two of the serial cards known as
> MOXA C104H/PCI.
> 
> When only using one, everything works like a charm, but when
> an attempt is made to access a serial port on the second card,
> I get a NULL pointer dereference.
> 
> 
> This is the relevant output from dmesg:
> 
> MOXA Smartio family driver version 1.2
> Tty devices major number = 174, callout devices major number = 175
> Found MOXA C104H/PCI series board(BusNo=0,DevNo=10)
> 
> 
> The relevant stuff from /proc/pci:
> 
>   Bus  0, device  10, function  0:
>     Serial controller: Moxa Technologies Co Ltd Smartio C104H/PCI (rev 2).
>       IRQ 10.
>       I/O at 0xa800 [0xa87f].
>       I/O at 0xa400 [0xa43f].
>       I/O at 0xa000 [0xa00f].
>   Bus  0, device  11, function  0:
>     Serial controller: Moxa Technologies Co Ltd Smartio C104H/PCI (#2) (rev 2).
>       IRQ 11.
>       I/O at 0x9800 [0x987f].
>       I/O at 0x9400 [0x943f].
>       I/O at 0x9000 [0x900f].

Well there you have it: they didn't recognise the second board at all. The dmesg should show it, but does not.
Please try attached patch to mxser.c. I cannot test, I have no two cards (in fact I haven't a single one either ;-). If it works out tell me and send patch to support@moxa.com.tw with regards from me :-)

Have fun,
Stephan


--- linux/drivers/char/mxser.c-orig     Mon Dec 10 19:29:13 2001
+++ linux/drivers/char/mxser.c  Mon Dec 10 19:34:36 2001
@@ -614,9 +614,9 @@
                n = (sizeof(mxser_pcibrds) / sizeof(mxser_pcibrds[0])) - 1;
                index = 0;
                for (b = 0; b < n; b++) {
-                       pdev = pci_find_device(mxser_pcibrds[b].vendor,
-                                              mxser_pcibrds[b].device, pdev);
-                       if (!pdev || pci_enable_device(pdev))
+                       while (pdev = pci_find_device(mxser_pcibrds[b].vendor,
+                                              mxser_pcibrds[b].device, pdev)) {
+                       if (pci_enable_device(pdev))
                                continue;
                        hwconf.pdev = pdev;
                        printk("Found MOXA %s board(BusNo=%d,DevNo=%d)\n",
@@ -646,6 +646,7 @@
 
                        }
 
+                       }
                }
        }
 #endif



