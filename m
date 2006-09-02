Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWIBTYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWIBTYa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 15:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWIBTYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 15:24:30 -0400
Received: from www.osadl.org ([213.239.205.134]:51430 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751424AbWIBTYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 15:24:30 -0400
Subject: Re: [PATCH] prevent timespec/timeval to ktime_t overflow
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Frank v Waveren <fvw@var.cx>
In-Reply-To: <1157222493.29250.383.camel@localhost.localdomain>
References: <1156927468.29250.113.camel@localhost.localdomain>
	 <20060831204612.73ed7f33.akpm@osdl.org>
	 <1157100979.29250.319.camel@localhost.localdomain>
	 <20060901020404.c8038837.akpm@osdl.org>
	 <1157103042.29250.337.camel@localhost.localdomain>
	 <20060901201305.f01ec7d2.akpm@osdl.org>
	 <1157222493.29250.383.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 02 Sep 2006 21:28:26 +0200
Message-Id: <1157225306.29250.391.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-02 at 20:41 +0200, Thomas Gleixner wrote:
> This smells like gcc magic. Can you please disassemble the code in
> question ?

Doh. 

Fortunately I own shares of a brown-paperbag-factory and the dividend is
payed in kind.

> > I wonder if this is related to the occasional hrtimr_run_queues() lockup
> > which Andi is encountering.
> 
> Hmm, not sure.

I'm quite sure right now.

	tglx


diff --git a/include/linux/ktime.h b/include/linux/ktime.h
index ed3396d..84eeecd 100644
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -56,7 +56,8 @@ typedef union {
 #endif
 } ktime_t;
 
-#define KTIME_MAX			(~((u64)1 << 63))
+#define KTIME_MAX			((s64)~((u64)1 << 63))
+#define KTIME_SEC_MAX			(KTIME_MAX / NSEC_PER_SEC)
 
 /*
  * ktime_t definitions when using the 64-bit scalar representation:
@@ -73,6 +74,10 @@ typedef union {
  */
 static inline ktime_t ktime_set(const long secs, const unsigned long nsecs)
 {
+#if (BITS_PER_LONG == 64)
+	if (unlikely(secs >= KTIME_SEC_MAX))
+		return (ktime_t){ .tv64 = KTIME_MAX };
+#endif
 	return (ktime_t) { .tv64 = (s64)secs * NSEC_PER_SEC + (s64)nsecs };
 }
 



-- 
VGER BF report: U 0.482714
