Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbWGFRAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWGFRAp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 13:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWGFRAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 13:00:45 -0400
Received: from mail.suse.de ([195.135.220.2]:27019 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751138AbWGFRAp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 13:00:45 -0400
From: Andi Kleen <ak@suse.de>
To: Martin Peschke <mp3@de.ibm.com>
Subject: Re: [Patch] statistics infrastructure - update 9
Date: Thu, 6 Jul 2006 19:00:39 +0200
User-Agent: KMail/1.9.3
Cc: heiko.carstens@de.ibm.com, clg@fr.ibm.com, linux-kernel@vger.kernel.org
References: <1151943862.2936.10.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <p73ac7qql4a.fsf@verdi.suse.de> <44AD406A.7090709@de.ibm.com>
In-Reply-To: <44AD406A.7090709@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607061900.39406.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Good question. Btw. - faster by what order of magnitude?

pushf + popf is on K8 at least ~18 cycles, on P4 it is much more
because they synchronize the pipeline there (hundreds of cycles)

cpu local add would be a few cycles at best and doesn't have
any impact on the pipeline


> local_irq_save/restore seems to be fine for kernel/profile.c
> 
> 
> Reason 1:
> cpu_local_* uses __get_cpu_var, which conflicts with struct statistic
> being embedded into struct xyz that is allocated whenever the client
> needs it.
> 
> I could try to use local_t in conjunction with local_add etc.
> (as seen in include/linux/dmaengine.h in 2.6.17-mm6).
> Does this also yield a performance gain worth consideration?

Yes, but you would need preempt_disable() then. For non preemptible
kernels (far majority) that would be already a big win.


> So, removing local_irq_save/restore would require statistics to be
> switched on and their buffers being available all the time. That is,
> buffers holding counters etc. can't be allocated at run time - what
> if allocation fails? (Should I leave this issue to clients?).

Can't you use RCU for this?


> Reason 4:
> The alleged overhead of local_irq_save/restore (as compared
> to atomic operations) 

local_* doesn't need to be atomic. IT isn't on x86 at least.
On some other architectures it can be, but i think it's just a SMOP
of fixing them.

-Andi
