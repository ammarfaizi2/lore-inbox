Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUGZAZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUGZAZe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 20:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264677AbUGZAZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 20:25:34 -0400
Received: from mail023.syd.optusnet.com.au ([211.29.132.101]:62357 "EHLO
	mail023.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264668AbUGZAZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 20:25:30 -0400
Message-ID: <cone.1090801520.852584.20693.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH][2.6.8-rc1-mm1] Autotune swappiness01
Date: Mon, 26 Jul 2004 10:25:20 +1000
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_pc.kolivas.org-1090801520-0000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_pc.kolivas.org-1090801520-0000
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Attached is a patch designed to improve the behaviour of the swappiness knob 
in 2.6.8-rc1-mm1. 

The current mechanism decides to reclaim mapped pages based on the 
combination of mapped_ratio/2 and the manual setting of swappiness currently 
tuned to 60. Biasing this mechanism to be proportional to the square root of 
mapped_ratio gives good overall performance improvement for desktop 
workloads without any noticable detriment to other loads. It has the effect 
of being fairly aggressive at avoiding loss of applications to swap under 
conditions of heavy or sustained file stress while allowing applications to 
swap out under what would be considered "application" memory stresses on a 
desktop. It has no measurable effect on any known benchmarks.

The swappiness knob is kept intact and ironically is set to the same value 
of 60, and overall behaves the same as previous patches posted for 
autoregulating swappiness. The idea of this patch is to ultimately deprecate 
the need for a swappiness knob if this achieves good performance in most 
workloads.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


--=_pc.kolivas.org-1090801520-0000
Content-Description: Autotune Swappiness
Content-Disposition: inline;
  FILENAME="autotune_swappiness01.diff"
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Index: linux-2.6.8-rc1/mm/vmscan.c
===================================================================
--- linux-2.6.8-rc1.orig/mm/vmscan.c	2004-07-15 09:59:34.820962044 +1000
+++ linux-2.6.8-rc1/mm/vmscan.c	2004-07-15 10:03:06.243433612 +1000
@@ -119,6 +119,7 @@
  * From 0 .. 100.  Higher means more swappy.
  */
 int vm_swappiness = 60;
+static int mapped_bias;
 static long total_memory;
 
 static LIST_HEAD(shrinker_list);
@@ -646,6 +647,7 @@
 	struct page *page;
 	struct pagevec pvec;
 	int reclaim_mapped = 0;
+	int swappiness_bias;
 	long mapped_ratio;
 	long distress;
 	long swap_tendency;
@@ -690,6 +692,7 @@
 	 * is mapped.
 	 */
 	mapped_ratio = (sc->nr_mapped * 100) / total_memory;
+	mapped_bias = mapped_ratio * mapped_ratio;
 
 	/*
 	 * Now decide how much we really want to unmap some pages.  The mapped
@@ -700,7 +703,9 @@
 	 *
 	 * A 100% value of vm_swappiness overrides this algorithm altogether.
 	 */
-	swap_tendency = mapped_ratio / 2 + distress + vm_swappiness;
+	swappiness_bias = vm_swappiness * vm_swappiness / 100;
+	swappiness_bias = 101 - swappiness_bias;
+	swap_tendency = distress + mapped_bias / swappiness_bias;
 
 	/*
 	 * Now use this metric to decide whether to start moving mapped memory

--=_pc.kolivas.org-1090801520-0000--
