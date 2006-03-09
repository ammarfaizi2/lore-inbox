Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161002AbWCIDM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbWCIDM1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 22:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbWCIDM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 22:12:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30647 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161002AbWCIDM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 22:12:26 -0500
Date: Wed, 8 Mar 2006 22:12:18 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: len.brown@intel.com
Subject: acpi thermal driver leaks in failure path
Message-ID: <20060309031218.GA18238@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, len.brown@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leaking memory in failure path.

Coverity: #601
Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/drivers/acpi/thermal.c~	2006-03-08 22:09:51.000000000 -0500
+++ linux-2.6/drivers/acpi/thermal.c	2006-03-08 22:11:05.000000000 -0500
@@ -942,8 +942,10 @@ acpi_thermal_write_trip_points(struct fi
 	memset(limit_string, 0, ACPI_THERMAL_MAX_LIMIT_STR_LEN);
 
 	active = kmalloc(ACPI_THERMAL_MAX_ACTIVE * sizeof(int), GFP_KERNEL);
-	if (!active)
+	if (!active) {
+		kfree(limit_string);
 		return_VALUE(-ENOMEM);
+	}
 
 	if (!tz || (count > ACPI_THERMAL_MAX_LIMIT_STR_LEN - 1)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid argument\n"));
-- 
http://www.codemonkey.org.uk
