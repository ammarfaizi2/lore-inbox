Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264143AbTEWTHU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 15:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264144AbTEWTHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 15:07:20 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:46221 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264143AbTEWTHS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 15:07:18 -0400
Date: Fri, 23 May 2003 14:20:16 -0500
Mime-Version: 1.0 (Apple Message framework v552)
Content-Type: multipart/mixed; boundary=Apple-Mail-24-248489016
Subject: [PATCH] two PNP memory leaks
From: Hollis Blanchard <hollis@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Message-Id: <95DA0F64-8D53-11D7-BCE2-000A95A0560C@austin.ibm.com>
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-24-248489016
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Also caught by Stanford memory leak checker circa 2.5.48.

-- 
Hollis Blanchard
IBM Linux Technology Center


--Apple-Mail-24-248489016
Content-Disposition: attachment;
	filename=pnp-memleaks.diff
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="pnp-memleaks.diff"

--- linux-2.5.69/drivers/pnp/quirks.c.orig	2003-05-15 16:53:12.000000000 -0500
+++ linux-2.5.69/drivers/pnp/quirks.c	2003-05-15 16:53:15.000000000 -0500
@@ -39,9 +39,13 @@
 	 */
 	for ( ; res ; res = res->dep ) {
 		port2 = pnp_alloc(sizeof(struct pnp_port));
+		if (!port2)
+			return;
 		port3 = pnp_alloc(sizeof(struct pnp_port));
-		if (!port2 || !port3)
+		if (!port3) {
+			kfree(port2);
 			return;
+		}
 		port = res->port;
 		memcpy(port2, port, sizeof(struct pnp_port));
 		memcpy(port3, port, sizeof(struct pnp_port));
--- linux-2.5.69/drivers/pnp/isapnp/core.c.orig	2003-05-13 14:08:02.000000000 -0500
+++ linux-2.5.69/drivers/pnp/isapnp/core.c	2003-05-13 14:08:25.000000000 -0500
@@ -419,11 +419,12 @@
 
 static void isapnp_parse_id(struct pnp_dev * dev, unsigned short vendor, unsigned short device)
 {
-	struct pnp_id * id = isapnp_alloc(sizeof(struct pnp_id));
-	if (!id)
-		return;
+	struct pnp_id * id;
 	if (!dev)
 		return;
+	id = isapnp_alloc(sizeof(struct pnp_id));
+	if (!id)
+		return;
 	sprintf(id->id, "%c%c%c%x%x%x%x",
 			'A' + ((vendor >> 2) & 0x3f) - 1,
 			'A' + (((vendor & 3) << 3) | ((vendor >> 13) & 7)) - 1,

--Apple-Mail-24-248489016--

