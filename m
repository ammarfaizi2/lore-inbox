Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262582AbVBYWSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbVBYWSr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 17:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbVBYWSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 17:18:47 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:26550 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262582AbVBYWSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 17:18:14 -0500
Message-ID: <421FA443.6090100@sgi.com>
Date: Fri, 25 Feb 2005 14:18:43 -0800
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-tw, en-us, en, zh-cn, zh-hk
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: kaigai@ak.jp.nec.com, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       tim@physik3.uni-rostock.de, erikj@subway.americas.sgi.com,
       limin@dbear.engr.sgi.com, jbarnes@sgi.com
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
References: <42168D9E.1010900@sgi.com>	<20050218171610.757ba9c9.akpm@osdl.org>	<421993A2.4020308@ak.jp.nec.com>	<421B955A.9060000@sgi.com>	<421C2B99.2040600@ak.jp.nec.com>	<421CEC38.7010008@sgi.com>	<421EB299.4010906@ak.jp.nec.com>	<20050224212839.7953167c.akpm@osdl.org>	<421F6139.5020207@sgi.com> <20050225133034.09da67f9.akpm@osdl.org>
In-Reply-To: <20050225133034.09da67f9.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jay Lan <jlan@sgi.com> wrote:
> 
>>Andrew Morton wrote:
>> > Kaigai Kohei <kaigai@ak.jp.nec.com> wrote:
>> > 
>> >>In my understanding, what Andrew Morton said is "If target functionality can
>> >> implement in user space only, then we should not modify the kernel-tree".
>> > 
>> > 
>> > fork, exec and exit upcalls sound pretty good to me.  As long as
>> > 
>> > a) they use the same common machinery and
>> > 
>> > b) they are next-to-zero cost if something is listening on the netlink
>> >    socket but no accounting daemon is running.
>> > 
>> > Question is: is this sufficient for CSA?
>>
>> Yes, fork, exec, and exit upcalls are sufficient for CSA.
>>
>> The framework i proposed earlier should satisfy your requirement a
>> and b, and provides upcalls needed by BSD, ELSA and CSA. Maybe i
>> misunderstood your concern of the 'very light weight' framework
>> i proposed besides being "overkill"?
> 
> 
> "upcall" is poorly defined.
> 
> What I meant was that ELSA can perform its function when the kernel merely
> sends asynchronous notifications of forks out to userspace via netlink.
> 
> Further, I'm wondering if CSA can perform its function with the same level
> of kernel support, perhaps with the addition of netlink-based notification
> of exec and exit as well.
> 
> The framework patch which you sent was designed to permit the addition of
> more kernel accounting code, which is heading in the opposite direction.
> 
> In other words: given that ELSA can do its thing via existing accounting
> interfaces and a fork notifier, why does CSA need to add lots more kernel
> code?

Here are some codes from do_exit() starting line 813 (based on
2.6.11-rc4-mm1):

813        acct_update_integrals(tsk);
814        update_mem_hiwater(tsk);
815        group_dead = atomic_dec_and_test(&tsk->signal->live);
816        if (group_dead) {
817                del_timer_sync(&tsk->signal->real_timer);
818                acct_process(code);
819        }
820        exit_mm(tsk);

The acct_process() is called to save off BSD accounting data at
line 818. The next statement at 820, tsk->mm is disposed and all
data saved at tsk->mm is gone, including memory hiwater marks
information saved at line 814. The complete tsk is disposed
before exit of do_exit() routine.

In separate emails discussion thread among interested parties,
i asked Guillaume to clarify this question. I suspect ELSA counts
on BSD's acct_process() at line 818 to save most accounting data.
If that is the case and since ELSA wants extended accounting data
collection, a way to save the extended acct data would be essential
to ELSA as well.

I can better asnwer your "why ELSA can do but CSA can't" question
after i learn more from Guilluame.

Later,
  - jay

> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech

