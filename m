Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264499AbUHBWww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbUHBWww (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 18:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264502AbUHBWww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 18:52:52 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:18942 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264499AbUHBWwu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 18:52:50 -0400
Subject: Re: CPU hotplug broken in 2.6.8-rc2 ?
From: Nathan Lynch <nathanl@austin.ibm.com>
To: dipankar@in.ibm.com
Cc: V Srivatsa <vatsa@in.ibm.com>, Joel Schopp <jschopp@austin.ibm.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       lkml <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, zwane@linuxpower.ca
In-Reply-To: <20040802095741.GA4599@in.ibm.com>
References: <20040802094907.GA3945@in.ibm.com>
	 <20040802095741.GA4599@in.ibm.com>
Content-Type: text/plain
Message-Id: <1091475519.29556.4.camel@pants.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 02 Aug 2004 14:38:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-02 at 04:57, Dipankar Sarma wrote:
> Copied to the right email ids to avoid bouncing emails on replies.
> 
> Thanks
> Dipankar
> 
> On Mon, Aug 02, 2004 at 03:19:07PM +0530, Dipankar Sarma wrote:
> > Could it be that recent sched domain stuff broke CPU hotplug ?
> > While testing cpu hotplug with some RCU changes, I got the following
> > panic (while onlining).

Could you try on 2.6.8-rc2-mm2 along with this patch?  Vatsa had a patch
go in that should prevent the crash you are seeing -- the patch below is
needed to prevent the same crash in the offline case.  This check used
to be in load_balance and some other scheduler functions, iirc; does
anyone know why they were removed?

Nathan


---


diff -puN kernel/sched.c~check-for-cpu-offline-in-load_balance kernel/sched.c
--- 2.6.8-rc2-mm2/kernel/sched.c~check-for-cpu-offline-in-load_balance	2004-08-02 13:12:04.000000000 -0500
+++ 2.6.8-rc2-mm2-nathanl/kernel/sched.c	2004-08-02 13:12:58.000000000 -0500
@@ -1405,6 +1405,9 @@ static int load_balance(int this_cpu, ru
 
 	spin_lock(&this_rq->lock);
 
+	if (unlikely(cpu_is_offline(this_cpu)))
+		goto out_balanced;
+
 	group = find_busiest_group(sd, this_cpu, &imbalance, idle);
 	if (!group)
 		goto out_balanced;

_


