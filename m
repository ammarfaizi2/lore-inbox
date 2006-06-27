Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161127AbWF0Pxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161127AbWF0Pxq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161128AbWF0Pxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:53:46 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:57574 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161127AbWF0Pxp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:53:45 -0400
Message-ID: <44A15483.30308@watson.ibm.com>
Date: Tue, 27 Jun 2006 11:53:39 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: michal.k.k.piotrowski@gmail.com, linux-kernel@vger.kernel.org,
       mingo@elte.hu, akpm@osdl.org, balbir@in.ibm.com, jlan@engr.sgi.com
Subject: Re: + delay-accounting-taskstats-interface-send-tgid-once.patch	added
 to -mm tree
References: <200606261906.k5QJ6vCp025201@shell0.pdx.osdl.net> <1151421336.5217.28.camel@laptopd505.fenrus.org>
In-Reply-To: <1151421336.5217.28.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>also in response to
>                           Subject: 
>Re: 2.6.17-mm3
>                              Date: 
>Tue, 27 Jun 2006 16:12:42 +0200
>with Message-ID:
><6bffcb0e0606270712w166f04a6u237d695e2bfa1913@mail.gmail.com>
>
>On Mon, 2006-06-26 at 12:06 -0700, akpm@osdl.org wrote:
>
>  
>
>>+static inline void taskstats_tgid_alloc(struct signal_struct *sig)
>>+{
>>+	struct taskstats *stats;
>>+
>>+	stats = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
>>+	if (!stats)
>>+		return;
>>+
>>+	spin_lock(&sig->stats_lock);
>>+	if (!sig->stats) {
>>    
>>
>
>+static inline void taskstats_tgid_free(struct signal_struct *sig)
>+{
>+       struct taskstats *stats = NULL;
>+       spin_lock(&sig->stats_lock);
>+       if (sig->stats) {
>+               stats = sig->stats;
>+               sig->stats = NULL;
>+       }
>+       spin_unlock(&sig->stats_lock);
>+       if (stats)
>+               kmem_cache_free(taskstats_cache, stats);
>+}
>
>this is buggy and deadlock prone!
>(found by lockdep)
>
>stats_lock nests within tasklist_lock, which is taken in irq context.
>(and thus needs irq_save treatment). But because of this nesting, it is
>not allowed to take stats_lock without disabling irqs, or you can have
>the following scenario
>
>CPU 0                		CPU 1
>(in irq)            	 	(in the code above)
>		     		stats_lock is taken
>tasklist_lock is taken	     	
>stats_lock_is taken <spin>	
>				<interrupt happens>
>		     		tasklist_lock is taken
>		     
>which now forms an AB-BA deadlock!
>
>
>this happens at least in copy_process which can call taskstats_tgid_free
>without first disabling interrupts (via cleanup_signal). 
>

Arjan,

Didn't get how stats_lock is nesting within tasklist_lock in copy_process ?
The call to cleanup_signal (or any call to taskstats_tgid_alloc/free) 
seems to be happening
outside of holding the tasklist lock ? Or maybe I'm missing something.

Changing to an irqsave variant isn't a problem of course...

--Shailabh

>There may be
>many other cases, I've not checked deeper yet.
>
>Solution should be to make these functions use irqsave variant... any
>comments from the authors of this patch ?
>
>
>  
>

