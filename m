Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264648AbUIWGBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264648AbUIWGBc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 02:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUIWGBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 02:01:31 -0400
Received: from holomorphy.com ([207.189.100.168]:41428 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264648AbUIWGB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 02:01:29 -0400
Date: Wed, 22 Sep 2004 23:01:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm2
Message-ID: <20040923060122.GC9106@holomorphy.com>
References: <20040922131210.6c08b94c.akpm@osdl.org> <20040923050740.GZ9106@holomorphy.com> <41526341.8070902@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41526341.8070902@bigpond.net.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Something's a tad off here. Should be easy enough to fix up.
[...]
>> TPC: <sched_clock+0xc/0x40>

On Thu, Sep 23, 2004 at 03:46:41PM +1000, Peter Williams wrote:
> This looks the problem of sched_clock() being called before it's ready 
> (that we experienced with 2.6.9-rc2 on IA32 systems) only this time it's 
> fatal :-(
> A quick workaround for this would be to initialize idle->sched_timestamp 
> in init_idle() and current->sched_timestamp in sched_init() to the 
> INITIAL_JIFFIES converted to nanoseconds instead of using sched_clock().
> Another solution would be to set them to a value much greater than the 
> nanosecond equivalent of INITIAL_JIFFIES (e.g. 1ULL << 63) and let the 
> code that handles the non monotonic behaviour of sched_clock() sort it 
> out later.

Well, I posted a quick hack to get it to tolerate being called so early.
Might be better if I statically initialized the thing to a dummy driver
so only the indirect call remains at runtime. e.g.:


-- wli

Index: mm2-2.6.9-rc2/arch/sparc64/kernel/time.c
===================================================================
--- mm2-2.6.9-rc2.orig/arch/sparc64/kernel/time.c	2004-09-22 21:33:03.000000000 -0700
+++ mm2-2.6.9-rc2/arch/sparc64/kernel/time.c	2004-09-22 22:59:35.980157226 -0700
@@ -64,7 +64,16 @@
 
 static int set_rtc_mmss(unsigned long);
 
-struct sparc64_tick_ops *tick_ops;
+static __init unsigned long dummy_get_tick(void)
+{
+	return 0;
+}
+
+static __initdata struct sparc64_tick_ops dummy_tick_ops = {
+	.get_tick	= dummy_get_tick,
+};
+
+struct sparc64_tick_ops *tick_ops = &dummy_tick_ops;
 
 #define TICK_PRIV_BIT	(1UL << 63)
 
