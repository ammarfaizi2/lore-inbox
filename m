Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbUEPEXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUEPEXJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 00:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUEPEXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 00:23:09 -0400
Received: from omr2.netsolmail.com ([216.168.230.163]:37545 "EHLO
	omr2.netsolmail.com") by vger.kernel.org with ESMTP id S262322AbUEPEXD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 00:23:03 -0400
Message-Id: <200405160420.BMB67029@ms6.netsolmail.com>
Reply-To: <shai@ftcon.com>
From: "Shai Fultheim" <shai@ftcon.com>
To: "'Jeff Garzik'" <jgarzik@pobox.com>
Cc: "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "'Andrew Morton'" <akpm@osdl.org>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Multiple (ICH3) IDE-controllers in a system
Date: Sat, 15 May 2004 21:20:06 -0700
Organization: FT Consulting
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <40A66819.9040806@pobox.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcQ6roE6fM5trsB5S6CpgIHShASQiwATiafQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

Here is what I see: pci_scan_single_device() at
http://lxr.linux.no/source/drivers/pci/probe.c?v=2.6.5#L590 which calls to
pci_fixup_device() (line 601) which in turn use the quirks table at
http://lxr.linux.no/source/arch/i386/pci/fixup.c?v=2.6.5#L190 (my chipset is
in line 248).  The quirks table for ICH3 use pci_fixup_ide_trash()at
http://lxr.linux.no/source/arch/i386/pci/fixup.c?v=2.6.5#L90 - this reset
the BARs for the device.  Resetting the all (4) BARs of (ICH3) IDE
controllers will cause them to use the defaults BARs (0x170, 0x1f0) in
ide_hwif_configure() at
http://lxr.linux.no/source/drivers/ide/setup-pci.c?v=2.6.5#L420.  This will
fail with any subsequent (ICH3) IDE controllers (two devices can't use the
same ports).  

Agree or not?

My patch (not sure there is nicer way to handle this), will not allow reset
of BARs if you hit any ICH3 which is not the first one. This will rely on
BIOS setting for all other controllers.

--Shai


-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@pobox.com] 
Sent: Saturday, May 15, 2004 11:57
To: Linux Kernel Mailing List
Cc: shai@ftcon.com; Bartlomiej Zolnierkiewicz; Andrew Morton
Subject: Re: [PATCH] Multiple (ICH3) IDE-controllers in a system

Linux Kernel Mailing List wrote:
> ChangeSet 1.1627, 2004/05/15 09:42:40-07:00, shai@ftcon.com
> 
> 	[PATCH] Multiple (ICH3) IDE-controllers in a system
> 	
> 	This fixes a problem with multiple IDE controllers in a system.
> 	
> 	The problem is that pcibios_fixups table (in arch/i386/pci/fixup.c)
uses
> 	the pci_fixup_ide_trash() quirk for Intel's ICH3 (my case
specifically
> 	8086:248b).  This clears any bogus BAR information set up by the
BIOS.
> 	
> 	In a system which has multiple ICH3's can't use any of the IDE
> 	controllers beside the one on the first ICH3.
> 	
> 	Anyhow, the fix is to make sure pci_fixup_ide_trash resets the BARs
only
> 	for first time being called, so the subsequent IDE controllers will
use
> 	the BIOS BARs.  This is better than "loosing" all these IDE
controllers
> 	in the case their BARs set right.

I do not think this is correct.

The programming interface register tells us if we're in legacy or native 
mode, which is what this fixup is concerned with, AFAICS.

So, the code should base its actions on whether or not the controller is 
in legacy mode, _not_ ordering.

	Jeff



