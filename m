Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266073AbUIJANW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266073AbUIJANW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 20:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266870AbUIJAJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 20:09:42 -0400
Received: from holomorphy.com ([207.189.100.168]:44468 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266195AbUIJAHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 20:07:21 -0400
Date: Thu, 9 Sep 2004 17:07:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: [pagevec] resize pagevec to O(lg(NR_CPUS))
Message-ID: <20040910000717.GR3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
	linux-kernel@vger.kernel.org
References: <20040909163929.GA4484@logos.cnet> <20040909155226.714dc704.akpm@osdl.org> <20040909230905.GO3106@holomorphy.com> <20040909162245.606403d3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909162245.606403d3.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> Reducing arrival rates by an Omega(NR_CPUS) factor would probably help,
>> though that may blow the stack on e.g. larger Altixen. Perhaps
>> O(lg(NR_CPUS)), e.g. NR_CPUS > 1 ? 4*lg(NR_CPUS) : 4 etc., will suffice,
>> though we may have debates about how to evaluate lg(n) at compile-time...
>> Would be nice if calls to sufficiently simple __attribute__((pure))
>> functions with constant args were considered constant expressions by gcc.

On Thu, Sep 09, 2004 at 04:22:45PM -0700, Andrew Morton wrote:
> Yes, that sort of thing.
> It wouldn't be surprising if increasing the pagevec up to 64 slots on big
> ia64 SMP provided a useful increase in some fs-intensive workloads.
> One needs to watch stack consumption though.

Okay, Marcelo, looks like we need to do cache alignment work with a
variable-size pagevec.

In order to attempt to compensate for arrival rates to zone->lru_lock
increasing as O(num_cpus_online()), this patch resizes the pagevec to
O(lg(NR_CPUS)) for lock amortization that adjusts better to the size of
the system. Compiletested on ia64.


Index: mm4-2.6.9-rc1/include/linux/pagevec.h
===================================================================
--- mm4-2.6.9-rc1.orig/include/linux/pagevec.h	2004-08-24 00:03:39.000000000 -0700
+++ mm4-2.6.9-rc1/include/linux/pagevec.h	2004-09-09 16:58:19.978150158 -0700
@@ -4,8 +4,27 @@
  * In many places it is efficient to batch an operation up against multiple
  * pages.  A pagevec is a multipage container which is used for that.
  */
+#include <linux/config.h>
+#include <linux/threads.h>
 
-#define PAGEVEC_SIZE	16
+#define __PAGEVEC_SIZE_0(n, k)						\
+	((k) * !!((unsigned long)(n) > (1ULL << (!(k) ? 0 : (k) - 1))	\
+			&& ((unsigned long)(n) <= (1ULL << (k)))))
+#define __PAGEVEC_SIZE_1(n, k)						\
+	(__PAGEVEC_SIZE_0(n, 2*(k)+1) + __PAGEVEC_SIZE_0(n, 2*(k)))
+#define __PAGEVEC_SIZE_2(n, k)						\
+	(__PAGEVEC_SIZE_1(n, 2*(k)+1) + __PAGEVEC_SIZE_1(n, 2*(k)))
+#define __PAGEVEC_SIZE_3(n, k)						\
+	(__PAGEVEC_SIZE_2(n, 2*(k)+1) + __PAGEVEC_SIZE_2(n, 2*(k)))
+#define __PAGEVEC_SIZE_4(n, k)						\
+	(__PAGEVEC_SIZE_3(n, 2*(k)+1) + __PAGEVEC_SIZE_3(n, 2*(k)))
+#define __PAGEVEC_SIZE_5(n, k)						\
+	(__PAGEVEC_SIZE_4(n, 2*(k)+1) + __PAGEVEC_SIZE_4(n, 2*(k)))
+#define __PAGEVEC_SIZE_6(n, k)						\
+	(__PAGEVEC_SIZE_5(n, 2*(k)+1) + __PAGEVEC_SIZE_5(n, 2*(k)))
+#define __PAGEVEC_SIZE(n)						\
+	(BITS_PER_LONG == 32 ? __PAGEVEC_SIZE_5(n, 0) : __PAGEVEC_SIZE_6(n, 0))
+#define PAGEVEC_SIZE		(NR_CPUS > 1 ? 4*__PAGEVEC_SIZE(NR_CPUS) : 4)
 
 struct page;
 struct address_space;
