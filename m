Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVB0PU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVB0PU1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 10:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVB0PU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 10:20:26 -0500
Received: from juran.asahi-net.or.jp ([202.224.39.39]:42031 "EHLO
	mail-old.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S261401AbVB0PUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 10:20:17 -0500
Message-ID: <4221E548.4000008@ak.jp.nec.com>
Date: Mon, 28 Feb 2005 00:20:40 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
Organization: KAIGAI.GR.JP
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, davem@redhat.com, jlan@sgi.com,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
References: <42168D9E.1010900@sgi.com> <20050218171610.757ba9c9.akpm@osdl.org> <421993A2.4020308@ak.jp.nec.com> <421B955A.9060000@sgi.com> <421C2B99.2040600@ak.jp.nec.com> <421CEC38.7010008@sgi.com> <421EB299.4010906@ak.jp.nec.com> <20050224212839.7953167c.akpm@osdl.org> <20050227094949.GA22439@logos.cnet>
In-Reply-To: <20050227094949.GA22439@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>>Kaigai Kohei <kaigai@ak.jp.nec.com> wrote:
>>
>>>In my understanding, what Andrew Morton said is "If target functionality can
>>> implement in user space only, then we should not modify the kernel-tree".
>>
>>fork, exec and exit upcalls sound pretty good to me.  As long as
>>
>>a) they use the same common machinery and
>>
>>b) they are next-to-zero cost if something is listening on the netlink
>>   socket but no accounting daemon is running.
> 
> 
> b) would involved being able to avoid sending netlink messages in case there are 
> no listeners. AFAIK that isnt possible currently, netlink sends 
> packets unconditionally.
> 
> Am I wrong? 

In current implementaion, you might be right.
But we should make an effort to achieve the requirement-(b) from now.

And, why can't netlink packets send always?
If there are fork/exec/exit hooks, and they call CSA or other process-grouping modules,
then those modules will decide whether packets for interaction with the daemon should be
sent or not.
In most considerable case, CSA's kernel-loadable-module using such hooks will not be loaded
when no accounting daemon is running. Adversely, this module must be loaded when accounting
daemon needs CSA's netlink packets.
Thus, it is only necessary to refer flag valiable and to execute conditional-jump
when no-accounting daemon is running.

In my estimation, we must pay additional cost for an increment-operation, an decrement-op,
an comparison-op and an conditional jump-op. It's enough lightweight, I think.

For example:
If CSA's module isn't loaded, 'privates_for_grouping' will be empty.

inline int on_fork_hook(task_struct *parent, task_struct *newtask){
   rcu_read_lock();
   if( !list_empty(&parent->privates_for_grouping) ){
     ..<Calling to any process grouping module>..;
   }
   rcu_read_unlock();
}

Thanks,
-- 
Linux Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>
