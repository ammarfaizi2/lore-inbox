Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVG1Hzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVG1Hzv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 03:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVG1Hzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 03:55:40 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:23475 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261356AbVG1HyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 03:54:03 -0400
Message-ID: <42E88F09.2000904@jp.fujitsu.com>
Date: Thu, 28 Jul 2005 16:53:45 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 2.6.13-rc3 3/6] failure of acpi_register_gsi() should be handled
 properly - change hpet driver
References: <42E88DC8.7050507@jp.fujitsu.com>
In-Reply-To: <42E88DC8.7050507@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the error check of acpi_register_gsi() into hpet
driver.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>


---

 linux-2.6.13-rc3-kanesige/drivers/char/hpet.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff -puN drivers/char/hpet.c~handle-error-acpi_register_gsi-hpet drivers/char/hpet.c
--- linux-2.6.13-rc3/drivers/char/hpet.c~handle-error-acpi_register_gsi-hpet	2005-07-28 01:01:16.000000000 +0900
+++ linux-2.6.13-rc3-kanesige/drivers/char/hpet.c	2005-07-28 01:01:16.000000000 +0900
@@ -906,11 +906,15 @@ static acpi_status hpet_resources(struct
 		if (irqp->number_of_interrupts > 0) {
 			hdp->hd_nirqs = irqp->number_of_interrupts;
 
-			for (i = 0; i < hdp->hd_nirqs; i++)
-				hdp->hd_irq[i] =
+			for (i = 0; i < hdp->hd_nirqs; i++) {
+				int rc =
 				    acpi_register_gsi(irqp->interrupts[i],
 						      irqp->edge_level,
 						      irqp->active_high_low);
+				if (rc < 0)
+					return AE_ERROR;
+				hdp->hd_irq[i] = rc;
+			}
 		}
 	}
 

_

