Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWJQXTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWJQXTU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 19:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWJQXTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 19:19:20 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:19871 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751088AbWJQXTT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 19:19:19 -0400
Message-ID: <453564F5.80202@us.ibm.com>
Date: Tue, 17 Oct 2006 16:19:17 -0700
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ACPI: Processor native C-states using MWAIT
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch breaks C-state discovery on my IBM IntelliStation Z30
because the return value of acpi_processor_get_power_info_fadt is not
assigned to "result" in the case that acpi_processor_get_power_info_cst
returns -ENODEV.  Thus, if ACPI provides C-state data via the FADT and
not _CST (as is the case on this machine), we incorrectly exit the
function with -ENODEV after reading the FADT.  The attached patch
sets the value of result so that we don't exit early.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

--

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 526387d..5c118cb 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -962,7 +962,7 @@ static int acpi_processor_get_power_info
 
 	result = acpi_processor_get_power_info_cst(pr);
 	if (result == -ENODEV)
-		acpi_processor_get_power_info_fadt(pr);
+		result = acpi_processor_get_power_info_fadt(pr);
 
 	if (result)
 		return result;
