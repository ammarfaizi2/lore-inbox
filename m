Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268328AbUJDSyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268328AbUJDSyZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 14:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268411AbUJDSyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 14:54:25 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:35752 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S268328AbUJDSyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 14:54:20 -0400
Subject: [PATCH] set membase in serial8250_request_port
From: Alex Williamson <alex.williamson@hp.com>
To: rmk+serial@arm.linux.org.uk
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: LOSL
Date: Mon, 04 Oct 2004 12:54:22 -0600
Message-Id: <1096916062.4510.20.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   I'm running into a problem that seems to be caused by this really old
changeset:

http://linux.bkbits.net:8080/linux-2.5/cset@3d9f67f2BWvXiLsZCFwD-8s_E9AN6A

When I run 'setserial /dev/ttyS1 uart 16450' on an ia64 system w/ MMIO
UARTs, I get a NAT consumption oops from the kernel.  The problem is
that this code path calls serial8250_release_port() where the membase
gets cleared.  However, the subsequent call to serial8250_request_port()
doesn't restore membase, causing a read from a bad address.  I don't see
many users of the UPF_IOREMAP flag, so I think the solution is to simply
make the remap case symmetric to the unmap case.  Patch below.  Thanks,

	Alex

-- 
Signed-off-by: Alex Williamson <alex.williamson@hp.com>

===== drivers/serial/8250.c 1.67 vs edited =====
--- 1.67/drivers/serial/8250.c	2004-09-13 18:23:24 -06:00
+++ edited/drivers/serial/8250.c	2004-10-04 12:12:34 -06:00
@@ -1733,7 +1733,7 @@
 	/*
 	 * If we have a mapbase, then request that as well.
 	 */
-	if (ret == 0 && up->port.flags & UPF_IOREMAP) {
+	if (ret == 0 && up->port.iotype == UPIO_MEM && up->port.mapbase) {
 		int size = res->end - res->start + 1;
 
 		up->port.membase = ioremap(up->port.mapbase, size);


