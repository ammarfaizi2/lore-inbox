Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVB0SZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVB0SZn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 13:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVB0SZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 13:25:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44232 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261403AbVB0SZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 13:25:30 -0500
Date: Sun, 27 Feb 2005 11:03:55 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: Andrew Morton <akpm@osdl.org>, davem@redhat.com, jlan@sgi.com,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
Message-ID: <20050227140355.GA23055@logos.cnet>
References: <42168D9E.1010900@sgi.com> <20050218171610.757ba9c9.akpm@osdl.org> <421993A2.4020308@ak.jp.nec.com> <421B955A.9060000@sgi.com> <421C2B99.2040600@ak.jp.nec.com> <421CEC38.7010008@sgi.com> <421EB299.4010906@ak.jp.nec.com> <20050224212839.7953167c.akpm@osdl.org> <20050227094949.GA22439@logos.cnet> <4221E548.4000008@ak.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4221E548.4000008@ak.jp.nec.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 12:20:40AM +0900, KaiGai Kohei wrote:
> Hi,
> 
> >>Kaigai Kohei <kaigai@ak.jp.nec.com> wrote:
> >>
> >>>In my understanding, what Andrew Morton said is "If target functionality 
> >>>can
> >>>implement in user space only, then we should not modify the kernel-tree".
> >>
> >>fork, exec and exit upcalls sound pretty good to me.  As long as
> >>
> >>a) they use the same common machinery and
> >>
> >>b) they are next-to-zero cost if something is listening on the netlink
> >>  socket but no accounting daemon is running.
> >
> >
> >b) would involved being able to avoid sending netlink messages in case 
> >there are no listeners. AFAIK that isnt possible currently, netlink sends 
> >packets unconditionally.
> >
> >Am I wrong? 
> 
> In current implementaion, you might be right.
> But we should make an effort to achieve the requirement-(b) from now.

Yep, the netlink people should be able to help - they known what would be
required for not sending messages in case there is no listener registered.

Maybe its already possible? I have never used netlink myself.

> And, why can't netlink packets send always?
> If there are fork/exec/exit hooks, and they call CSA or other 
> process-grouping modules,
> then those modules will decide whether packets for interaction with the 
> daemon should be
> sent or not.

The netlink data will be sent to userspace at fork/exec/exit hooks - one wants
to avoid that if there are no listeners, so setups which dont want to run the 
accounting daemon dont pay the cost of building and sending the information 
through netlink. 

Thats what Andrew asked for if I understand correctly.

> In most considerable case, CSA's kernel-loadable-module using such hooks 
> will not be loaded
> when no accounting daemon is running. Adversely, this module must be loaded 
> when accounting
> daemon needs CSA's netlink packets.
> Thus, it is only necessary to refer flag valiable and to execute 
> conditional-jump
> when no-accounting daemon is running.

That would be one hack, although it is uglier than the pure netlink 
selection.

> In my estimation, we must pay additional cost for an increment-operation, 
> an decrement-op,
> an comparison-op and an conditional jump-op. It's enough lightweight, I 
> think.
> 
> For example:
> If CSA's module isn't loaded, 'privates_for_grouping' will be empty.
> 
> inline int on_fork_hook(task_struct *parent, task_struct *newtask){
>   rcu_read_lock();
>   if( !list_empty(&parent->privates_for_grouping) ){
>     ..<Calling to any process grouping module>..;
>   }
>   rcu_read_unlock();
> }

Andrew has been talking about sending data over netlink to implement the 
accounting at userspace, so this piece of code is out of the game, no?
