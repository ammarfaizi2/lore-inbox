Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313716AbSDZIwq>; Fri, 26 Apr 2002 04:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313727AbSDZIwp>; Fri, 26 Apr 2002 04:52:45 -0400
Received: from c2ce9fba.adsl.oleane.fr ([194.206.159.186]:30582 "EHLO
	avalon.france.sdesigns.com") by vger.kernel.org with ESMTP
	id <S313716AbSDZIwo>; Fri, 26 Apr 2002 04:52:44 -0400
To: linux-kernel@vger.kernel.org
Subject: spinlocking between user context / tasklet / tophalf question
From: Emmanuel Michon <emmanuel_michon@realmagic.fr>
Date: 26 Apr 2002 10:52:33 +0200
Message-ID: <7wwuuu4zam.fsf@avalon.france.sdesigns.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I read various documents about spinlocks, including Linux device
drivers by A.Rubini 2nd edition, Unreliable guide to locking by P.R.Russel,
and the source code of mainly network device drivers.

I'm trying to achieve correct SMP synchronization on the Sigma Designs
EM84xx; this one involves an extra small hardware interrupt (let's call it tophalf),
only one tasklet scheduled at end of tophalf, and usual kernel side code of
ioctl() I call usercontext.

tophalf and tasklet are potentially writing the same data X

tasklet and usercontext are potentially writing the same data Y

So, my first guess was to use two spinlocks, X_lock and Y_lock, 

with

tophalf()
{
        spin_lock(&X_lock);
        write X
        spin_unlock(&X_lock);
}

tasklet()
{
        unsigned long flags;
        spin_lock_irqsave(&X_lock,flags);
        write X
        spin_lock(&Y_lock);
        write X, write Y
        spin_unlock(&Y_lock);
        write X
        spin_unlock_irqrestore(&X_lock,flags);
}

ioctl()
{
        spin_lock_bh(&Y_lock);
        write Y ... maybe copy_from_user/copy_to_user
        spin_unlock_bh(&Y_lock);
}

So far I get really hardcore freezes and I'm trying to handle this with kgdb

1. Should I use spin_lock(&Y_lock); or spin_lock_bh(&Y_lock); in the tasklet body?

2. What is the reality behind: ``things which sleep'', is it really a problem
to use copy_from_user/copy_to_user holding a spinlock?

3. Previous version used one semaphore to serialize usercontext access 
down_interruptible(&sem)/up(&sem)
and handle tasklet concurrency with:
down_trylock(&sem)/up(&sem)

That allowed to catch signals (^C) with the usual -ERESTARTSYS stuff. As
far as I understand, spinlocks allow the serialization but no way to interrupt
a dead system call --- should I keep the semaphore only for this purpose?

Sincerely yours,

-- 
Emmanuel Michon
Chef de projet
REALmagic France SAS
Mobile: 0614372733 GPGkeyID: D2997E42  
