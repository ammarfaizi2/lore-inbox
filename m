Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264655AbTIIVOm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264502AbTIIVOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:14:42 -0400
Received: from 24-193-66-245.nyc.rr.com ([24.193.66.245]:14976 "EHLO
	siri.morinfr.org") by vger.kernel.org with ESMTP id S264655AbTIIVOj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:14:39 -0400
Date: Tue, 9 Sep 2003 17:14:42 -0400
From: Guillaume Morin <guillaume@morinfr.org>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix cpu_test_and_set() on UP
Message-ID: <20030909211441.GF1937@siri.morinfr.org>
Mail-Followup-To: torvalds@osdl.org, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus and Andrew,

cpumask_up.h is broken. It tries to access the "mask" member although
that cpumask_t is an ulong on UP. This breaks archs which uses cpumask
functions even on UP such as s390.


--- include/asm-generic/cpumask_up.h    28 Aug 2003 16:23:00 -0000      1.1
+++ include/asm-generic/cpumask_up.h    9 Sep 2003 21:12:21 -0000
@@ -6,7 +6,7 @@
 #define cpu_set(cpu, map)              do { (void)(cpu); cpus_coerce(map) = 1UL; } while (0)
 #define cpu_clear(cpu, map)            do { (void)(cpu); cpus_coerce(map) = 0UL; } while (0)
 #define cpu_isset(cpu, map)            ((void)(cpu), cpus_coerce(map) != 0UL)
-#define cpu_test_and_set(cpu, map)     ((void)(cpu), test_and_set_bit(0, (map).mask))
+#define cpu_test_and_set(cpu, map)     ((void)(cpu), test_and_set_bit(0, &(map)))

 #define cpus_and(dst, src1, src2)                                      \
        do {                                                            \

Please apply.

-- 
Guillaume Morin <guillaume@morinfr.org>

                    Sometimes I find I need to scream (RHCP)
