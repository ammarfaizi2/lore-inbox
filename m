Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbUD3WVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUD3WVF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 18:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUD3WVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 18:21:05 -0400
Received: from outmx013.isp.belgacom.be ([195.238.3.64]:958 "EHLO
	outmx013.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261654AbUD3WU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 18:20:58 -0400
Subject: [PATCH 2.6.6-rc3-mm1] Add maxthinktime to sysfs
From: FabF <Fabian.Frederick@skynet.be>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-MV0GVh2ZnxVHGGGezb6t"
Message-Id: <1083364002.6303.9.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 01 May 2004 00:26:42 +0200
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx013.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MV0GVh2ZnxVHGGGezb6t
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

	Here's a patch to add the asio maxthinktime to sysfs.
Could you apply ?

Regards,
Fabian

--=-MV0GVh2ZnxVHGGGezb6t
Content-Disposition: attachment; filename=maxthinktime1.diff
Content-Type: text/x-patch; name=maxthinktime1.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur orig/drivers/block/as-iosched.c edited/drivers/block/as-iosched.c
--- orig/drivers/block/as-iosched.c	2004-04-30 20:10:43.000000000 +0200
+++ edited/drivers/block/as-iosched.c	2004-05-01 00:02:59.000000000 +0200
@@ -65,7 +65,7 @@
  * or doing a lengthy computation. A small penalty can be justified there, and
  * will still catch out those processes that constantly have large thinktimes.
  */
-#define MAX_THINKTIME (HZ/50UL)
+unsigned long maxthinktime=(HZ/50UL);
 
 /* Bits in as_io_context.state */
 enum as_io_states {
@@ -869,7 +869,7 @@
 			if (test_bit(AS_TASK_IORUNNING, &aic->state)
 							&& in_flight == 0) {
 				thinktime = jiffies - aic->last_end_request;
-				thinktime = min(thinktime, MAX_THINKTIME-1);
+				thinktime = min(thinktime, maxthinktime-1);
 			} else
 				thinktime = 0;
 			as_update_thinktime(ad, aic, thinktime);
@@ -1951,6 +1951,7 @@
 {									\
 	return as_var_show(__VAR, (page));			\
 }
+SHOW_FUNCTION(as_maxthinktime_show, maxthinktime);
 SHOW_FUNCTION(as_readexpire_show, ad->fifo_expire[REQ_SYNC]);
 SHOW_FUNCTION(as_writeexpire_show, ad->fifo_expire[REQ_ASYNC]);
 SHOW_FUNCTION(as_anticexpire_show, ad->antic_expire);
@@ -1968,6 +1969,7 @@
 		*(__PTR) = (MAX);					\
 	return ret;							\
 }
+STORE_FUNCTION(as_maxthinktime_store, &maxthinktime, 0, LONG_MAX);
 STORE_FUNCTION(as_readexpire_store, &ad->fifo_expire[REQ_SYNC], 0, INT_MAX);
 STORE_FUNCTION(as_writeexpire_store, &ad->fifo_expire[REQ_ASYNC], 0, INT_MAX);
 STORE_FUNCTION(as_anticexpire_store, &ad->antic_expire, 0, INT_MAX);
@@ -1977,6 +1979,11 @@
 			&ad->batch_expire[REQ_ASYNC], 0, INT_MAX);
 #undef STORE_FUNCTION
 
+static struct as_fs_entry as_maxthinktime = {
+	.attr = {.name = "maxthinktime", .mode = S_IRUGO | S_IWUSR },
+	.show = as_maxthinktime_show,
+	.store = as_maxthinktime_store,
+};
 static struct as_fs_entry as_est_entry = {
 	.attr = {.name = "est_time", .mode = S_IRUGO },
 	.show = as_est_show,

--=-MV0GVh2ZnxVHGGGezb6t--

