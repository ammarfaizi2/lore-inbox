Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030526AbWKOO4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030526AbWKOO4Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 09:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030527AbWKOO4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 09:56:16 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:34967
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030526AbWKOO4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 09:56:16 -0500
Message-Id: <455B38EC.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 15 Nov 2006 14:57:32 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386: conditionalize touching of memory in
	touch_nmi_watchdog()
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just like on x86-64, don't touch foreign CPUs' memory if the watchdog
isn't enabled at all.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.19-rc5/arch/i386/kernel/nmi.c	2006-11-08 09:21:37.000000000 +0100
+++ 2.6.19-rc5-i386-touch_nmi_watchdog/arch/i386/kernel/nmi.c	2006-11-06 09:10:16.000000000 +0100
@@ -867,14 +867,16 @@ static unsigned int
 
 void touch_nmi_watchdog (void)
 {
-	int i;
+	if (nmi_watchdog > 0) {
+		unsigned cpu;
 
-	/*
-	 * Just reset the alert counters, (other CPUs might be
-	 * spinning on locks we hold):
-	 */
-	for_each_possible_cpu(i)
-		alert_counter[i] = 0;
+		/*
+		 * Just reset the alert counters, (other CPUs might be
+		 * spinning on locks we hold):
+		 */
+		for_each_present_cpu (cpu)
+			alert_counter[cpu] = 0;
+	}
 
 	/*
 	 * Tickle the softlockup detector too:


