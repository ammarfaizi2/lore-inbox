Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317408AbSFCQED>; Mon, 3 Jun 2002 12:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317409AbSFCQEC>; Mon, 3 Jun 2002 12:04:02 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:52653 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317408AbSFCQEA>; Mon, 3 Jun 2002 12:04:00 -0400
Date: Mon, 3 Jun 2002 09:03:28 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, icollinson@imerge.co.uk, andrea@suse.de
Subject: Re: realtime scheduling problems with 2.4 linux kernel >= 2.4.10
Message-ID: <20020603090328.A1581@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <C0D45ABB3F45D5118BBC00508BC292DB09C992@imgserv04> <20020531112847.B1529@w-mikek2.des.beaverton.ibm.com> <m37kljkjys.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 01, 2002 at 07:05:47PM +0200, Andi Kleen wrote:
> Mike Kravetz <kravetz@us.ibm.com> writes:
> 
> > This works fine for me on 2.4.17 with a SERIAL console.  Could this
> > be related to some differences (new features) in the VGA console?
> > I am totally ignorant of how the consoles work.
> 
> One possibility is that something relies on schedule_task() - keventd
> doesn't run with realtime priority and can be starved.
> 
> Seems to be the case indeed: 
> 
> /usr/src/linux/drivers/char% grep schedule_task *.c
> console.c:      schedule_task(&console_callback_tq);
> ...
> 
> the console switch does.

Thanks Andi!

Part of the 'problem' is the following in the 'sched_setscheduler'
man page.

"      As  a  non-blocking  end-less  loop in a process scheduled
       under SCHED_FIFO or SCHED_RR will block all processes with
       lower priority forever, a software developer should always
       keep available on the console a shell  scheduled  under  a
       higher  static  priority than the tested application. This
       will allow an emergency kill of tested real-time  applica­
       tions  that  do  not  block  or  terminate as expected. As
       SCHED_FIFO and SCHED_RR processes can preempt  other  pro­
       cesses  forever,  only root processes are allowed to acti­
       vate these policies under Linux.
"

Seems that this tells people to leave a high priority real-
time shell running on the console.  However, if one can not
get to the console, then there is no point in leaving a high
priority shell running there.  Part of the problem may be
in the definition of 'console'.  Different console implementations
behave differently.

Is this something we should 'fix'?  I would envision a 'solution'
for each console implementation.  OR we could remove the above
from the man page. :)

Comments?
-- 
Mike
