Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbSJ2ABI>; Mon, 28 Oct 2002 19:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261388AbSJ2ABI>; Mon, 28 Oct 2002 19:01:08 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:50060 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S261290AbSJ2ABF> convert rfc822-to-8bit; Mon, 28 Oct 2002 19:01:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [Lse-tech] Re: NUMA scheduler  (was: 2.5 merge candidate list 1.5)
Date: Tue, 29 Oct 2002 01:07:12 +0100
User-Agent: KMail/1.4.1
Cc: Michael Hohnbaum <hohnbaum@us.ibm.com>, mingo@redhat.com,
       habanero@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
References: <200210280132.33624.efocht@ess.nec.de> <200210281826.37451.efocht@ess.nec.de> <535130000.1035826537@flay>
In-Reply-To: <535130000.1035826537@flay>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210290107.12914.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 October 2002 18:35, Martin J. Bligh wrote:
> > I'm puzzled about the initial load balancing impact and have to think
> > about the results I've seen from you so far... In the environments I am
> > used to, the frequency of exec syscalls is rather low, therefore I didn't
> > care too much about the sched_balance_exec performance and prefered to
> > try harder to achieve good distribution across the nodes.
>
> OK, but take a look at Michael's second patch. It still looks at
> nr_running on every queue in the system (with some slightly strange
> code to make a rotating choice on nodes on the case of equality),
> so should still be able to make the best decision .... *but* it
> seems to be much cheaper to execute. Not sure why at this point,
> given the last results I sent you last night ;-)

Yes, I like it! I needed some time to understand that the per_cpu
variables can spread the execed tasks acros the nodes as well as the
atomic sched_node. Sure, I'd like to select the least loaded node instead
of the least loaded CPU. It can well be that you just have created on a
node 10 threads (by fork, therefore still on their original CPU), and have
an idle CPU in the same node (which didn't steal yet the newly created
tasks). Suppose your instant load looks like this:
node 0:   cpu0: 1 , cpu1: 1, cpu2: 1, cpu3: 1
node 1:   cpu4:10 , cpu5: 0, cpu6: 1, cpu7: 1

If you exec on cpu0 before cpu5 managed to steal something from cpu4,
you'll aim for cpu5. This would just increase the node-imbalance and
force more of the threads on cpu4 to move to node0, which is maybe bad
for them. Just an example... If you start considering non-trivial
cpus_allowed masks, you might get more of these cases.

We could take this as a design target for the initial load balancer
and keep the fastest version we currently have for the benchmarks
we currently use (Michael's).

Regards,
Erich







