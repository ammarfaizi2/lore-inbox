Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266364AbUA3FKV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 00:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266525AbUA3FKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 00:10:21 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:49284 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S266364AbUA3FKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 00:10:15 -0500
Date: Thu, 29 Jan 2004 23:55:04 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Updates for 2.6.2-rc2
Message-ID: <20040129235504.GB12308@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040129235304.GA12308@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129235304.GA12308@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The serial driver currently fails to unregister its pnp driver upon module
unload.  This patch corrects the problem by calling pnp_unregister_driver and
implementing a proper remove function.

--- a/drivers/serial/8250_pnp.c	2004-01-28 22:35:02.000000000 +0000
+++ b/drivers/serial/8250_pnp.c	2004-01-28 22:33:40.000000000 +0000
@@ -418,7 +418,9 @@

 static void serial_pnp_remove(struct pnp_dev * dev)
 {
-	return;
+	int line = (int)pnp_get_drvdata(dev);
+	if (line)
+		unregister_serial(line - 1);
 }

 static struct pnp_driver serial_pnp_driver = {
@@ -435,7 +437,7 @@

 static void __exit serial8250_pnp_exit(void)
 {
-	/* FIXME */
+	pnp_unregister_driver(&serial_pnp_driver);
 }

 module_init(serial8250_pnp_init);
