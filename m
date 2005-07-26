Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbVGZVIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbVGZVIM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 17:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVGZVDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 17:03:10 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:59112 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261977AbVGZVBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 17:01:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=rSz12Glru2rnjTQ3jUit9ukglqf346dhOAD5bZIDSi/M3HEJw24JBM9MMNv7ChAzIZVhX7KtOFy1a8uXlA9LaIbo9LQnWrEhab4QiUoKJJKIE0q7Dr7aNaPFrNKau7+nDdt5yvCeVULjQQjoCTDR7AXrvRGP9+8BBPrjL4hWoig=
From: Giancarlo Formicuccia <giancarlo.formicuccia@gmail.com>
To: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
Subject: Re: [2.6.13-rc3-git4] VIA686A polymorphs into VIA586!
Date: Tue, 26 Jul 2005 23:09:20 +0200
User-Agent: KMail/1.6.1
Cc: <linux-kernel@vger.kernel.org>
References: <0EF82802ABAA22479BC1CE8E2F60E8C33D28A2@scl-exch2k3.phoenix.com>
In-Reply-To: <0EF82802ABAA22479BC1CE8E2F60E8C33D28A2@scl-exch2k3.phoenix.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200507262309.20330.giancarlo.formicuccia@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aleksey Gorelov wrote:
> >This patch brings my board back to the correct behaviour
> >[Aleksey Gorelov CC'd for review/comments/suggestions]:
> >
> >--- linux-2.6.13-git4/arch/i386/pci/irq.c.org	2005-07-23
> >11:15:12.000000000 +0200
> >+++ linux-2.6.13-git4/arch/i386/pci/irq.c	2005-07-23
> >11:55:50.000000000 +0200
> >@@ -553,10 +553,12 @@
> > 	switch(device)
> > 	{
> > 		case PCI_DEVICE_ID_VIA_82C586_0:
> >-			r->name = "VIA";
> >-			r->get = pirq_via586_get;
> >-			r->set = pirq_via586_set;
> >-			return 1;
> >+			if (router->device==PCI_DEVICE_ID_VIA_82C586_0) {
> >+				r->name = "VIA";
> >+				r->get = pirq_via586_get;
> >+				r->set = pirq_via586_set;
> >+				return 1;
> >+			}
> > 		case PCI_DEVICE_ID_VIA_82C596:
> > 		case PCI_DEVICE_ID_VIA_82C686:
> > 		case PCI_DEVICE_ID_VIA_8231:
>
> Probably, comments on buggy BIOS would be nice here..
>

Does this patch look good for you?
Who's the right developer to ask for inclusion? I'd like to see this problem addressed before 2.6.13...

Thanks,
Giancarlo


--- linux-2.6.13-git4/arch/i386/pci/irq.c.org	2005-07-23 11:15:12.000000000 +0200
+++ linux-2.6.13-git4/arch/i386/pci/irq.c	2005-07-26 20:53:11.000000000 +0200
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
