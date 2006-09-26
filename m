Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWIZVrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWIZVrY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 17:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWIZVrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 17:47:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49294 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964848AbWIZVrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 17:47:22 -0400
Date: Tue, 26 Sep 2006 14:47:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Henne <henne@nachtwindheim.de>
Cc: jirislaby@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: droping a patch in mm
Message-Id: <20060926144716.5cb606a1.akpm@osdl.org>
In-Reply-To: <4517B1C5.30609@nachtwindheim.de>
References: <451792E2.2020800@nachtwindheim.de>
	<4517950D.8010907@gmail.com>
	<4517B1C5.30609@nachtwindheim.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2006 12:39:01 +0200
Henne <henne@nachtwindheim.de> wrote:

> >Jiri Slaby schrieb:
> 
> >>Henne wrote:
> >>Hi!
> >>Would you please drop:
> >>pci_module_init_conversion-in-scsi-subsys-2nd-try.patch
> >>cause it the moving of libata now it will only produce a lot of errors.
> >>I'll rewrite it today.
> >
> >And this wrong too in that patch:
> >-    /* Translate error or zero return into zero or one */
> >-    return pci_module_init(&aic7xxx_pci_driver) ? 0 : 1;
> >+    return pci_register_driver(&aic7xxx_pci_driver);
> >
> >regards,
> 
> Acked! But I don't think thats good style to __translate__ return values,
> even if this one is ignored.
> I'll keep it the way it was and just change pci_module_init() into pci_register_driver().
> 
> From: Henrik Kretzschmar <henne@nachtwindheim.de>
> 
> Changes pci_module_init() to pci_register_driver() in the scsi-subsys
> for drivers which just return the returvalue of that function.
> Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

Your new patch boils down to this:

--- a/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c~pci_module_init-conversion-in-scsi-subsys-2nd-try-update
+++ a/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
@@ -246,7 +246,8 @@ ahc_linux_pci_dev_probe(struct pci_dev *
 int
 ahc_linux_pci_init(void)
 {
-	return pci_register_driver(&aic7xxx_pci_driver);
+	/* Translate error or zero return into zero or one */
+	return pci_register_driver(&aic7xxx_pci_driver) ? 0 : 1;
 }
 
 void
_


But the earlier verion was better, and ahc_linux_pci_init() has only one
caller which cheerfully ignores the error code anyway.

pci_register_driver() is (or will be) marked __must_check. 
ahc_linux_pci_init() will cunningly suppress that warning, while leaving the
driver in an incorrect state.

An appropriate fix would be to teach the rather optimistic ahc_linux_init()
about failures.
