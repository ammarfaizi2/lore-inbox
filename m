Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131730AbRDMQfe>; Fri, 13 Apr 2001 12:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131733AbRDMQfO>; Fri, 13 Apr 2001 12:35:14 -0400
Received: from [32.97.182.101] ([32.97.182.101]:17579 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S131730AbRDMQfJ>;
	Fri, 13 Apr 2001 12:35:09 -0400
Importance: Normal
Subject: Re: PATCH(?): linux-2.4.4-pre2: fork should run child first
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF69F0F3AE.1E1ACFE0-ON85256A2D.0055CD5B@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Fri, 13 Apr 2001 12:28:58 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.7 |March 21, 2001) at
 04/13/2001 12:34:43 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



First you are wrong by assuming that setting current->counter=0
will guarantee that the child runs first. In an SMP it only means
that this might initiate another recalculate and could run from
there in parallel with the child.

Actually quickly looking at the source code here.
You don't have to call schedule() at all.
A bit further down wake_up_process(p) is called, which in turn
calls reschedule_idle(p). Hence we don't have to call schedule.

If one satisfies the conditions:

(preemption_goodness(current,p,p->processor) > 1) then the child should
run.
[ with (child==p) and (parent==current) ].

This is for the uniprocessor system. In the SMP both could continue
to run. Looking at goodness computation, since p->mm == current->mm,
p->nice == current->nice and p->processor == current->processor,
all what matters is the difference in the counter values.
My proposed patch always yield 1, which ofcourse doesn't have the desired
effect.


Here is a patch that always yields a diff of 2. However for odd number of
current->counter it looses a token between the two.

     {
          long parcnt = current->counter;
          p->counter = (parcnt+((parcnt&1)?1:2)) >> 1;
          parcnt >>= 1;
          if (parcnt>0) {
               current->counter = 0;
               current->need_resched = 1;
          } else {
               current->counter = parcnt - 1;
     }


There is the other view that I should not loose a token.
In that case the following code will add a token in the odd counter case.
I think that this is preferrable over the first solution.


     p->counter = (current->counter+3)>>1;
     current->counter = (current->counter >> 1) - 1;
     if (current->counter <= 0) {
          current->counter = 0;
          current->need_resched = 1;
     }



Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



"Adam J. Richter" <adam@yggdrasil.com> on 04/12/2001 08:42:12 PM

To:   Hubertus Franke/Watson/IBM@IBMUS
cc:
Subject:  Re: PATCH(?): linux-2.4.4-pre2: fork should run child first



>        p->counter = (current->counter + 1) >> 1;
>        current->counter = (current->counter - 1) >> 1;
>        schedule();

     I don't have time to try this right now and I'm not sure
what locks are held at that point in the code or whether schedule()
will actually schedule a different process if the current one
has current->counter > 0 (even if current->need_resched is set and
even if another process has a higher proc->counter value).

     Even if it did work, your code is more complex and makes it
less likely that the child will reach exec() before the parent
runs again.  So, I am not sure I would see the advantage if it did work.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite
104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."



