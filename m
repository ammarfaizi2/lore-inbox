Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267534AbRGSLQM>; Thu, 19 Jul 2001 07:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267535AbRGSLQC>; Thu, 19 Jul 2001 07:16:02 -0400
Received: from over.ny.us.ibm.com ([32.97.182.111]:18657 "EHLO
	over.ny.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267534AbRGSLPv>; Thu, 19 Jul 2001 07:15:51 -0400
Importance: Normal
Subject: Re: [Lse-tech] Re: CPU affinity & IPI latency (FIX)_
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF592B2674.D77BFDC0-ON85256A8C.00649982@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Tue, 17 Jul 2001 14:28:52 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 07/17/2001 02:27:53 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



This only applies only to the idle thread and it says that the idle
thread actively monitors its need_resched flag and hence will
instantly call schedule() at that point. Hence there won't be any
delay either for IPI or for waiting to return from the kernel.

You might be right that the problem situation still arises, because
the idle_thread needs to content again for the lock.
Let me ask the otherway around, why do we HAVE to put it in ?
And if I missed something here, we put it outside the <if> clause.


Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



Davide Libenzi <davidel@xmailserver.org>@lists.sourceforge.net on
07/17/2001 02:11:55 PM

Sent by:  lse-tech-admin@lists.sourceforge.net


To:   Hubertus Frnake <frankeh@watson.ibm.com>
cc:   linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
      ak@suse.de
Subject:  Re: [Lse-tech] Re: CPU affinity & IPI latency (FIX)_




On 17-Jul-2001 Hubertus Frnake wrote:
> In an attempt to inline the code, somehow the tabs got lost. So here is
the
> attached correct patch fo 2.4.5. Please try and let me know whether you
> see your problems disappear and/or others arise.
> The sketchy writeup is still the same.

What is the reason You don't set the resched task in the fast path ?

        best_cpu = p->processor;
        if (can_schedule(p, best_cpu)) {
                tsk = idle_task(best_cpu);
                if ((cpu_curr(best_cpu) == tsk) &&
                    (cpu_resched(best_cpu) == NULL)) {
                        int need_resched;
send_now_idle:
                        /*
                         * If need_resched == -1 then we can skip sending
                         * the IPI altogether, tsk->need_resched is
                         * actively watched by the idle thread.
                         */
                        need_resched = tsk->need_resched;
                        tsk->need_resched = 1;
                        if ((best_cpu != this_cpu) && !need_resched) {
>>>>                            cpu_resched(best_cpu) = p;
                                smp_send_reschedule(best_cpu);
                        }
                        return;
                }
        }



- Davide


_______________________________________________
Lse-tech mailing list
Lse-tech@lists.sourceforge.net
http://lists.sourceforge.net/lists/listinfo/lse-tech



