Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281571AbRKUKH5>; Wed, 21 Nov 2001 05:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281570AbRKUKHq>; Wed, 21 Nov 2001 05:07:46 -0500
Received: from pat.uio.no ([129.240.130.16]:50393 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S281563AbRKUKHa>;
	Wed, 21 Nov 2001 05:07:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo
To: kuznet@ms2.inr.ac.ru, "David S. Miller" <davem@redhat.com>
Subject: Re: more tcpdumpinfo for nfs3 problem: aix-server --- linux 2.4.15pre5 client
Date: Wed, 21 Nov 2001 11:07:14 +0100
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200111201945.WAA03637@ms2.inr.ac.ru>
In-Reply-To: <200111201945.WAA03637@ms2.inr.ac.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E166UHi-0005dA-00@charged.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20. November 2001 20:45, kuznet@ms2.inr.ac.ru wrote:

> (Call QDIO bottom half code)
> spin_lock(&QDIO_lock);
>                                                  <QDIO hard interrupt>
>                                                       
>                                                  ->spin_lock(&QDIO_lock)
>                                                  (spins...)
>
> with the same result. No help of nfs is required. :-)

Now that my blood caffeine levels are above the 'sleep' watermark, I should 
probably correct the above in case Ulrich decides to slap us both with a 
slander lawsuit 8-)...

Since (as I said in the original mail) CPU 1 is in a bottom half context, 
both local bh and local interrupts should be disabled on that process!

Basically, the deadlock between the QDIO driver and RPC/fasync can be reduced 
to:

CPU 1                                       CPU 2

(In BH context)                             (In ordinary process context)
spin_lock_irq(&lock1);
                                            spin_lock_bh(&lock2);
dev_kfree_skb_any(skb);
                                            <QDIO Hard interrupt>
                                            (switch to QDIO interrupt context)
    -> sk->write_space();
                                            spin_lock(&lock1);
         -> spin_lock(&lock2);


IOW:
    Either we must demand that CPU 2 uses irq-safe spinlocks in order to 
protect against sk->write_space(), or we must demand that CPU 1 should drop 
'lock1' before being allowed to call dev_kfree_skb_any().

Cheers,
   Trond
