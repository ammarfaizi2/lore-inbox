Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267435AbUIFW74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267435AbUIFW74 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 18:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267433AbUIFW74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 18:59:56 -0400
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:15075 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267435AbUIFW7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 18:59:54 -0400
References: <413CE863.3050400@as.arizona.edu>
Message-ID: <cone.1094511587.419898.6110.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: don fisher <dfisher@as.arizona.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sched_setaffinity(), RT priorities and migration thread usage
         at 30%
Date: Tue, 07 Sep 2004 08:59:47 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

don fisher writes:

> Hello,
> 
> Apologies in advance if this is a newbie question. I am attempting to 
> write a real-time simulation of an application we have in house. I 
> have a dual processor SMP system, hyperthreading enabled, running 
> kernel 2.6.7.
> 
> The first thread begins at priority 1 (SCHED_RR) and subsequently 
> spawns another time critical task running at priority 2. The initial 
> thread uses setaffinity to set the desired cpu to 2. When the second 
> task begins, the migration thread becomes 30% active (as reported by 
> top) for the duration of its execution. When the priority 2 thread 
> terminates the first thread continues with the migration task 
> consuming only 2% of the CPU.
> 
> If there was any change, I was expecting that the higher priority of 
> the second thread would cause it to execute closer to 100% CPU. I 
> built a test code where each thread computes an identical dumb timing 
> loop. The priority 2 thread ends up executing 30% slower than the 
> priority 1 thread due to contention with the migration thread.
> 
> Is this the expected behavior, and if so could you please inform me 
> why? I had not anticipated the any attempt by the kernel to shift the 
> process to another CPU, since sched_setafinity had been applied.
> 
> I want to confirm that from xosview, both tasks do actually execute 
> serially on processor 2 as expected. Code is include below.

Yes this is a problem with the balancing code in SMP. It will continually 
keep trying to balance the now unbalanced cpus (2 tasks on one cpu and the 
other cpu idle) despite the fact that the affinity is set for those 2 tasks 
to run on the other cpu. The balancing code is not smart enough (yet?) to 
recognise that there is no point trying to balance processes that you don't 
want balanced.

Con

