Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266183AbUHJPHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266183AbUHJPHR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 11:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266333AbUHJPHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 11:07:17 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:45255 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266345AbUHJPHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 11:07:06 -0400
From: Andrew Theurer <habanero@us.ibm.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.6.8-rc2-mm2 performance improvements (scheduler?)
Date: Tue, 10 Aug 2004 10:05:15 -0500
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, ricklind@us.ibm.com, mbligh@aracnet.com,
       mingo@elte.hu, akpm@osdl.org
References: <200408092240.05287.habanero@us.ibm.com> <200408092308.56160.habanero@us.ibm.com> <cone.1092112649.681597.29067.502@pc.kolivas.org>
In-Reply-To: <cone.1092112649.681597.29067.502@pc.kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408101005.15384.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Also, one big change apparent to me, the elimination of
> > TIMESLICE_GRANULARITY.
>
> Ah well I tuned the timeslice granularity and I can tell you it isn't quite
> what most people think. The granularity when you get to greater than 4 cpus
> is effectively _disabled_. So in fact, the timeslices are shorter in
> staircase (in normal interactive=1, compute=0 mode which is how martin
> would have tested it), not longer. But this is not the reason either since
> in "compute" mode they are ten times longer and this also improves
> throughput further.

Interesting, I forgot about the "* nr_cpus" that was in the granularity 
calculation.  That does make me wonder, maybe the timeslices you are 
calculating could have something similar, but more appropriate.  

Since the number of runnable tasks on a cpu should play a part in latency (the 
more tasks, potentially the longer the latency), I wonder if the timeslice 
would benefit from a modifier like " / task_cpu(p)->nr_running ".  With this 
the base timeslice could be quite a bit larger to start for better cache 
warmth, and as we add more tasks to that cpu, the timeslices get smaller, so 
an acceptable latency is preserved.  


> > Do you have cswitch data?  I would not be surprised if it's a lot higher
> > on -no-staircase, and cache is thrashed a lot more.  This may be
> > something you can pull out of the -no-staircase kernel quite easily.
>
> Well from what I got on 8x the optimal load (-j x4cpus) and maximal load
> (-j) on kernbench gives surprisingly similar context switch rates. It's
> only when I enable compute mode that the context switches drop compared to
> default staircase mode and mainline. You'd have to ask Martin and Rick
> about what they got.

OK, thanks!

-Andrew Theurer
