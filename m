Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264638AbSJTUI5>; Sun, 20 Oct 2002 16:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264639AbSJTUI5>; Sun, 20 Oct 2002 16:08:57 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:52469 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S264638AbSJTUI4>;
	Sun, 20 Oct 2002 16:08:56 -0400
Message-ID: <3DB30EB0.EB5C91B1@mvista.com>
Date: Sun, 20 Oct 2002 13:14:40 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH ] POSIX clocks & timers take 3 (NOT HIGH RES)
References: <3DAF4362.EE87F7F1@mvista.com> <20021021015050.21dbd4d9.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:
> 
> Hi George,
> 
> On Thu, 17 Oct 2002 16:10:26 -0700 george anzinger <george@mvista.com> wrote:
> >
> > +++ linux/include/asm-generic/siginfo.h       Thu Oct 17 15:33:39 2002
> > @@ -43,8 +43,9 @@
> >
> >               /* POSIX.1b timers */
> >               struct {
> > -                     unsigned int _timer1;
> > -                     unsigned int _timer2;
> > +                     timer_t _tid;           /* timer id */
> > +                     int _overrun;           /* overrun count */
> > +                     sigval_t _sigval;       /* same as below */
> >               } _timer;
> 
> This, of course, will only work on architectures where (sizeof(timer_t) +
> sizeof(int) + alignment padding for sigval_t) is the same as
> (sizeof(pid_t) + sizeof(uid_t) + alignment padding for sigval_t). Which is
> true as far as I can see, but is fragile.  It might be worth a comment.

Hm..., yes, but I would rather express such things as
something that will cause the compiler to complain (i.e.
stop, not just warn).  Possibly something like:

static int
dummy[sizeof(timer_t)+sizeof(int)-sizeof(pid_t)-sizeof(uid_t)];
static int
dummy2[sizeof(pid_t)+sizeof(uid_t)-sizeof(timer_t)-sizeof(int)-];

It is UGLY, but it does cause the right thing (i.e. a
failure) to happen when things are wrong.

Or we could do the same sort of thing on the offset of
_sigval in the several unions, which is what we really care
about.

Thanks for the comments.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
