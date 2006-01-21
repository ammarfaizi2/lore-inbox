Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWAUKBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWAUKBh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 05:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWAUKBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 05:01:37 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:10640
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751104AbWAUKBh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 05:01:37 -0500
Message-Id: <20060121094137.049533000@localhost.localdomain>
Date: Sat, 21 Jan 2006 10:02:19 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       George Anzinger <george@wildturkeyfarm.net>
Subject: [PATCH] Normalize timespec for negative values in ns_to_timespec
Content-Disposition: inline;
	filename=ns_to_timespec_normalize_if_negative.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Anzinger <george@wildturkeyranch.net>

In case of a negative nsec value the result of the division must be
normalized.
Remove inline from an exported function.

Signed-off-by: George Anzinger <george@wildturkeyranch.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


Index: linux-2.6.15/kernel/time.c
===================================================================
--- linux-2.6.15.orig/kernel/time.c
+++ linux-2.6.15/kernel/time.c
@@ -658,15 +658,16 @@ void set_normalized_timespec(struct time
  *
  * Returns the timespec representation of the nsec parameter.
  */
-inline struct timespec ns_to_timespec(const nsec_t nsec)
+struct timespec ns_to_timespec(const nsec_t nsec)
 {
 	struct timespec ts;
 
-	if (nsec)
-		ts.tv_sec = div_long_long_rem_signed(nsec, NSEC_PER_SEC,
-						     &ts.tv_nsec);
-	else
-		ts.tv_sec = ts.tv_nsec = 0;
+	if (!nsec)
+		return (struct timespec) {0, 0};
+
+	ts.tv_sec = div_long_long_rem_signed(nsec, NSEC_PER_SEC, &ts.tv_nsec);
+	if (unlikely(nsec < 0))
+		set_normalized_timespec(&ts, ts.tv_sec, ts.tv_nsec);
 
 	return ts;
 }

--

