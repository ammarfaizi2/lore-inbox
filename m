Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751557AbWCJPLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbWCJPLi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 10:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbWCJPLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 10:11:38 -0500
Received: from cirse.extra.cea.fr ([132.166.172.102]:26764 "EHLO
	cirse.extra.cea.fr") by vger.kernel.org with ESMTP id S1751535AbWCJPLh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 10:11:37 -0500
Message-Id: <200603101510.QAA17788@styx.bruyeres.cea.fr>
Date: Fri, 10 Mar 2006 16:10:25 +0100
From: Aurelien Degremont <aurelien.degremont@cea.fr>
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1 (X11/20050719)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Jacques-Charles Lafoucriere <jc.lafoucriere@cea.fr>,
       Bruno Faccini <bruno.faccini@bull.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix deadlock in RPC scheduling code.
References: <200603091035.LAA04829@styx.bruyeres.cea.fr> <1141915219.8293.5.camel@lade.trondhjem.org>
In-Reply-To: <1141915219.8293.5.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

> The real fix is the one I posted in response to this thread last week.

Oops, I missed it.

Ok for the patch, the list iteration will be better, but I don't
understand how this will prevent the race condition?

I do not think it is not a good idea to keep this lock order in
rpc_wake_up_task() anyway. I must be missing something but I
think this function should be modified in order to be in accordance with
the lock hierarchy in rpc code. It seems to me that the potential race 
is still there.

Even if we cannot certify task->u.tk_wait.rpc_waitq is valid, the
current kernel code cannot either (err... I think it can't). So let's 
try at least to improve it, even if we cannot set it totally harmless.
Warn me if I'm wrong :
    When rpc_wake_up_task() is called, the calling context is helpless. 
So we have absolutely no information on the task queue. We must 
atomically check the "queued-ness" of the task and grab the queue lock 
to prevent any error? Hmmm... So the matter is : the queue mustn't be 
modified between the test and the lock? Have we some "magical" lock 
somewhere which could help up? I didn't find it.
   With the patch I propose (quite the same than Simon Derr's last week
proposal), the insertion of the RPC task is not a problem since the
QUEUED flag is set when the task is totally enqueued (in 
__rpc_add_wait_queue(): task->u.tk_wait.list is modified and 
task->u.tk_wait.rpc_waitq set), so if the test is
true, the task does have a queue. The task removal is more problematic.
The task could be executed and removed from the queue between the bit
test and the lock grabbing. I've checked the code responsible for this,
and it seems that the task->u.tk_wait.rpc_waitq pointer is still valid,
the task is just removed from wait queue list. So, we could still take
the queue lock and, with the lock taken, we just need to do one more
test to verify the task was not woken up and removed from the queue
since the test.

I do not really like this solution, that's not really clean, but, at
least, I hope my analysis is not too far from correct?
Please let me now where I wrong.

Cordially

-- 
Aurelien Degremont

