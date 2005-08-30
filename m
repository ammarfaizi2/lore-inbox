Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbVH3Esj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVH3Esj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 00:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbVH3Esj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 00:48:39 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:13512 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S932129AbVH3Esi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 00:48:38 -0400
Date: Mon, 29 Aug 2005 23:48:18 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       marcelo.tosatti@cyclades.com
Subject: [PATCH] cpm_uart: use schedule_timeout instead of direct call to
 schedule
Message-ID: <Pine.LNX.4.61.0508292347360.31749@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

use schedule_timeout instead of direct call to schedule

Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 85e29936d8eab1c16120ab319cc50828f3863aba
tree a6fbb48fc860c6f5dbef0d518a500b37576caf40
parent b9ecc8e4b5db64f0b4ee36dbdd6758e4ce3c2025
author Kumar K. Gala <kumar.gala@freescale.com> Mon, 29 Aug 2005 23:46:59 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Mon, 29 Aug 2005 23:46:59 -0500

 drivers/serial/cpm_uart/cpm_uart_core.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -403,10 +403,8 @@ static int cpm_uart_startup(struct uart_
 
 inline void cpm_uart_wait_until_send(struct uart_cpm_port *pinfo)
 {
-	unsigned long target_jiffies = jiffies + pinfo->wait_closing;
-
-	while (!time_after(jiffies, target_jiffies))
-   		schedule();
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(pinfo->wait_closing);
 }
 
 /*
@@ -425,9 +423,12 @@ static void cpm_uart_shutdown(struct uar
 	/* If the port is not the console, disable Rx and Tx. */
 	if (!(pinfo->flags & FLAG_CONSOLE)) {
 		/* Wait for all the BDs marked sent */
-		while(!cpm_uart_tx_empty(port))
+		while(!cpm_uart_tx_empty(port)) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout(2);
-		if(pinfo->wait_closing)
+		}
+
+		if (pinfo->wait_closing)
 			cpm_uart_wait_until_send(pinfo);
 
 		/* Stop uarts */
