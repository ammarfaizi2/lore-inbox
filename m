Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266161AbTIKGww (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 02:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266165AbTIKGwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 02:52:51 -0400
Received: from holomorphy.com ([66.224.33.161]:9143 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S266161AbTIKGwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 02:52:50 -0400
Date: Wed, 10 Sep 2003 23:53:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test5-mm1
Message-ID: <20030911065359.GS4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030908235028.7dbd321b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908235028.7dbd321b.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 11:50:28PM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test5/2.6.0-test5-mm1/
> Small fixes, mainly.

Here's another one.

any_online_cpu() is required to and with cpu_online_map before
attempting to find an online cpu somewhere in the map; this patch adds
that logic to the implementation(s) of any_online_cpu().

Untested, but apparently necessary e.g. for set_cpus_allowed() not to oops.


-- wli



===== include/asm-generic/cpumask_arith.h 1.1 vs edited =====
--- 1.1/include/asm-generic/cpumask_arith.h	Mon Aug 18 19:46:23 2003
+++ edited/include/asm-generic/cpumask_arith.h	Wed Sep 10 23:46:36 2003
@@ -27,7 +27,12 @@
 #define cpus_shift_right(dst, src, n)	do { dst = (src) >> (n); } while (0)
 #define cpus_shift_left(dst, src, n)	do { dst = (src) << (n); } while (0)
 
-#define any_online_cpu(map)		({ (map) ? first_cpu(map) : NR_CPUS; })
+#define any_online_cpu(map)			\
+({						\
+	cpumask_t __tmp__;			\
+	cpus_and(__tmp__, map, cpu_online_map);	\
+	__tmp__ ? first_cpu(__tmp__) : NR_CPUS;	\
+})
 
 #define CPU_MASK_ALL	(~((cpumask_t)0) >> (8*sizeof(cpumask_t) - NR_CPUS))
 #define CPU_MASK_NONE	((cpumask_t)0)
===== include/asm-generic/cpumask_array.h 1.1 vs edited =====
--- 1.1/include/asm-generic/cpumask_array.h	Mon Aug 18 19:46:23 2003
+++ edited/include/asm-generic/cpumask_array.h	Wed Sep 10 23:46:05 2003
@@ -36,7 +36,13 @@
 					cpu_set(cpu, __cpu_mask);	\
 					__cpu_mask;			\
 				})
-#define any_online_cpu(map)	find_first_bit((map).mask, NR_CPUS)
+#define any_online_cpu(map)			\
+({						\
+	cpumask_t __tmp__;			\
+	cpus_and(__tmp__, map, cpu_online_map);	\
+	find_first_bit(__tmp__.mask, NR_CPUS);	\
+})
+
 
 /*
  * um, these need to be usable as static initializers
