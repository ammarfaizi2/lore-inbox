Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031689AbWLABSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031689AbWLABSH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 20:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031692AbWLABSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 20:18:07 -0500
Received: from alephnull.demon.nl ([83.160.184.112]:25837 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S1031689AbWLABSE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 20:18:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=1148133259;
	d=wantstofly.org;
	h=date:from:to:cc:subject:message-id:mime-version:content-type:
	content-disposition:user-agent;
	b=MtxfXvZJem3sDor74KPfiNJL1AcoBfr5W33DGhrloOxzVt/ozclYlTZ5qzP4M
	GdvGioTRDTeRnpe001MxZ56kA==
Date: Fri, 1 Dec 2006 02:18:02 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: akpm@osdl.org
Cc: linux@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] amba-pl010: clear error flags on rx error
Message-ID: <20061201011802.GA29869@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The pl010 primecell documentation specifies that an error indicated via
RSR should be cleared by a write to ECR.  We didn't do this, which was
causing errors to be re-reported on every call to pl010_rx_chars().

Doing a write to ECR once we detect an error appears to prevent the
ep93xx console UART driver from going into a mode where it reports
"ttyAM0: X input overrun(s)" every couple of keystrokes.

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>

Index: linux-2.6.19-rc5/drivers/serial/amba-pl010.c
===================================================================
--- linux-2.6.19-rc5.orig/drivers/serial/amba-pl010.c
+++ linux-2.6.19-rc5/drivers/serial/amba-pl010.c
@@ -129,6 +129,8 @@ static void pl010_rx_chars(struct uart_p
 		 */
 		rsr = readb(port->membase + UART01x_RSR) | UART_DUMMY_RSR_RX;
 		if (unlikely(rsr & UART01x_RSR_ANY)) {
+			writel(0, port->membase + UART01x_ECR);
+
 			if (rsr & UART01x_RSR_BE) {
 				rsr &= ~(UART01x_RSR_FE | UART01x_RSR_PE);
 				port->icount.brk++;
