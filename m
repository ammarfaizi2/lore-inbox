Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290719AbSARPRJ>; Fri, 18 Jan 2002 10:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290720AbSARPQ7>; Fri, 18 Jan 2002 10:16:59 -0500
Received: from linux2.viasys.com ([194.100.28.129]:53263 "HELO mail.viasys.com")
	by vger.kernel.org with SMTP id <S290719AbSARPQl>;
	Fri, 18 Jan 2002 10:16:41 -0500
Message-ID: <00c201c1a033$1cf46700$b71c64c2@viasys.com>
From: "Jani Forssell" <jani.forssell@viasys.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <akpm@zip.com.au>,
        =?iso-8859-1?Q?Fran=E7ois_Cami?= <stilgar2k@wanadoo.fr>,
        <daniel.blueman@btinternet.com>, "Vojtech Pavlik" <vojtech@suse.cz>
Subject: VIA KT133 & HPT 370 IDE disk corruption
Date: Fri, 18 Jan 2002 17:16:33 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We first reported disk corruption with a VIA KT133A based board (Abit KT7A)

http://marc.theaimsgroup.com/?l=linux-kernel&m=100651892331843&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=100669782329815&w=2

and then switched to a VIA KT133 board (Abit KT7) that showed the same
symptoms. It finally seems to be working, so I'm going to try to summarise
our
experiences.

The test configuration is:

VIA KT133
kernels: stock 2.4.18pre2, 2.2.21pre2 and 2.2.20 (both with Hedrick
IDE patch 05042001 )
Two hdds and a cdrom attached to the onboard hpt 370 controller
3com 905b-tx
Matrox G200 AGP

In this configuration, we could force an oops

http://marc.theaimsgroup.com/?l=linux-kernel&m=101052001508211&w=2

with all the kernels we tested on each boot by running:

cat /dev/hde > null &
cat /dev/hdg > null &
ping -f -s 64000 otherMachine &

It usually took about 15 seconds for the oops to trigger. We also verified
that wgetting a file (instead of ping -f) on the local 100mbit network would
trigger the oops.

The peculiar thing is that with certain BIOS settings the disk read & write
test didn't show errors, even when left running over the weekend. But when
the ping -f was launched, it started immediately showing disk corruption
(from
4 to ~1000 bytes in 64 megabyte blocks). The data corruption most likely
happened when both disks were read in parallel. We weren't able to trigger
disk corruption with disks on VIA IDE (686A & 686B).

It turned out that the main culprit was the NIC that was attached to PCI
slot
4. Moving it to slot 3 resolved the disk corruption as well as the oopses
that
occured. Other PCI slots to avoid for the NIC were 5 and 6. Slot 4 & 6
shares
an IRQ with the VIA USB controller, but I did try disabling it from the BIOS
but it didn't help (lspci didn't show the device after it had been
disabled).
Slot 5 shares and IRQ with the Highpoint controller.

Finally, we tested that it works with an  Adaptec 2940UW SCSI card in PCI
slot
1 and the NIC in PCI slot 3.

More details on request. Does anyone have any idea what causes this?

Jani Forssell

