Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWFWS6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWFWS6L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbWFWS6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:58:11 -0400
Received: from usea-naimss1.unisys.com ([192.61.61.103]:60680 "EHLO
	usea-naimss1.unisys.com") by vger.kernel.org with ESMTP
	id S1750897AbWFWS6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:58:09 -0400
Subject: [PATCH] Fix kdump Crash Kernel boot memory reservation for NUMA
	machines
From: Amul Shah <amul.shah@unisys.com>
To: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, fastboot@osdl.org,
       Eric Biederman <ebiederm@xmission.com>,
       Randy Dunlap <rdunlap@xenotime.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Linux Systems Group
Date: Fri, 23 Jun 2006 14:57:17 -0400
Message-Id: <1151089038.29121.32.camel@b4.na.uis.unisys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
X-OriginalArrivalTime: 23 Jun 2006 18:58:04.0092 (UTC) FILETIME=[F4DD8FC0:01C696F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will fix a boot memory reservation bug that trashes memory on
the ES7000 when loading the kdump crash kernel.

The code in arch/x86_64/kernel/setup.c to reserve boot memory for the 
crash kernel uses the non-numa aware "reserve_bootmem" function instead 
of the NUMA aware "reserve_bootmem_generic".  I checked to make sure 
that no other function was using "reserve_bootmem" and found none, 
except the ones that had NUMA ifdef'ed out.

I have tested this patch only on an ES7000 with NUMA on and off (numa=off)
in a single (non-NUMA) and multi-cell (NUMA) configurations.

Signed-off-by: Amul Shah <amul.shah@unisys.com>


---
--- linux-2.6.16.18-1.8/arch/x86_64/kernel/setup.c      2006-06-06 12:07:42.000000000 -0400
+++ linux-2.6.16.18-1.8-az/arch/x86_64/kernel/setup.c   2006-06-21 17:06:04.000000000 -0400
@@ -715,7 +715,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 #ifdef CONFIG_KEXEC
        if (crashk_res.start != crashk_res.end) {
-               reserve_bootmem(crashk_res.start,
+               reserve_bootmem_generic(crashk_res.start,
                        crashk_res.end - crashk_res.start + 1);
        }
 #endif

