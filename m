Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263167AbVHEU2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbVHEU2Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 16:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbVHEU2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 16:28:22 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:55968 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263177AbVHEU2F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 16:28:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H1iTbHF55TEXhGisj2WTzkETKxe738IQkYnFgADL3WJXzBt0uXMG43+inhWuOP6lyMHcJ2wwpiANWJ4RzWqtiCIafz3vbxxw+jamAFooNyr5akTms7Pk+SQpauLYZw3mMRwn423qS6HExTmxSNhynfonT8R8w37+/qAEBpW2LJI=
Message-ID: <86802c44050805132853070f1@mail.gmail.com>
Date: Fri, 5 Aug 2005 13:28:04 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: Roland Dreier <rolandd@cisco.com>, linville@tuxdriver.com, gregkh@suse.de,
       torvalds@osdl.org
Subject: Re: mthca and LinuxBIOS
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <86802c4405080512451cdcae48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20057281331.dR47KhjBsU48JfGE@cisco.com> <521x59a6tb.fsf@cisco.com>
	 <86802c440508041230143354c2@mail.gmail.com> <52slxp6o5b.fsf@cisco.com>
	 <86802c440508051103500f6942@mail.gmail.com>
	 <86802c4405080511079d01532@mail.gmail.com> <52psss5k1x.fsf@cisco.com>
	 <86802c44050805112661d889aa@mail.gmail.com>
	 <86802c4405080512254b9cd496@mail.gmail.com>
	 <86802c4405080512451cdcae48@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

please check the patch for fix overwrite upper 32bit 

YH

--- drivers/pci/setup-res.c.orig        2005-08-05 10:08:45.000000000 -0700
+++ drivers/pci/setup-res.c     2005-08-05 13:25:06.000000000 -0700
@@ -33,6 +33,18 @@
        u32 new, check, mask;
        int reg;

+        if (resno < 6) {
+                reg = PCI_BASE_ADDRESS_0 + 4 * resno;
+                if((resno & 1)==1) {
+                        /* check if previous reg is 64 mem */
+                        pci_read_config_dword(dev, reg-4, &check );
+                        if ((check &
(PCI_BASE_ADDRESS_SPACE|PCI_BASE_ADDRESS_MEM_TYPE_MASK)) ==
+                           
(PCI_BASE_ADDRESS_SPACE_MEMORY|PCI_BASE_ADDRESS_MEM_TYPE_64))
+                                return;
+                }
+
+        }
+
        pcibios_resource_to_bus(dev, &region, res);

        pr_debug("  got res [%lx:%lx] bus [%lx:%lx] flags %lx for "
@@ -67,7 +79,7 @@

        if ((new & (PCI_BASE_ADDRESS_SPACE|PCI_BASE_ADDRESS_MEM_TYPE_MASK)) ==
            (PCI_BASE_ADDRESS_SPACE_MEMORY|PCI_BASE_ADDRESS_MEM_TYPE_64)) {
-               new = 0; /* currently everyone zeros the high address */
+               new = region.start >> 32 ;
                pci_write_config_dword(dev, reg + 4, new);
                pci_read_config_dword(dev, reg + 4, &check);
                if (check != new) {
