Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUIIORX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUIIORX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 10:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUIIOPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 10:15:14 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:19687 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S264377AbUIIOOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 10:14:04 -0400
Date: Thu, 9 Sep 2004 16:14:04 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.9-rc1-bk16: DHCPACK, compile time error ...
Message-ID: <20040909141403.GD14891@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew!


diff -Nru a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
--- a/net/ipv4/ipconfig.c	2004-07-05 16:26:17 -07:00
+++ b/net/ipv4/ipconfig.c	2004-09-07 15:33:17 -07:00
@@ -966,6 +966,11 @@
 				break;
 
 			case DHCPACK:
+				for (i = 0; (dev->dev_addr[i] == b->hw_addr[i])
+						&& (i < dev->addr_len); i++);
+				if (i < dev->addr_len)
+					goto drop_unlock;
+
 				/* Yeah! */
 				break;
 

(from patch-2.6.9-rc1-bk16.bz2) results in:

net/ipv4/ipconfig.c: In function `ic_bootp_recv':
net/ipv4/ipconfig.c:969: error: `i' undeclared (first use in this function)
net/ipv4/ipconfig.c:969: error: (Each undeclared identifier is reported only once
net/ipv4/ipconfig.c:969: error: for each function it appears in.)


--- net/ipv4/ipconfig.c.orig	2004-09-09 15:18:26.000000000 +0200
+++ net/ipv4/ipconfig.c	2004-09-09 16:12:44.000000000 +0200
@@ -913,7 +913,7 @@ static int __init ic_bootp_recv(struct s
 #ifdef IPCONFIG_DHCP
 		if (ic_proto_enabled & IC_USE_DHCP) {
 			u32 server_id = INADDR_NONE;
-			int mt = 0;
+			int i, mt = 0;
 
 			ext = &b->exten[4];
 			while (ext < end && *ext != 0xff) {

fixes it ...

best,
Herbert


