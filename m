Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265710AbUBFXdf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 18:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265799AbUBFXdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 18:33:35 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:29388 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265710AbUBFXd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 18:33:28 -0500
Date: Fri, 06 Feb 2004 15:33:07 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>, Rick Lindsley <ricklind@us.ibm.com>
cc: Anton Blanchard <anton@samba.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
Message-ID: <231480000.1076110387@flay>
In-Reply-To: <40242152.5030606@cyberone.com.au>
References: <200402062311.i16NBdF14365@owlet.beaverton.ibm.com> <40242152.5030606@cyberone.com.au>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From a later email ....
>
> Hopefully just tending to round down more would damp it better.
> *imbalance = (*imbalance + SCHED_LOAD_SCALE/2) >> SCHED_LOAD_SHIFT;
> Or even remove the addition all together.

I'd side with just removing the addition alltogether ...

>>Moreover, as Rick pointed out, it's particularly futile over idle cpus ;-)
>
> I don't follow...

If CPU 7 has 1 task, and cpu 8 has 0 tasks, there's an imbalance of 1.
There is no point whatsoever in bouncing that task back and forth
between cpu 7 and 8 - it just makes things slower, and trashes the cache.
There's *no* fairness issue here.

If CPU 8 has 2 tasks, and cpu 1 has 1 task, there's an imbalance of 1.
*If* that imbalance persists (and it probably won't, given tasks being
created, destroyed, and blocking for IO), we may want to rotate that 
to 1 vs 2, and then back to 2 vs 1, etc. in the interests of fairness,
even though it's slower throughput overall.

However, my point is that we shouldn't do that as agressively (in terms
of how long the imbalance persists for) as we should for loads of 3 vs 1 -
that's a "real" imbalance, not just a fairness problem.

M.

