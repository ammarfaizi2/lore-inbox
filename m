Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWGFTb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWGFTb7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWGFTb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:31:59 -0400
Received: from gw.goop.org ([64.81.55.164]:18351 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750745AbWGFTb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:31:59 -0400
Message-ID: <44AD6531.7050803@goop.org>
Date: Thu, 06 Jul 2006 12:32:01 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: cpufreq@lists.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] cpufreq: demand load governor modules
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Demand-load cpufreq governor modules if needed.

Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>

---
 drivers/cpufreq/cpufreq.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)


diff -r 4650553b3f11 drivers/cpufreq/cpufreq.c
--- a/drivers/cpufreq/cpufreq.c	Wed Jul 05 15:21:25 2006 -0700
+++ b/drivers/cpufreq/cpufreq.c	Wed Jul 05 15:25:52 2006 -0700
@@ -320,6 +320,23 @@ static int cpufreq_parse_governor (char 
 		mutex_lock(&cpufreq_governor_mutex);
 
 		t = __find_governor(str_governor);
+
+		if (t == NULL) {
+			char *name = kasprintf(GFP_KERNEL, "cpufreq_%s", str_governor);
+
+			if (name) {
+				int ret;
+
+				mutex_unlock(&cpufreq_governor_mutex);
+				ret = request_module(name);
+				mutex_lock(&cpufreq_governor_mutex);
+
+				if (ret == 0)
+					t = __find_governor(str_governor);
+			}
+
+			kfree(name);
+		}
 
 		if (t != NULL) {
 			*governor = t;


