Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932591AbVISTRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbVISTRE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 15:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbVISTRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 15:17:04 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:22667 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932591AbVISTRD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 15:17:03 -0400
Subject: [PATCH] x86-64: Fix bad assumption that dualcore cpus have synced
	TSCs
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Content-Type: text/plain
Date: Mon, 19 Sep 2005 12:16:43 -0700
Message-Id: <1127157404.3455.209.camel@cog.beaverton.ibm.com>
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


