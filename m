Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310175AbSCETwr>; Tue, 5 Mar 2002 14:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310183AbSCETwi>; Tue, 5 Mar 2002 14:52:38 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:36347 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S310175AbSCETwZ>;
	Tue, 5 Mar 2002 14:52:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Rajan Ravindran" <rajancr@us.ibm.com>
Subject: Re: Fwd: [Lse-tech] get_pid() performance fix
Date: Tue, 5 Mar 2002 14:53:15 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
In-Reply-To: <OF810580E6.8672B341-ON85256B73.005AF9B8@pok.ibm.com> <873czeaodr.fsf@devron.myhome.or.jp>
In-Reply-To: <873czeaodr.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020305195211.144FC3FE0C@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 March 2002 12:57 pm, OGAWA Hirofumi wrote:
> "Rajan Ravindran" <rajancr@us.ibm.com> writes:
> > Yes, pid's are guaranteed to be unique.
> > Here the problem we focused is the time taken in finding the next
> > available free pid.
> > I really don't mean by your task->xxx.
>
> I'm confused.
>

yes you are .....

> I said:
> 	task { pid = 300, pgrp = 301, };
> 	301 is free;
>
> 	get_pid() returns 301.
>
> "task 301" can't call setsid(). pid 301 is available?

The original code is/was:

                        if(p->pid == last_pid   ||
                           p->pgrp == last_pid  ||
                           p->tgid == last_pid  ||
                           p->session == last_pid) {
                                if(++last_pid >= next_safe) {
                                        if(last_pid & 0xffff8000)
                                                last_pid = 300;
                                        next_safe = PID_MAX;
                                }
                                goto repeat;
                        }

if any process holds the pgrp=301 as in your case, 301 won't be eligible due 
to (p->pgrp == last_pid) check.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
