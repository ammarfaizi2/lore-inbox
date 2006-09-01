Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWIAJ0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWIAJ0x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 05:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWIAJ0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 05:26:53 -0400
Received: from www.osadl.org ([213.239.205.134]:2257 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751100AbWIAJ0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 05:26:52 -0400
Subject: Re: [PATCH] prevent timespec/timeval to ktime_t overflow
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Frank v Waveren <fvw@var.cx>
In-Reply-To: <20060901020404.c8038837.akpm@osdl.org>
References: <1156927468.29250.113.camel@localhost.localdomain>
	 <20060831204612.73ed7f33.akpm@osdl.org>
	 <1157100979.29250.319.camel@localhost.localdomain>
	 <20060901020404.c8038837.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 11:30:42 +0200
Message-Id: <1157103042.29250.337.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 02:04 -0700, Andrew Morton wrote:
> > > This makes my FC3 x86_64 testbox hang during udev startup.  sysrq-T trace at
> > > http://www.zip.com.au/~akpm/linux/patches/stuff/log-x.
> > 
> > Does not help much.
> > 
> > > I had a quick look at the args to hrtimer_nanosleep and all seems to be in
> > > order.
> > 
> > Hmm. I can not reproduce that on any one of my boxen. Can you please try
> > with this debug variant, so we have a chance to figure out what's wrong.
> > 
> 
> With that patch the machine emits 88 bigabytes of stuff then locks up. 
> Something a little less aggressive is needed, methinks.

Fun, here is a version with a bigabyte blocker.

Index: linux-2.6.18-rc5/include/linux/ktime.h
===================================================================
--- linux-2.6.18-rc5.orig/include/linux/ktime.h	2006-09-01 10:48:38.000000000 +0200
+++ linux-2.6.18-rc5/include/linux/ktime.h	2006-09-01 11:20:10.000000000 +0200
@@ -57,6 +57,7 @@ typedef union {
 } ktime_t;
 
 #define KTIME_MAX			(~((u64)1 << 63))
+#define KTIME_SEC_MAX			(KTIME_MAX / NSEC_PER_SEC)
 
 /*
  * ktime_t definitions when using the 64-bit scalar representation:
@@ -73,6 +74,18 @@ typedef union {
  */
 static inline ktime_t ktime_set(const long secs, const unsigned long nsecs)
 {
+#if (BITS_PER_LONG == 64)
+	static int no88bigabytes = 0;
+
+	if (unlikely(secs >= KTIME_SEC_MAX)) {
+		if (!no88bigabytes) {
+			no88bigabytes = 1;
+			printk("ktime_set: %ld : %lu\n", secs, nsecs);
+			WARN_ON(1);
+		}
+		return (ktime_t){ .tv64 = KTIME_MAX };
+	}
+#endif
 	return (ktime_t) { .tv64 = (s64)secs * NSEC_PER_SEC + (s64)nsecs };
 }
 


