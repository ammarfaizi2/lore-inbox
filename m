Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265412AbTLHN5m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 08:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265418AbTLHN5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 08:57:42 -0500
Received: from holomorphy.com ([199.26.172.102]:19675 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265412AbTLHN5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 08:57:39 -0500
Date: Mon, 8 Dec 2003 05:57:37 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11-wli-1
Message-ID: <20031208135737.GG8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20031204200120.GL19856@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031204200120.GL19856@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 12:01:20PM -0800, William Lee Irwin III wrote:
> Successfully tested on a Thinkpad T21. Any feedback regarding
> performance would be very helpful. Desktop users should notice top(1)
> is faster, kernel hackers that kernel compiles are faster, and highmem
> users should see much less per-process lowmem overhead.

Woops, I missed the target by a few bytes. Probably a bit overwrought:


-- wli


diff -prauN wli-2.6.0-test11-36/include/asm-i386/processor.h wli-2.6.0-test11-37/include/asm-i386/processor.h
--- wli-2.6.0-test11-36/include/asm-i386/processor.h	2003-12-03 19:40:24.000000000 -0800
+++ wli-2.6.0-test11-37/include/asm-i386/processor.h	2003-12-07 06:36:51.000000000 -0800
@@ -497,11 +497,19 @@ void show_trace(struct task_struct *task
 unsigned long get_wchan(struct task_struct *task);
 
 #define THREAD_SIZE_LONGS	(THREAD_SIZE/sizeof(unsigned long))
+#define KSTK_TOP(info)							\
+({									\
+	unsigned long *__ptr = (unsigned long *)(info);			\
+	(unsigned long)(&__ptr[THREAD_SIZE_LONGS]);			\
+})
+
 #define task_pt_regs(task)						\
 ({									\
-	unsigned long *__ptr = (unsigned long *)(task)->thread_info;	\
-	(struct pt_regs *)(&__ptr[THREAD_SIZE_LONGS-1]);		\
+	struct pt_regs *__regs__;					\
+	__regs__ = (struct pt_regs *)KSTK_TOP((task)->thread_info);	\
+	__regs__ - 1;							\
 })
+
 #define KSTK_EIP(task)	(task_pt_regs(task)->eip)
 #define KSTK_ESP(task)	(task_pt_regs(task)->esp)
 
