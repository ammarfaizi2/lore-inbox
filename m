Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWAJX7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWAJX7Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 18:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932729AbWAJX7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 18:59:15 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:7664 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S932320AbWAJX7P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 18:59:15 -0500
Message-ID: <43C44A3C.6010803@mvista.com>
Date: Tue, 10 Jan 2006 15:58:52 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: new time code problem
References: <Pine.LNX.4.61.0512220019330.30882@scrub.home> <1136935211.2890.11.camel@cog.beaverton.ibm.com>
In-Reply-To: <1136935211.2890.11.camel@cog.beaverton.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------040104050008010606080107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040104050008010606080107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The 64-bit conversion routine to convert 64-bit nsec time to a time spec. 
gives an unnormalized result if the value being converted is negative.  I 
think there are two ways to go about fixing this.  Most systems will give a 
negative remainder and so need to just normalize.  On the other hand, some 
systems will use div64 to do the division and, I think, it expects unsigned 
numbers.  The attached patch uses the conservative approach of expecting the 
div to be set up for unsigned numbers.

I came accross this when one of my tests set a time near 1 Jan 1970, i.e. it 
is a real problem.
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

--------------040104050008010606080107
Content-Type: text/plain;
 name="ktime_conversion.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ktime_conversion.patch"

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
+	if (nsec) return (struct timespec){0, 0};
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
 

--------------040104050008010606080107--
