Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161134AbVLWWwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161134AbVLWWwu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161125AbVLWWwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:52:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:56015 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161104AbVLWWt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:49:28 -0500
Date: Fri, 23 Dec 2005 14:47:42 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       dsd@gentoo.org, venkatesh.pallipadi@intel.com
Subject: [patch 02/19] ACPI: Prefer _CST over FADT for C-state capabilities
Message-ID: <20051223224742.GB19057@kroah.com>
References: <20051223221200.342826000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="acpi-prefer-_cst-over-fadt-for-c-state-capabilities.patch"
In-Reply-To: <20051223224712.GA18975@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

[ACPI] Prefer _CST over FADT for C-state capabilities

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

--- linux-2.6.14.4.orig/drivers/acpi/processor_idle.c
+++ linux-2.6.14.4/drivers/acpi/processor_idle.c
@@ -706,7 +706,7 @@ static int acpi_processor_get_power_info
 
 	/* Validate number of power states discovered */
 	if (pr->power.count < 2)
-		status = -ENODEV;
+		status = -EFAULT;
 
       end:
 	acpi_os_free(buffer.pointer);
@@ -857,11 +857,11 @@ static int acpi_processor_get_power_info
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
