Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135801AbRASVv6>; Fri, 19 Jan 2001 16:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136421AbRASVvt>; Fri, 19 Jan 2001 16:51:49 -0500
Received: from gateway.sequent.com ([192.148.1.10]:38810 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S135801AbRASVvo>; Fri, 19 Jan 2001 16:51:44 -0500
Date: Fri, 19 Jan 2001 13:51:35 -0800
From: Mike Kravetz <mkravetz@sequent.com>
To: Andrea Arcangeli <andrea@suse.de>,
        Davide Libenzi <davidel@xmail.virusscreen.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: multi-queue scheduler update
Message-ID: <20010119135135.H26968@w-mikek.des.sequent.com>
In-Reply-To: <20010118155311.B8637@w-mikek.des.sequent.com> <20010119012616.D32087@athlon.random> <20010118165225.E8637@w-mikek.des.sequent.com> <20010119023041.F32087@athlon.random> <20010118173435.K8637@w-mikek.des.sequent.com> <20010119124921.G26968@w-mikek.des.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010119124921.G26968@w-mikek.des.sequent.com>; from mkravetz@sequent.com on Fri, Jan 19, 2001 at 12:49:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2001 at 12:49:21PM -0800, Mike Kravetz showed his lack
of internet slang understanding and wrote:
> 
> It was my intention to post IIRC numbers for small thread counts today.
> However, the benchmark (not the system) seems to hang on occasion.  This
> occurs on both the unmodified 2.4.0 kernel and the one which contains
> my multi-queue patch.  Therefore, I'm pretty sure it is not something
> I did. :)
> 
> Anyone else see anything like this before?  I'll look into the reason
> for the hang, but it will delay my posting of these numbers.

I think I have found the problem.  Here is a code snippet from the
benchmark Andrea posted.

void            oneatwork(int thr)
{
    int             i;
    while (!start)              /* don't disturb pthread_create() */
        usleep(10000);                                                          

    actthreads++;
    while (!stop)
    {
        if (count)
            totalwork[thr]++;

        syscall(158); /* sys_sched_yield() */                                   
    }                                                                           
    actthreads--;                                                               
    pthread_exit(0);
}                                                                               

Note that actthreads is a global variable which is being updated
by multiple threads without any form of synchronization.  Because
of this actthreads sometimes never goes to zero after all worker
threads have finished.  I changed actthreads to be an atomic and
used atomic operations to manipulate it.  With this change, I was
able to complete one round of testing which I had not been able to
do in the past.

Does anyone maintain this benchmark code?  The changes I indicate
above should be made.  If you need more specifics I can provide
them.

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
