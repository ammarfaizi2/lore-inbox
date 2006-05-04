Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWEDXQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWEDXQG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 19:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWEDXQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 19:16:06 -0400
Received: from barracuda.s2io.com ([72.1.205.138]:8628 "EHLO
	barracuda.mail.s2io.com") by vger.kernel.org with ESMTP
	id S1751469AbWEDXQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 19:16:04 -0400
X-ASG-Debug-ID: 1146784563-10906-9-0
X-Barracuda-URL: http://72.1.205.138:8000/cgi-bin/mark.cgi
Reply-To: <ravinandan.arakali@neterion.com>
From: "Ravinandan Arakali" <ravinandan.arakali@neterion.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Ananda. Raju" <ananda.raju@neterion.com>, <netdev@vger.kernel.org>,
       "Leonid Grossman" <Leonid.Grossman@neterion.com>
X-ASG-Orig-Subj: pci_enable_msix throws up error
Subject: pci_enable_msix throws up error
Date: Thu, 4 May 2006 16:16:13 -0700
Message-ID: <MAEEKMLDLDFEGKHNIJHIOECKCEAA.ravinandan.arakali@neterion.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=3.5 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.12049
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am seeing the following problem with MSI/MSI-X.

Note: I am copying netdev since other network drivers use
this feature and somebody on the list could throw light.

Our 10G network card(Xframe II) supports MSI and MSI-X.
When I load/unload the driver with MSI support followed
by an attempt to load with MSI-X, I get the following
message from pci_enable_msix:

"Can't enable MSI-X.  Device already has an MSI vector assigned"

I seem to be doing the correct things when unloading the
MSI driver. Basically, I do free_irq() followed by pci_disable_msi().
Any idea what I am missing ?

Further analysis:
Looking at the code, the following check(when it finds a match) in
msi_lookup_vector(called by pci_enable_msix) seems to throw up this
message:
if (!msi_desc[vector] || msi_desc[vector]->dev != dev ||
    msi_desc[vector]->msi_attrib.type != type ||
    msi_desc[vector]->msi_attrib.default_vector != dev->irq)

pci_enable_msi, on successful completion will populate the
fields in msi_desc. But neither pci_disable_msi nor free_irq
seems to undo/unpopulate the msi_desc table.
Could this be the cause for the problem ?

Thanks,
Ravi


