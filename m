Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbULMLSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbULMLSQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 06:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbULMLSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 06:18:16 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:40613 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S262227AbULMLSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 06:18:06 -0500
Date: Mon, 13 Dec 2004 12:17:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Con Kolivas <kernel@kolivas.org>, pavel@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Message-ID: <20041213111741.GR16322@dualathlon.random>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <20041213030237.5b6f6178.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213030237.5b6f6178.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 03:02:37AM -0800, Andrew Morton wrote:
> We should retain the option of compile-time constant HZ - it's
> easy enough.  Probably the patch already does that.

The patch only does HZ at dynamic time. But of course it's absolutely
trivial to define it at compile time, it's probably a 3 liner on top of
my current patch ;). However personally I don't think the three liner
will worth the few seconds more spent configuring the kernel ;).

The HZ cacheline is pure readonly (actually I'm not defining it as
cacheline_aligned, I probably should, __HZ can go together with
__SHIFT_HZ). The only debug option I introduced (because it could have a
performance penalty) is a check that nobody ever attempts to read HZ
before we initialized it by parsing the boot command line. If that
happens I printk and then I fallback to the fixed-HZ, so machine works
fine even in case of bugs and I get the debugging printk. That code
actually never triggered once. I did it primarly during development to
be sure I could debug fast troubles with other archs (this is already
running in all archs with SLES8).

This is pretty much the core of the patch:

+extern unsigned long __HZ;
+
+static inline unsigned long get_hz(void)
+{
+#ifdef CONFIG_DEBUG_HZ
+	if (unlikely(!__HZ)) {
+		__label__ here;
+		printk("early HZ: %p\n", &&here);
+	here:
+		init_HZ(USER_HZ);
+	}
+#endif /* CONFIG_DEBUG_HZ */
+	return __HZ;
+}
+
+#define HZ get_hz()
+
+#define CLOCKS_PER_SEC	(USER_HZ)	/* like times() */
+
+#define jiffies_to_clock_t(x)	(likely((HZ) >= (USER_HZ)) ?
\
+				 (x + ((HZ) / (USER_HZ)) - 1) / ((HZ) /
(USER_HZ)) :	\
+				 (x) * ((USER_HZ) / (HZ)))
+#define user_to_kernel_hz(x)	(likely((HZ) >= (USER_HZ)) ?
\
+				 (x) * ((HZ) / (USER_HZ)) :
\
+				 (x + ((USER_HZ) / (HZ)) - 1) /
((USER_HZ) / (HZ)))
+#define user_to_kernel_hz_overflow(x)	((x * (HZ) + (USER_HZ) - 1) / (USER_HZ))

[..]

+++ x/kernel/sched.c	2004-05-31 15:51:42.722918448 +0200
@@ -45,6 +45,8 @@
 #define TASK_USER_PRIO(p)	USER_PRIO((p)->static_prio)
 #define MAX_USER_PRIO		(USER_PRIO(MAX_PRIO))
 
+unsigned long __HZ, __SHIFT_HZ;
+
 /*
