Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQLKCRn>; Sun, 10 Dec 2000 21:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129255AbQLKCRd>; Sun, 10 Dec 2000 21:17:33 -0500
Received: from r1922.muc.dial.surf-callino.de ([213.21.8.144]:1540 "EHLO
	notebook.diehl.home") by vger.kernel.org with ESMTP
	id <S129231AbQLKCRX>; Sun, 10 Dec 2000 21:17:23 -0500
Date: Mon, 11 Dec 2000 02:46:34 +0100 (CET)
From: Martin Diehl <mdiehlcs@compuserve.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Martin Mares <mj@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] VLSI irq router (was: PCI irq routing..)
In-Reply-To: <Pine.LNX.4.10.10012071031300.2496-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0012110138280.1413-200000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463786495-223338545-976498884=:506"
Content-ID: <Pine.LNX.4.21.0012110246220.592@notebook.diehl.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463786495-223338545-976498884=:506
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.21.0012110246221.592@notebook.diehl.home>

On Thu, 7 Dec 2000, Linus Torvalds wrote:

> > btw, I'm thinking I could guess the routing from the VLSI config space,
> > but I don't have any doc's. Would it be worth to try to add some specific
> 
> Please do. You might leave them commented out right now, but this is

Ok. Apparently it's the "pirq is nibble index in config space" kind of
routing which makes guessing a change bios and lspci procedure.
patch vs. 2.4.0-t12p8 below. Tested as (in)complete as my bios permits.
Works fine for several days and correctly assigns IRQ's when unassigned 
due to "pnp os". So I feel confident enough to not leave it commented out.
Test example attached.

Regards
Martin

-----

diff -Nur linux-2.4.0-t12p8/arch/i386/kernel/pci-irq.c linux-2.4.0-t12p8-md/arch/i386/kernel/pci-irq.c
--- linux-2.4.0-t12p8/arch/i386/kernel/pci-irq.c	Mon Dec 11 00:29:42 2000
+++ linux-2.4.0-t12p8-md/arch/i386/kernel/pci-irq.c	Mon Dec 11 00:58:48 2000
@@ -298,6 +298,33 @@
 	return 1;
 }
 
+/*
+ * VLSI: nibble offset 0x74 - educated guess due to routing table and
+ *       config space of VLSI 82C534 PCI-bridge/router (1004:0102)
+ *       Tested on HP OmniBook 800 covering PIRQ 1, 2, 4, 8 for onboard
+ *       devices, PIRQ 3 for non-pci(!) soundchip and (untested) PIRQ 6
+ *       for the busbridge to the docking station.
+ */
+
+static int pirq_vlsi_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
+{
+	if (pirq > 8) {
+		printk("VLSI router pirq escape (%d)\n", pirq);
+		return 0;
+	}
+	return read_config_nybble(router, 0x74, pirq-1);
+}
+
+static int pirq_vlsi_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
+{
+	if (pirq > 8) {
+		printk("VLSI router pirq escape (%d)\n", pirq);
+		return 0;
+	}
+	write_config_nybble(router, 0x74, pirq-1, irq);
+	return 1;
+}
+                                                                
 #ifdef CONFIG_PCI_BIOS
 
 static int pirq_bios_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
@@ -329,6 +356,7 @@
 
 	{ "NatSemi", PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5520, pirq_cyrix_get, pirq_cyrix_set },
 	{ "SIS", PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_503, pirq_sis_get, pirq_sis_set },
+        { "VLSI 82C534", PCI_VENDOR_ID_VLSI, PCI_DEVICE_ID_VLSI_82C534, pirq_vlsi_get, pirq_vlsi_set },
 	{ "default", 0, 0, NULL, NULL }
 };



---1463786495-223338545-976498884=:506
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=vlsi_debug
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0012110241240.506@notebook.diehl.home>
Content-Description: vlsi_debug
Content-Disposition: ATTACHMENT; FILENAME=vlsi_debug

UENJOiBCSU9TMzIgU2VydmljZSBEaXJlY3Rvcnkgc3RydWN0dXJlIGF0IDB4
YzAwZWMwNjANClBDSTogQklPUzMyIFNlcnZpY2UgRGlyZWN0b3J5IGVudHJ5
IGF0IDB4ZWVmYjANClBDSTogQklPUyBwcm9iZSByZXR1cm5lZCBzPTAwIGh3
PTExIHZlcj0wMi4xMCBsPTAxDQpQQ0k6IFBDSSBCSU9TIHJldmlzaW9uIDIu
MTAgZW50cnkgYXQgMHhlZWZjMiwgbGFzdCBidXM9MQ0KUENJOiBVc2luZyBj
b25maWd1cmF0aW9uIHR5cGUgMQ0KUENJOiBQcm9iaW5nIFBDSSBoYXJkd2Fy
ZQ0KUENJOiBTY2FubmluZyBmb3IgZ2hvc3QgZGV2aWNlcyBvbiBidXMgMA0K
UENJOiBTY2FubmluZyBmb3IgZ2hvc3QgZGV2aWNlcyBvbiBidXMgMQ0KUENJ
OiBJUlEgaW5pdA0KUENJOiBJbnRlcnJ1cHQgUm91dGluZyBUYWJsZSBmb3Vu
ZCBhdCAweGMwMGYzNmUwDQowMDowMyBzbG90PTAwIDA6MDAvMDAwMCAxOjAw
LzAwMDAgMjowMC8wMDAwIDM6MDAvMDAwMA0KMDA6MDQgc2xvdD0wMCAwOjAx
LzhlYjggMTowNC84ZWI4IDI6MDQvMDAwMCAzOjA0LzAwMDANCjAwOjA1IHNs
b3Q9MDAgMDowOC84ZWI4IDE6MDgvMDAwMCAyOjA4LzAwMDAgMzowOC8wMDAw
DQowMDowNiBzbG90PTAwIDA6MDIvOGViOCAxOjAyLzAwMDAgMjowMi8wMDAw
IDM6MDIvMDAwMA0KMDE6MDAgc2xvdD0wMCAwOjA4LzhlYjggMTowOC8wMDAw
IDI6MDgvMDAwMCAzOjA4LzAwMDANCjAxOjA2IHNsb3Q9MDEgMDowNi84ZWI4
IDE6MDYvOGViOCAyOjA2LzhlYjggMzowNi84ZWI4DQpQQ0k6IFVzaW5nIElS
USByb3V0ZXIgVkxTSSA4MkM1MzQgWzEwMDQvMDEwMl0gYXQgMDA6MDEuMA0K
UENJOiBJUlEgZml4dXANCjAwOjAzLjA6IGlnbm9yaW5nIGJvZ3VzIElSUSAy
NTUNCjAwOjA0LjA6IGlnbm9yaW5nIGJvZ3VzIElSUSAyNTUNCjAwOjA0LjE6
IGlnbm9yaW5nIGJvZ3VzIElSUSAyNTUNCklSUSBmb3IgMDA6MDMuMCgwKSB2
aWEgMDA6MDMuMCAtPiBub3Qgcm91dGVkDQpJUlEgZm9yIDAwOjA0LjAoMCkg
dmlhIDAwOjA0LjAgLT4gUElSUSAwMSwgbWFzayA4ZWI4LCBleGNsIDAwMDAg
LT4gbmV3aXJxPTAgLi4uIGZhaWxlZA0KSVJRIGZvciAwMDowNC4xKDEpIHZp
YSAwMDowNC4xIC0+IFBJUlEgMDQsIG1hc2sgOGViOCwgZXhjbCAwMDAwIC0+
IG5ld2lycT0wIC4uLiBmYWlsZWQNClBDSTogQWxsb2NhdGluZyByZXNvdXJj
ZXMNClBDSTogUmVzb3VyY2UgYzAwMDAwMDAtYzAzZmZmZmYgKGY9MTIwOCwg
ZD0wLCBwPTApDQpQQ0k6IFJlc291cmNlIDAwMDAzMTAwLTAwMDAzMWZmIChm
PTEwMSwgZD0wLCBwPTApDQpQQ0k6IFJlc291cmNlIDFmZmZmZjAwLTFmZmZm
ZmZmIChmPTIwMCwgZD0wLCBwPTApDQpQQ0k6IFJlc291cmNlIDAwMDAzMDAw
LTAwMDAzMDFmIChmPTEwMSwgZD0wLCBwPTApDQogIGdvdCByZXNbMTAwMDAw
MDA6MTAwMDBmZmZdIGZvciByZXNvdXJjZSAwIG9mIFRleGFzIEluc3RydW1l
bnRzIFBDSTExMzENCiAgZ290IHJlc1sxMDAwMTAwMDoxMDAwMWZmZl0gZm9y
IHJlc291cmNlIDAgb2YgVGV4YXMgSW5zdHJ1bWVudHMgUENJMTEzMSAoIzIp
DQpQQ0k6IFNvcnRpbmcgZGV2aWNlIGxpc3QuLi4NCg0KTGludXggUENNQ0lB
IENhcmQgU2VydmljZXMgMy4xLjIyDQogIG9wdGlvbnM6ICBbcGNpXSBbY2Fy
ZGJ1c10gW3BtXQ0KUENJOiBFbmFibGluZyBkZXZpY2UgMDA6MDQuMCAoMDAw
MCAtPiAwMDAyKQ0KSVJRIGZvciAwMDowNC4wKDApIHZpYSAwMDowNC4wIC0+
IFBJUlEgMDEsIG1hc2sgOGViOCwgZXhjbCAwMDAwIC0+IG5ld2lycT01IC0+
IGFzc2lnbmluZyBJUlEgNSAuLi4gT0sNClBDSTogQXNzaWduZWQgSVJRIDUg
Zm9yIGRldmljZSAwMDowNC4wDQpQQ0k6IEVuYWJsaW5nIGRldmljZSAwMDow
NC4xICgwMDAwIC0+IDAwMDIpDQpJUlEgZm9yIDAwOjA0LjEoMSkgdmlhIDAw
OjA0LjEgLT4gUElSUSAwNCwgbWFzayA4ZWI4LCBleGNsIDAwMDAgLT4gbmV3
aXJxPTkgLT4gYXNzaWduaW5nIElSUSA5IC4uLiBPSw0KUENJOiBBc3NpZ25l
ZCBJUlEgOSBmb3IgZGV2aWNlIDAwOjA0LjENClllbnRhIElSUSBsaXN0IDBh
ZDgsIFBDSSBpcnE1DQpTb2NrZXQgc3RhdHVzOiAzMDAwMDExMA0KWWVudGEg
SVJRIGxpc3QgMDhkOCwgUENJIGlycTkNClNvY2tldCBzdGF0dXM6IDMwMDAw
MDEwDQoNCjAwOjAwLjAgSG9zdCBicmlkZ2U6IFZMU0kgVGVjaG5vbG9neSBJ
bmMgODJDNTM1IChyZXYgMDMpDQoJRmxhZ3M6IGJ1cyBtYXN0ZXIsIG1lZGl1
bSBkZXZzZWwsIGxhdGVuY3kgMA0KDQowMDowMS4wIFBDSSBicmlkZ2U6IFZM
U0kgVGVjaG5vbG9neSBJbmMgODJDNTM0IChyZXYgMDMpIChwcm9nLWlmIDAw
IFtOb3JtYWwgZGVjb2RlXSkNCglGbGFnczogYnVzIG1hc3RlciwgbWVkaXVt
IGRldnNlbCwgbGF0ZW5jeSAwDQoJQnVzOiBwcmltYXJ5PTAwLCBzZWNvbmRh
cnk9MDEsIHN1Ym9yZGluYXRlPTAxLCBzZWMtbGF0ZW5jeT0wDQoJSS9PIGJl
aGluZCBicmlkZ2U6IDAwMDA0MDAwLTAwMDA3ZmZmDQoJTWVtb3J5IGJlaGlu
ZCBicmlkZ2U6IDIwMDAwMDAwLTJmZmZmZmZmDQoJUHJlZmV0Y2hhYmxlIG1l
bW9yeSBiZWhpbmQgYnJpZGdlOiAzMDAwMDAwMC0zZmZmZmZmZg0KNzA6IDA4
IDA4IDA4IDAwIGE1IDk1IDAwIGEwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDNh
DQogICAgICAgICAgICAgICAgXl5eXl5eXl5eXl4NCg0KMDA6MDIuMCBDbGFz
cyBmZjAwOiBWTFNJIFRlY2hub2xvZ3kgSW5jIDgyQzUzMiAocmV2IDAyKQ0K
CUZsYWdzOiBtZWRpdW0gZGV2c2VsDQoNCjAwOjAzLjAgVkdBIGNvbXBhdGli
bGUgY29udHJvbGxlcjogTmVvbWFnaWMgQ29ycG9yYXRpb24gTk0yMDkzIFtN
YWdpY0dyYXBoIDEyOFpWXSAocmV2IDA0KSAocHJvZy1pZiAwMCBbVkdBXSkN
CglGbGFnczogbWVkaXVtIGRldnNlbA0KCU1lbW9yeSBhdCBjMDAwMDAwMCAo
MzItYml0LCBwcmVmZXRjaGFibGUpIFtzaXplPTRNXQ0KDQowMDowNC4wIENh
cmRCdXMgYnJpZGdlOiBUZXhhcyBJbnN0cnVtZW50cyBQQ0kxMTMxIChyZXYg
MDEpDQoJRmxhZ3M6IGJ1cyBtYXN0ZXIsIG1lZGl1bSBkZXZzZWwsIGxhdGVu
Y3kgMTY4LCBJUlEgNQ0KCU1lbW9yeSBhdCAxMDAwMDAwMCAoMzItYml0LCBu
b24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT00S10NCglCdXM6IHByaW1hcnk9MDAs
IHNlY29uZGFyeT0wMiwgc3Vib3JkaW5hdGU9MDIsIHNlYy1sYXRlbmN5PTE3
Ng0KCU1lbW9yeSB3aW5kb3cgMDogMTAwMDAwMDAtMTAzZmYwMDAgKHByZWZl
dGNoYWJsZSkNCglNZW1vcnkgd2luZG93IDE6IDEwNDAwMDAwLTEwN2ZmMDAw
DQoJSS9PIHdpbmRvdyAwOiAwMDAwMTQwMC0wMDAwMTRmZg0KCUkvTyB3aW5k
b3cgMTogMDAwMDE4MDAtMDAwMDE4ZmYNCgkxNi1iaXQgbGVnYWN5IGludGVy
ZmFjZSBwb3J0cyBhdCAwMDAxDQoNCjAwOjA0LjEgQ2FyZEJ1cyBicmlkZ2U6
IFRleGFzIEluc3RydW1lbnRzIFBDSTExMzEgKHJldiAwMSkNCglGbGFnczog
YnVzIG1hc3RlciwgbWVkaXVtIGRldnNlbCwgbGF0ZW5jeSAxNjgsIElSUSA5
DQoJTWVtb3J5IGF0IDEwMDAxMDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFi
bGUpIFtzaXplPTRLXQ0KCUJ1czogcHJpbWFyeT0wMCwgc2Vjb25kYXJ5PTA2
LCBzdWJvcmRpbmF0ZT0wNiwgc2VjLWxhdGVuY3k9MTc2DQoJTWVtb3J5IHdp
bmRvdyAwOiAxMDgwMDAwMC0xMGJmZjAwMCAocHJlZmV0Y2hhYmxlKQ0KCU1l
bW9yeSB3aW5kb3cgMTogMTBjMDAwMDAtMTBmZmYwMDANCglJL08gd2luZG93
IDA6IDAwMDAxYzAwLTAwMDAxY2ZmDQoJSS9PIHdpbmRvdyAxOiAwMDAwMjAw
MC0wMDAwMjBmZg0KCTE2LWJpdCBsZWdhY3kgaW50ZXJmYWNlIHBvcnRzIGF0
IDAwMDENCg0KMDA6MDUuMCBTQ1NJIHN0b3JhZ2UgY29udHJvbGxlcjogU3lt
YmlvcyBMb2dpYyBJbmMuIChmb3JtZXJseSBOQ1IpIDUzYzgxMCAocmV2IDEy
KQ0KCUZsYWdzOiBidXMgbWFzdGVyLCBtZWRpdW0gZGV2c2VsLCBsYXRlbmN5
IDEyOCwgSVJRIDEwDQoJSS9PIHBvcnRzIGF0IDMxMDAgW3NpemU9MjU2XQ0K
CU1lbW9yeSBhdCAxZmZmZmYwMCAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxl
KSBbc2l6ZT0yNTZdDQoNCjAwOjA2LjAgSVJEQSBjb250cm9sbGVyOiBWTFNJ
IFRlY2hub2xvZ3kgSW5jIDgyQzE0NyAocmV2IDAyKQ0KCUZsYWdzOiBidXMg
bWFzdGVyLCBtZWRpdW0gZGV2c2VsLCBsYXRlbmN5IDAsIElSUSAxMA0KCUkv
TyBwb3J0cyBhdCAzMDAwIFtzaXplPTMyXQ0KDQo=
---1463786495-223338545-976498884=:506--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
