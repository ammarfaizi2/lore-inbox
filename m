Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266391AbUFZSNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266391AbUFZSNx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 14:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267194AbUFZSNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 14:13:52 -0400
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:13757 "EHLO
	gw01.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S266391AbUFZSNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 14:13:48 -0400
Date: Sat, 26 Jun 2004 21:10:16 +0300
From: Anssi Saari <as@sci.fi>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       len.brown@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: booting 2.6.7 hangs with IRQ handling problems
Message-ID: <20040626181016.GA17572@sci.fi>
Mail-Followup-To: Anssi Saari <as@sci.fi>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	len.brown@intel.com, linux-kernel@vger.kernel.org
References: <20040622192942.GA15367@sci.fi> <200406231748.33679.bzolnier@elka.pw.edu.pl> <20040623180431.GA8963@sci.fi> <200406252106.04029.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406252106.04029.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 09:06:03PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 23 of June 2004 20:04, Anssi Saari wrote:
> > On Wed, Jun 23, 2004 at 05:48:33PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > On Tuesday 22 of June 2004 21:29, Anssi Saari wrote:
> > > > Hello,
> > >
> > > Hi,
> > >
> > > > On my home PC I have an AMD Athlon XP 1900+ on an Aopen AK77-600Max
> > > > motherboard, VIA KT600 chipset. It works fine with Linux 2.6.6, apart
> > > > from the apparently nonexistent support for PATA devices on the Promise
> > > > PDC20378, but I can't boot 2.6.7. I've tried vanilla 2.6.7, 2.6.7 with
> > > > acpi-20040326 patch and 2.6.7-bk4. acpi=off, noapic or nolapic don't
> > > > seem to help.
> > >
> > > Since 2.6.6 works and 2.6.7-bk4 doesn't can you try -bk1/2/3 and
> > > do bisection search on specific changesets?  Thanks!
> >
> > OK. I find that 2.6.6-bk1 seemed fine, but 2.6.6-bk2 already prints out
> > these messages. It did boot, but then hanged shortly after. I hope this
> > helps to narrow it down?
> 
> Does it hang the same way as 2.6.7?
> 
> There were no IDE changes between 2.6.6-bk1 and 2.6.6-bk2.
> Can you do a diff between dmesg outputs from -bk1 and -bk2?
 
Well, who said this has anything to do with IDE?

> You can also try narrowing it down to a specific changeset
> [ http://linux.bkbits.net:8080/linux-2.5/ ] but it can take a while.

I couldn't figure out if there is a way to get individual changesets for
a date range from bk, each as a separate diff file, so I just went
through the whole big diff between 2.6.6-bk1 and 2.6.6-bk2. Since this
didn't smell like a device driver problem, I was left with only three
changed files.

This is the change that breaks things for me:

-------------------------------------------------------------------------
diff -urN linux-2.6.6-bk1/drivers/acpi/pci_link.c linux-2.6.6-bk2/drivers/acpi/pci_link.c
--- linux-2.6.6-bk1/drivers/acpi/pci_link.c	2004-05-09 19:32:00.000000000 -0700
+++ linux-2.6.6-bk2/drivers/acpi/pci_link.c	2004-05-15 04:50:32.000000000 -0700
@@ -479,7 +479,7 @@
 	PIRQ_PENALTY_PCI_AVAILABLE,	/* IRQ9  PCI, often acpi */
 	PIRQ_PENALTY_PCI_AVAILABLE,	/* IRQ10 PCI */
 	PIRQ_PENALTY_PCI_AVAILABLE,	/* IRQ11 PCI */
-	PIRQ_PENALTY_ISA_TYPICAL,	/* IRQ12 mouse */
+	PIRQ_PENALTY_ISA_USED,	/* IRQ12 mouse */
 	PIRQ_PENALTY_ISA_USED,	/* IRQ13 fpe, sometimes */
 	PIRQ_PENALTY_ISA_USED,	/* IRQ14 ide0 */
 	PIRQ_PENALTY_ISA_USED,	/* IRQ15 ide1 */
@@ -546,17 +546,23 @@
 		if (link->irq.active == link->irq.possible[i])
 			break;
 	}
+	/*
+	 * forget active IRQ that is not in possible list
+	 */
+	if (i == link->irq.possible_count) {
+		if (acpi_strict)
+			printk(KERN_WARNING PREFIX "_CRS %d not found"
+				" in _PRS\n", link->irq.active);
+		link->irq.active = 0;
+	}
 
 	/*
 	 * if active found, use it; else pick entry from end of possible list.
 	 */
-	if (i != link->irq.possible_count) {
+	if (link->irq.active) {
 		irq = link->irq.active;
 	} else {
 		irq = link->irq.possible[link->irq.possible_count - 1];
-		if (acpi_strict)
-			printk(KERN_WARNING PREFIX "_CRS %d not found"
-				" in _PRS\n", link->irq.active);
 	}
 
 	if (acpi_irq_balance || !link->irq.active) {
-------------------------------------------------------------------------

I'm now running 2.6.7 vanilla with the lirc patch and don't seem to have
any problems.

The comment in the change "forget active IRQ that is not in possible list"
and then the "irq 10: nobody cared!" messages from the kernel might have
something to do with each other.

This change is apparently this one from the log:

ChangeSet@1.1608.8.1, 2004-05-10 16:48:38-04:00, len.brown@intel.com
  [ACPI] handle _CRS outside _PRS -- even when non-zero
  avoid sharing IRQ12
  http://bugzilla.kernel.org/show_bug.cgi?id=2665

Apparently Len Brown came up with this as a bugfix for a different
problem, but it breaks things for me. I copied him with this.

Anssi


