Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266894AbRGQSIz>; Tue, 17 Jul 2001 14:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266895AbRGQSIq>; Tue, 17 Jul 2001 14:08:46 -0400
Received: from sncgw.nai.com ([161.69.248.229]:28627 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S266894AbRGQSIa>;
	Tue, 17 Jul 2001 14:08:30 -0400
Message-ID: <XFMail.20010717111155.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3B5476E0.EBC7CA12@watson.ibm.com>
Date: Tue, 17 Jul 2001 11:11:55 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Hubertus Frnake <frankeh@watson.ibm.com>
Subject: Re: [Lse-tech] Re: CPU affinity & IPI latency (FIX)_
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net, ak@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 17-Jul-2001 Hubertus Frnake wrote:
> In an attempt to inline the code, somehow the tabs got lost. So here is the
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

