Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751857AbWAERap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbWAERap (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 12:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbWAERap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 12:30:45 -0500
Received: from fmr14.intel.com ([192.55.52.68]:28380 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751857AbWAERao convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 12:30:44 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.6.15-mm1 (pnp: PnPACPI: unknown resource type 7)
Date: Thu, 5 Jan 2006 12:30:35 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300599D822@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RE: 2.6.15-mm1 (pnp: PnPACPI: unknown resource type 7)
Thread-Index: AcYRz/zMt3P6OCyRTgyuZO5RUyC10QAS37Cw
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Jan 2006 17:30:37.0515 (UTC) FILETIME=[BDD9B1B0:01C6121D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you build with CONFIG_PNPACPI=y and boot without "pnpacpi=off",
PnPACPI will fail with the warnings below --
fixed by the additional patch below.

thanks,
-Len

In ACPICA 20051117, acpi_walk_resources() started
sending ACPI_RESOURCE_TYPE_END_TAG to the callback
routine which wasn't prepared for it, causing
_CRS to fail and PnPACPI to not recognize any devices:

pnp: ACPI device : hid PNP0C02
pnp: PnPACPI: unknown resource type 7
pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c02

Signed-off-by: Len Brown <len.brown@intel.com>

---

 drivers/acpi/resources/rsxface.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

ed349a8a0a780ed27e2a765f16cee54d9b63bfee
diff --git a/drivers/acpi/resources/rsxface.c b/drivers/acpi/resources/rsxface.c
index 50a956b..5408e5d 100644
--- a/drivers/acpi/resources/rsxface.c
+++ b/drivers/acpi/resources/rsxface.c
@@ -286,6 +286,12 @@ acpi_walk_resources(acpi_handle device_h
 			break;
 		}
 
+		/* end_tag indicates end-of-list */
+
+		if (resource->type == ACPI_RESOURCE_TYPE_END_TAG) {
+			break;
+		}
+
 		/* Invoke the user function, abort on any error returned */
 
 		status = user_function(resource, context);
@@ -298,12 +304,6 @@ acpi_walk_resources(acpi_handle device_h
 			break;
 		}
 
-		/* end_tag indicates end-of-list */
-
-		if (resource->type == ACPI_RESOURCE_TYPE_END_TAG) {
-			break;
-		}
-
 		/* Get the next resource descriptor */
 
 		resource =
