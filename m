Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310384AbSCBOI2>; Sat, 2 Mar 2002 09:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310381AbSCBOIT>; Sat, 2 Mar 2002 09:08:19 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:63455 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S310384AbSCBOIJ>;
	Sat, 2 Mar 2002 09:08:09 -0500
Date: Sat, 2 Mar 2002 09:08:56 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Martin Wirth <martin.wirth@dlr.de>
Cc: rusty@rustycorp.com.au, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] Lightweight userspace semaphores...
Message-ID: <20020302090856.A1332@elinux01.watson.ibm.com>
In-Reply-To: <3C7C9C41.5080400@dlr.de> <20020227102446.A838@elinux01.watson.ibm.com> <3C7D14B5.1020702@dlr.de> <20020227140441.A1573@elinux01.watson.ibm.com> <3C7FDF76.9040903@dlr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7FDF76.9040903@dlr.de>; from martin.wirth@dlr.de on Fri, Mar 01, 2002 at 09:07:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 09:07:18PM +0100, Martin Wirth wrote:
> 
> 
> Hubertus Franke Worte:
> 
> >
> >So, it works and is correct. Hope that clarifies it, if not let me know.
> >Interestingly enough. This scheme doesn't work for spinning locks.
> >Goto lib/ulocks.c[91-133], I have integrated this dead code here
> >to show how not to do it. A similar analysis as above shows
> >that this approach wouldn't work. You need cmpxchg for these scenarios
> >(more or less).
> >
> 
> You are right, I falsely assumed the initial state to be [1,1].
> 
> But as mentioned in your README, your approach is currently is not able 
> to manage signal handling correctly.
> You have to ignore all non-fatal signals by using ESYSRESTART and a 
> SIG_KILL sent to one of the processes
> may corrupt your user-kernel-syncronisation. 
> 
> I don't think a user space semaphore implementation is acceptable until 
> it provides (signal-) interruptability and
> timeouts. But maybe you have some idea how to manage this.
> 
> Martin Wirth
> 
>  

As of the signal handling and ESYSRESTART.
The user code on the slow path can check for return code and
has two choices (a) reenter the kernel and wait or (b) correct the
status word, because its still counted as a waiting process and return
0. I have chosen (a) and I automated it.
I have tried to send signals (e.g. SIGIO) and it 
seems to work fine. The signal is handled in user space and returns back
to the kernel section. (b) is feasible but a requires a bit more exception
work in the routine.
As of the corruption case. There is flatout (almost) nothing you can do.
For instance, if a process graps the locks and exits, then another process
tries to acquire it you got a deadlock. At the least on the mailing list
most people feel that you are dead in the water anyway.

I have been thinking about the problem of corruption.
The owner of the lock could register its pid in the lock aread (2nd word).
That still leaves non-atomic windows open and is a half-ass solution.

But more conceptually, if you process dies while holding a lock that protects
some shared data, there is no guarantee that you can make about the data
itself if the updating process dies. In that kind of scenario, why
trying to continue as if nothing happened. 
It seems the general consent on the list is that your app is toast at that
point.


-- Hubertus

