Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265100AbTLHR4a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 12:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265107AbTLHR4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 12:56:30 -0500
Received: from holomorphy.com ([199.26.172.102]:65243 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265100AbTLHR41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 12:56:27 -0500
Date: Mon, 8 Dec 2003 09:56:22 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched-HT-2.6.0-test11-A5
Message-ID: <20031208175622.GY19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20031117021511.GA5682@averell> <Pine.LNX.4.56.0311231300290.16152@earth> <1027750000.1069604762@[10.10.2.4]> <Pine.LNX.4.58.0312011102540.3323@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312011102540.3323@earth>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 01, 2003 at 11:08:17AM +0100, Ingo Molnar wrote:
> i've uploaded the HT scheduler patch against 2.6.0-test11 to:
>     redhat.com/~mingo/O(1)-scheduler/sched-HT-2.6.0-test11-A5
> note, the patch includes a fix to sync wakeups, which might hurt lat_ctx.  
> I've attached the fix against vanilla 2.6.0-test11 as well.

This appears to either leak migration threads or not set
rq->cpu[x].migration_thread basically ever for x > 0. Or if they
are shut down, how? Also, what makes sure cpu_idx is initialized
before they wake? They'll all spin on cpu_rq(0)->lock, no?

Furthermore, sched_map_runqueue() is performed after all the idle
threads are running and all the notifiers have kicked the migration
threads, but does no locking whatsoever.

Also, does init_idle() need to move into rest_init()? It should be
equivalent to its current placement.

Why not per_cpu for __rq_idx[] and __cpu_idx[]? This would have the
advantage of residing on node-local memory for sane architectures
(and perhaps in the future, some insane ones).

-- wli
