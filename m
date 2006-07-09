Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbWGIXD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbWGIXD2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 19:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbWGIXD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 19:03:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:24215 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932480AbWGIXD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 19:03:27 -0400
X-IronPort-AV: i="4.06,221,1149490800"; 
   d="diff'?scan'208"; a="62654439:sNHT18209534"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C6A3AB.E197BAFE"
Subject: RE: 2.6.17-mm2 -- drivers/built-in.o: In function `is_pci_dock_device':acpiphp_glue.c:(.text+0x12364): undefined reference to `is_dock_device'
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Sun, 9 Jul 2006 19:03:23 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6ECF9E7@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.17-mm2 -- drivers/built-in.o: In function `is_pci_dock_device':acpiphp_glue.c:(.text+0x12364): undefined reference to `is_dock_device'
Thread-Index: AcaYl6IJB7gcQznqSa+Cd/5a3RjmngLEVZcQ
From: "Brown, Len" <len.brown@intel.com>
To: "Adrian Bunk" <bunk@stusta.de>, "Miles Lane" <miles.lane@gmail.com>,
       "Accardi, Kristen C" <kristen.c.accardi@intel.com>
Cc: "Dave Hansen" <haveblue@us.ibm.com>, "Andrew Morton" <akpm@osdl.org>,
       "LKML" <linux-kernel@vger.kernel.org>, <gregkh@suse.de>,
       <linux-acpi@vger.kernel.org>, "Linus Torvalds" <torvalds@osdl.org>
X-OriginalArrivalTime: 09 Jul 2006 23:03:26.0198 (UTC) FILETIME=[E288A960:01C6A3AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6A3AB.E197BAFE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


>It would be a solution to let HOTPLUG_PCI_ACPI depend on
>(ACPI_DOCK || ACPI_DOCK=3Dn), or the #if in=20
>include/acpi/acpi_drivers.h could be changed to
>#if defined(CONFIG_ACPI_DOCK) ||=20
>(defined(CONFIG_ACPI_DOCK_MODULE) && defined(MODULE))

CONFIG_HOTPLUG_PCI_ACPI requires CONFIG_ACPI_DOCK.
There are 9 combinations.

DOCK	HPA
n	n	ok
n	y	illegal
n	m	illegal
y	n	ok
y	y	ok
y	m	ok
m	n	ok
m	y	illegal (subject of this thread)
m	m	ok

The patch below handles all these cases:

DOCK	HPA
n	n	builds
n	y	-> y,y
n	m	-> m,m
y	n	builds
y	y	builds
y	m	builds
m	n	builds
m	y	-> m,y
m	m	builds

okay?

-Len

diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index 222a1cc..e7c955b 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -78,6 +78,7 @@ config HOTPLUG_PCI_IBM
 config HOTPLUG_PCI_ACPI
 	tristate "ACPI PCI Hotplug driver"
 	depends on ACPI && HOTPLUG_PCI
+	select ACPI_DOCK
 	help
 	  Say Y here if you have a system that supports PCI Hotplug
using
 	  ACPI.

------_=_NextPart_001_01C6A3AB.E197BAFE
Content-Type: application/octet-stream;
	name="git.diff"
Content-Transfer-Encoding: base64
Content-Description: git.diff
Content-Disposition: attachment;
	filename="git.diff"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2hvdHBsdWcvS2NvbmZpZyBiL2RyaXZlcnMvcGNpL2hv
dHBsdWcvS2NvbmZpZwppbmRleCAyMjJhMWNjLi5lN2M5NTViIDEwMDY0NAotLS0gYS9kcml2ZXJz
L3BjaS9ob3RwbHVnL0tjb25maWcKKysrIGIvZHJpdmVycy9wY2kvaG90cGx1Zy9LY29uZmlnCkBA
IC03OCw2ICs3OCw3IEBAIGNvbmZpZyBIT1RQTFVHX1BDSV9JQk0KIGNvbmZpZyBIT1RQTFVHX1BD
SV9BQ1BJCiAJdHJpc3RhdGUgIkFDUEkgUENJIEhvdHBsdWcgZHJpdmVyIgogCWRlcGVuZHMgb24g
QUNQSSAmJiBIT1RQTFVHX1BDSQorCXNlbGVjdCBBQ1BJX0RPQ0sKIAloZWxwCiAJICBTYXkgWSBo
ZXJlIGlmIHlvdSBoYXZlIGEgc3lzdGVtIHRoYXQgc3VwcG9ydHMgUENJIEhvdHBsdWcgdXNpbmcK
IAkgIEFDUEkuCg==

------_=_NextPart_001_01C6A3AB.E197BAFE--
