Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263767AbTLTQts (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 11:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263809AbTLTQts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 11:49:48 -0500
Received: from port-212-202-159-243.reverse.qsc.de ([212.202.159.243]:8066
	"EHLO mail.onestepahead.de") by vger.kernel.org with ESMTP
	id S263767AbTLTQtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 11:49:46 -0500
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
From: Christian Meder <chris@onestepahead.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031220111917.GA18267@elte.hu>
References: <1071864709.1044.172.camel@localhost>
	 <1071885178.1044.227.camel@localhost> <3FE3B61C.4070204@cyberone.com.au>
	 <200312201355.08116.kernel@kolivas.org>
	 <1071891168.1044.256.camel@localhost> <3FE3C6FC.7050401@cyberone.com.au>
	 <1071893802.1363.21.camel@localhost> <3FE3D0CB.603@cyberone.com.au>
	 <1071897314.1363.43.camel@localhost>  <20031220111917.GA18267@elte.hu>
Content-Type: text/plain
Message-Id: <1071938978.1025.48.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 20 Dec 2003 17:49:39 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-12-20 at 12:19, Ingo Molnar wrote:
> * Christian Meder <chris@onestepahead.de> wrote:
> 
> > That would leave me with two possibilities: 2.6. is doing something
> > different in the gnomemeeting case or gnomemeeting is doing something
> > different in the 2.6 case. A cursory look at the gnomemeeting sources
> > didn't give me the impression that it's doing anything which would be
> > affected by 2.6 deployment but I'll ask on the gnomemeeting-devel list
> > for advice.
> 
> yep, i've looked at the source too and it doesnt do anything that 
> changed in 2.6 from an interactivity POV.

Stefan Bruens pointed out on the gnomemeeting-devel list that pwlib
which gnomemeeting is using executes sched_yield and that perhaps there
is a problem akin to the openoffice busy-loop on sched_yield() problem
earlier this year. I found the following sched_yield code in pwlib 1.5.2
in src/ptlib/unix/tlibthrd.cxx:


> static BOOL PAssertThreadOp(int retval,
>                             unsigned & retry,
>                             const char * funcname,
>                             const char * file,
>                             unsigned line)
> {
>   if (retval == 0) {
>     PTRACE_IF(2, retry > 0, "PWLib\t" << funcname << " required " << retry << "
> retries!");
>     return FALSE;
>   }
>                                                                                 
>   if (errno == EINTR || errno == EAGAIN) {
>     if (++retry < 1000) {
> #if defined(P_RTEMS)
>       sched_yield();
> #else
>       usleep(10000); // Basically just swap out thread to try and clear blockage
> #endif
>       return TRUE;   // Return value to try again
>     }
>     // Give up and assert
>   }
>                                                                                 
>   PAssertFunc(file, line, NULL, psprintf("Function %s failed", funcname));
>   return FALSE;
> }

Is this obviously broken for 2.6 usage ?


			Christian

-- 
Christian Meder, email: chris@onestepahead.de
 
What's the railroad to me ?
I never go to see
Where it ends.
It fills a few hollows,
And makes banks for the swallows, 
It sets the sand a-blowing,
And the blackberries a-growing.
                      (Henry David Thoreau)
 




