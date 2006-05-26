Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWEZLAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWEZLAx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 07:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWEZLAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:00:53 -0400
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:36246 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751391AbWEZLAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:00:52 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [RFC 3/5] sched: Add CPU rate hard caps
Date: Fri, 26 May 2006 21:00:21 +1000
User-Agent: KMail/1.9.1
Cc: Mike Galbraith <efault@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest> <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest>
In-Reply-To: <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605262100.22071.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 May 2006 14:20, Peter Williams wrote:
> This patch implements hard CPU rate caps per task as a proportion of a
> single CPU's capacity expressed in parts per thousand.

A hard cap of 1/1000 could lead to interesting starvation scenarios where a 
mutex or semaphore was held by a task that hardly ever got cpu. Same goes to 
a lesser extent to a 0 soft cap. 

Here is how I handle idleprio tasks in current -ck:

http://ck.kolivas.org/patches/2.6/pre-releases/2.6.17-rc5/2.6.17-rc5-ck1/patches/track_mutexes-1.patch
tags tasks that are holding a mutex

http://ck.kolivas.org/patches/2.6/pre-releases/2.6.17-rc5/2.6.17-rc5-ck1/patches/sched-idleprio-1.7.patch
is the idleprio policy for staircase.

What it does is runs idleprio tasks as normal tasks when they hold a mutex or 
are waking up after calling down() (ie holding a semaphore). These two in 
combination have shown resistance to any priority inversion problems in 
widespread testing. An attempt was made to track semaphores held via a 
down_interruptible() but unfortunately the lack of strict rules about who 
could release the semaphore meant accounting was impossible of this scenario. 
In practice, though there were no test cases that showed it to be an issue, 
and the recent conversion en-masse of semaphores to mutexes in the kernel 
means it has pretty much covered most possibilities.

-- 
-ck
