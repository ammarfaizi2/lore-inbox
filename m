Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751550AbWJXEhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbWJXEhW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 00:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbWJXEhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 00:37:21 -0400
Received: from www.osadl.org ([213.239.205.134]:50924 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751550AbWJXEhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 00:37:20 -0400
Subject: Re: -rt7 announcement? (was Re: 2.6.18-rt6) and more info about a
	compile error
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: sergio@sergiomb.no-ip.org
Cc: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Mike Galbraith <efault@gmx.de>,
       Daniel Walker <dwalker@mvista.com>,
       Manish Lachwani <mlachwani@mvista.com>, bastien.dugue@bull.net
In-Reply-To: <1161653206.2996.17.camel@localhost.portugal>
References: <20061018083921.GA10993@elte.hu>
	 <1161356444.15860.327.camel@mindpipe>  <1161621286.2835.3.camel@mindpipe>
	 <1161628539.22373.36.camel@localhost.localdomain>
	 <1161635161.2948.12.camel@localhost.portugal>
	 <1161636049.3982.18.camel@mindpipe>
	 <1161653206.2996.17.camel@localhost.portugal>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 06:38:25 +0200
Message-Id: <1161664706.22373.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-24 at 02:26 +0100, Sergio Monteiro Basto wrote:
> On Mon, 2006-10-23 at 16:40 -0400, Lee Revell wrote:
> > On Mon, 2006-10-23 at 21:26 +0100, Sergio Monteiro Basto wrote:
> > > rt7 should be to be applied on 2.6.18.1 
> > > still for 2.6.18 
> > > 
> > 
> > The -rt patch has always been against the most recent base kernel.  It
> > could be rebased against -stable but that would be more work for the
> > maintainers...
>  
> For me the most recent stable kernel is 2.6.18.1. 
> Normally change for .1 are very small but in this case I got 1, just 1,
> reject which I don't know to fix and prefer don't try it. My luck is the
> rej in a sparc arch and I can ignore it.

-rtXX is always against 2.6.X, never against the .stable versions.

> I got this compile error if I don't use CONFIG_PREEMPT_BKL in .config
> 
> kernel/rtmutex.c:938:48: error: macro "rt_release_bkl" passed 2
> arguments, but takes just 1
> kernel/rtmutex.c: In function 'rt_mutex_slowlock':
> kernel/rtmutex.c:938: error: 'rt_release_bkl' undeclared (first use in
> this function)
> kernel/rtmutex.c:938: error: (Each undeclared identifier is reported
> only once
> kernel/rtmutex.c:938: error: for each function it appears in.)

Fix below.

	tglx

Index: linux-2.6.18/kernel/rtmutex.c
===================================================================
--- linux-2.6.18.orig/kernel/rtmutex.c	2006-10-24 06:33:02.000000000 +0200
+++ linux-2.6.18/kernel/rtmutex.c	2006-10-24 06:31:55.000000000 +0200
@@ -902,7 +902,10 @@ static inline void rt_reacquire_bkl(int 
 }
 
 #else
-# define rt_release_bkl(x)	(-1)
+static inline int rt_release_bkl(struct rt_mutex *lock, unsigned long flags)
+{
+	return -1;
+}
 # define rt_reacquire_bkl(x)	do { } while (0)
 #endif
 


