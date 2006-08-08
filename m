Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWHHTRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWHHTRT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbWHHTRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:17:19 -0400
Received: from outbound-kan.frontbridge.com ([63.161.60.23]:61070 "EHLO
	outbound2-kan-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1030188AbWHHTRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:17:18 -0400
X-BigFish: VP
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Date: Tue, 8 Aug 2006 13:19:03 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-acpi@vger.kernel.org
cc: linux-kernel@vger.kernel.org, william.morrow@amd.com
Subject: [PATCH] ACPI: Clear GPE before disabling it
Message-ID: <20060808191903.GA10816@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 08 Aug 2006 19:17:03.0776 (UTC)
 FILETIME=[3B2C0A00:01C6BB1F]
X-WSS-ID: 68C63CA51NW1326498-01-01
Content-Type: multipart/mixed;
 boundary=M9NhX3UHpAaciwkO
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On AMD Geode BIOSen, we have problems with GPE interrupt storms.  The
attached patch resolves that.  This should be fine for all implementations,
though.

Jordan
-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>

--M9NhX3UHpAaciwkO
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=acpi-s1-fix.patch
Content-Transfer-Encoding: 7bit

[PATCH] ACPI:  Clear GPE before disabling it

From: William Morrow <william.morrow@amd.com>

On some BIOSen, the GPE bit will remain set even if it is disabled, 
resulting in a interrupt storm.  This patch clears the bit before 
disabling it.

Signed-off-by:  William Morrow <william.morrow@amd.com>
Signed-off-by:  Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/acpi/events/evgpe.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
index c76c058..1f93b23 100644
--- a/drivers/acpi/events/evgpe.c
+++ b/drivers/acpi/events/evgpe.c
@@ -677,10 +677,22 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_eve
 	case ACPI_GPE_DISPATCH_METHOD:
 
 		/*
-		 * Disable GPE, so it doesn't keep firing before the method has a
+		 * Clear GPE, so it doesn't keep firing before the method has a
 		 * chance to run.
 		 */
+		status = acpi_hw_clear_gpe(gpe_event_info);
+		if (ACPI_FAILURE(status)) {
+			ACPI_EXCEPTION((AE_INFO, status,
+					"Unable to clear GPE[%2X]",
+					gpe_number));
+			return_UINT32(ACPI_INTERRUPT_NOT_HANDLED);
+		}
+		/*
+		 * Disable GPE, so it doesn't keep happen again.
+		 */
+
 		status = acpi_ev_disable_gpe(gpe_event_info);
+
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
 					"Unable to disable GPE[%2X]",

--M9NhX3UHpAaciwkO--


