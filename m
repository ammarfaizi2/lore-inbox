Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbTFCPj1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 11:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265064AbTFCPj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 11:39:27 -0400
Received: from palrel12.hp.com ([156.153.255.237]:38798 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S265060AbTFCPjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 11:39:23 -0400
Date: Tue, 3 Jun 2003 08:52:46 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200306031552.h53FqknC023999@napali.hpl.hp.com>
To: torvalds@transmeta.com
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
       linux-ia64@linuxia64.org
Subject: fix TCP roundtrip time update code
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of those very-hard-to-track-down, trivial-to-fix kind of problems:
without this patch, TCP roundtrip time measurements will corrupt the
routing cache's RTT estimates under heavy network load (the bug causes
RTAX_RTT to go negative, but since its type is u32, you end up with a
huge positive value...).  From there on, later TCP connections quickly
will go south.

The typo was introduced 8 months ago in v1.29 of the file by the patch
entitled "Cleanup DST metrics and abstrct MSS/PMTU further".

	--david

===== net/ipv4/tcp_input.c 1.36 vs edited =====
--- 1.36/net/ipv4/tcp_input.c	Mon Apr 28 09:27:57 2003
+++ edited/net/ipv4/tcp_input.c	Tue Jun  3 08:19:36 2003
@@ -556,8 +556,8 @@
 			if (m >= dst_metric(dst, RTAX_RTTVAR))
 				dst->metrics[RTAX_RTTVAR-1] = m;
 			else
-				dst->metrics[RTAX_RTT-1] -=
-					(dst->metrics[RTAX_RTT-1] - m)>>2;
+				dst->metrics[RTAX_RTTVAR-1] -=
+					(dst->metrics[RTAX_RTTVAR-1] - m)>>2;
 		}
 
 		if (tp->snd_ssthresh >= 0xFFFF) {
