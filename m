Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbUK1PCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbUK1PCT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 10:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbUK1PCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 10:02:19 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:24012 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261267AbUK1PCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 10:02:14 -0500
Message-ID: <41A9E857.7040100@colorfullife.com>
Date: Sun, 28 Nov 2004 16:01:43 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] rcu: eliminate rcu_data.last_qsctr
References: <41A9E98F.209C59B0@tv-sign.ru> <20041128144346.GB2714@holomorphy.com>
In-Reply-To: <20041128144346.GB2714@holomorphy.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>On Sun, Nov 28, 2004 at 06:06:55PM +0300, Oleg Nesterov wrote:
>  
>
>>Is the rcu_data.last_qsctr really needed?
>>It is used in rcu_check_quiescent_state() exclusively.
>>I think we can reset qsctr at the start of the grace period,
>>and then just test qsctr against 0.
>>    
>>
>
>That might work if there were only 1 cpu. The local cpu owns ->qsctr,
>->last_qsctr is stored and loaded by remote cpus under locks.
>
>  
>
No. The whole rcu_data structure is cpu-local, it's never accessed from 
remote cpus [except during hotunplug]. It doesn't even contain a lock.
A grace period consists of the following steps:
- one cpu is in rcu_start_batch() and does rcp->cur++.
- for all cpus:
* __rcu_pending mismatch between rdp->quiescbatch and rcp->cur, calls to 
rcu_check_callbacks
* rcu_check_callbacks schedules rcu_process_callbacks as a tasklet
* rcu_process_callbacks stores last_qsctr.
* further calls to rcu_process_callbacks du to __rcu_pendig()==1, until 
qsctr was increased
* grace period completed by the cpu
- for the last cpu: call rcu_start_batch() and start the next one, if 
needed.

As far as I can see the patch is correct.

--
    Manfred
-

>-- wli
>  
>

