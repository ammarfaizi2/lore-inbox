Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265407AbRGEPWs>; Thu, 5 Jul 2001 11:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265410AbRGEPWi>; Thu, 5 Jul 2001 11:22:38 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:46469 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S265407AbRGEPWa>; Thu, 5 Jul 2001 11:22:30 -0400
Message-ID: <3B448684.8355DB69@uow.edu.au>
Date: Fri, 06 Jul 2001 01:23:48 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Manfred H. Winter" <mahowi@gmx.net>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
In-Reply-To: <3B4450DF.82EEC851@uow.edu.au> <20010705162812.A602@marvin.mahowi.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Manfred H. Winter" wrote:
> 
> ...
> > --- linux-2.4.6/kernel/softirq.c      Wed Jul  4 18:21:32 2001
> > +++ lk-ext3/kernel/softirq.c  Thu Jul  5 21:32:08 2001
> > @@ -202,8 +202,10 @@ static void tasklet_hi_action(struct sof
> >               if (!tasklet_trylock(t))
> >                       BUG();
> >  repeat:
> > -             if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
> > +             if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state)) {
> > +                     printk("func: %p\n", t->func);
> >                       BUG();
> > +             }
> >               if (!atomic_read(&t->count)) {
> >                       local_irq_enable();
> >                       t->func(t->data);
> >
> 
> Okay, here's the output of gdb:
> 
> (gdb) x/10i 0xc0118028
> 0xc0118028 <bh_action>: mov    0x4(%esp,1),%eax
> 0xc011802c <bh_action+4>:       cmpl   $0x0,0xc025c2e4
> 0xc0118033 <bh_action+11>:      jne    0xc0118043 <bh_action+27>
> 0xc0118035 <bh_action+13>:      mov    0xc024af20(,%eax,4),%eax
> 0xc011803c <bh_action+20>:      test   %eax,%eax
> 0xc011803e <bh_action+22>:      je     0xc0118042 <bh_action+26>
> 0xc0118040 <bh_action+24>:      call   *%eax
> 0xc0118042 <bh_action+26>:      ret
> 0xc0118043 <bh_action+27>:      lea    (%eax,%eax,4),%eax
> 0xc0118046 <bh_action+30>:      lea    0xc025bf80(,%eax,4),%eax
> 

Well I guess it tells us it's not random uninitialised
crud.

Just for interest: what happens if you swap around the lines

        time_init();
        softirq_init();

in init/main.c?

-
