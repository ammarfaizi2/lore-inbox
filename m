Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131221AbQLVH7H>; Fri, 22 Dec 2000 02:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131851AbQLVH65>; Fri, 22 Dec 2000 02:58:57 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:33163 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131221AbQLVH6r>; Fri, 22 Dec 2000 02:58:47 -0500
Message-ID: <3A4303AC.C635F671@uow.edu.au>
Date: Fri, 22 Dec 2000 18:33:00 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.2.19pre2
In-Reply-To: <E147MkJ-00036t-00@the-village.bc.nu>, <E147MkJ-00036t-00@the-village.bc.nu>; <20001220142858.A7381@athlon.random> <3A40C8CB.D063E337@uow.edu.au>, <3A40C8CB.D063E337@uow.edu.au>; <20001220162456.G7381@athlon.random> <3A41DDB3.7E38AC7@uow.edu.au>,
		<3A41DDB3.7E38AC7@uow.edu.au>; from andrewm@uow.edu.au on Thu, Dec 21, 2000 at 09:38:43PM +1100 <20001221161952.B20843@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> > > Other thing about your patch, adding TASK_EXCLUSIVE to
> > > wake_up/wake_up_interruptible is useless.
> >
> > This enables wake_up_all().
> 
> It is useless as it is in 2.2.19pre2: there's no wake_up_all in 2.2.19pre2.

#define wake_up_all(x) __wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE)

> > Anyway, this is all just noise.
> >
> > The key question is: which of the following do we want?
> >
> > a) A simple, specific accept()-accelerator, and 2.2 remains without
> >    an exclusive wq API or
> 
> To make the accellerator we need a minimal wake-one support. So a) doesn't
> make sense to me.

It makes heaps of sense.  We've introduced into 2.2 an API
which has the same appearance as one in 2.4, but which is
subtly broken wrt the 2.4 one.

I suggest you change the names to something other than
add_waitqueue_exclusive() and TASK_EXCLUSIVE, add a
cautionary comment and then go ahead with your patch.

Except for this bit, which looks slightly fatal:

	/*
         * We can drop the read-lock early if this
         * is the only/last process.
         */
        if (next == head) {
                 read_unlock(&waitqueue_lock);
                 wake_up_process(p);
                 goto out;
        }

Once the waitqueue_lock has been dropped, the task at `p'
is free to remove itself from the waitqueue and exit.  This
CPU can then try to wake up a non-existent task, no?

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
