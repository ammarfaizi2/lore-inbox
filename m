Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267405AbTALTLq>; Sun, 12 Jan 2003 14:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267406AbTALTLq>; Sun, 12 Jan 2003 14:11:46 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23571 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267405AbTALTLp>; Sun, 12 Jan 2003 14:11:45 -0500
Date: Sun, 12 Jan 2003 11:15:52 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
In-Reply-To: <20030112171744.A11040@infradead.org>
Message-ID: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 12 Jan 2003, Christoph Hellwig wrote:
> 
> 2.5 does hold the BKL on ->open of charater- (and block-) devices.

Ahh, my bad.

> The real problem is that the big irqlock is gone and mingo just replaced
> it with local_irq_save & friends, which is not enough.

Ok, most of them should be fixable with a simple spinlock approach.

If the recursion is too nasty to handle, we could make some tty-specific 
recursive spinlock as a stop-gap measure, and mark it as being destined 
for the garbage-heap in 2.7.x:

	/*
	 * This isn't even _trying_ to be fast!
	 */
	struct recursive_spinlock {
		spinlock_t lock;
		int lock_count;
		struct task_struct *lock_owner;
	};

	static struct recursive_spinlock tty_lock = {
		.lock = SPIN_LOCK_UNLOCKED,
		.lock_count = 0,
		.lock_owner = NULL
	};

	unsigned long tty_spin_lock(void)
	{
		unsigned long flags;
		struct task_struct *tsk;

		local_irq_save(flags);
		preempt_disable();
		tsk = current;
		if (spin_trylock(&tty_lock.lock))
			goto got_lock;
		if (tsk == tty_lock.lock_owner) {
			WARN_ON(!tty_lock.lock_count);
			tty_lock.lock_count++;
			return flags;
		}
		spin_lock(&tty_lock.lock);
	got_lock:
		WARN_ON(tty_lock.lock_owner);
		WARN_ON(tty_lock.lock_count);
		tty_lock.lock_owner = tsk;
		tty_lock.lock_count = 1;
		return flags;
	}

	void tty_spin_unlock(unsigned long flags)
	{
		WARN_ON(tty_lock.lock_owner != current);
		WARN_ON(!tty_lock.lock_count);
		if (!--tty_lock.lock_count) {
			tty_lock.lock_owner = NULL;
			spin_unlock(&tty_lock.lock);
		}
		preempt_enable();
		local_irq_restore(flags);
	}

and be done with it.

Anybody willing to test it and see if the above works? 

			Linus

