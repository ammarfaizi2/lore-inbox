Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWCHB6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWCHB6y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 20:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWCHB6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 20:58:54 -0500
Received: from ns1.siteground.net ([207.218.208.2]:4779 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964863AbWCHB6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 20:58:53 -0500
Date: Tue, 7 Mar 2006 17:59:34 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
       shai@scalex86.org
Subject: [patch 1/4] net: percpufy frequently used vars -- add percpu_counter_mod_bh
Message-ID: <20060308015934.GB9062@localhost.localdomain>
References: <20060308015808.GA9062@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308015808.GA9062@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add percpu_counter_mod_bh for using these counters safely from
both softirq and process context.

Signed-off by: Pravin B. Shelar <pravins@calsoftinc.com>
Signed-off by: Ravikiran G Thirumalai <kiran@scalex86.org>
Signed-off by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.16-rc5mm3/include/linux/percpu_counter.h
===================================================================
--- linux-2.6.16-rc5mm3.orig/include/linux/percpu_counter.h	2006-03-07 15:08:00.000000000 -0800
+++ linux-2.6.16-rc5mm3/include/linux/percpu_counter.h	2006-03-07 15:09:21.000000000 -0800
@@ -11,6 +11,7 @@
 #include <linux/smp.h>
 #include <linux/threads.h>
 #include <linux/percpu.h>
+#include <linux/interrupt.h>
 
 #ifdef CONFIG_SMP
 
@@ -110,4 +111,11 @@ static inline void percpu_counter_dec(st
 	percpu_counter_mod(fbc, -1);
 }
 
+static inline void percpu_counter_mod_bh(struct percpu_counter *fbc, long amount)
+{
+	local_bh_disable();
+	percpu_counter_mod(fbc, amount);
+	local_bh_enable();
+}
+
 #endif /* _LINUX_PERCPU_COUNTER_H */
