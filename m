Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136901AbRASWCi>; Fri, 19 Jan 2001 17:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136899AbRASWC3>; Fri, 19 Jan 2001 17:02:29 -0500
Received: from dns-229.dhcp-248.nai.com ([161.69.248.229]:37348 "HELO
	localdomain") by vger.kernel.org with SMTP id <S136896AbRASWCU>;
	Fri, 19 Jan 2001 17:02:20 -0500
From: Davide Libenzi <davidel@xmail.virusscreen.com>
Organization: myCIO.com
Date: Fri, 19 Jan 2001 14:03:06 -0800
X-Mailer: KMail [version 1.1.95.5]
Content-Type: text/plain;
  charset="us-ascii"
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
To: Mike Kravetz <mkravetz@sequent.com>, Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <20010118155311.B8637@w-mikek.des.sequent.com> <20010119124921.G26968@w-mikek.des.sequent.com> <20010119135135.H26968@w-mikek.des.sequent.com>
In-Reply-To: <20010119135135.H26968@w-mikek.des.sequent.com>
Subject: Re: [Lse-tech] Re: multi-queue scheduler update
MIME-Version: 1.0
Message-Id: <01011914030601.01005@ewok.dev.mycio.com>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 January 2001 13:59, Mike Kravetz wrote:
> On Fri, Jan 19, 2001 at 12:49:21PM -0800, Mike Kravetz showed his lack
>
> of internet slang understanding and wrote:
> > It was my intention to post IIRC numbers for small thread counts today.
> > However, the benchmark (not the system) seems to hang on occasion.  This
> > occurs on both the unmodified 2.4.0 kernel and the one which contains
> > my multi-queue patch.  Therefore, I'm pretty sure it is not something
> > I did. :)
> >
> > Anyone else see anything like this before?  I'll look into the reason
> > for the hang, but it will delay my posting of these numbers.
>
> I think I have found the problem.  Here is a code snippet from the
> benchmark Andrea posted.
>
> void            oneatwork(int thr)
> {
>     int             i;
>     while (!start)              /* don't disturb pthread_create() */
>         usleep(10000);
>
>     actthreads++;
>     while (!stop)
>     {
>         if (count)
>             totalwork[thr]++;
>
>         syscall(158); /* sys_sched_yield() */
>     }
>     actthreads--;
>     pthread_exit(0);
> }
>
> Note that actthreads is a global variable which is being updated
> by multiple threads without any form of synchronization.  Because
> of this actthreads sometimes never goes to zero after all worker
> threads have finished. 

If all threads complete successfully actthreads has to be zero.
If some thread dies, this won't be true.



- Davide
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
