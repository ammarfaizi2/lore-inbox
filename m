Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbUJYJr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbUJYJr5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 05:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbUJYJr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 05:47:57 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:32364 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261733AbUJYJrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 05:47:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type;
        b=HReWVDKaiEIRe/Ua/Hhuj95YyQ6ZyMqVy5fu7O1nw5a2vkQM/7i3FnVn79XAY/A/p5tU2aQOgD4gM5cONtxvOWi3o/CRlLjWJM9Lp10LwKKZ4rYrl+JI7x7PF5F+P1EToRxysjHpQI051Je3Fvk632BNWtVpvAkh9CpfUDtPveU=
Message-ID: <288dbef704102502474fdd0c84@mail.gmail.com>
Date: Mon, 25 Oct 2004 17:47:52 +0800
From: shaohua li <shaoh.li@gmail.com>
Reply-To: shaohua li <shaoh.li@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] call 'pci_dev_put' after pci_get_device
Cc: akpm@osdl.org, greg@kroah.com
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4737_28747266.1098697672725"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_4737_28747266.1098697672725
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
Some code didn't call 'pci_dev_put' after pci_get_device. Below is an
incomplete list.

Thanks,
Shaohua

Signed-off-by: Li Shaohua <shaoh.li@gmail.com>

===== drivers/pci/pci.c 1.73 vs edited =====
--- 1.73/drivers/pci/pci.c	2004-10-07 00:42:55 +08:00
+++ edited/drivers/pci/pci.c	2004-10-25 17:30:36 +08:00
@@ -734,6 +734,7 @@ static int __devinit pci_init(void)
 
 	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 		pci_fixup_device(pci_fixup_final, dev);
+		pci_dev_put(dev);
 	}
 	return 0;
 }
===== drivers/pci/quirks.c 1.55 vs edited =====
--- 1.55/drivers/pci/quirks.c	2004-10-20 00:54:38 +08:00
+++ edited/drivers/pci/quirks.c	2004-10-25 17:29:48 +08:00
@@ -38,6 +38,7 @@ static void __devinit quirk_passive_rele
 			dlc |= 1<<1;
 			pci_write_config_byte(d, 0x82, dlc);
 		}
+		pci_dev_put(d);
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release
);
===== drivers/pci/setup-irq.c 1.5 vs edited =====
--- 1.5/drivers/pci/setup-irq.c	2004-10-07 00:44:51 +08:00
+++ edited/drivers/pci/setup-irq.c	2004-10-25 17:29:08 +08:00
@@ -67,5 +67,6 @@ pci_fixup_irqs(u8 (*swizzle)(struct pci_
 	struct pci_dev *dev = NULL;
 	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 		pdev_fixup_irq(dev, swizzle, map_irq);
+		pci_dev_put(dev);
 	}
 }

------=_Part_4737_28747266.1098697672725
Content-Type: application/octet-stream; name="pci_get_device.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pci_get_device.patch"

PT09PT0gZHJpdmVycy9wY2kvcGNpLmMgMS43MyB2cyBlZGl0ZWQgPT09PT0KLS0tIDEuNzMvZHJp
dmVycy9wY2kvcGNpLmMJMjAwNC0xMC0wNyAwMDo0Mjo1NSArMDg6MDAKKysrIGVkaXRlZC9kcml2
ZXJzL3BjaS9wY2kuYwkyMDA0LTEwLTI1IDE3OjMwOjM2ICswODowMApAQCAtNzM0LDYgKzczNCw3
IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IHBjaV9pbml0KHZvaWQpCiAKIAl3aGlsZSAoKGRldiA9
IHBjaV9nZXRfZGV2aWNlKFBDSV9BTllfSUQsIFBDSV9BTllfSUQsIGRldikpICE9IE5VTEwpIHsK
IAkJcGNpX2ZpeHVwX2RldmljZShwY2lfZml4dXBfZmluYWwsIGRldik7CisJCXBjaV9kZXZfcHV0
KGRldik7CiAJfQogCXJldHVybiAwOwogfQo9PT09PSBkcml2ZXJzL3BjaS9xdWlya3MuYyAxLjU1
IHZzIGVkaXRlZCA9PT09PQotLS0gMS41NS9kcml2ZXJzL3BjaS9xdWlya3MuYwkyMDA0LTEwLTIw
IDAwOjU0OjM4ICswODowMAorKysgZWRpdGVkL2RyaXZlcnMvcGNpL3F1aXJrcy5jCTIwMDQtMTAt
MjUgMTc6Mjk6NDggKzA4OjAwCkBAIC0zOCw2ICszOCw3IEBAIHN0YXRpYyB2b2lkIF9fZGV2aW5p
dCBxdWlya19wYXNzaXZlX3JlbGUKIAkJCWRsYyB8PSAxPDwxOwogCQkJcGNpX3dyaXRlX2NvbmZp
Z19ieXRlKGQsIDB4ODIsIGRsYyk7CiAJCX0KKwkJcGNpX2Rldl9wdXQoZCk7CiAJfQogfQogREVD
TEFSRV9QQ0lfRklYVVBfRklOQUwoUENJX1ZFTkRPUl9JRF9JTlRFTCwJUENJX0RFVklDRV9JRF9J
TlRFTF84MjQ0MSwJcXVpcmtfcGFzc2l2ZV9yZWxlYXNlICk7Cj09PT09IGRyaXZlcnMvcGNpL3Nl
dHVwLWlycS5jIDEuNSB2cyBlZGl0ZWQgPT09PT0KLS0tIDEuNS9kcml2ZXJzL3BjaS9zZXR1cC1p
cnEuYwkyMDA0LTEwLTA3IDAwOjQ0OjUxICswODowMAorKysgZWRpdGVkL2RyaXZlcnMvcGNpL3Nl
dHVwLWlycS5jCTIwMDQtMTAtMjUgMTc6Mjk6MDggKzA4OjAwCkBAIC02Nyw1ICs2Nyw2IEBAIHBj
aV9maXh1cF9pcnFzKHU4ICgqc3dpenpsZSkoc3RydWN0IHBjaV8KIAlzdHJ1Y3QgcGNpX2RldiAq
ZGV2ID0gTlVMTDsKIAl3aGlsZSAoKGRldiA9IHBjaV9nZXRfZGV2aWNlKFBDSV9BTllfSUQsIFBD
SV9BTllfSUQsIGRldikpICE9IE5VTEwpIHsKIAkJcGRldl9maXh1cF9pcnEoZGV2LCBzd2l6emxl
LCBtYXBfaXJxKTsKKwkJcGNpX2Rldl9wdXQoZGV2KTsKIAl9CiB9Cg==
------=_Part_4737_28747266.1098697672725--
