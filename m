Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130317AbRCWXyH>; Fri, 23 Mar 2001 18:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129529AbRCWXx5>; Fri, 23 Mar 2001 18:53:57 -0500
Received: from nrg.org ([216.101.165.106]:7010 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S131524AbRCWXxn>;
	Fri, 23 Mar 2001 18:53:43 -0500
Date: Fri, 23 Mar 2001 15:52:54 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Stelian Pop <stelian.pop@fr.alcove.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Use semaphore for producer/consumer case...
In-Reply-To: <20010323130722.A8916@come.alcove-fr>
Message-ID: <Pine.LNX.4.05.10103231541010.6461-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001, Stelian Pop wrote:
> I want to use a semaphore for the classic producer/consumer case
> (put the consumer to wait until X items are produced, where X != 1).
> 
> If X is 1, the semaphore is a simple MUTEX, ok.
> 
> But if the consumer wants to wait for several items, it doesn't
> seem to work (or something is bad in my code).
> 
> What is wrong in the following ?
> 
> 	DECLARE_MUTEX(sem);

For the producer/consumer case, you want to initialize the semaphore to
0, not 1 which DECLARE_MUTEX(sem) does.  So I would use

__DECLARE_SEMAPHORE_GENERIC(sem, 0)

The count is then the number of items produced but not yet consumed.

> 	producer() {
> 		/* One item produced */
> 		up(&sem);
> 	}
> 	
> 	consumer() {
> 		/* Let's wait for 10 items */
> 		atomic_set(&sem->count, -10);
> 	
> 		/* This starts the producers, they will call producer()
> 		   some time in the future */
> 		start_producers();
> 	
> 		/* Wait for completion */
> 		down(&sem);
> 	}

Then consumer could be:

	consumer()
	{
		int i;

		start_producers();

		/* Wait for 10 items to be produced */
		for (i = 0; i < 10; i++)
			down(&sem);
	}


Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com

