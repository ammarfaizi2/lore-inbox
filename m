Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbUFVM5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUFVM5F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 08:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263457AbUFVM5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 08:57:05 -0400
Received: from guardian.hermes.si ([193.77.5.150]:42513 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP id S262772AbUFVM45
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 08:56:57 -0400
Message-ID: <600B91D5E4B8D211A58C00902724252C01BC0705@piramida.hermes.si>
From: David Balazic <david.balazic@hermes.si>
To: David Balazic <david.balazic@hermes.si>,
       "'Matt Domsch'" <Matt_Domsch@dell.com>
Cc: "'Riley@Williams.Name'" <Riley@Williams.Name>,
       "'Linux-Kernel@vger.kernel.org'" <Linux-Kernel@vger.kernel.org>
Subject: RE: EDD code causes long boot delay
Date: Tue, 22 Jun 2004 14:56:30 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: 	Matt Domsch[SMTP:Matt_Domsch@dell.com]
> 
> On Tue, Jun 22, 2004 at 08:45:00AM +0200, David Balazic wrote:
> > I use the commands ( in the grub shell that boots from my HD ):
> > root (hd0,0)
> > kernel /vmlinuz-2.6.xxx ro root=dev/hda2
> > initrd /initrd-2.xxx
> > boot
> > 
> > After entering the "boot" command, the screen is cleared and then
> nothing
> > happens for 93 seconds.
> > After that linux boot normally ( beginning with the message
> "Uncompressing
> > linux..." and so on ).
> > If I trim the kernel command line to only "kernel /vmlinuz-2.6.xxx ro" ,
> > then the delay is 10 seconds.
> 
> Wow.  That's really interesting, and gives a good starting point to
> look at, where the command line is stored.  But the EDD code shouldn't
> be using any of the space that the command line occupies, ever...  
> 
Yes, it is really weird. I will look into this some more ...
>  
> > If I change the operating mode of the IDE adapter in BIOS to RAID,
> > then the delay is infinite ( I waited 8 hours and it still did not
> > print "Uncompressing linx ...." ). Note that with this option, there
> > is no real difference, since the disks are not mirrored or striped
> > or anything. GRUB can read everything just fine.
> 
> > I tested all kernels ( vanilla Linus release from kernel.org ) from
> > 2.6.0 to 2.6.7 and saw that the problem appeared in 2.6.3. Then I
> > found out that that the cause is the CONFIG_EDD option, if I turn it
> > off, then linux-2.6.7 boot without the mentioned delay.
> >
> > So, is there some bug in the EDD code ? A BIOS bug ? Any other comment ?
> > My hardware is a Gigabyte GA-7 VAXP Ultra motherboard ( see 
> >
> http://www.giga-byte.com/MotherBoard/Products/Products_GA-7VAXP%20Ultra.ht
> m
> > )
> > BIOS version is F6.
> > Disks : 
> >  - Quantum lct20 20 GB
> >  - IBM Deskstar 120GXP 60 GB
> > Both on the Promise PDC 20276 on-board controller, each on its own
> > channel(cable).
> 
> It *feels* like a BIOS bug (or bugs), as you're the first to report
> such a problem.  I've got one success report with this motherboard
> dated 8 Feb 2004.
> 
> Motherboard:  Gigabyte GA-7IXE4
> BIOS version: FAd  (that's a beta version)
> Kernel:       2.6.2-mm1
> 
> The question is, which of the int13 calls is messing up your BIOS?
> The "read MBR sector and save the 4-byte MBR signature" code was added
> there at 2.6.3, which is quite coincident.
> 
> This is the code, in arch/i386/boot/setup.S, which makes that int13
> call.  Can you try #if 0'ing this chunk out and see if this helps?
> 
Will do ...

> +# Read the first sector of device 80h and store the 4-byte signature
> +       movl    $0xFFFFFFFF, %eax
> +       movl    %eax, (DISK80_SIG_BUFFER)       # assume failure
> +       movb    $READ_SECTORS, %ah
> +       movb    $1, %al                         # read 1 sector
> +       movb    $0x80, %dl                      # from device 80
> +       movb    $0, %dh                         # at head 0
> +       movw    $1, %cx                         # cylinder 0, sector 0
> +       pushw   %es
> +       pushw   %ds
> +       popw    %es
> +       movw    $EDDBUF, %bx
> +       int     $0x13
> +       jc      disk_sig_done
> +       movl    (EDDBUF+MBR_SIG_OFFSET), %eax
> +       movl    %eax, (DISK80_SIG_BUFFER)       # store success
> +disk_sig_done:
> +       popw    %es
> +
> 
> If so, then I'd like to believe that it's definitely a BIOS bug, as
> int13 reads to the MBR had better work (gee, that's how the boot
> loader got loaded in the first place, right?)
> 
Yes, it(grub) loads the kernel and everything just fine ...

> Thanks,
> Matt
> 
Can you send mail to Riley@Williams.Name ?
It got refused for me : 
--begin quote--
This message was created automatically by mail delivery software.

A message that you sent could not be delivered to one or more of its
recipients. This is a permanent error. The following address(es) failed:

  rhw@memalpha.co.uk
    retry time not reached for any host after a long failure period

--end quote--
No other information was present :-(

Regards,
David Balazic
