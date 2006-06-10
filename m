Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWFJL4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWFJL4i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 07:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWFJL4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 07:56:38 -0400
Received: from web26907.mail.ukl.yahoo.com ([217.146.176.96]:56470 "HELO
	web26907.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751010AbWFJL4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 07:56:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=MIFhc25/Eq6yeWlOavgeL4QAQv8nNByIaNJeqK5GtN8HxBwzXXepuPHSj3K2PJN7BSLTvzCe8icD6HWcAGphtGiGh5QSf32S/kvnGGlRXxOwKFG/SsqN+yKNnriOWUaPZnmJv6oskA27XDgDRHijjbeLERXBWp82Cx76enE7b9k=  ;
Message-ID: <20060610115636.57029.qmail@web26907.mail.ukl.yahoo.com>
Date: Sat, 10 Jun 2006 13:56:36 +0200 (CEST)
From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: Re: [RFC] ATA host-protected area (HPA) device mapper?
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jeff@garzik.org
In-Reply-To: <1149873734.22124.40.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> Don't see how your HPA code protects versus password locking however. If
> I hack the OS I write a new boot block which locks the disk then reboot
> into it. By the time you go for your floppy its too late.
> If thats not the case I'm most interested how you set it up to avoid this.

 I was a bit too quick to answer this one yesterday.
 Basically, you want to protect against an attack replacing the bootloader,
 whatever happens later is bad anyway.
 The only way to get that is if the bootloader cannot be overwritten,
 preferably even by root, at the time of the attack.
 You have to know that whatever put Gujin in memory is independant of how
 it will probe the disks, partitions and files.

 The simple solution is: you never boot from the hard disk, but from a
 physically write protected device (write protected floppy, non writeable
 CD or CDRW in a non writing CDROM drive, USB thumb drive with a physical
 write protect switch). It may be interresting to be able to enable
 writing to the boot device at setup (for instance to select a kernel
 to "autoboot" after few seconds or set up the keyboard language and
 the default kernel command line), Gujin can itself save few data in
 its second 512 bytes sector if write is enabled, but that is not
 100 % needed because the installer "instboot" can set all those
 parameter in file "boot.bcd" for CDROM install.
 Note that, if you are using a "write once" CDROM, you should take care
 of not enabling an attacker to add a session with a new El-torito
 boot sector.

 The complex solution is described in the ATA standard T13 D1367,
 Protect Area Run Time Interface Extension Services, skip to "4 Overview",
 and depends on the hard drive supporting the "Address Offset Reserved Area Boot",
 only IBM drives seem to have such a support.
 Basically, at boot, the LBA is offseted by a constant and you boot this
 "minidisk" with its own MBR. You can then send a command to the HD
 to stop this offset, and protect your "minidisk" by the HPA or by
 reducing the visible size of the disk (latter hurts the BIOS).
 The real MBR is never executed, the executed MBR is write protected
 even by root at the time of the attack, and if you boot with a DOS floppy
 you will see a small hard disk with the really used MBR.
 Gujin is designed to produce a complete disk mapping with FAT12/16
 filesystem (no partition like a floppy) to be able to handle such a boot,
 but I did not finish to support it, mainly because the only IBM drive
 I have is my main one, and because my hobby time is limited (I am not
 working in the PC industry). It should not be difficult to support
 that completely, the details are how to upgrade Gujin, how to behave
 with non booted but present disks...

 If you are using one of these two solutions, an attacker will have to
 take control of the system before Gujin is executed - so the only
 attack is either the main BIOS FLASH (check that you have a jumper
 to write protect it physically) and other PCI/AGP BIOS (video BIOS,
 network BIOS) which may be present on FLASH and may be overwritten.
 Modifying the firmware of the HD may be another attack path.

 All this remember me the software write protection of 5 1/4 inch floppy...
 Also, never try to test IDE passwords at 2:00 in the morning, even for
 a quick test, you may type a random password and get a 160GB brick.
 Someone knows the master password of Maxtor 4G160J8 code GAK819K0
 drive S/N G80CNBME FG08A - I promise not to repeat it!

 Cheers,
 Etienne.

__________________________________________________
Do You Yahoo!?
En finir avec le spam? Yahoo! Mail vous offre la meilleure protection possible contre les messages non sollicités 
http://mail.yahoo.fr Yahoo! Mail 
