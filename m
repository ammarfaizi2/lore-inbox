Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVBWTLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVBWTLo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 14:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVBWTLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 14:11:44 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:39366 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261536AbVBWTLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 14:11:30 -0500
Message-ID: <421CD570.7070907@sgi.com>
Date: Wed, 23 Feb 2005 11:11:44 -0800
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-tw, en-us, en, zh-cn, zh-hk
MIME-Version: 1.0
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
CC: Andrew Morton <akpm@osdl.org>, Kaigai Kohei <kaigai@ak.jp.nec.com>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       erikj@subway.americas.sgi.com, limin@dbear.engr.sgi.com,
       jbarnes@sgi.com, elsa-devel <elsa-devel@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
References: <42168D9E.1010900@sgi.com>	 <20050218171610.757ba9c9.akpm@osdl.org> <421993A2.4020308@ak.jp.nec.com>	 <421B955A.9060000@sgi.com> <421C2B99.2040600@ak.jp.nec.com>	 <20050222232002.4d934465.akpm@osdl.org> <1109147623.1738.91.camel@frecb000711.frec.bull.fr>
In-Reply-To: <1109147623.1738.91.camel@frecb000711.frec.bull.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Thouvenin wrote:
> On Tue, 2005-02-22 at 23:20 -0800, Andrew Morton wrote:
> 
>>Kaigai Kohei <kaigai@ak.jp.nec.com> wrote:
>>
>>> The common agreement for the method of dealing with process aggregation
>>> has not been constructed yet, I understood. And, we will not able to
>>> integrate each process aggregation model because of its diverseness.
>>>
>>> For example, a process which belong to JOB-A must not belong any other
>>> 'JOB-X' in CSA-model. But, In ELSA-model, a process in BANK-B can concurrently
>>> belong to BANK-B1 which is a child of BANK-B.
>>>
>>> And, there are other defferences:
>>> Whether a process not to belong to any process-aggregation is permitted or not ?
>>> Whether a process-aggregation should be inherited to child process or not ?
>>> (There is possibility not to be inherited in a rule-based process aggregation like CKRM)
>>>
>>> Some process-aggregation model have own philosophy and implemantation,
>>> so it's hard to integrate. Thus, I think that common 'fork/exec/exit' event handling
>>> framework to implement any kinds of process-aggregation.
> 
> 
> I can add "policies". With ELSA, a process belongs to one or several
> groups and if a process is removed from one group, its children still
> belong to the group. Thus a good idea could be to associate a
> "philosophy" to a group. For exemple, when a group of processes is
> created it can be tagged as UNIQUE or SHARED. UNIQUE means that a
> process that belongs to it could not be added in another group by
> opposition to SHARED. It's not needed inside the kernel.

This makes sense to me. CSA can use the UNIQUE policy to enforce
its "can't escape from job container" philisophy.

> 
> 
>>We really want to avoid doing such stuff in-kernel if at all possible, of
>>course.
>>
>>Is it not possible to implement the fork/exec/exit notifications to
>>userspace so that a daemon can track the process relationships and perform
>>aggregation based upon individual tasks' accounting?  That's what one of
>>the accounting systems is proposing doing, I believe.
> 
> 
> It's what I'm proposing. The problem is to be alerted when a new process
> is created in order to add it in the correct group of processes if the
> parent belongs to one (or several) groups. The notification can be done
> with the fork connector patch. 

I am not quite comfortable of ELSA requesting a fork hook this way.
How many hooks in the stock kernel that are related to accounting? Can
anyone answer this question? I know of 'acct_process()' in exit.c used
by the BSD accounting and ELSA is requesting a hook in fork. If people
raise the same question again a few years later, how many people will
still remember this ELSA hook?

That was the reason i thought a central piece was a good idea. I
would rather see the fork hook is coded in acct.c and then invokes
a routine that handles what ELSA needs. If CSA would adopt the ELSA's
daemon's approach, CSA may also need to use the fork hook.

Actually the acct_process() was modified not long ago to become
a wrapper, which then invokes do_acct_process() which is completely
BSD specific. The fork hook can be the same.

- jay

> 
> 
>>(In fact, why do we even need the notifications?  /bin/ps can work this
>>stuff out).
> 
> 
> Yes it can but the risk is to lose some forks no? 
> I think that /bin/ps is using the /proc interface. If we're polling
> the /proc to catch process creation we may lost some of them. With the
> fork connector we catch all forks and we can check that by using the
> sequence number (incremented by each fork) of the message.
> 
> Guillaume

