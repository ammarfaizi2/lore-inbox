Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWHMVLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWHMVLb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 17:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWHMVLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 17:11:07 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:35222 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751475AbWHMVLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 17:11:03 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH -mm 2/2] x86_64: Detect clock skew during suspend
Date: Sun, 13 Aug 2006 23:07:40 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Andi Kleen <ak@suse.de>
References: <200608132303.00012.rjw@sisk.pl>
In-Reply-To: <200608132303.00012.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608132307.40741.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Detect the situations in which the time after a resume from disk would
be earlier than the time before the suspend and prevent them from
happening on x86_64.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86_64/kernel/time.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletion(-)

Index: linux-2.6.18-rc4-mm1/arch/x86_64/kernel/time.c
===================================================================
--- linux-2.6.18-rc4-mm1.orig/arch/x86_64/kernel/time.c
+++ linux-2.6.18-rc4-mm1/arch/x86_64/kernel/time.c
@@ -1039,8 +1039,16 @@ static int timer_resume(struct sys_devic
 	unsigned long flags;
 	unsigned long sec;
 	unsigned long ctime = get_cmos_time();
-	unsigned long sleep_length = (ctime - sleep_start) * HZ;
+	long sleep_length = (ctime - sleep_start) * HZ;
 
+	if (sleep_length < 0) {
+		printk(KERN_WARNING "Time skew detected in timer resume!\n");
+		/* The time after the resume must not be earlier than the time
+		 * before the suspend or some nasty things will happen
+		 */
+		sleep_length = 0;
+		ctime = sleep_start;
+	}
 	if (vxtime.hpet_address)
 		hpet_reenable();
 	else

