Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264174AbTE0VNp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264158AbTE0VNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:13:44 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:63210 "EHLO
	ophelia.hpce.nec.com") by vger.kernel.org with ESMTP
	id S264181AbTE0VMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:12:42 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [Lse-tech] Node affine NUMA scheduler extension
Date: Tue, 27 May 2003 23:28:27 +0200
User-Agent: KMail/1.5.1
Cc: Andi Kleen <ak@suse.de>, LSE <lse-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200305271031.55554.efocht@hpce.nec.com> <200305271154.52608.efocht@hpce.nec.com> <10090000.1054049930@[10.10.2.4]>
In-Reply-To: <10090000.1054049930@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305272328.27269.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 May 2003 17:38, Martin J. Bligh wrote:
> > Interesting observation, I didn't make it when I tried the lazy
> > homenode (quite a while ago). But I was focusing on MPI jobs. So what
> > if we add a condition to CAN_MIGRATE which disables the cache affinity
> > before the first load balance?
...
>
> It'd be nice not to require user intervention here ... is it OK to
> set CAN_MIGRATE for all clone operations?

Do you think of something like:

#define CAN_MIGRATE_TASK(p,rq,this_cpu)				\
	(HOMENODE_UNSET(p) &&					\ //<--
	 (jiffies - (p)->last_run > cache_decay_ticks) &&	\
		!task_running(rq, p) &&				\
		((p)->cpus_allowed & (1UL << (this_cpu))))

	curr = curr->prev;

	if (!CAN_MIGRATE_TASK(tmp, busiest, this_cpu) 
	    || !numa_should_migrate(tmp, busiest, this_cpu)) {
		if (curr != head)
			goto skip_queue;
		idx++;
		goto skip_bitmap;
	}
	if (HOMENODE_UNSET(tmp))				//<--
		set_task_node(tmp,cpu_to_node(this_cpu));	//<--
	pull_task(busiest, array, tmp, this_rq, this_cpu);
	if (!idle && --imbalance) {
	...

?
Guess this would help a bit for multithreaded jobs. Chosing the
homenode more carefully here would be pretty expensive.

Regards,
Erich


