Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWCMPQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWCMPQv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 10:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWCMPQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 10:16:51 -0500
Received: from cirse.extra.cea.fr ([132.166.172.102]:16096 "EHLO
	cirse.extra.cea.fr") by vger.kernel.org with ESMTP id S1751422AbWCMPQu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 10:16:50 -0500
Message-Id: <200603131516.QAA19564@styx.bruyeres.cea.fr>
Date: Mon, 13 Mar 2006 16:16:04 +0100
From: Aurelien Degremont <aurelien.degremont@cea.fr>
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1 (X11/20050719)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Jacques-Charles Lafoucriere <jc.lafoucriere@cea.fr>,
       Bruno Faccini <bruno.faccini@bull.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix deadlock in RPC scheduling code.
References: <200603091035.LAA04829@styx.bruyeres.cea.fr>	 <1141915219.8293.5.camel@lade.trondhjem.org>	 <200603101510.QAA17788@styx.bruyeres.cea.fr>	 <1142004255.8041.26.camel@lade.trondhjem.org>	 <200603131007.LAA10812@styx.bruyeres.cea.fr> <1142260115.7996.13.camel@lade.trondhjem.org>
In-Reply-To: <1142260115.7996.13.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
>>Hmmm... With those constraints, it seems difficult to be able to modify 
>>the current rpc_wake_up_task() function...
> That is the price of optimisation in this case.

Optimisation against potential race (see below) ?

> Your deadlock problem resulted in __rpc_wake_up_task() iterating forever
> on the same task since the while() loop would not ever exit before it
> was empty. By changing the iteration scheme into one where we only try
> to wake up each task once, we allow rpc_wake_up()/rpc_wake_up_status()
> to complete.

IMO, the code will still hang because, the list_for_each_entry_safe() 
loop will never complete, even with the new scheme. Indeed, the loop 
call __rpc_wake_up_task() will try to set RPC_TASK_WAKEUP bit, but it is 
already set by rpc_wake_up_task(), so it hangs...

A: run rpc_wake_up_task(task foo)
A: set RPC_TASK_WAKEUP bit
--interrupt--
B: run rpc_wake_up()
B: grab queue->lock
B: enter the list_for_each_entry_safe() loop
B: run __rpc_wake_up_task(task foo)
B: wait for RPC_TASK_WAKEUP bit
A: wait for queue->lock

  -> deadlock ?

-- 
Aurelien Degremont

