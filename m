Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264202AbTE0Vxg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264204AbTE0Vxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:53:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:25239 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264202AbTE0Vxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:53:34 -0400
Date: Tue, 27 May 2003 15:04:49 -0700 (PDT)
Message-Id: <20030527.150449.08322270.davem@redhat.com>
To: andrea@suse.de
Cc: akpm@digeo.com, davidsen@tmr.com, haveblue@us.ibm.com, habanero@us.ibm.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030527115314.GU3767@dualathlon.random>
References: <20030527012617.GH3767@dualathlon.random>
	<20030526.231120.26504389.davem@redhat.com>
	<20030527115314.GU3767@dualathlon.random>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrea Arcangeli <andrea@suse.de>
   Date: Tue, 27 May 2003 13:53:14 +0200

   in case it wasn't obvious (that is the whole point of ksoftirqd) what
   accomplishes in a single word is "fairness" and "not starving userspace
   during networking".

The problem is that is gives up and goes to ksoftirqd far too easily.

Also, if a softirq is triggered between when we wake up ksoftirqd and
ksoftirqd actually runs, we just run the loop again in do_softirq().

This situation is even more likely if we are being "softirq bombed".
In fact in such a situation it is almost a certainty that do_softirq()
will execute multiple times before we schedule to any task.

In fact, and here is the important part, we probably won't run very
much userspace at all if we are being "softirq bombed".  Every trap,
softirq causing or not, is going to cause us to drop into do_softirq()
again and again and again.

Perhaps even, we will drain the pending softirqs before ksoftirqd even
gets to execute.  In this case the ksoftirqd wakeup and context switch
is a total waste of cpu cycles.

You are trying to apply flow control in an odd way to softirqs.
But the problem with such schemes is that they absolutely do not
make the problem go away.  You are merely moving the work from one
place to another, and in many cases added more useless work.  The one
thing you don't do when you are resource limited is take more of those
resources away and that is exactly what the ksoftirqd scheme does.
