Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313865AbSDPUDf>; Tue, 16 Apr 2002 16:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313867AbSDPUDf>; Tue, 16 Apr 2002 16:03:35 -0400
Received: from dialin-145-254-145-010.arcor-ip.net ([145.254.145.10]:52488
	"EHLO picklock.adams.family") by vger.kernel.org with ESMTP
	id <S313865AbSDPUDd>; Tue, 16 Apr 2002 16:03:33 -0400
Message-ID: <3CBC837E.2633533D@loewe-komp.de>
Date: Tue, 16 Apr 2002 22:03:10 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: B16
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: frankeh@watson.ibm.com
CC: Bill Abt <babt@us.ibm.com>, drepper@redhat.com,
        linux-kernel@vger.kernel.org, Martin.Wirth@dlr.de,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Futex Generalization Patch
In-Reply-To: <OF24E0B753.2B92A422-ON85256B9C.00512368@raleigh.ibm.com> <20020415172204.4B6073FE08@smtp.linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke wrote:
> 
> On Monday 15 April 2002 10:49 am, Bill Abt wrote:
> > Dealing with the realtime signal is not a problem.  Also, saving the extra
> > system call is *BIG* bonus.
> >
> 
> Cool
> 
> As of Peter's initial message. I took a look at the siginfo_t and Peter's
> statement needs to be corrected "a bit".
> All the members he listed are NOT necessarily available.
> 

Well, then we do not comply to susv2. But that's not so bad.

But what we need is there:

typedef union sigval {
	int sival_int;
	void *sival_ptr;
} sigval_t;
[...]
>                 /* POSIX.1b signals */
>                 struct {
>                         pid_t _pid;             /* sender's pid */
>                         uid_t _uid;             /* sender's uid */
>                         sigval_t _sigval;
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                 } _rt;
> 
>         } _sifields;
> } siginfo_t;
> 
> I'd suggest we tag along the _sigfault semantics.
> We don't need to know who woke us up, just which <addr> got signalled.
> 

Please not, this would be confusing.

we can add our si_code and our own struct to the union as suggested
by Mark and me.



--- /usr/local/src/linux-2.5.7/include/asm-i386/siginfo.h ---
/*
 * si_code values
 * Digital reserves positive values for kernel-generated signals.
 */
#define SI_USER		0		/* sent by kill, sigsend, raise */
#define SI_KERNEL	0x80		/* sent by the kernel from somewhere */
#define SI_QUEUE	-1		/* sent by sigqueue */
#define SI_TIMER __SI_CODE(__SI_TIMER,-2) /* sent by timer expiration */
#define SI_MESGQ	-3		/* sent by real time mesq state change */
#define SI_ASYNCIO	-4		/* sent by AIO completion */
#define SI_SIGIO	-5		/* sent by queued SIGIO */
#define SI_TKILL	-6		/* sent by tkill system call */
#define SI_DETHREAD	-7		/* sent by execve() killing subsidiary threads */
--- snip ---
