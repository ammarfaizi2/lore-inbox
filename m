Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131538AbQLVBoh>; Thu, 21 Dec 2000 20:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131558AbQLVBo1>; Thu, 21 Dec 2000 20:44:27 -0500
Received: from hermes.mixx.net ([212.84.196.2]:57616 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S131538AbQLVBoV>;
	Thu, 21 Dec 2000 20:44:21 -0500
Message-ID: <3A42AA60.80FA07F7@innominate.de>
Date: Fri, 22 Dec 2000 02:12:00 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Cassella <pwc@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Semaphores used for daemon wakeup
In-Reply-To: <3A42380B.6E9291D1@sgi.com> <Pine.SGI.3.96.1001221130859.8463C-100000@fsgi626.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Cassella wrote:
> > int atomic_read_and_clear(atomic_t *p)
> > {
> >         int n = atomic_read(p);
> >         atomic_sub(p, n);
> >         return n;
> > }
> 
> I don't think this will work; consider two callers doing the atomic_read()
> at the same time, or someone else doing an atomic_dec() after the
> atomic_read().

Oh yes, mea culpa, this is a terrible primitive, yet it works for this
application.  1) We don't have two callers 2) We only have atomic_inc
from the other processes, and it's ok for the atomic_inc to occur after
the atomic_read because that means the atomic_inc'er will then proceed
to up() the atomic_sub'ers semaphore, and it won't block.

I much preferred my original waiters = xchg(&sem.count, 0), but as noted
it doesn't work with sparc.  A satisfying approach would be to create
the new primitive up_down, which simplifies everything dramatically.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
