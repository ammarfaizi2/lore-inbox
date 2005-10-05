Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbVJEQ5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbVJEQ5A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbVJEQ5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:57:00 -0400
Received: from amdext3.amd.com ([139.95.251.6]:40335 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S1030247AbVJEQ47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:56:59 -0400
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Date: Wed, 5 Oct 2005 10:56:01 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-kernel@vger.kernel.org
cc: info-linux@ldcmail.amd.com
Subject: [PATCH 2/5] AMD Geode GX/LX support V2
Message-ID: <20051005165601.GB24950@cosmic.amd.com>
References: <20051005164626.GA25189@cosmic.amd.com>
MIME-Version: 1.0
In-Reply-To: <20051005164626.GA25189@cosmic.amd.com>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F5ADE0D2OC1438555-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No changes to this patch from V1, but included to keep from confusing
anybody.

This is a simple patch that fixes console APM blanking on the GX/LX
platforms with BIOSes that still support APM.  Please apply against
linux-2.4.14-rc2-mm2.

Index: linux-2.6.14-rc2-mm2/arch/i386/kernel/apm.c
===================================================================
--- linux-2.6.14-rc2-mm2.orig/arch/i386/kernel/apm.c
+++ linux-2.6.14-rc2-mm2/arch/i386/kernel/apm.c
@@ -1057,22 +1057,23 @@ static int apm_engage_power_management(u
  
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

