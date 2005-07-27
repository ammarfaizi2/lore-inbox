Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbVG0IKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVG0IKU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 04:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVG0IKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 04:10:20 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:40303 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262042AbVG0IIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 04:08:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:subject:date:user-agent:mime-version:content-disposition:to:cc:content-type:content-transfer-encoding:message-id;
        b=UWmWYv8L5AwtAh1Ejb2htxaNDYn0gmKd8tN6LgfQpcRAl6ymN3yslaCa6bT8vBQc0qnK+D2jwETf2+CjOjiN24KbppcVxpKZT7C/mQn9yhtHNI1aVp7GesrI4Gr3NB8drKfuB6clNcfouEkVmtHjLp/BlocPuHwVnwDgxpwQQV0=
From: Giancarlo Formicuccia <giancarlo.formicuccia@gmail.com>
Subject: [PATCH] Fix incorrect Asus k7m irq router detection
Date: Wed, 27 Jul 2005 10:16:30 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
To: "Greg KH" <greg@kroah.com>, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org,
       "Aleksey Gorelov" <Aleksey_Gorelov@phoenix.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200507271016.30447.giancarlo.formicuccia@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch:
http://marc.theaimsgroup.com/?l=bk-commits-head&m=111955644929114&w=2
uncovered a k7m bios bug, where the VT82C686A router is reported as
being "586-compatible". The two chips have different pirq mapping, so
this leads to "irq routing conflict" on many pci devices.

The suggested fix was discussed with Aleksey Gorelov, who helped me
to identify the problem as a probable bios bug.

Patch for 2.6.13-git4.

Signed-off-by: Giancarlo Formicuccia <giancarlo.formicuccia@gmail.com>

--- linux-2.6.13-rc3-git4/arch/i386/pci/irq.c.org	2005-07-27 08:58:05.000000000 +0200
+++ linux-2.6.13-rc3-git4/arch/i386/pci/irq.c	2005-07-27 08:59:29.000000000 +0200
@@ -550,6 +550,13 @@
 static __init int via_router_probe(struct irq_router *r, struct pci_dev *router, u16 device)
 {
 	/* FIXME: We should move some of the quirk fixup stuff here */
+
+	if (router->device == PCI_DEVICE_ID_VIA_82C686 &&
+			device == PCI_DEVICE_ID_VIA_82C586_0) {
+		/* Asus k7m bios wrongly reports 82C686A as 586-compatible */
+		device = PCI_DEVICE_ID_VIA_82C686;
+	}
+
 	switch(device)
 	{
 		case PCI_DEVICE_ID_VIA_82C586_0:


