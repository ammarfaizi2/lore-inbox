Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288050AbSCEV6x>; Tue, 5 Mar 2002 16:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289606AbSCEV6g>; Tue, 5 Mar 2002 16:58:36 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:18583 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S288050AbSCEV61>;
	Tue, 5 Mar 2002 16:58:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: Fwd: [Lse-tech] get_pid() performance fix
Date: Tue, 5 Mar 2002 16:59:02 -0500
X-Mailer: KMail [version 1.3.1]
Cc: "Rajan Ravindran" <rajancr@us.ibm.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
In-Reply-To: <OF810580E6.8672B341-ON85256B73.005AF9B8@pok.ibm.com> <20020305195211.144FC3FE0C@smtp.linux.ibm.com> <87g03e3hdl.fsf@devron.myhome.or.jp>
In-Reply-To: <87g03e3hdl.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020305215759.21E623FFD3@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 March 2002 03:10 pm, OGAWA Hirofumi wrote:
> Hubertus Franke <frankeh@watson.ibm.com> writes:
> > > I said:
> > > 	task { pid = 300, pgrp = 301, };
> > > 	301 is free;
> > >
> > > 	get_pid() returns 301.
> > >
> > > "task 301" can't call setsid(). pid 301 is available?
> >
> > The original code is/was:
> >
> >                         if(p->pid == last_pid   ||
> >                            p->pgrp == last_pid  ||
> >                            p->tgid == last_pid  ||
> >                            p->session == last_pid) {
> >                                 if(++last_pid >= next_safe) {
> >                                         if(last_pid & 0xffff8000)
> >                                                 last_pid = 300;
> >                                         next_safe = PID_MAX;
> >                                 }
> >                                 goto repeat;
> >                         }
> >
> > if any process holds the pgrp=301 as in your case, 301 won't be eligible
> > due to (p->pgrp == last_pid) check.
>
> I know.
>
> > @@ -153,13 +155,18 @@
> >                               if(last_pid & 0xffff8000)
> >                                     last_pid = 300;
> >                               next_safe = PID_MAX;
> > +                             goto repeat;
> >                         }
> > -                       goto repeat;
> > +                       if(unlikely(last_pid == beginpid))
> > +                             goto nomorepids;
> > +                       continue;
>
> You changed it. No?

Yes, we changed but only the logic that once a pid is busy we start searching 
for every task again. This is exactly the O(n**2) problem.
Run the program and you'll see.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
