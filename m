Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbUJ1TYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUJ1TYZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 15:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbUJ1TYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 15:24:25 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:27282 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S261764AbUJ1TYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 15:24:17 -0400
Subject: Re: [PATCH] set membase in serial8250_request_port
From: Alex Williamson <alex.williamson@hp.com>
To: rmk+serial@arm.linux.org.uk
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1098111389.30201.7.camel@tdi>
References: <1096916062.4510.20.camel@tdi>
	 <20041004220419.C21216@flint.arm.linux.org.uk>
	 <1096926184.4510.54.camel@tdi>  <1098111389.30201.7.camel@tdi>
Content-Type: text/plain
Organization: LOSL
Date: Thu, 28 Oct 2004 13:24:55 -0600
Message-Id: <1098991495.2719.8.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  The iounmap/ioremap path in serial8250_release/request_port is
terribly unbalanced.  The UPF_IOREMAP flag is used to determine if a
port gets ioremap'd, but plays no part in whether it gets iounmap'd.
It's easy to see how an MMIO serial port can be passed through
uart_set_info and end up with an unmapped membase.  The results is a
non-functional UART or worse.  I've tried to generate some discussion on
the proper fix for this, but I haven't succeeded.  I propose the patch
below as a safe compromise.  An MMIO uart w/ a mapbase, but no membase
doesn't seem viable to me.  Thanks,

	Alex

-- 
Signed-off-by: Alex Williamson <alex.williamson@hp.com>

===== drivers/serial/8250.c 1.77 vs edited =====
--- 1.77/drivers/serial/8250.c	2004-10-25 06:05:26 -06:00
+++ edited/drivers/serial/8250.c	2004-10-28 13:18:01 -06:00
@@ -1858,7 +1858,11 @@
 	/*
 	 * If we have a mapbase, then request that as well.
 	 */
-	if (ret == 0 && up->port.flags & UPF_IOREMAP) {
+	if (ret == 0 && ((up->port.flags & UPF_IOREMAP) ||
+	                 (up->port.iotype == UPIO_MEM &&
+	                  up->port.mapbase &&
+	                  !up->port.membase))) {
+
 		int size = res->end - res->start + 1;
 
 		up->port.membase = ioremap(up->port.mapbase, size);


