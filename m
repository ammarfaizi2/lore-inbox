Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbQL0RT2>; Wed, 27 Dec 2000 12:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129428AbQL0RTR>; Wed, 27 Dec 2000 12:19:17 -0500
Received: from jalon.able.es ([212.97.163.2]:6339 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129401AbQL0RTN>;
	Wed, 27 Dec 2000 12:19:13 -0500
Date: Wed, 27 Dec 2000 17:48:21 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Semaphores slow???
Message-ID: <20001227174821.C1038@werewolf.able.es>
In-Reply-To: <20001227162655.A783@werewolf.able.es> <200012271545.QAA18971@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200012271545.QAA18971@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Wed, Dec 27, 2000 at 16:45:29 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2000.12.27 Rogier Wolff wrote:
> J . A . Magallon wrote:
> 
> You missed that we push the bs 1000 times before we allow the producer
> to start. 
> 

Lets rename
write_buffer_sem == holes
write_sem == items

So:
producer:
        while (1) {
		// Wait a hole
                sem_wait (&holes);
                ... 
		// Signal we posted an item
                sem_post (&items);
        } 
consumer:
        for (i=0;i<1000;i++)
                sem_post (&holes);
	/* OK, you have 1000 holes fo fill */
        while (1) {
		// Wait an item
                sem_wait (&items);
                ...
		// Say we left a hole
                sem_post (&holes);
        }

So you have a finite FIFO of size N, empty at start. There will be 
a short transient state when:
- if producer is faster, queue fills; consumer is 'free-run'-alike,
  there is always something to eat, but producer blocks him.
- if consumer is faster, queue exhausts and it runs as if queue size
  was 1. There is always hole for a new item, but consumer has to wait
  a full producer loop to get an item.
And you end up in the case of the previous post.

You don't have to keep the queue blocked while you work on items.
Try something like:
producer:
        while (1) {
		... (prepare item)
			(and consumer can read items at the same time)
		// Wait a hole
                sem_wait (&holes);
			put item
		// Signal we posted an item
                sem_post (&items);
        } 
consumer:
        for (i=0;i<1000;i++)
                sem_post (&holes);
	/* OK, you have 1000 holes fo fill */
        while (1) {
		// Wait an item
                sem_wait (&items);
			get item
		// Say we left a hole
                sem_post (&holes);
                ... (use item)
			(and producer can insert items at the same time)
       }


-- 
J.A. Magallon                                         $> cd pub
mailto:jamagallon@able.es                             $> more beer

Linux werewolf 2.2.19-pre3-aa3 #3 SMP Wed Dec 27 10:25:32 CET 2000 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
