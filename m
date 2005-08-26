Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751584AbVHZOSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbVHZOSO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 10:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbVHZOSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 10:18:14 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:183 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S1751584AbVHZOSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 10:18:13 -0400
X-SBRSScore: None
From: Gerhard Wichert <Gerhard.Wichert@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12] x86_64/kernel/time.c
Date: Fri, 26 Aug 2005 16:18:00 +0200
User-Agent: KMail/1.8.1
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Wilck, Martin" <Martin.Wilck@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508261618.01285.Gerhard.Wichert@fujitsu-siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,
there are are two error returns of hpet_init() but vxtime.hpet_address remains 
set. 
This can cause div-by-zero exceptions later in the boot process when executing 
the 
wrong code sequences ( hpet code instead of pit code). To avoid this error 
behaviour 
vxtime.hpet_address should be cleared in time_init() if hpet_init() returns 
-1.

Regards, Gerhard.

--- linux-2.6.12.orig/arch/x86_64/kernel/time.c 2005-06-17 21:48:29.000000000 
+0200
+++ linux-2.6.12/arch/x86_64/kernel/time.c      2005-08-16 08:54:29.000000000 
+0200
@@ -892,16 +892,16 @@
                       "at %#lx.\n", vxtime.hpet_address);
         }
 #endif
-       if (nohpet)
-               vxtime.hpet_address = 0;
-
        xtime.tv_sec = get_cmos_time();
        xtime.tv_nsec = 0;

        set_normalized_timespec(&wall_to_monotonic,
                                -xtime.tv_sec, -xtime.tv_nsec);

-       if (!hpet_init()) {
+       if (nohpet || hpet_init())
+               vxtime.hpet_address = 0;
+
+       if (vxtime.hpet_address) {
                 vxtime_hz = (1000000000000000L + hpet_period / 2) /
                        hpet_period;
                cpu_khz = hpet_calibrate_tsc();
-- 
Gerhard Wichert              Phone: +49 5251 8 15127
Fujitsu Siemens Computers    Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1         mailto:Gerhard.Wichert@Fujitsu-Siemens.com
D-33106 Paderborn            http://www.fujitsu-siemens.com/primergy
