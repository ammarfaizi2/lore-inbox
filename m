Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932569AbVLMI3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbVLMI3m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbVLMI3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:29:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:30340 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932569AbVLMIZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:25:11 -0500
Date: Tue, 13 Dec 2005 00:22:51 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       dsd@gentoo.org, venkatesh.pallipadi@intel.com, len.brown@intel.com
Subject: [patch 10/26] ACPI: Prefer _CST over FADT for C-state capabilities
Message-ID: <20051213082251.GK5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="acpi-prefer-_cst-over-fadt-for-c-state-capabilities.patch"
In-Reply-To: <20051213082143.GA5823@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Note: This ACPI standard compliance may cause regression
on some system, if they have _CST present, but _CST value
is bogus. "nocst" module parameter should workaround
that regression.

http://bugzilla.kernel.org/show_bug.cgi?id=5165

(cherry picked from 883baf7f7e81cca26f4683ae0d25ba48f094cc08 commit)

Signed-off-by: Venkatesh Pallipadi<venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/acpi/processor_idle.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-2.6.14.3.orig/drivers/acpi/processor_idle.c
+++ linux-2.6.14.3/drivers/acpi/processor_idle.c
@@ -687,7 +687,7 @@ static int acpi_processor_get_power_info
 
 	/* Validate number of power states discovered */
 	if (pr->power.count < 2)
-		status = -ENODEV;
+		status = -EFAULT;
 
       end:
 	acpi_os_free(buffer.pointer);
@@ -838,11 +838,11 @@ static int acpi_processor_get_power_info
 	 * this function */
 
 	result = acpi_processor_get_power_info_cst(pr);
-	if ((result) || (acpi_processor_power_verify(pr) < 2)) {
+	if (result == -ENODEV)
 		result = acpi_processor_get_power_info_fadt(pr);
-		if ((result) || (acpi_processor_power_verify(pr) < 2))
-			result = acpi_processor_get_power_info_default_c1(pr);
-	}
+
+	if ((result) || (acpi_processor_power_verify(pr) < 2))
+		result = acpi_processor_get_power_info_default_c1(pr);
 
 	/*
 	 * Set Default Policy

--
