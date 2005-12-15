Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbVLOVOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbVLOVOW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 16:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbVLOVOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 16:14:22 -0500
Received: from amdext4.amd.com ([163.181.251.6]:47003 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1751081AbVLOVOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 16:14:21 -0500
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Date: Thu, 15 Dec 2005 14:16:01 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-kernel@vger.kernel.org
cc: akpm@osdl.org, alan@lxorguk.ukuu.org.uk, info-linux@ldcmail.amd.com
Subject: [PATCH 3/3] APM Screen Blanking fix
Message-ID: <20051215211601.GG11054@cosmic.amd.com>
References: <20051215211248.GE11054@cosmic.amd.com>
 <20051215211423.GF11054@cosmic.amd.com>
MIME-Version: 1.0
In-Reply-To: <20051215211423.GF11054@cosmic.amd.com>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FBF03190C04065-01-01
Content-Type: multipart/mixed;
 boundary=a2FkP9tdjPU2nyhF
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a2FkP9tdjPU2nyhF
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

A simple patch to fix APM assisted screen blanking (this at least fixes
a issue with the Geode LX BIOS).  Reposted from before with no changes.


--a2FkP9tdjPU2nyhF
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=apm.patch
Content-Transfer-Encoding: 7bit

APM screen blanking fix.

This patch fixes screen blanking on BIOSes that return
APM_NOT_ENGAGED when APM enabled screen blanking is not
turned on.

Signed off by: Jordan Crouse <jordan.crouse@amd.com>
---

 arch/i386/kernel/apm.c |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
index 1e60acb..03e9d84 100644
--- a/arch/i386/kernel/apm.c
+++ b/arch/i386/kernel/apm.c
@@ -1075,22 +1075,23 @@ static int apm_engage_power_management(u
  
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

--a2FkP9tdjPU2nyhF--

