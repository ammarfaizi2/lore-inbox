Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbVJ1Pox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbVJ1Pox (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 11:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbVJ1Pox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 11:44:53 -0400
Received: from amdext4.amd.com ([163.181.251.6]:49308 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1030214AbVJ1Pox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 11:44:53 -0400
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Date: Fri, 28 Oct 2005 09:46:11 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-kernel@vger.kernel.org
cc: info-linux@ldcmail.amd.com
Subject: [PATCH 2/6] AMD Geode GX/LX Support (Refreshed)
Message-ID: <20051028154611.GC19854@cosmic.amd.com>
References: <LYRIS-4270-74122-2005.10.28-09.38.17--jordan.crouse#amd.com@whitestar.amd.com>
MIME-Version: 1.0
In-Reply-To: <LYRIS-4270-74122-2005.10.28-09.38.17--jordan.crouse#amd.com@whitestar.amd.com>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F7C98AA22C3258396-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a simple patch that fixes console APM blanking on the GX/LX
platforms with BIOSes that still support APM.

apm.c |   27 ++++++++++++++-------------
1 file changed, 14 insertions(+), 13 deletions(-)

Index: linux-2.6.14/arch/i386/kernel/apm.c
===================================================================
--- linux-2.6.14.orig/arch/i386/kernel/apm.c
+++ linux-2.6.14/arch/i386/kernel/apm.c
@@ -1054,22 +1054,23 @@ static int apm_engage_power_management(u
  
 static int apm_console_blank(int blank)
 {
-	int	error;
-	u_short	state;
+	int error, i;
+	u_short state;
+	u_short dev[3] = { 0x100, 0x1FF, 0x101 };
 
 	state = blank ? APM_STATE_STANDBY : APM_STATE_READY;
-	/* Blank the first display device */
-	error = set_power_state(0x100, state);
-	if ((error != APM_SUCCESS) && (error != APM_NO_ERROR)) {
-		/* try to blank them all instead */
-		error = set_power_state(0x1ff, state);
-		if ((error != APM_SUCCESS) && (error != APM_NO_ERROR))
-			/* try to blank device one instead */
-			error = set_power_state(0x101, state);
+
+	for (i = 0; i < 3; i++) {
+		error = set_power_state(dev[i], state);
+
+		if ((error == APM_SUCCESS) || (error == APM_NO_ERROR))
+			return 1;
+
+		if (error == APM_NOT_ENGAGED)
+			break;
 	}
-	if ((error == APM_SUCCESS) || (error == APM_NO_ERROR))
-		return 1;
-	if (error == APM_NOT_ENGAGED) {
+
+	if (error == APM_NOT_ENGAGED && state != APM_STATE_READY) {
 		static int tried;
 		int eng_error;
 		if (tried++ == 0) {

