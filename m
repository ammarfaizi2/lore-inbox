Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWFFV6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWFFV6T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 17:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWFFV6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 17:58:19 -0400
Received: from father.pmc-sierra.com ([216.241.224.13]:4804 "HELO
	father.pmc-sierra.bc.ca") by vger.kernel.org with SMTP
	id S1751083AbWFFV6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 17:58:18 -0400
Message-ID: <478F19F21671F04298A2116393EEC3D527431D@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
From: Kallol Biswas <Kallol_Biswas@pmc-sierra.com>
To: Kallol Biswas <Kallol_Biswas@pmc-sierra.com>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Cc: Mike Galbraith <efault@gmx.de>
Subject: RE: process starvation with 2.6 scheduler
Date: Tue, 6 Jun 2006 14:58:10 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for help. We do not see the issue if every netserver's priority is set to 19 with setpriority() call.

-----Original Message-----
From: Kallol Biswas 
Sent: Tuesday, June 06, 2006 10:56 AM
To: 'Stephen Hemminger'; linux-kernel@vger.kernel.org
Cc: 'Mike Galbraith'
Subject: RE: process starvation with 2.6 scheduler


I have verified that the starved tasks are in the runqueue (prio_array_t 
array[0], active points to array[0]), the timestamp and last_ran 
indicate that they have not run for a while.

The network traffic is of request response type.

Client (on an external box)3 ports ---- 3 cables ----3 ports Emulated Host
 
The netperf clients run on an external box, the emulated host (ppc440) runs 
the servers. A client sends request to a server, the server returns the 
reply, then the next request from the client goes to the server. There are 3
clients and 3 servers, one client-server pair for each connection 
(3 connections: 3 ports on external box  --3 connection 
 -- 3 ports on emulated host).

Since traffic is of request/response in nature and the packets reach
user space (to netserver) before turning around I do not think slow CPU is an issue.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Stephen Hemminger
Sent: Tuesday, June 06, 2006 9:56 AM
To: linux-kernel@vger.kernel.org
Subject: Re: process starvation with 2.6 scheduler

On Tue, 06 Jun 2006 10:01:58 +0200
Mike Galbraith <efault@gmx.de> wrote:

> (please line wrap)
> 
> On Mon, 2006-06-05 at 12:48 -0700, Kallol Biswas wrote:
> > Hello,
> >        We have a process starvation problem with our 2.6.11 kernel running on a ppc-440 based system.
> > 
> > We have a storage SOC based on PPC-440. The SOC is emulated on a system emulator called Palladium. It is from Cadence. The system runs at 400KHz speed. It has three Ethernet ports; they are connected to outside lab network with a speed bridge.
> > 
> > The netperf server netserver runs on the emulated system (2.6.11 kernel on Palladium). There are netperf linux clients running on a x86 box.
> > 
> > If netperf request response (TCP_RR) traffic is run on all three ports; after sometime only one port remains active, the application (netperf client) on other two ports wait for a long time and eventually time out.
> > 
> > The netserver code has been instrumented. For one of the starved netserver processes it has been found that the TCP_RR request from the netperf client on linux x86 box has been received by the server, it has issued send() call to send back reply but send() never returns.
> > 
> > With an ICE connected to the Palladium (emulator) I have dumped the kernel data structures of the starved process and the active process. 
> > 
> > 
> > For Active  Process:
> >   Time_slice 84
> >   Policy : SCHED_NORMAL
> >   Dynamic priority: 118
> >   Static priority: 120
> >   Preempt_count: 0x20100
> >   Flags = 0
> >   State = 0 (TASK_RUNNING)
> > 
> > For Starved Process:
> >   Time slice: 77
> >   Policy: SCHED_NORMAL
> >   Dynamic priority: 120
> >   Static priority: 120
> >   Preempt_count: 0x10000000 (PREEMPT_ACTIVE is set)
> >   Flags = 0 
> >   State = 0 (TASK_RUNNING)
> > 
> > Any help to debug the problem is welcome. 
> 
> I'm having difficulty understanding.  Are you saying that the "starved"
> tasks are runnable, but receiving _zero_ cpu?  That's impossible with
> only one other SCHED_NORMAL task afaik, which makes me think you may
> mean they're not receiving cpu frequently enough to keep clients from
> timing out?  One task which has slept enough to acquire interactive
> status (as above) can hold others off the cpu for quite a while if it
> starts a burst of heavy cpu burning.  If your netperf clients are
> choking on this latency, running the servers at nice 19 should prevent
> the problem.
> 


Is the processor getting consumed by network traffic in soft irq?
If you are using non NAPI device driver, then it is easy to get soft irq
overwhelmed with packets.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
