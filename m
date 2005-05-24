Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVEXJOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVEXJOz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVEXJND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:13:03 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:30391 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S261464AbVEXJLC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:11:02 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524091059.9F308FA7B@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:10:59 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id B7FC8FB7B

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 10:01:49 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261407AbVEXH3u (ORCPT <rfc822;chiakotay@nexlab.it>);

	Tue, 24 May 2005 03:29:50 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVEXH3u

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Tue, 24 May 2005 03:29:50 -0400

Received: from ns2.suse.de ([195.135.220.15]:11926 "EHLO mx2.suse.de")

	by vger.kernel.org with ESMTP id S261410AbVEXH3g (ORCPT

	<rfc822;linux-kernel@vger.kernel.org>);

	Tue, 24 May 2005 03:29:36 -0400

Received: from hermes.suse.de (hermes-ext.suse.de [195.135.221.8])

	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))

	(No client certificate requested)

	by mx2.suse.de (Postfix) with ESMTP id 4FA8911A90;

	Tue, 24 May 2005 09:29:36 +0200 (CEST)

Date:	Tue, 24 May 2005 09:29:29 +0200

From: Karsten Keil <kkeil@suse.de>
To: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>
Cc: Ondrej Zary <linux@rainbow-software.org>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	jgarzik@pobox.com
Subject: Re: [PATCH] bug in VIA PCI IRQ routing

Message-ID: <20050524072929.GD22182@pingi3.kke.suse.de>

Mail-Followup-To: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>,
	Ondrej Zary <linux@rainbow-software.org>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	jgarzik@pobox.com
References: <0EF82802ABAA22479BC1CE8E2F60E8C31B4902@scl-exch2k3.phoenix.com>

Mime-Version: 1.0

Content-Type: text/plain; charset=us-ascii

Content-Disposition: inline

In-Reply-To: <0EF82802ABAA22479BC1CE8E2F60E8C31B4902@scl-exch2k3.phoenix.com>

Organization: SuSE Linux AG

X-Operating-System: Linux 2.6.8-24.10-default i686

User-Agent: Mutt/1.5.6i

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org



Hi,

On Mon, May 23, 2005 at 12:53:41PM -0700, Aleksey Gorelov wrote:
> 
> Karsten, 
> 
>   could you please verify if attached patch works for you ?

Works and seems to be OK, according to the specs. So this
patch should go into the kernel, also into 2.4 I think.
These chipset is still used on small special purpose systems.

--- linux-2.6.11.10/arch/i386/pci/irq.c	2005-05-16 10:50:30.000000000 -0700
+++ new/arch/i386/pci/irq.c	2005-05-23 12:47:19.000000000 -0700
@@ -227,6 +227,24 @@
 }
 
 /*
+ * The VIA pirq rules are nibble-based, like ALI,
+ * but without the ugly irq number munging.
+ * However, for 82C586, nibble map is different .
+ */
+static int pirq_via586_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
+{
+	static unsigned int pirqmap[4] = { 3, 2, 5, 1 };
+	return read_config_nybble(router, 0x55, pirqmap[pirq-1]);
+}
+
+static int pirq_via586_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
+{
+	static unsigned int pirqmap[4] = { 3, 2, 5, 1 };
+	write_config_nybble(router, 0x55, pirqmap[pirq-1], irq);
+	return 1;
+}
+
+/*
  * ITE 8330G pirq rules are nibble-based
  * FIXME: pirqmap may be { 1, 0, 3, 2 },
  * 	  2+3 are both mapped to irq 9 on my system
@@ -509,6 +527,10 @@
 	switch(device)
 	{
 		case PCI_DEVICE_ID_VIA_82C586_0:
+			r->name = "VIA";
+			r->get = pirq_via586_get;
+			r->set = pirq_via586_set;
+			return 1;
 		case PCI_DEVICE_ID_VIA_82C596:
 		case PCI_DEVICE_ID_VIA_82C686:
 		case PCI_DEVICE_ID_VIA_8231:

-- 
Karsten Keil
SuSE Labs
ISDN development
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

