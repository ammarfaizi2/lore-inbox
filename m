Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWHYQnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWHYQnx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 12:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWHYQnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 12:43:53 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:62231 "EHLO
	dhcp119.mvista.com") by vger.kernel.org with ESMTP id S1751434AbWHYQnw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 12:43:52 -0400
Date: Fri, 25 Aug 2006 09:45:12 -0700
Message-Id: <200608251645.k7PGjCj9003096@dhcp119.mvista.com>
Subject: [PATCH -mm] x86_64: Adjust the timing of initializing cyc2ns_scale.
From: Toyo Abe <toyoa@mvista.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The x86_64-mm-monotonic-clock.patch in 2.6.18-rc4-mm2 made a change to
the updating of monotonic_base. It now uses cycles_2_ns().

I suggest that a set_cyc2ns_scale() should be done prior to the setup_irq().
Because cycles_2_ns() can be called from the timer ISR right after the irq0
is enabled.


Signed-off-by: Toyo Abe <toyoa@mvista.com>

---

 arch/x86_64/kernel/time.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index 5bbd05d..03ddc1a 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -928,10 +928,10 @@ #endif
 	vxtime.quot = (USEC_PER_SEC << US_SCALE) / vxtime_hz;
 	vxtime.tsc_quot = (USEC_PER_MSEC << US_SCALE) / cpu_khz;
 	vxtime.last_tsc = get_cycles_sync();
-	setup_irq(0, &irq0);
-
 	set_cyc2ns_scale(cpu_khz);
 
+	setup_irq(0, &irq0);
+
 	hotcpu_notifier(time_cpu_notifier, 0);
 	time_cpu_notifier(NULL, CPU_ONLINE, (void *)(long)smp_processor_id());
 
