Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319038AbSH1Xtx>; Wed, 28 Aug 2002 19:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319039AbSH1Xtx>; Wed, 28 Aug 2002 19:49:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4112 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319038AbSH1Xtx>;
	Wed, 28 Aug 2002 19:49:53 -0400
Message-ID: <3D6D6558.B2CE77B6@zip.com.au>
Date: Wed, 28 Aug 2002 17:05:44 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] mysterious tty deadlock
References: <20020828220114.GA878@holomorphy.com> <3D6D4DD0.1900B894@zip.com.au> <20020829002103.B28455@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> ...
> > --- 2.5.32/drivers/serial/core.c~serial-race  Wed Aug 28 15:22:22 2002
> > +++ 2.5.32-akpm/drivers/serial/core.c Wed Aug 28 15:22:26 2002
> > @@ -1315,13 +1315,14 @@ static void uart_wait_until_sent(struct
> >        * 'timeout' / 'expire' give us the maximum amount of time
> >        * we wait.
> >        */
> > +     set_current_state(TASK_INTERRUPTIBLE);
> >       while (!port->ops->tx_empty(port)) {
> > -             set_current_state(TASK_INTERRUPTIBLE);
> >               schedule_timeout(char_time);
> >               if (signal_pending(current))
> >                       break;
> >               if (time_after(jiffies, expire))
> >                       break;
> > +             set_current_state(TASK_INTERRUPTIBLE);
> >       }
> >       set_current_state(TASK_RUNNING); /* might not be needed */
> >  }
> 
> Patch looks good, as far as correctness goes.  However, since char_time
> will be the amount of time for one character, we should never sleep long
> enough for the user to notice this slip-up.
> 
> If people are seeing deadlocks, I agree with wli that there's something
> very wrong elsewhere.

Well Bill's trace is claiming that we're doing a schedule_timeout(0x7fffffff)
for some reason.

But yes, he seems to be able to hit it too frequently for this to be
the cause.
