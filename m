Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264749AbUEESW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264749AbUEESW7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 14:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264756AbUEESW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 14:22:58 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:28351 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264749AbUEESWv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 14:22:51 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: <shai@ftcon.com>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Multiple (ICH3) IDE-controllers in a system
Date: Wed, 5 May 2004 17:16:43 +0200
User-Agent: KMail/1.5.3
Cc: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <200405042213.BLD39867@ms6.netsolmail.com>
In-Reply-To: <200405042213.BLD39867@ms6.netsolmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405051716.43909.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Vojtech,

Do I correctly assume that these fixups for Intel chipsets are from you?

http://linus.bkbits.net:8080/linux-2.5/cset@3cfbacdfzHvfqp0Sa45QXt9pNn3LNg?nav=index.html|src/|src/arch|src/arch/i386|src/arch/i386/pci|related/arch/i386/pci/fixup.c
http://linus.bkbits.net:8080/linux-2.5/cset@3cfcec0fOJreGFyCWkPeT7EWiydYFw?nav=index.html|src/|src/arch|src/arch/i386|src/arch/i386/pci|related/arch/i386/pci/fixup.c

Care to explain why 'trash' fixup is needed in 2.6 but not in 2.4?

Cheers,
Bartlomiej

On Wednesday 05 of May 2004 00:13, Shai Fultheim wrote:
> Hi,
>
> I am working on an IO-robust custom-made PC server, which runs the Linux
> kernel.  The machine is working very nicely with 2.4 kernels, but we
> recently found out that in 2.6 it couldn't see all IDE controllers.
>
> In Linux 2.6.x pcibios_fixups table (in arch/i386/pci/fixup.c), use the
> pci_fixup_ide_trash() quirk for Intel's ICH3 (my case specifically
> 8086:248b).  That quirk wasn't in use for ICH3 by the 2.4.x kernels.  The
> result of the change is that the system, which has multiple ICH3's can't
> use any of the IDE controllers beside the one on the first ICH3 (again,
> that worked in 2.4 kernels).
>
> Is there a real reason to call that quirk?  If there is not, why are you
> calling that quirk?  If there is, can I suggest that the quirk will handle
> only the first ICH3 (i.e. add check in the quirk that it is called for the
> first time only).  This is better than "loosing" all these IDE controllers
> in the case their BARs set right.
>
>
> Blow references for bare 2.6.5 kernel:
>
> Code walkup starts with pci_scan_single_device() at
> http://lxr.linux.no/source/drivers/pci/probe.c?v=2.6.5#L590 which calls to
> pci_fixup_device() (line 601) which in turn use the quirks table at
> http://lxr.linux.no/source/arch/i386/pci/fixup.c?v=2.6.5#L190 (my chipset
> is in line 248).  The quirks table for ICH3 use pci_fixup_ide_trash()at
> http://lxr.linux.no/source/arch/i386/pci/fixup.c?v=2.6.5#L90 - this reset
> the BARs for the device.  Resetting the all (4) BARs of (ICH3) IDE
> controllers will cause them to use the defaults BARs (0x170, 0x1f0) in
> ide_hwif_configure() at
> http://lxr.linux.no/source/drivers/ide/setup-pci.c?v=2.6.5#L420.  This will
> fail with any subsequent (ICH3) IDE controllers (two devices can't use the
> same ports). 
>
> I'm not sure if ICH3 needs to reset its BARs at all, but if it is, I
> suggest making sure pci_fixup_ide_trash() reset BARs only for first time
> being called.  In that way subsequent IDE controllers will use the BIOS
> BARs (which we set fine, and worked GREAT at 2.4.x), as said above, this is
> better than "loosing" all the other IDE controllers in the case their BARs
> set right.
>
> Thanks in advance,
> Shai.

