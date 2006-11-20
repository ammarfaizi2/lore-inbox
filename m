Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965862AbWKTWRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965862AbWKTWRz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966866AbWKTWR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:17:26 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:47446 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S966853AbWKTWPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:15:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=T0t0WnmvEkwnXVHQtLO0xsNHPEOTlPbu+qlUrJxrBFrIXnsBx5fyGD77wpPisahCg/FyngojeyBPRzDZ1EmMY9OJqSo0KrWGIiN19RXgXpi8+5UJ89gprKhRep2h1/pOlPPLcBlHmZKilMkFGFcwdbwu5tnzSAooWkAOWOTkvtc=  ;
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: [patch 2.6.19-rc6 2/6] rtc-sa1100 tweaks
Date: Mon, 20 Nov 2006 10:19:53 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, rpurdie@rpsys.net
References: <200611201014.41980.david-b@pacbell.net>
In-Reply-To: <200611201014.41980.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611201019.53906.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor updates to rtc-sa1100: report whether the alarm is enabled, remove
duplicate procfs reporting of that factoid, and stick a FIXME at a place
where alarms should be enabled (but aren't).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/drivers/rtc/rtc-sa1100.c
===================================================================
--- g26.orig/drivers/rtc/rtc-sa1100.c	2006-11-20 09:35:19.000000000 -0800
+++ g26/drivers/rtc/rtc-sa1100.c	2006-11-20 09:36:24.000000000 -0800
@@ -263,8 +263,12 @@ static int sa1100_rtc_set_time(struct de
 
 static int sa1100_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
+	u32	rtsr;
+
 	memcpy(&alrm->time, &rtc_alarm, sizeof(struct rtc_time));
-	alrm->pending = RTSR & RTSR_AL ? 1 : 0;
+	rtsr = RTSR;
+	alrm->pending = (rtsr & RTSR_AL) ? 1 : 0;
+	alrm->enabled = (rtsr & RTSR_ALE) ? 1 : 0;
 	return 0;
 }
 
@@ -277,6 +281,7 @@ static int sa1100_rtc_set_alarm(struct d
 	if (ret == 0) {
 		memcpy(&rtc_alarm, &alrm->time, sizeof(struct rtc_time));
 
+		/* FIXME 'enabled' should update RTSR_ALE instead */
 		if (alrm->enabled)
 			enable_irq_wake(IRQ_RTCAlrm);
 		else
@@ -290,8 +295,6 @@ static int sa1100_rtc_set_alarm(struct d
 static int sa1100_rtc_proc(struct device *dev, struct seq_file *seq)
 {
 	seq_printf(seq, "trim/divider\t: 0x%08lx\n", RTTR);
-	seq_printf(seq, "alarm_IRQ\t: %s\n",
-			(RTSR & RTSR_ALE) ? "yes" : "no" );
 	seq_printf(seq, "update_IRQ\t: %s\n",
 			(RTSR & RTSR_HZE) ? "yes" : "no");
 	seq_printf(seq, "periodic_IRQ\t: %s\n",
