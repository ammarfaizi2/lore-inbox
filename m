Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313841AbSDJVON>; Wed, 10 Apr 2002 17:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313843AbSDJVOM>; Wed, 10 Apr 2002 17:14:12 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:46759 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313841AbSDJVOL>;
	Wed, 10 Apr 2002 17:14:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: "Bill Abt" <babt@us.ibm.com>
Subject: Re: [PATCH] Futex Generalization Patch
Date: Wed, 10 Apr 2002 16:14:36 -0400
X-Mailer: KMail [version 1.3.1]
Cc: drepper@redhat.com, linux-kernel@vger.kernel.org, Martin.Wirth@dlr.de,
        pwaechtler@loewe-Komp.de, Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <OF6ED1E5D5.39630DC3-ON85256B97.006D2F99@raleigh.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020410211348.AB5E93FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 April 2002 03:59 pm, Bill Abt wrote:
> On 04/10/2002 at 02:47:50 PM AST, Hubertus Franke <frankeh@watson.ibm.com>
>
> wrote:
> > The current interface is
> >
> > (A)
> > async wait:
> >    sys_futex (uaddr, FUTEX_AWAIT, value, (struct timespec*) sig);
> > upon signal handling
> >    sys_futex(uaddrs[], FUTEX_WAIT, size, NULL);
> >    to retrieve the uaddrs that got woken up...
>
> This is actually the preferred way.  I must've misinterpeted what you said
> earlier.  I believe this is actually a more generic way of handling.  A
> thread package can specify the signal to used much in the way the current
> LinuxThreads pre-allocates and uses certain real-time signals...
>
> > I am mainly concerned that SIGIO can be overloaded in a thread package ?
> > How would you know whether a SIGIO came from the futex or from other file
> >
> > handle.
>
> By keep with the original interface, we don't have to contend with this
> problem.  The thread package can use the signal that most suits its'
> implementation...
>
> Make sense?
>

I wasn't precise... 
There are ++ and -- for the file descriptors approach
++)
(a) it automatically cleans up the notify queue associated with the FD.
     [ notify queue could still be global, if we want that ]
     when the process disappears, no callback required in do_exit()
--) There is more overhead in the wakeup and the wait because I need to 
     move from the fd to the filestruct which is always some lookup and
     I have to verify that the file descriptor is actually a valid /dev/futex
     file (yikes).    

Another problem I see is that we only have one additional 
argument (void *utime) to piggyback the fd and the signal on. 

What could be done is the following.
Make utime a (void *utime) argument
In FUTEX_WAIT   interpret it as a pointer <struct timespec>
In FUTEX_AWAIT  inteprest it as { short fd, short sig };
There should be no limitation by casting it to shorts ?

Comments, anyone....

I suggest, we leave it as is right now until more comments come.

> Regards,
>       Bill Abt
>       Senior Software Engineer
>       Next Generation POSIX Threading for Linux
>       IBM Cambridge, MA, USA 02142
>       Ext: +(00)1 617-693-1591
>       T/L: 693-1591 (M/W/F)
>       T/L: 253-9938 (T/Th/Eves.)
>       Cell: +(00)1 617-803-7514
>       babt@us.ibm.com or abt@us.ibm.com
>       http://oss.software.ibm.com/developerworks/opensource/pthreads

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
