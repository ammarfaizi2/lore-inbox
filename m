Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271724AbTGROFD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271709AbTGROEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:04:45 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20869
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271723AbTGROCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:02:33 -0400
Date: Fri, 18 Jul 2003 15:16:53 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181416.h6IEGrAp017738@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: make isapnp request its port properly
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/pnp/isapnp/core.c linux-2.6.0-test1-ac2/drivers/pnp/isapnp/core.c
--- linux-2.6.0-test1/drivers/pnp/isapnp/core.c	2003-07-10 21:10:50.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/pnp/isapnp/core.c	2003-07-14 19:56:48.000000000 +0100
@@ -255,14 +255,22 @@
 static int isapnp_next_rdp(void)
 {
 	int rdp = isapnp_rdp;
+	static int old_rdp = 0;
+	
+	if(old_rdp)
+	{
+		release_region(old_rdp, 1);
+		old_rdp = 0;
+	}
 	while (rdp <= 0x3ff) {
 		/*
 		 *	We cannot use NE2000 probe spaces for ISAPnP or we
 		 *	will lock up machines.
 		 */
-		if ((rdp < 0x280 || rdp >  0x380) && !check_region(rdp, 1))
+		if ((rdp < 0x280 || rdp >  0x380) && request_region(rdp, 1, "ISAPnP"))
 		{
 			isapnp_rdp = rdp;
+			old_rdp = rdp;
 			return 0;
 		}
 		rdp += RDP_STEP;
