Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267265AbSLEHEl>; Thu, 5 Dec 2002 02:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267266AbSLEHEl>; Thu, 5 Dec 2002 02:04:41 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:34043 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S267265AbSLEHEk>;
	Thu, 5 Dec 2002 02:04:40 -0500
Message-ID: <3DEEFBE7.A1B2A28E@mvista.com>
Date: Wed, 04 Dec 2002 23:10:31 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jim Houston <jim.houston@ccur.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
References: <Pine.LNX.4.44.0212042009340.11869-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 4 Dec 2002, george anzinger wrote:
> >
> > Once it changes the system call (eax, right), could the new
> > call code then just get the parms from the restart_block.
> 
> Agreed.
> 
> > I think it would be best to keep this as generic as
> > possible, i.e. let the new call code fetch its own
> > paramerers from the restart_block.
> 
> We could even have one _single_ a generic "restart" system call, and have
> the function pointer for that be in the restart block.

I think what you mean is that, if there is a
restart_function (i.e. the block is set up) and the return
is -ERESTART_RESTARTBLOCK, then change eax (x86 ) to call
sys_restart which would in turn call the function in the
restart_block.

One of the problems with this is the way parameters are
passed to system calls.  One way to do this would be to have
sys_restart branch to the restart_function (requires asm). 
Another way is to just pass a struct pointer (actually the
reg struct) which the restart function could sort out.  For
example for nano_sleep:

int sys_restart(struct void parms)
{
	return (current->restart_block.sys_call) (&parms);

}
Then:
struct nano_sleep_call{
	struct timespec *tp;
	struct timespec *rem;
}
int restart_nano_sleep(struct nano_sleep_call *parm)
> 
> > My question is who sets up these values?  I think you are
> > saying it should be the system call.  Is this right?
> 
> Whatever system call that return -ERESTART_RESTARTBLOCK, yes.
> 
> So it would never get set up at all in the fast path. Only in the error
> case path of a system call that wants to have restarting capabilities.

And then only when returning -ERESTART_RESTARTBLOCK.
> 
>                 Linus
> 
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
