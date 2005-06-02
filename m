Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVFBURX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVFBURX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 16:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVFBUPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:15:22 -0400
Received: from smtpq1.home.nl ([213.51.128.196]:12475 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S261313AbVFBUNw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 16:13:52 -0400
Message-ID: <429F0570.1090004@keyaccess.nl>
Date: Thu, 02 Jun 2005 15:11:12 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Mark Lord <lkml@rtr.ca>,
       David Brownell <dbrownell@users.sourceforge.net>
Subject: Re: External USB2 HDD affects speed hda
References: <429BA001.2030405@keyaccess.nl> <20050601081810.GA23114@elf.ucw.cz> <429DFD90.10802@keyaccess.nl> <200506011240.09540.david-b@pacbell.net> <429E3338.9000401@keyaccess.nl> <20050602135737.GO23621@csclub.uwaterloo.ca>
In-Reply-To: <20050602135737.GO23621@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:

> I just tried pluging in my usb2 flash reader which ought to d the same
> thing to usb-storage as pluging in the external usb2 hd.
> 
> Reading from a 120G SATA WD drive gets about 41MB/s without the USB2
> drive connected and about the same with.  That is on an nforce2
> motherboard with it's builtin usb controller and using 2.6.10.
> 
> Trying on an Athlon64 with a 250G SATA WD drive and the same usb flash
> reader, I get 57MB/s both with and without the usb2 drive connected.
> That one uses a VIA K8T800 chipset and also 2.6.10.
> 
> I wonder what is different with your hardware/software mix.

Many thanks for trying but our systems really are quite different. I'm 
on an old fashioned north/south-bridge system, where everything does 
compete for bus bandwidth but on newer systems it's all some form of 
"hub architecture" (intel nomenclature) or whatever nVidia calls it. I'm 
not too familiar with it, but I do believe that on that system one 
needn't really expect a misbehaving EHCI controller to have (much?) 
effect on IDE throughput.

Would you be willing to enable CONFIG_USB_DEBUG and then look at 
/sys/class/usb_host/usbN/registers, for usbN your EHCI bus (the second 
line of that file will say EHCI for that one)? Example for me:

bus pci, device 0000:00:09.2 (driver 10 Dec 2004)
EHCI 1.00, hcd state 1
structural params 0x00002204
capability params 0x00006872
status 0008 FLR
command 010009 (park)=0 ithresh=1 period=256 RUN
intrenable 37 IAA FATAL PCD ERR INT
uframe 2dee
port 1 status 001000 POWER sig=se0
port 2 status 001000 POWER sig=se0
port 3 status 001000 POWER sig=se0
port 4 status 001000 POWER sig=se0
irq normal 0 err 0 reclaim 0 (lost 0)
complete 0 unlink 0

When my IDE throughput is normal, the "status" line is always as above, 
but after switching on the USB2 HDD (and even after switching if off 
again and/or unplugging it) "Async" and/or "Recl" start toggling on and 
off (and IDE throughput drops) until I rmmod ehci-hcd. You'd need to 
check the file a few times in a row...

In fact, anyone who could do the same would be much welcome. Certainly 
with the EHCI controller on a PCI card, and even more certainly with a 
VIA VT6212 EHCI controller on a PCI card.

> I tried unloading everything to do with usb to try and see if I could
> make it get a higher speed with hdparm, but no change no matter what.

Your 41MB/s for the SATA disk on nForce2 does seem a bit low. The 50 
here is with a PATA Maxtor 120G on a UDMA66 controller. I just checked 
and I see that with current kernels hdparm -a hasn't as much influence 
as it used to have on the hdparm -t result, but try after a "hdparm -a N 
/dev/sda" (sda for SATA, right?) for at least N = 256, 512, 1024, 2048 
and 4096...

Rene.
