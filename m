Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbUD3Xbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbUD3Xbn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 19:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbUD3Xbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 19:31:43 -0400
Received: from outmx010.isp.belgacom.be ([195.238.3.233]:3770 "EHLO
	outmx010.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261822AbUD3Xbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 19:31:37 -0400
Subject: Re: [PATCH 2.6.6-rc3-mm1] Add maxthinktime to sysfs
From: FabF <Fabian.Frederick@skynet.be>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       Badari Pulavarty <pbadari@us.ibm.com>
In-Reply-To: <20040430154246.2019f9ec.akpm@osdl.org>
References: <1083364002.6303.9.camel@bluerhyme.real3>
	 <20040430154246.2019f9ec.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-5IeYmhozG3pWKcFgwwaB"
Message-Id: <1083368224.4976.9.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 01 May 2004 01:37:04 +0200
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx010.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5IeYmhozG3pWKcFgwwaB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2004-05-01 at 00:42, Andrew Morton wrote:
> FabF <Fabian.Frederick@skynet.be> wrote:
> >
> > 	Here's a patch to add the asio maxthinktime to sysfs.
> 
> Why? Have you measured any benefit from varying it, and if so, what was
> the result?

Andrew,

       I notice huge variations in first seconds of a 10 client
throughput activity as attached (5,100,300 as maxthinktime).
It's just another parameter I'd like to play with ;)
Maybe this one's exposition is not important intrinsequely but we could
bring interesting combinations later ...
       

> 
> Badari, did you find any need to vary this in the AS tuning work which you
> were doing?  (What happened to that, btw?)
> 
> If we're going to expose this tunable to users it needs to be documented in
> as-iosched.txt

I'm an absolute beginner Andrew ... Maybe someone more experienced could do that ?

PS:Attached the patch v2.

Best regards,
Fabian

--=-5IeYmhozG3pWKcFgwwaB
Content-Disposition: attachment; filename=ffbench11.txt
Content-Type: text/plain; name=ffbench11.txt; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

ffbench 11 - Fabian Frederick 04/2004 - asio - maxthinktime - 10 clients
5	100	300
---------------------
5.37	21.26	16.28
11.71	23.10	20.14
15.22	21.05	20.20
13.85	18.03	17.55
11.58	16.39	16.86
11.41	15.50	14.30
11.43	14.37	14.03
11.43	13.82	14.16
11.43	13.60	14.29
11.57	13.27	14.01
11.24	13.06	13.67
10.78	12.91	13.67
10.71	12.41	12.91
10.91	12.53	12.70
10.97	12.32	12.67
10.90	12.34	12.82
10.62	12.25	12.68
10.59	11.81	12.61
10.44	11.40	12.15
10.44	11.35	11.96
10.37	11.36	11.68
10.20	11.19	11.73
10.39	11.18	11.85
10.22	11.22	11.92
10.10	11.15	11.81
10.11	11.03	11.53
9.95	11.00	11.56
10.15	11.21	11.55
10.32	11.17	11.54
10.34	10.96	11.47
10.08	11.02	11.47
10.10	11.14	11.54
10.15	11.14	11.45
10.07	11.04	11.31
10.12	11.08	11.26
10.01	11.04	11.28
10.02	10.93	11.15
9.98	10.70	10.93
9.94	10.60	10.93
9.85	10.45	10.78
9.87	10.40	10.68
9.98	10.37	10.62
9.95	10.28	10.56
9.87	10.20	10.51
9.72	10.16	10.55

--=-5IeYmhozG3pWKcFgwwaB
Content-Disposition: attachment; filename=maxthinktime2.diff
Content-Type: text/x-patch; name=maxthinktime2.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur orig/drivers/block/as-iosched.c edited/drivers/block/as-iosched.c
--- orig/drivers/block/as-iosched.c	2004-04-30 20:10:43.000000000 +0200
+++ edited/drivers/block/as-iosched.c	2004-05-01 01:00:36.000000000 +0200
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
@@ -2008,6 +2015,7 @@
 };
 
 static struct attribute *default_attrs[] = {
+	&as_maxthinktime.attr,
 	&as_est_entry.attr,
 	&as_readexpire_entry.attr,
 	&as_writeexpire_entry.attr,

--=-5IeYmhozG3pWKcFgwwaB--

