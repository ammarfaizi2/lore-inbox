Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269337AbUINMod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269337AbUINMod (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 08:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269414AbUINMmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 08:42:42 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:41565 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269411AbUINMl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 08:41:27 -0400
Message-ID: <4146E6F0.5030405@yahoo.com.au>
Date: Tue, 14 Sep 2004 22:41:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andries Brouwer <Andries.Brouwer@cwi.nl>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [no patch] broken use of mm_release / deactivate_mm
References: <20040913190633.GA22639@apps.cwi.nl> <Pine.LNX.4.58.0409131224440.2378@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409131224440.2378@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 13 Sep 2004, Andries Brouwer wrote:
> 
>>What happens at a fork, is that a long sequence of things is done,
>>and if a failure occurs all previous things are undone. Thus
>>(in copy_process()):
>>
>>        if ((retval = copy_mm(clone_flags, p)))
>>                goto bad_fork_cleanup_signal;
>>        if ((retval = copy_namespace(clone_flags, p)))
>>                goto bad_fork_cleanup_mm;
>>        retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
>>        if (retval)
>>                goto bad_fork_cleanup_namespace;
>>
>>...
>>
>>bad_fork_cleanup_namespace:
>>        exit_namespace(p);
>>bad_fork_cleanup_mm:
>>        exit_mm(p);
>>        if (p->active_mm)
>>                mmdrop(p->active_mm);
> 
> 
> I agree. Looks like the "exit_mm()" should really be a "mmput()".
> 
> Can we have a few more eyes on this thing? Ingo, Nick?
> 

AFAIKS yes. exit_mm doesn't look legal unless its dropping the current
mm context. And mmput looks like it should clean up everything - it is
used almost exactly the same way to cleanup a failure case in copy_mm.
