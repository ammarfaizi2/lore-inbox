Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbSLTT03>; Fri, 20 Dec 2002 14:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264969AbSLTT03>; Fri, 20 Dec 2002 14:26:29 -0500
Received: from packet.digeo.com ([12.110.80.53]:27298 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264938AbSLTT02>;
	Fri, 20 Dec 2002 14:26:28 -0500
Message-ID: <3E0370C1.21909EF5@digeo.com>
Date: Fri, 20 Dec 2002 11:34:25 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH]Timer list init is done AFTER use
References: <3E02D81F.13A5A59D@mvista.com> <3E02F073.BF57207C@digeo.com> <3E0350CA.6B99F722@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Dec 2002 19:34:25.0592 (UTC) FILETIME=[CDFA4B80:01C2A85E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> Andrew Morton wrote:
> >
> > george anzinger wrote:
> > >
> > > On SMP systems the timer list init is done by way of a
> > > cpu_notifier call.  This has two problems:
> > >
> > > 1.) Timers are started WAY before the cpu_notifier call
> > > chain is executed.  In particular the console blanking timer
> > > is deleted and inserted every time printk() is called.  That
> > > this does not fail is only because the kernel has yet to
> > > protect location zero.
> >
> > But init_timers() directly calls timer_cpu_notify(), which directly
> > calls init_timers_cpu().
> >
> > So your patch appears to be a no-op for the boot CPU.
> 
> That is correct.  The problem is when cpu_init is called for
> the secondary cpus.  It almost immediately calls printk.

OK.  So until that CPU sees it bit come on in smp_commenced_mask()
it's not allowed to assume that it is running yet.

> ...
> My comments here are a wonderment if
> this is the right thing to do when doing a hot swap of the
> cpu.  I sort of doubt that this is correct.

I agree.  And from a quick read it does seem that ia32 is
doing the right thing apart from calling printk.

I don't think we should make changes to the timer code because
who knows what assumptions other console drivers could be making?

I don't think we should carefully remove all printk() calls because
printk() is supposed to be robust, and always callable.

The logical thing is to implement arch_consoles_callable().  Does
this look workable?



--- 25/kernel/printk.c~ga	Fri Dec 20 11:32:05 2002
+++ 25-akpm/kernel/printk.c	Fri Dec 20 11:33:14 2002
@@ -43,7 +43,11 @@
 #define LOG_BUF_MASK	(LOG_BUF_LEN-1)
 
 #ifndef arch_consoles_callable
-#define arch_consoles_callable() (1)
+/*
+ * Some console drivers may assume that per-cpu resources have been allocated.
+ * So don't allow them to be called by this CPU until it is officially up.
+ */
+#define arch_consoles_callable() cpu_online(smp_processor_id())
 #endif
 
 /* printk's without a loglevel use this.. */

_
