Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268031AbUIJEFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268031AbUIJEFs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 00:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268033AbUIJEFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 00:05:48 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:53719 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S268031AbUIJEFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 00:05:13 -0400
Message-ID: <01be01c496eb$6a9dbd60$f97d220a@linux.bs1.fc.nec.co.jp>
From: "Kaigai Kohei" <kaigai@ak.jp.nec.com>
To: "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0409092005430.14004-100000@localhost.localdomain>
Subject: PATCH] atomic_inc_return() [0/5] (Re: atomic_inc_return)
Date: Fri, 10 Sep 2004 13:05:32 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The first mail to LKML was returned to me because Triple-X was in subject.
I tried to send this one again.
---------------------------

Hello, Hugh Dickins

> KaiGai-San,
> 
> I believe you have a patch adding those to i386 (including CONFIG_M386
> runtime check lest it's an actual i386 which cannot do "xadd") and x86_64.
> I'd be glad to see that go into the tree, would you be ready to submit it
> to Andrew or Linus based on the current 2.6 BK tree?

Indeed, I hope to do this.
atomic_inc_return() is necessary for the 'SELinux performance improvement
by RCU' patch.

See, http://lkml.org/lkml/2004/8/30/63
  [PATCH]SELinux performance improvement by RCU (Re: RCU issue with SELinux)

These fundamental functions should be managed in up-stream.

> I think arm was missing the inc and dec, but has recently gained them.
> arm26 doesn't have any of the four, but it's not SMP, and just a matter
> of following the other examples in its atomic.h to add them.  sparc64
> is missing the add and sub (which neither of us particularly need),
> I think just because nobody was using them: easily added - I think
> it'd be a good idea for all architectures to have the set of four.

I made patches for i386, x86_64, arm, arm26 and sparc64.
These patches apply to both linux-2.6.9-rc1 and 2.6.9-rc1-mm4.

[1/5] atomic_inc_return-linux-2.6.9-rc1.i386.patch
  This patch implements atomic_inc_return() and so on for i386,
  and includes runtime check whether CPU is legacy 386.
  It is same as I posted to LKML and Andi Kleen at '04/09/01.

[2/5] atomic_inc_return-linux-2.6.9-rc1.x86_64.patch
  This patch implements atomic_inc_return() and so on for x86_64.
  It is same as I posted to LKML and Andi Kleen at '04/09/01.

[3/5] atomic_inc_return-linux-2.6.9-rc1.arm.patch
  This patch declares atomic_inc_return() as the alias of atomic_add_return()
  and atomic_dec_return() as an alias of atomic_dec_return().
  This patch has not been tested, since we don't have ARM machine.
  I want to let this reviewed by ARM specialists.

[4/5] atomic_inc_return-linux-2.6.9-rc1.arm26.patch
  This patch implements atomic_inc_return() and so on for ARM26.
  Because Hugh says that SMP is not supported in arm26, it is implemented
  by normal operations between local_irq_save() and local_irq_restore()
  like another atomic operations.
  This patch has not been tested, since we don't have ARM26 machine.
  I want to let this reviewed by ARM26 specialists.

[5/5] atomic_inc_return-linux-2.6.9-rc1.sparc64.patch
  This patch declares atomic_add_return() as an alias of __atomic_add().
  atomic64_add_return(),atomic_sub_return() and atomic64_sub_return() are same.
  This patch has not been tested, since we don't have SPARC64 machine.  
  I want to let this reviewed by SPARC64 specialists.

--------
Kai Gai <kaigai@ak.jp.nec.com>


> Andrew,
> 
> Sorry, I think I must ask you to back my lighten-mmlist_lock.patch
> out of -mm for the moment, and I'll resubmit a little later on.
> 
> Reason being, though nobody is at all likely to hit the race,
> I've put a pathetic piece of self-delusion in try_to_unuse:
> if (!atomic_read(&mm->mm_users))
> continue;
>   atomic_inc(&mm->mm_users);
> 
> I've tried several ways of fixing it (including reworking that dance
> using marker mms instead of raised counts), but got bored or given up
> in disgust over most of them.  Much the nicest fix would be:
> if (atomic_inc_return(&mm->mm_users) == 1) {
> atomic_dec(&mm->mm_users);
> continue;
> }
> 
> (Since, if mm_users was 0, try_to_unuse is the only one which could
> be incrementing it; and though it's possible to do two swapoffs at
> once, we here have the mmlist_lock guarding against another.)
> 
> But that suffers from the drawback that not all architectures currently
> support atomic_inc_return (nor do all support cmpxchg, which could have
> been used instead), and its friends atomic_add_return, atomic_sub_return,
> atomic_dec_return.  Though most do: wouldn't it be nice if they all did?
> 
> KaiGai-San,
> 
> I believe you have a patch adding those to i386 (including CONFIG_M386
> runtime check lest it's an actual i386 which cannot do "xadd") and x86_64.
> I'd be glad to see that go into the tree, would you be ready to submit it
> to Andrew or Linus based on the current 2.6 BK tree?
> 
> I think arm was missing the inc and dec, but has recently gained them.
> arm26 doesn't have any of the four, but it's not SMP, and just a matter
> of following the other examples in its atomic.h to add them.  sparc64
> is missing the add and sub (which neither of us particularly need),
> I think just because nobody was using them: easily added - I think
> it'd be a good idea for all architectures to have the set of four.
> 
> Hirokazu-San,
> 
> That leaves your m32r architecture without them: are those functions
> which you could easily add to the m32r atomic.h, or would there be a
> problem with them?  I'd hate to break your newly-arrived architecture!
> 
> Thanks,
> Hugh
> 

