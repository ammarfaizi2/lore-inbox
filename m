Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262548AbVCSOdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbVCSOdk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 09:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262555AbVCSOdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 09:33:40 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:28056 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262548AbVCSOct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 09:32:49 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: [PATCH] swsusp: do not leak memory if there's an error during suspend
Date: Sat, 19 Mar 2005 15:35:53 +0100
User-Agent: KMail/1.7.1
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503191535.54071.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch prevents swsusp from leaking memory if there's an error
during suspend (eg when device_power_down() returns non-zero).

Greets,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

--- linux-2.6.12-rc1-a/kernel/power/swsusp.c	2005-03-19 11:51:02.000000000 +0100
+++ linux-2.6.12-rc1-b/kernel/power/swsusp.c	2005-03-19 15:16:56.000000000 +0100
@@ -894,10 +894,12 @@ int swsusp_suspend(void)
 	 */
 	if ((error = device_power_down(PMSG_FREEZE))) {
 		local_irq_enable();
+		swsusp_free();
 		return error;
 	}
 	save_processor_state();
-	error = swsusp_arch_suspend();
+	if ((error = swsusp_arch_suspend()))
+		swsusp_free();
 	/* Restore control flow magically appears here */
 	restore_processor_state();
 	BUG_ON (nr_copy_pages_check != nr_copy_pages);

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
