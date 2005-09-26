Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbVIZTrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbVIZTrB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 15:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbVIZTrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 15:47:01 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:11432 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932485AbVIZTrA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 15:47:00 -0400
Subject: [PATCH] x86-64: Fix bad assumption that dualcore cpus have synced
	TSCs (resend)
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 26 Sep 2005 12:46:52 -0700
Message-Id: <1127764012.8195.138.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
	This patch should resolve the issue seen in bugme bug #5105, where it
is assumed that dualcore x86_64 systems have synced TSCs. This is not
the case, and alternate timesources should be used instead.

For more details, see:
http://bugzilla.kernel.org/show_bug.cgi?id=5105

Andi's earlier concerns that the TSCs should be synced on dualcore
systems have been resolved by confirmation from AMD folks that they can
be unsynced.

Please consider for inclusion in your tree.

thanks
-john

diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -959,9 +959,6 @@ static __init int unsynchronized_tsc(voi
  	   are handled in the OEM check above. */
  	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
  		return 0;
- 	/* All in a single socket - should be synchronized */
- 	if (cpus_weight(cpu_core_map[0]) == num_online_cpus())
- 		return 0;
 #endif
  	/* Assume multi socket systems are not synchronized */
  	return num_online_cpus() > 1;


