Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbUEDWNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbUEDWNj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 18:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUEDWNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 18:13:39 -0400
Received: from omr5.netsolmail.com ([216.168.230.142]:52688 "EHLO
	omr5.netsolmail.com") by vger.kernel.org with ESMTP id S261273AbUEDWNb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 18:13:31 -0400
Message-Id: <200405042213.BLD39867@ms6.netsolmail.com>
Reply-To: <shai@ftcon.com>
From: "Shai Fultheim" <shai@ftcon.com>
To: <linux-ide@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Multiple (ICH3) IDE-controllers in a system
Date: Tue, 4 May 2004 15:13:29 -0700
Organization: FT Consulting
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcQyJQe3mLYeVAvJSD2RdpGEPZp+pw==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am working on an IO-robust custom-made PC server, which runs the Linux
kernel.  The machine is working very nicely with 2.4 kernels, but we
recently found out that in 2.6 it couldn't see all IDE controllers.

In Linux 2.6.x pcibios_fixups table (in arch/i386/pci/fixup.c), use the
pci_fixup_ide_trash() quirk for Intel's ICH3 (my case specifically
8086:248b).  That quirk wasn't in use for ICH3 by the 2.4.x kernels.  The
result of the change is that the system, which has multiple ICH3's can't use
any of the IDE controllers beside the one on the first ICH3 (again, that
worked in 2.4 kernels).

Is there a real reason to call that quirk?  If there is not, why are you
calling that quirk?  If there is, can I suggest that the quirk will handle
only the first ICH3 (i.e. add check in the quirk that it is called for the
first time only).  This is better than "loosing" all these IDE controllers
in the case their BARs set right.


Blow references for bare 2.6.5 kernel:

Code walkup starts with pci_scan_single_device() at
http://lxr.linux.no/source/drivers/pci/probe.c?v=2.6.5#L590 which calls to
pci_fixup_device() (line 601) which in turn use the quirks table at
http://lxr.linux.no/source/arch/i386/pci/fixup.c?v=2.6.5#L190 (my chipset is
in line 248).  The quirks table for ICH3 use pci_fixup_ide_trash()at
http://lxr.linux.no/source/arch/i386/pci/fixup.c?v=2.6.5#L90 - this reset
the BARs for the device.  Resetting the all (4) BARs of (ICH3) IDE
controllers will cause them to use the defaults BARs (0x170, 0x1f0) in
ide_hwif_configure() at
http://lxr.linux.no/source/drivers/ide/setup-pci.c?v=2.6.5#L420.  This will
fail with any subsequent (ICH3) IDE controllers (two devices can't use the
same ports).  

I'm not sure if ICH3 needs to reset its BARs at all, but if it is, I suggest
making sure pci_fixup_ide_trash() reset BARs only for first time being
called.  In that way subsequent IDE controllers will use the BIOS BARs
(which we set fine, and worked GREAT at 2.4.x), as said above, this is
better than "loosing" all the other IDE controllers in the case their BARs
set right.

Thanks in advance,
Shai.


 
_________________________
Shai Fultheim
FT Consulting
 
Mobile: +1 (408) 480-1612
Fax:    +1 (501) 647-4113
E-Mail: shai@ftcon.com
Web:    www.ftcon.com


