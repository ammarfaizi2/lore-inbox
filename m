Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWFFQ4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWFFQ4Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 12:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWFFQ4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 12:56:25 -0400
Received: from hera.kernel.org ([140.211.167.34]:11654 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750734AbWFFQ4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 12:56:24 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: process starvation with 2.6 scheduler
Date: Tue, 6 Jun 2006 09:55:50 -0700
Organization: OSDL
Message-ID: <20060606095550.57247fd4@localhost.localdomain>
References: <478F19F21671F04298A2116393EEC3D52741DC@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
	<1149580918.8455.85.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1149612949 7962 10.8.0.54 (6 Jun 2006 16:55:49 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 6 Jun 2006 16:55:49 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.1.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
