Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWAUR1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWAUR1f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 12:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWAUR1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 12:27:35 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:44783 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S932214AbWAUR1e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 12:27:34 -0500
Message-ID: <43D26EE5.90102@wildturkeyranch.net>
Date: Sat, 21 Jan 2006 09:27:01 -0800
From: George Anzinger <george@wildturkeyranch.net>
Reply-To: george@wildturkeyranch.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Normalize timespec for negative values in	ns_to_timespec
References: <20060121094137.049533000@localhost.localdomain>	 <20060121021917.1ab7787c.akpm@osdl.org> <1137839641.28034.62.camel@localhost.localdomain>
In-Reply-To: <1137839641.28034.62.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------080105060508070601070806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080105060508070601070806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here is the patch again.  This time with a header.
-- 
George Anzinger   george@wildturkeyranch.net
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

--------------080105060508070601070806
Content-Type: text/plain;
 name="ktime_conversion.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ktime_conversion.patch"

Source: George Anzinger<george@wilturkeyranch.net>

Bug fix.

Description:

The timespec ns_to_timespec() inline in kernel/time.c mishandles
negative times in that it generates unnormalized timespecs.

There are several ways to handle this, the attached being the most
conservative.

Signed off: George Anzinger<george@wildturkeyranch.net>

 kernel/time.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

Index: linux-2.6.16-rc/kernel/time.c
===================================================================
--- linux-2.6.16-rc.orig/kernel/time.c
+++ linux-2.6.16-rc/kernel/time.c
@@ -702,16 +702,19 @@ void set_normalized_timespec(struct time
  *
  * Returns the timespec representation of the nsec parameter.
  */
-inline struct timespec ns_to_timespec(const nsec_t nsec)
+struct timespec ns_to_timespec(const nsec_t nsec)
 {
 	struct timespec ts;
 
-	if (nsec)
+	if (!nsec) return (struct timespec){0, 0};
+
+	if (nsec < 0) {
+		ts.tv_sec = div_long_long_rem_signed(-nsec, NSEC_PER_SEC,
+						     &ts.tv_nsec);
+		set_normalized_timespec(&ts, -ts.tv_sec, -ts.tv_nsec);
+	} else
 		ts.tv_sec = div_long_long_rem_signed(nsec, NSEC_PER_SEC,
 						     &ts.tv_nsec);
-	else
-		ts.tv_sec = ts.tv_nsec = 0;
-
 	return ts;
 }
 

--------------080105060508070601070806--
