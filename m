Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271683AbRICMhE>; Mon, 3 Sep 2001 08:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271685AbRICMgz>; Mon, 3 Sep 2001 08:36:55 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:2743 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S271683AbRICMgf>; Mon, 3 Sep 2001 08:36:35 -0400
Importance: Normal
Subject: Re: NFS deadlock explained (on S/390)
To: "Manfred Spraul" <manfred@colorfullife.com>
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFED05871E.27F0F7FB-ONC1256ABC.0042AF59@de.ibm.com>
From: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Date: Mon, 3 Sep 2001 14:35:43 +0200
X-MIMETrack: Serialize by Router on D12ML028/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 03/09/2001 14:35:51
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Manfred Spraul:

>I think in_irq() and in_interrupt() should check the cpu interrupt flag
>and return TRUE if the per-cpu interrupts are disabled.
>
>The current behavious is just weird:
>    spin_lock_bh();
>    in_interrupt(); --> true
>    spin_unlock_bh();
>    spin_lock_irq();
>    in_interrupt(); --> false
>    spin_unlock_irq();

I see.  Instead of checking the interrupt flag in in_irq(), spin_lock_irq
could also simply increment the local_irq_count, just like spin_lock_bh
increments the local_bh_count.

>> Whether this same situation can explain the deadlocks seen on
>> other platforms depends on whether the drivers used there exhibit
>> similar locking behaviours as the QDIO driver, of course.
>
>It should be possible to detect that automatically: if
>dev_kfree_skb_any() is called outside irq context with disabled per-cpu
>interrupts then it's probably due to a spin_lock_irq() and could
>deadlock.

This would definitely solve the deadlock in our case.  However, I'm not
sure this doesn't have some adverse effect on other code; e.g. there are
quite a few routines that use if (!in_interrupt()) as a bug-check, and
some might possibly be called from inside a spin_lock_irq ...



Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com

