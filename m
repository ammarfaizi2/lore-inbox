Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132095AbQLIAtf>; Fri, 8 Dec 2000 19:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132996AbQLIAtZ>; Fri, 8 Dec 2000 19:49:25 -0500
Received: from feral.com ([192.67.166.1]:31576 "EHLO feral.com")
	by vger.kernel.org with ESMTP id <S132095AbQLIAtJ>;
	Fri, 8 Dec 2000 19:49:09 -0500
Date: Fri, 8 Dec 2000 16:18:15 -0800 (PST)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: Reto Baettig <baettig@scs.ch>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: io_request_lock question (2.2)
In-Reply-To: <200012090010.QAA28833@k2.llnl.gov>
Message-ID: <Pine.BSF.4.21.0012081611380.72881-100000@beppo.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> I am actually concerned about the following case:
> 
> The add_request ON CPU_1 function calls 
>         spin_lock_irqsave(&io_request_lock,flags); 
> 
> Our I/O Function unlocks the spinlock and goes to sleep.
> 
> Finally, the add_request function, NOW ON CPU_2 calls
>         spin_unlock_irqrestore(&io_request_lock,flags);
> and restores the flags of CPU_1 on CPU_2.    
> 
> What am I missing? Are the flags which we restore valid for all the CPU's
> the same?

Absolutely not. They're state *for that CPU*.

Before I gave up doing my own locking in my HBA, I was using flags in my
softc, so I could do things like this in transitioning from an int svc routine
to another module (in this case, a SCSI target mode handler):

	<interrupt starts>
	spinlock_irq_save(&isp->isp_lk, isp->isp_lkflags);
	<get stuff from response queue>
	spinlock_irq_restore(&isp->isp_lk, isp->isp_lkflags);
	<call scsi_target_mode_handler>
	spinlock_irq_save(&isp->isp_lk, isp->isp_lkflags);
	<reinstruct card>
	spinlock_irq_restore(&isp->isp_lk, isp->isp_lkflags);
	(return from interrupt)

So, if you acquire the lock, the flags go with *that* CPU's acquisition of the
lock.  But that's dangerous in that you're passing the flags around to be
possibly 'restored' (incorrectly) in some other context. That's why flags
seems to be usually an auto variable construct.

But what I still don't get is why it's okay to do a spin_unlock_irq on
io_request_lock (because you don't have access to the flags that were locked
with it (if any)) and not end up with a system that can deadlock. Well,
enlightenment will come some day I'm sure.


-matt


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
