Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269603AbUI3XEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269603AbUI3XEv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 19:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269606AbUI3XEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 19:04:51 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:54476 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S269603AbUI3XEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 19:04:38 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: 2.6.9rc2-mm4 oops
Date: Thu, 30 Sep 2004 17:04:28 -0600
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu,
       Len Brown <len.brown@intel.com>, acpi-devel@lists.sourceforge.net,
       Bernhard Rosenkraenzer <bero@arklinux.org>
References: <1096571653.11298.163.camel@cmn37.stanford.edu> <20040930124937.5942fd64.akpm@osdl.org> <200409301522.29198.bjorn.helgaas@hp.com>
In-Reply-To: <200409301522.29198.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8DJXBchNOWwdXZf"
Message-Id: <200409301704.28573.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_8DJXBchNOWwdXZf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 30 September 2004 3:22 pm, Bjorn Helgaas wrote:
> Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> > inserting floppy driver for 2.6.8.1-1.520.1nov.rhfc2.ccrma
> > Unable to handle kernel paging request at virtual address f8881920
> >  printing eip:
> > c0251d3d
> > *pde = 37f5f067
> > Oops: 0002 [#1]
> > PREEMPT 
> > Modules linked in: floppy(U) sg(U) dm_mod(U) uhci_hcd(U) ehci_hcd(U)
> > button(U) battery(U) asus_acpi(U) ac(U) ext3(U) jbd(U) raid5(U) xor(U)
> > sata_via(U) sata_promise(U) libata(U) sd_mod(U) scsi_mod(U)
> > CPU:    0
> > EIP:    0060:[<c0251d3d>]    Not tainted VLI
> > EFLAGS: 00010246   (2.6.8.1-1.520.1nov.rhfc2.ccrma) 
> > EIP is at acpi_bus_register_driver+0xd2/0x165

Like Pierre, I was able to reproduce this with DEBUG_PAGEALLOC.
I found a struct acpi_driver in hpet.c that was erroneously marked
__init, and the attached patch fixed the oops for me.  Can you give
this a whirl?

--Boundary-00=_8DJXBchNOWwdXZf
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diffs.hpet"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diffs.hpet"

--- 2.6.9-rc2-mm4/drivers/char/hpet.c	2004-09-27 10:12:16.000000000 -0600
+++ hpet/drivers/char/hpet.c	2004-09-30 15:44:39.000000000 -0600
@@ -925,7 +925,7 @@
 	return 0;
 }
 
-static struct acpi_driver hpet_acpi_driver __initdata = {
+static struct acpi_driver hpet_acpi_driver = {
 	.name = "hpet",
 	.ids = "PNP0103",
 	.ops = {

--Boundary-00=_8DJXBchNOWwdXZf--
