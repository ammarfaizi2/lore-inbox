Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265959AbUHANlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265959AbUHANlX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 09:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265960AbUHANlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 09:41:23 -0400
Received: from holomorphy.com ([207.189.100.168]:18598 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265959AbUHANlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 09:41:21 -0400
Date: Sun, 1 Aug 2004 06:41:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: zwane@linuxpower.ca, linux-kernel@vger.kernel.org, akpm@osdl.org,
       colpatch@us.ibm.com
Subject: Re: [PATCH][2.6] first/next_cpu returns values > NR_CPUS
Message-ID: <20040801134112.GU2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, zwane@linuxpower.ca,
	linux-kernel@vger.kernel.org, akpm@osdl.org, colpatch@us.ibm.com
References: <Pine.LNX.4.58.0407311347270.4094@montezuma.fsmlabs.com> <20040731232126.1901760b.pj@sgi.com> <Pine.LNX.4.58.0408010316590.4095@montezuma.fsmlabs.com> <20040801124053.GS2334@holomorphy.com> <20040801060529.4bc51b98.pj@sgi.com> <20040801131004.GT2334@holomorphy.com> <20040801063632.66c49e61.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040801063632.66c49e61.pj@sgi.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2004 at 06:36:32AM -0700, Paul Jackson wrote:
> You mean, in Zwane's example, we'd see a return from any_online_cpu() of
> 32 or 64, not 3 (his NR_CPUS), and not just on i386, but on a majority
> of arch's.  That's what you're saying, right?
> Ok ... that favors your preference, teaching the users of find_next_bit
> to be more tolerant.
> Darn.  Your min(nbits, ...) patch looks good, but more is needed.
> And could you make it:
> +	return min(nbits, find_next_bit(srcp->bits, nbits, n+1));
> rather than:
> +	return min(NR_CPUS, find_next_bit(srcp->bits, nbits, n+1));
> for consistency of presentation?  All the cpu and node mask macros of
> this form (#define wrapped static inline) use the inline's parameter
> names in the body of the inline, not what the define passed as those
> params, including another 'nbits' in this very line of code.

No problem.


Index: hotplug-2.6.8-rc2/include/linux/cpumask.h
===================================================================
--- hotplug-2.6.8-rc2.orig/include/linux/cpumask.h	2004-07-29 04:44:59.000000000 -0700
+++ hotplug-2.6.8-rc2/include/linux/cpumask.h	2004-08-01 06:32:31.615472016 -0700
@@ -207,13 +207,13 @@
 #define first_cpu(src) __first_cpu(&(src), NR_CPUS)
 static inline int __first_cpu(const cpumask_t *srcp, int nbits)
 {
-	return find_first_bit(srcp->bits, nbits);
+	return min_t(int, nbits, find_first_bit(srcp->bits, nbits));
 }
 
 #define next_cpu(n, src) __next_cpu((n), &(src), NR_CPUS)
 static inline int __next_cpu(int n, const cpumask_t *srcp, int nbits)
 {
-	return find_next_bit(srcp->bits, nbits, n+1);
+	return min_t(int, nbits, find_next_bit(srcp->bits, nbits, n+1));
 }
 
 #define cpumask_of_cpu(cpu)						\
