Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266119AbTIKF7N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 01:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266124AbTIKF7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 01:59:13 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:53155 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S266119AbTIKF7K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 01:59:10 -0400
Message-ID: <0a7701c37829$c4bdef40$890010ac@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: "Andi Kleen" <ak@colin2.muc.de>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>, "Andi Kleen" <ak@muc.de>,
       <linux-kernel@vger.kernel.org>
References: <uqD5.3BI.3@gated-at.bofh.it> <m3iso0arlx.fsf@averell.firstfloor.org> <0a5801c37821$54eb8180$890010ac@edumazet> <20030911051121.GA7751@colin2.muc.de>
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Date: Thu, 11 Sep 2003 07:58:46 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> I don't have any. But it would be very similar to the in kernel checking
> code (see the is_prefetch function in my patches). Just you feed it
> the fields from sigcontext in the signal handler and replace __get_user
> with a normal memory access.

OK will try... but how test it... sounds not easy.

> > I do use preftechnta instructions on my programs, and this errata could
> > explain some strange crashes.
>
> The bogus faults are very easy to diagnose. When you have a core dump
> and disassemble the faulting instruction (in gdb x/i $eip) and it is
> a prefetch (prefetch/prefetchw/prefetchnt*) then it could be that.

Well, the program is using more than 2Go ram... the core is not written to
disk as the machine hangs just *after*

And this is a remote machine in a Datacenter.

>
> If it is a different instruction it is unrelated.
>
> It would also only happen when you prefetch ever on unmapped addresses.

NULL for example ?

Typical example of code ;

T_cell *ptr, *next ;
for (ptr = list.head ; ptr != NULL ; ptr = next) {
   next = ptr->next ;
   prefetch(next) ;
   some_work(ptr) ;
   }

I may replace NULL by &FakeMappedData   (allways present in memory)

>
> That sounds like an unrelated issue.
>
> When user space crashes on this the kernel is unaffected.

This is not a kernel crash. But total freeze as all memory is used by
network buffers, in no more than 10 seconds.
This application receive smalls TCP messages (about 30 bytes), but the
network stacks allocates 4KB buffers to store this little messages.

No oops, but what can we do, if the freeze lasts eternity ?

I posted a test application some days ago about this problem and got no
answers/feedback.

>
> In case the 2.6 kernel crashes on this (2.4 does not trigger it)
> then you can also run the oops through ksymoops and check if the
> faulting instruction is prefetch. If it isn't  then it is something else.
>
> Network buffers using up all of low mem and then crash
> is likely some OOM handling problem. If you're on 2.4 try an -aa kernel,
> they handle this much better than the marcelo tree. If it's 2.6 then
> I would recommend posting oopses on this list, maybe someone can fix
> it. I suspect 2.6's OOM handling could be still improved.
>
> -Andi
> -

Eric

