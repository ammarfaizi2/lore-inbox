Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbTCJQxe>; Mon, 10 Mar 2003 11:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261208AbTCJQxe>; Mon, 10 Mar 2003 11:53:34 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:23557
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S261363AbTCJQxa>; Mon, 10 Mar 2003 11:53:30 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33DD8@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Robert White'" <rwhite@casabyte.com>,
       Bryan Whitehead <driver@jpl.nasa.gov>
Cc: linux-newbie@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RE: devfs + PCI serial card = no extra serial ports (probably uns
	upported card)
Date: Mon, 10 Mar 2003 09:04:10 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 6:18 PM, Robert White wrote:
> 
> I had a similar problem, but the actual problem had nothing 
> to do with the
> devfs, the PCI serial card in question was not in the list of 
> PCI devices.
> (It was a one-off P.O.S.. from CompUSA.)  Neither the serial ports nor
> parallel port were recognized.  The box claimed it was an 
> 16PCI592 but the
> chip maker had reved the chip ID.
> 
> The solution was to use scanpci to get the vendor and device 
> numbers and
> then add the numbers to pci_ids.h and then put an entry into the
> serial_pci_tbl array in serial.c.  It took a little 
> investigative work to
> find which PCI ids were for the card (I took it out, did a 
> scanpci, put it
> back in and did it again and looked at what changed. [I was 
> very newbie at
> the time 8-)])
> 
> Consider these two diffs, they added support for the card to 
> the driver.  I
> had to guess at some of the values but fortunately there was 
> a very similar
> listing in serial.c already.
> 
> After that, the card appears in the device file system normally.
> 
> ===== cut here =====
> --- /tmp/pci_ids.h.orig 2003-03-07 17:59:07.000000000 -0800
> +++ linux/include/linux/pci_ids.h       2002-07-29 
> 01:51:19.000000000 -0700
> @@ -1477,6 +1477,8 @@
>  #define PCI_DEVICE_ID_OXSEMI_16PCI952  0x950A
>  #define PCI_DEVICE_ID_OXSEMI_16PCI95N  0x9511
>  #define PCI_DEVICE_ID_OXSEMI_16PCI954PP        0x9513
> +#define PCI_DEVICE_ID_OXSEMI_16PCI952DS        0x9521 // later rev or
> something
> +#define PCI_DEVICE_ID_OXSEMI_16PCI952PP        0x9513 // the 
> Parallel Port
> device
> 
>  #define PCI_VENDOR_ID_AIRONET          0x14b9
>  #define PCI_DEVICE_ID_AIRONET_4800_1   0x0001
> --- /tmp/serial.c.orig  2003-03-07 17:59:56.000000000 -0800
> +++ linux/drivers/char/serial.c 2002-07-29 01:42:35.000000000 -0700
> @@ -4658,6 +4658,9 @@
>         {       PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI952,
>                 PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>                 pbn_b0_2_115200 },
> +       {       PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI952DS,
> +               PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +               pbn_b0_bt_2_115200 },
> 
>         /* Digitan DS560-558, from jimd@esoft.com */
>         {       PCI_VENDOR_ID_ATT, PCI_DEVICE_ID_ATT_VENUS_MODEM,
> ===== cut here =====
> 
> (Note that this caused the devices to appear as /dev/(tts|cua)/4 and
> /dev/(tts|cua)/5 even though I only have one other available 
> serial port.
> The first four (0..3) are reserved for the built in/reserved 
> COM1 though
> COM4 no matter what.  This is expected.)
> 
> Alternately, if the card came with drivers, the manufacturer 
> may have simply
> chosen not to support the devfs filesystem.  Nothing much you 
> can do in that
> case except yell at the manufacturer.
> 
> Rob.

Hi Rob,

Yep. What happened is that the wrong ID was in the PCI database for 952. 
Oxford does not even have a chip with device ID 950A. The EXSYS EX41092 
violated the PCI rules and assigned their own device ID in Oxford's space. 
They reprogrammed the 954 chip's device ID instead of using the subvendor 
and subsystem IDs. oops. It was a 2-port card so everybody assumed that 
it was an OX16PCI952 chip so device ID 950A crept into the PCI database 
as the 952. The chip on that card was actually an OX16PCI954, which has a 
programming interface that differs from the 952 at the second port, which 
has caused a bit more teeth grinding. 

The PCI device ID of the real OX16PCI952 was always 9521. 
1415:950A:XXXX:XXXX is an EXSYS EX41092 card.
1415:9521:XXXX:XXXX is a card based on a real Oxford OX16PCI952 chip.

So, you were absolutely right all along ...

Cheers,
Ed

---------------------------------------------------------------- 
Ed Vance              edv (at) macrolink (dot) com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
