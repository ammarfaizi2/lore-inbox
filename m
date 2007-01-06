Return-Path: <linux-kernel-owner+w=401wt.eu-S1751192AbXAFGtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbXAFGtO (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 01:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbXAFGtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 01:49:14 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:34438 "HELO
	smtp103.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751192AbXAFGtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 01:49:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:MIME-Version:Content-Disposition:Message-Id:Cc:Content-Type:Content-Transfer-Encoding;
  b=tj4iI7oiCqcl1/1RkaLBUqSQFcukJgqOF65IFXP1KX2HAtd/tlofdkr90NqztmNzmxQykr2KtuZPIIxxJok8nYl8pAHB5F4BFvTfFHmB/XcG/A5NZxRSiG0PEcQlXsFLhaEab59ZPzNAj0D0iQbrjWmfJXmgPgnpIUxQ7rv/dmk=  ;
X-YMail-OSG: ocDhn0sVM1n3M6P3hkgKQbq7mbEz7lh1dmuyD8_fuPIFlGVo11b9wahmqNC41vlT4.trypW2GyDKqJNMGyXvjCA_gF551zWhLO3fpqFM78tiDl7ot4E2PvFuC8BOvBM9UeWpq1CWmBRVkfVgHps9RtT2iFVwom2nTH36imYeIwyZoLCs9eaR1aVzxVDO
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>, rpurdie@rpsys.net
Subject: [patch 2.6.20-rc3] rtc-sa1100 correctly reports rtc_wkalrm.enabled
Date: Fri, 5 Jan 2007 20:55:32 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200701052055.32987.david-b@pacbell.net>
Cc: rtc-linux@googlegroups.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes one bug in the SA-1100/PXA RTC support:  read_alarm()
isn't reporting whether the alarm is enabled.  This causes a small
regression, with procfs no longer reporting that state.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

---
Note there are still bugs with how this driver handles this "enabled"
flag when it _sets_ alarms.  I'm told the hh.org tree already merged
this particular patch.

Index: at91/drivers/rtc/rtc-sa1100.c
===================================================================
--- at91.orig/drivers/rtc/rtc-sa1100.c	2006-12-18 23:32:22.000000000 -0800
+++ at91/drivers/rtc/rtc-sa1100.c	2006-12-19 00:09:46.000000000 -0800
@@ -263,8 +263,12 @@ static int sa1100_rtc_set_time(struct de
 
 static int sa1100_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
+	u32 rtsr;
+
 	memcpy(&alrm->time, &rtc_alarm, sizeof(struct rtc_time));
-	alrm->pending = RTSR & RTSR_AL ? 1 : 0;
+	rtsr = RTSR;
+	alrm->enabled = (rtsr & RTSR_ALE) ? 1 : 0;
+	alrm->pending = (rtsr & RTSR_AL) ? 1 : 0;
 	return 0;
 }
 
