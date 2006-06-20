Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWFTWr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWFTWr7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWFTWr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:47:59 -0400
Received: from 1wt.eu ([62.212.114.60]:5641 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S1751457AbWFTWr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:47:58 -0400
Date: Wed, 21 Jun 2006 00:42:43 +0200
From: Willy Tarreau <w@1wt.eu>
To: linux-kernel@vger.kernel.org
Cc: marcelo@kvack.org, len.brown@intel.com
Subject: [PATCH-2.4] range checking for sleep states sent to /proc/acpi/sleep
Message-ID: <20060620224243.GB11988@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A range checking is missing in acpi_system_write_sleep() in kernel
2.4, and writing a large integer value to /proc/acpi/sleep will cause
an oops. I could reproduce one this way :

   # echo 0x800000 >/proc/acpi/sleep

Fix extracted from the PaX patch.

Cheers,
Willy

---

 drivers/acpi/system.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

3cae76269fd00aa352255d872c8f461472ef8b56
diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
index a1e018c..26f7b68 100644
--- a/drivers/acpi/system.c
+++ b/drivers/acpi/system.c
@@ -748,7 +748,7 @@ acpi_system_write_sleep (
 	
 	state = simple_strtoul(state_string, NULL, 0);
 	
-	if (!system->states[state])
+	if (state >= ACPI_S_STATE_COUNT || !system->states[state])
 		return_VALUE(-ENODEV);
 
 	/*
-- 
1.3.3

