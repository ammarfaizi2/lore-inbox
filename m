Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310183AbSCEULa>; Tue, 5 Mar 2002 15:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310186AbSCEULV>; Tue, 5 Mar 2002 15:11:21 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:53511 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S310183AbSCEULK>; Tue, 5 Mar 2002 15:11:10 -0500
To: frankeh@watson.ibm.com
Cc: "Rajan Ravindran" <rajancr@us.ibm.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: Fwd: [Lse-tech] get_pid() performance fix
In-Reply-To: <OF810580E6.8672B341-ON85256B73.005AF9B8@pok.ibm.com>
	<873czeaodr.fsf@devron.myhome.or.jp>
	<20020305195211.144FC3FE0C@smtp.linux.ibm.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 06 Mar 2002 05:10:46 +0900
In-Reply-To: <20020305195211.144FC3FE0C@smtp.linux.ibm.com>
Message-ID: <87g03e3hdl.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke <frankeh@watson.ibm.com> writes:

> > I said:
> > 	task { pid = 300, pgrp = 301, };
> > 	301 is free;
> >
> > 	get_pid() returns 301.
> >
> > "task 301" can't call setsid(). pid 301 is available?
> 
> The original code is/was:
> 
>                         if(p->pid == last_pid   ||
>                            p->pgrp == last_pid  ||
>                            p->tgid == last_pid  ||
>                            p->session == last_pid) {
>                                 if(++last_pid >= next_safe) {
>                                         if(last_pid & 0xffff8000)
>                                                 last_pid = 300;
>                                         next_safe = PID_MAX;
>                                 }
>                                 goto repeat;
>                         }
> 
> if any process holds the pgrp=301 as in your case, 301 won't be eligible due 
> to (p->pgrp == last_pid) check.

I know.

> @@ -153,13 +155,18 @@
>                               if(last_pid & 0xffff8000)
>                                     last_pid = 300;
>                               next_safe = PID_MAX;
> +                             goto repeat;
>                         }
> -                       goto repeat;
> +                       if(unlikely(last_pid == beginpid))
> +                             goto nomorepids;
> +                       continue;

You changed it. No?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
