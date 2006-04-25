Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWDYGvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWDYGvL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 02:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWDYGvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 02:51:10 -0400
Received: from mga03.intel.com ([143.182.124.21]:24699 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751401AbWDYGvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 02:51:08 -0400
X-IronPort-AV: i="4.04,153,1144047600"; 
   d="scan'208"; a="27373809:sNHT9422732648"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C66834.9B7A1282"
Subject: [PATCH] reverse pci config space restore order
Date: Tue, 25 Apr 2006 14:50:57 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD13D48A5@pdsmsx411.ccr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] reverse pci config space restore order
Thread-Index: AcZoNJrdTLzm++oHRy2T9/ztUpRmXA==
From: "Yu, Luming" <luming.yu@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Apr 2006 06:50:58.0640 (UTC) FILETIME=[9BB29D00:01C66834]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C66834.9B7A1282
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


According to Intel ICH spec, there are several rules that
Base Address should be programmed before IOSE=20
(PCICMD register ) enabled.=20

For example ICH7:
12.1.3  SATA : the base address register for the bus=20
master register should be programmed before this bit is set.

11.1.3:  PCICMD (USB): The base address register for
USB should be programmed before this bit is set.
....
To make sure kernel code follow this rule=20
, and prevent unnecessary confusion. I proposal this
patch.=20

Note:
I'm sorry the patch is NOT in good format.
If you want to apply please use the attached patch file.
sorry for my email client.


Signed-off-by: Luming Yu <luming.yu@intel.com>

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bea1ad1..19a71a6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -456,7 +456,7 @@ pci_restore_state(struct pci_dev *dev)
 {
 	int i;
=20
-	for (i =3D 0; i < 16; i++)
+	for (i =3D 15; i >=3D 0 ; i--)
 		pci_write_config_dword(dev,i * 4,
dev->saved_config_space[i]);
 	return 0;
 }

------_=_NextPart_001_01C66834.9B7A1282
Content-Type: application/octet-stream;
	name="reverse_pci_config_space_restore_order.patch"
Content-Transfer-Encoding: base64
Content-Description: reverse_pci_config_space_restore_order.patch
Content-Disposition: attachment;
	filename="reverse_pci_config_space_restore_order.patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaS5jIGIvZHJpdmVycy9wY2kvcGNpLmMKaW5kZXgg
YmVhMWFkMS4uMTlhNzFhNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvcGNpLmMKKysrIGIvZHJp
dmVycy9wY2kvcGNpLmMKQEAgLTQ1Niw3ICs0NTYsNyBAQCBwY2lfcmVzdG9yZV9zdGF0ZShzdHJ1
Y3QgcGNpX2RldiAqZGV2KQogewogCWludCBpOwogCi0JZm9yIChpID0gMDsgaSA8IDE2OyBpKysp
CisJZm9yIChpID0gMTU7IGkgPj0gMCA7IGktLSkKIAkJcGNpX3dyaXRlX2NvbmZpZ19kd29yZChk
ZXYsaSAqIDQsIGRldi0+c2F2ZWRfY29uZmlnX3NwYWNlW2ldKTsKIAlyZXR1cm4gMDsKIH0K

------_=_NextPart_001_01C66834.9B7A1282--
