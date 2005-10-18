Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbVJRCKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbVJRCKf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 22:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbVJRCKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 22:10:35 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:8067 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932378AbVJRCKf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 22:10:35 -0400
Date: Mon, 17 Oct 2005 20:10:33 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Roland Dreier <rolandd@cisco.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] PCI: Add pci_find_next_capability() to deal with >1 caps of same type
Message-ID: <20051018021033.GA12610@parisc-linux.org>
References: <52mzl7pwrn.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52mzl7pwrn.fsf@cisco.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 04:08:12PM -0700, Roland Dreier wrote:
> +	while (ttl--) {
> +		pci_read_config_byte(dev, pos + PCI_CAP_LIST_NEXT, &pos);
> +		pos &= ~3;
> +		if (pos < 0x40)
> +			break;
> +		pci_read_config_byte(dev, pos + PCI_CAP_LIST_ID, &id);
> +		if (id == 0xff)
> +			break;
> +		if (id == cap)
> +			return pos;
> +	}

I don't like having this loop duplicated.  How about the following?

Index: ./drivers/pci/pci.c
===================================================================
RCS file: /var/lib/cvs/linux-2.6/drivers/pci/pci.c,v
retrieving revision 1.25
diff -u -p -r1.25 pci.c
--- ./drivers/pci/pci.c	24 Sep 2005 03:43:38 -0000	1.25
+++ ./drivers/pci/pci.c	18 Oct 2005 01:56:24 -0000
@@ -62,11 +62,38 @@ pci_max_busnr(void)
 	return max;
 }
 
+static int __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn, u8 pos, int cap)
+{
+	u8 id;
+	int ttl = 48;
+
+	while (ttl--) {
+		pci_bus_read_config_byte(bus, devfn, pos, &pos);
+		if (pos < 0x40)
+			break;
+		pos &= ~3;
+		pci_bus_read_config_byte(bus, devfn, pos + PCI_CAP_LIST_ID,
+					 &id);
+		if (id == 0xff)
+			break;
+		if (id == cap)
+			return pos;
+		pos += PCI_CAP_LIST_NEXT;
+	}
+	return 0;
+}
+
+int pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap)
+{
+	return __pci_find_next_cap(dev->bus, dev->devfn,
+				   pos + PCI_CAP_LIST_NEXT, cap);
+}
+EXPORT_SYMBOL(pci_find_next_capability);
+
 static int __pci_bus_find_cap(struct pci_bus *bus, unsigned int devfn, u8 hdr_type, int cap)
 {
 	u16 status;
-	u8 pos, id;
-	int ttl = 48;
+	u8 pos;
 
 	pci_bus_read_config_word(bus, devfn, PCI_STATUS, &status);
 	if (!(status & PCI_STATUS_CAP_LIST))
@@ -75,24 +102,15 @@ static int __pci_bus_find_cap(struct pci
 	switch (hdr_type) {
 	case PCI_HEADER_TYPE_NORMAL:
 	case PCI_HEADER_TYPE_BRIDGE:
-		pci_bus_read_config_byte(bus, devfn, PCI_CAPABILITY_LIST, &pos);
+		pos = PCI_CAPABILITY_LIST;
 		break;
 	case PCI_HEADER_TYPE_CARDBUS:
-		pci_bus_read_config_byte(bus, devfn, PCI_CB_CAPABILITY_LIST, &pos);
+		pos = PCI_CB_CAPABILITY_LIST;
 		break;
 	default:
 		return 0;
 	}
-	while (ttl-- && pos >= 0x40) {
-		pos &= ~3;
-		pci_bus_read_config_byte(bus, devfn, pos + PCI_CAP_LIST_ID, &id);
-		if (id == 0xff)
-			break;
-		if (id == cap)
-			return pos;
-		pci_bus_read_config_byte(bus, devfn, pos + PCI_CAP_LIST_NEXT, &pos);
-	}
-	return 0;
+	return __pci_find_next_cap(bus, devfn, pos, cap);
 }
 
 /**
