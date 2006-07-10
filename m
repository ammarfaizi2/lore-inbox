Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161297AbWGJCCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161297AbWGJCCW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 22:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161296AbWGJCCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 22:02:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:58277 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1161291AbWGJCCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 22:02:21 -0400
X-IronPort-AV: i="4.06,221,1149490800"; 
   d="diff'?scan'208"; a="95447616:sNHT21961184"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C6A3C4.D84BEF0F"
Subject: RE: 2.6.17-mm2 -- drivers/built-in.o: In function `is_pci_dock_device':acpiphp_glue.c:(.text+0x12364): undefined reference to `is_dock_device'
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Sun, 9 Jul 2006 22:02:04 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6ECFA0D@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.17-mm2 -- drivers/built-in.o: In function `is_pci_dock_device':acpiphp_glue.c:(.text+0x12364): undefined reference to `is_dock_device'
Thread-Index: AcajrSRN9xS+pJoyR36Tl1K/zxB5ZQACNyzw
From: "Brown, Len" <len.brown@intel.com>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: "Miles Lane" <miles.lane@gmail.com>,
       "Accardi, Kristen C" <kristen.c.accardi@intel.com>,
       "Dave Hansen" <haveblue@us.ibm.com>, "Andrew Morton" <akpm@osdl.org>,
       "LKML" <linux-kernel@vger.kernel.org>, <gregkh@suse.de>,
       <linux-acpi@vger.kernel.org>, "Linus Torvalds" <torvalds@osdl.org>
X-OriginalArrivalTime: 10 Jul 2006 02:02:07.0806 (UTC) FILETIME=[D91C35E0:01C6A3C4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6A3C4.D84BEF0F
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>it allows the illegal configuration
>ACPI_IBM_DOCK=3Dy, HOTPLUG_PCI_ACPI=3Dy/m, ACPI_DOCK=3Dy/m.

Hmm, that seems to be an additional pre-existing problem.
Since ACPI_IBM_DOCK is going away, lets put the burden
of depending on ACPI_DOCK=3Dn on it, rather than the reverse.

Lets not use select, since it baffles...
and lets add the EXPERIMENTAL that should be here too.

This works for me:

DOCK	HPA	IBM_DOCK	DOCK,HPA,IBM_DOCK
y	y	y	=3D> 	y,y,n
y	m	y	=3D> 	y,m,n
y	n	y	=3D> 	y,n,n
m	y	y	=3D> 	m,m,n
m	m	y	=3D> 	m,m,n
m	n	y	=3D> 	m,n,n
n	y	y	=3D> 	n,n,y
n	m	y	=3D> 	n,n,y
n	n	y	=3D> 	n,n,y

thanks,
-Len


diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index fef7bab..82289f1 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -135,8 +135,7 @@ config ACPI_FAN
=20
 config ACPI_DOCK
 	tristate "Dock"
-	depends on !ACPI_IBM_DOCK
-	default y
+	depends on EXPERIMENTAL
 	help
 	  This driver adds support for ACPI controlled docking stations
=20
@@ -214,6 +213,7 @@ config ACPI_IBM
 config ACPI_IBM_DOCK
 	bool "Legacy Docking Station Support"
 	depends on ACPI_IBM
+	depends on ACPI_DOCK=3Dn
 	default n
 	---help---
 	  Allows the ibm_acpi driver to handle docking station events.
diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index 222a1cc..d305d21 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -77,7 +77,7 @@ config HOTPLUG_PCI_IBM
=20
 config HOTPLUG_PCI_ACPI
 	tristate "ACPI PCI Hotplug driver"
-	depends on ACPI && HOTPLUG_PCI
+	depends on ACPI_DOCK && HOTPLUG_PCI
 	help
 	  Say Y here if you have a system that supports PCI Hotplug
using
 	  ACPI.

------_=_NextPart_001_01C6A3C4.D84BEF0F
Content-Type: application/octet-stream;
	name="git.diff"
Content-Transfer-Encoding: base64
Content-Description: git.diff
Content-Disposition: attachment;
	filename="git.diff"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9LY29uZmlnIGIvZHJpdmVycy9hY3BpL0tjb25maWcK
aW5kZXggZmVmN2JhYi4uODIyODlmMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9hY3BpL0tjb25maWcK
KysrIGIvZHJpdmVycy9hY3BpL0tjb25maWcKQEAgLTEzNSw4ICsxMzUsNyBAQCBjb25maWcgQUNQ
SV9GQU4KIAogY29uZmlnIEFDUElfRE9DSwogCXRyaXN0YXRlICJEb2NrIgotCWRlcGVuZHMgb24g
IUFDUElfSUJNX0RPQ0sKLQlkZWZhdWx0IHkKKwlkZXBlbmRzIG9uIEVYUEVSSU1FTlRBTAogCWhl
bHAKIAkgIFRoaXMgZHJpdmVyIGFkZHMgc3VwcG9ydCBmb3IgQUNQSSBjb250cm9sbGVkIGRvY2tp
bmcgc3RhdGlvbnMKIApAQCAtMjE0LDYgKzIxMyw3IEBAIGNvbmZpZyBBQ1BJX0lCTQogY29uZmln
IEFDUElfSUJNX0RPQ0sKIAlib29sICJMZWdhY3kgRG9ja2luZyBTdGF0aW9uIFN1cHBvcnQiCiAJ
ZGVwZW5kcyBvbiBBQ1BJX0lCTQorCWRlcGVuZHMgb24gQUNQSV9ET0NLPW4KIAlkZWZhdWx0IG4K
IAktLS1oZWxwLS0tCiAJICBBbGxvd3MgdGhlIGlibV9hY3BpIGRyaXZlciB0byBoYW5kbGUgZG9j
a2luZyBzdGF0aW9uIGV2ZW50cy4KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2hvdHBsdWcvS2Nv
bmZpZyBiL2RyaXZlcnMvcGNpL2hvdHBsdWcvS2NvbmZpZwppbmRleCAyMjJhMWNjLi5kMzA1ZDIx
IDEwMDY0NAotLS0gYS9kcml2ZXJzL3BjaS9ob3RwbHVnL0tjb25maWcKKysrIGIvZHJpdmVycy9w
Y2kvaG90cGx1Zy9LY29uZmlnCkBAIC03Nyw3ICs3Nyw3IEBAIGNvbmZpZyBIT1RQTFVHX1BDSV9J
Qk0KIAogY29uZmlnIEhPVFBMVUdfUENJX0FDUEkKIAl0cmlzdGF0ZSAiQUNQSSBQQ0kgSG90cGx1
ZyBkcml2ZXIiCi0JZGVwZW5kcyBvbiBBQ1BJICYmIEhPVFBMVUdfUENJCisJZGVwZW5kcyBvbiBB
Q1BJX0RPQ0sgJiYgSE9UUExVR19QQ0kKIAloZWxwCiAJICBTYXkgWSBoZXJlIGlmIHlvdSBoYXZl
IGEgc3lzdGVtIHRoYXQgc3VwcG9ydHMgUENJIEhvdHBsdWcgdXNpbmcKIAkgIEFDUEkuCg==

------_=_NextPart_001_01C6A3C4.D84BEF0F--
