Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbUGaU6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUGaU6S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 16:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUGaU6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 16:58:18 -0400
Received: from holomorphy.com ([207.189.100.168]:59042 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263001AbUGaU6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 16:58:01 -0400
Date: Sat, 31 Jul 2004 13:57:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH][2.6] first/next_cpu returns values > NR_CPUS
Message-ID: <20040731205757.GD2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@fsmlabs.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>
References: <Pine.LNX.4.58.0407311347270.4094@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407311347270.4094@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2004 at 04:52:18PM -0400, Zwane Mwaikambo wrote:
> The following caused some fireworks whilst merging i386 cpu hotplug.
> any_online_cpu(0x2) returns 32 on i386 if we're forced to continue past
> the only set bit due to the additional find_first_bit in the
> find_next_bit i386 implementation. Not wanting to change current
> behaviour in the bitops primitives and since the NR_CPUS thing is a
> cpumask issue, i've opted to fix next_cpu() and first_cpu() instead.
> Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

This might save a couple of lines of code.


Index: hotplug-2.6.8-rc2/include/linux/cpumask.h
===================================================================
--- hotplug-2.6.8-rc2.orig/include/linux/cpumask.h	2004-07-29 04:44:59.000000000 -0700
+++ hotplug-2.6.8-rc2/include/linux/cpumask.h	2004-07-31 13:49:15.647650104 -0700
@@ -207,13 +207,13 @@
 #define first_cpu(src) __first_cpu(&(src), NR_CPUS)
 static inline int __first_cpu(const cpumask_t *srcp, int nbits)
 {
-	return find_first_bit(srcp->bits, nbits);
+	return min(NR_CPUS, find_first_bit(srcp->bits, nbits));
 }
 
 #define next_cpu(n, src) __next_cpu((n), &(src), NR_CPUS)
 static inline int __next_cpu(int n, const cpumask_t *srcp, int nbits)
 {
-	return find_next_bit(srcp->bits, nbits, n+1);
+	return min(NR_CPUS, find_next_bit(srcp->bits, nbits, n+1));
 }
 
 #define cpumask_of_cpu(cpu)						\
