Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263340AbUFVMvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbUFVMvQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 08:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbUFVMvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 08:51:16 -0400
Received: from linux.us.dell.com ([143.166.224.162]:4709 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S263340AbUFVMvI
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 08:51:08 -0400
Date: Tue, 22 Jun 2004 07:50:55 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: David Balazic <david.balazic@hermes.si>
Cc: "'Riley@Williams.Name'" <Riley@Williams.Name>,
       "'Linux-Kernel@vger.kernel.org'" <Linux-Kernel@vger.kernel.org>
Subject: Re: EDD code causes long boot delay
Message-ID: <20040622125055.GA19315@lists.us.dell.com>
References: <600B91D5E4B8D211A58C00902724252C01BC06FA@piramida.hermes.si>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <600B91D5E4B8D211A58C00902724252C01BC06FA@piramida.hermes.si>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 22, 2004 at 08:45:00AM +0200, David Balazic wrote:
> I use the commands ( in the grub shell that boots from my HD ):
> root (hd0,0)
> kernel /vmlinuz-2.6.xxx ro root=3Ddev/hda2
> initrd /initrd-2.xxx
> boot
>=20
> After entering the "boot" command, the screen is cleared and then nothing
> happens for 93 seconds.
> After that linux boot normally ( beginning with the message "Uncompressing
> linux..." and so on ).
> If I trim the kernel command line to only "kernel /vmlinuz-2.6.xxx ro" ,
> then the delay is 10 seconds.

Wow.  That's really interesting, and gives a good starting point to
look at, where the command line is stored.  But the EDD code shouldn't
be using any of the space that the command line occupies, ever... =20
=20
> If I change the operating mode of the IDE adapter in BIOS to RAID,
> then the delay is infinite ( I waited 8 hours and it still did not
> print "Uncompressing linx ...." ). Note that with this option, there
> is no real difference, since the disks are not mirrored or striped
> or anything. GRUB can read everything just fine.

> I tested all kernels ( vanilla Linus release from kernel.org ) from
> 2.6.0 to 2.6.7 and saw that the problem appeared in 2.6.3. Then I
> found out that that the cause is the CONFIG_EDD option, if I turn it
> off, then linux-2.6.7 boot without the mentioned delay.
>
> So, is there some bug in the EDD code ? A BIOS bug ? Any other comment ?
> My hardware is a Gigabyte GA-7 VAXP Ultra motherboard ( see=20
> http://www.giga-byte.com/MotherBoard/Products/Products_GA-7VAXP%20Ultra.h=
tm
> )
> BIOS version is F6.
> Disks :=20
>  - Quantum lct20 20 GB
>  - IBM Deskstar 120GXP 60 GB
> Both on the Promise PDC 20276 on-board controller, each on its own
> channel(cable).

It *feels* like a BIOS bug (or bugs), as you're the first to report
such a problem.  I've got one success report with this motherboard
dated 8 Feb 2004.

Motherboard:  Gigabyte GA-7IXE4
BIOS version: FAd  (that's a beta version)
Kernel:       2.6.2-mm1

The question is, which of the int13 calls is messing up your BIOS?
The "read MBR sector and save the 4-byte MBR signature" code was added
there at 2.6.3, which is quite coincident.

This is the code, in arch/i386/boot/setup.S, which makes that int13
call.  Can you try #if 0'ing this chunk out and see if this helps?

+# Read the first sector of device 80h and store the 4-byte signature
+       movl    $0xFFFFFFFF, %eax
+       movl    %eax, (DISK80_SIG_BUFFER)       # assume failure
+       movb    $READ_SECTORS, %ah
+       movb    $1, %al                         # read 1 sector
+       movb    $0x80, %dl                      # from device 80
+       movb    $0, %dh                         # at head 0
+       movw    $1, %cx                         # cylinder 0, sector 0
+       pushw   %es
+       pushw   %ds
+       popw    %es
+       movw    $EDDBUF, %bx
+       int     $0x13
+       jc      disk_sig_done
+       movl    (EDDBUF+MBR_SIG_OFFSET), %eax
+       movl    %eax, (DISK80_SIG_BUFFER)       # store success
+disk_sig_done:
+       popw    %es
+

If so, then I'd like to believe that it's definitely a BIOS bug, as
int13 reads to the MBR had better work (gee, that's how the boot
loader got loaded in the first place, right?)

Thanks,
Matt

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA2CsvIavu95Lw/AkRAlVvAJsGBT7YHk7u3XxyUT2guGww519BBwCeIt2D
Ougm6sEmhl7frrHDlBfIiPk=
=SK5H
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
