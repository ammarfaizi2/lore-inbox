Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261990AbTCHCHk>; Fri, 7 Mar 2003 21:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262000AbTCHCHi>; Fri, 7 Mar 2003 21:07:38 -0500
Received: from mail.casabyte.com ([209.63.254.226]:33796 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP
	id <S261990AbTCHCHa>; Fri, 7 Mar 2003 21:07:30 -0500
From: "Robert White" <rwhite@casabyte.com>
To: "Bryan Whitehead" <driver@jpl.nasa.gov>, "Ed Vance" <EdV@macrolink.com>
Cc: <linux-newbie@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: devfs + PCI serial card = no extra serial ports (probably unsupported card)
Date: Fri, 7 Mar 2003 18:17:50 -0800
Message-ID: <PEEPIDHAKMCGHDBJLHKGCEGCCCAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3E69289F.5070801@jpl.nasa.gov>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had a similar problem, but the actual problem had nothing to do with the
devfs, the PCI serial card in question was not in the list of PCI devices.
(It was a one-off P.O.S.. from CompUSA.)  Neither the serial ports nor
parallel port were recognized.  The box claimed it was an 16PCI592 but the
chip maker had reved the chip ID.

The solution was to use scanpci to get the vendor and device numbers and
then add the numbers to pci_ids.h and then put an entry into the
serial_pci_tbl array in serial.c.  It took a little investigative work to
find which PCI ids were for the card (I took it out, did a scanpci, put it
back in and did it again and looked at what changed. [I was very newbie at
the time 8-)])

Consider these two diffs, they added support for the card to the driver.  I
had to guess at some of the values but fortunately there was a very similar
listing in serial.c already.

After that, the card appears in the device file system normally.

===== cut here =====
--- /tmp/pci_ids.h.orig 2003-03-07 17:59:07.000000000 -0800
+++ linux/include/linux/pci_ids.h       2002-07-29 01:51:19.000000000 -0700
@@ -1477,6 +1477,8 @@
 #define PCI_DEVICE_ID_OXSEMI_16PCI952  0x950A
 #define PCI_DEVICE_ID_OXSEMI_16PCI95N  0x9511
 #define PCI_DEVICE_ID_OXSEMI_16PCI954PP        0x9513
+#define PCI_DEVICE_ID_OXSEMI_16PCI952DS        0x9521 // later rev or
something
+#define PCI_DEVICE_ID_OXSEMI_16PCI952PP        0x9513 // the Parallel Port
device

 #define PCI_VENDOR_ID_AIRONET          0x14b9
 #define PCI_DEVICE_ID_AIRONET_4800_1   0x0001
--- /tmp/serial.c.orig  2003-03-07 17:59:56.000000000 -0800
+++ linux/drivers/char/serial.c 2002-07-29 01:42:35.000000000 -0700
@@ -4658,6 +4658,9 @@
        {       PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI952,
                PCI_ANY_ID, PCI_ANY_ID, 0, 0,
                pbn_b0_2_115200 },
+       {       PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI952DS,
+               PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+               pbn_b0_bt_2_115200 },

        /* Digitan DS560-558, from jimd@esoft.com */
        {       PCI_VENDOR_ID_ATT, PCI_DEVICE_ID_ATT_VENUS_MODEM,
===== cut here =====

(Note that this caused the devices to appear as /dev/(tts|cua)/4 and
/dev/(tts|cua)/5 even though I only have one other available serial port.
The first four (0..3) are reserved for the built in/reserved COM1 though
COM4 no matter what.  This is expected.)

Alternately, if the card came with drivers, the manufacturer may have simply
chosen not to support the devfs filesystem.  Nothing much you can do in that
case except yell at the manufacturer.

Rob.




-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Bryan Whitehead
Sent: Friday, March 07, 2003 3:18 PM
To: Ed Vance
Cc: linux-newbie@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: devfs + PCI serial card = no extra serial ports



> What serial driver initialization messages do you get from dmesg?
> Is the "MANY_PORTS" flag present in the list of enabled options?
> Which distribution and rev level are you using?

My boot messages say this:
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT
SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A

It only sets up my built-into-motherboard serial ports. The add on card
gets ignored.

I would have thought with SERIAL_PCI enabled I would have no problem.
But it doesn't seem to be so.

doing the quick/dirty setserial stuff with my own mknod's work. but it's
a big "messy". I'd at least like to get this fixed so next kernel
version I don't need to do a quick hack todo something as simple as
getting a serial port working.

I can post my entire dmesg if needed allong with my complete /proc/pci.
I'm also willing to play with patches. (if this is already fixed in a
later kernel than 2.4.19 I'd be willing to give it a go).



> Ed
>
> -----Original Message-----
> From: Bryan Whitehead [mailto:driver@jpl.nasa.gov]
> Sent: Friday, March 07, 2003 2:55 PM
> To: linux-kernel@vger.kernel.org
> Cc: linux-newbie@vger.kernel.org
> Subject: Re: devfs + PCI serial card = no extra serial ports
>
>
>
> BTW, this is with 2.4.19 (kernel shipped with distro).... I'm willing to
> test any patches / rebuild kernel to get this working.....
>
>
> Bryan Whitehead wrote:
>
>>It seems devfsd has an annoying "feature". I bought a PCI card to get a
>>couple (2) more serial ports. The kernel doesn't seem to set up the
>>serial ports at boot, so devfs never creates an entry. However, post
>>boot, since there is no entries, I cannot configure the serial ports
>>with setserial. So basically devfsd = no PCI based serial add on?
>>
>>03:05.0 Serial controller: NetMos Technology 222N-2 I/O Card (2S+1P)
>>(rev 01) (prog-if 02 [16550])
>>    Subsystem: LSI Logic / Symbios Logic (formerly NCR): Unknown device
>>0002
>>    Flags: medium devsel, IRQ 17
>>    I/O ports at ecf8 [size=8]
>>    I/O ports at ece8 [size=8]
>>    I/O ports at ecd8 [size=8]
>>    I/O ports at ecc8 [size=8]
>>    I/O ports at ecb8 [size=8]
>>    I/O ports at eca0 [size=16]
>>
>>
>>mknod ttyS2 c 4 66
>>mknod ttyS3 c 4 67
>>setserial ttyS2 port 0xecf8 UART 16550A irq 17 Baud_base 9600
>>setserial ttyS3 port 0xece8 UART 16550A irq 17 Baud_base 9600
>>
>>I hoped after "setting up" the serial ports with setserial some magic
>>would happen and they would apear in /dev/tts... but I was wrong.
>>
>>gets me working serial ports... but it's not in /dev... :O
>>
>>Am I just screwed?
>>
>>If so, what would be a good add on PCI based solution for more serial
>>ports that WORKS with devfsd? (I don't want to disable devfs as this
>>opens up a different set of problems)
>>
>>Thanks for any replay!
>>
>
>
>


--
Bryan Whitehead
SysAdmin - JPL - Interferometry Systems and Technology
Phone: 818 354 2903
driver@jpl.nasa.gov

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

