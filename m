Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129101AbRA2RV3>; Mon, 29 Jan 2001 12:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129306AbRA2RVT>; Mon, 29 Jan 2001 12:21:19 -0500
Received: from blackdog.wirespeed.com ([208.170.106.25]:35081 "EHLO
	blackdog.wirespeed.com") by vger.kernel.org with ESMTP
	id <S129101AbRA2RVK>; Mon, 29 Jan 2001 12:21:10 -0500
Message-ID: <3A75A70C.4050205@redhat.com>
Date: Mon, 29 Jan 2001 11:23:24 -0600
From: Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: Andrew Morton <andrewm@uow.edu.au>, Nigel Gamble <nigel@nrg.org>,
        linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <200101220150.UAA29623@renoir.op.net> <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>, <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>; <20010128061428.A21416@hq.fsmlabs.com> <3A742A79.6AF39EEE@uow.edu.au> <3A74462A.80804@redhat.com> <20010129084410.B32652@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning world! :o)

yodaiken@fsmlabs.com wrote:

> Only if your RTLinux application is running. In other words, you cannot
> commit more than 100% of cpu cycle time and expect to deliver.
> I think one of the common difficulties with realtime is that time-shared
> systems with virtual memory make people used to elastic resource
> limits and real-time has unforgiving time limits.
> 
> 

	The problem I see is not one of cpu 'overcommit' but of 'critical 
sections' in the driver code. I really like the preemptive model, but it 
would seem to me that there needs to be a way to cooperate with some of 
the driver code. Allowing the driver a brief exclusive time share does 
certainly have latency implications, but breaking drivers can crash 
things pretty quickly (If you're running a program XIP from flash and a 
RT interrupt leaves the flash in a unreadable state, boom!).
	If the answer is to run the 'critical' driver code as a RT thread, I can 
live with that, but there should be a clear policy and mechanism in 
place to handle it.

> 
> 
> Or what is the tradeoff or whether  a deadlock will follow. 
> step 1: memory manager thread frees a few pages and is courteous
> step 2: bunch of thrashing and eventually all processes stall
> step 3: go to step 1
> 
> alternative
> step 1: memory manager thread frees enough pages for some processes to
>         advance to termination
> step 2: all is well
> 
> and make up 100 similar scenarios. And this is why "preemptive"
> OS's tend to add such abominations as "priority inheritance" which 
> make failure cases rarer and harder to diagnose or complex schedulers
> that spend a significant fraction of cpu time trying to figure out
> what process should advance or ...
> 
> 

It doesn't matter how you do it, the cooperative model eventually starts 
to feel like Windoze3.1 in the extreme case, but even so, it was much 
more multithreaded than DOS. Of course, the Right Thing (TM) is to do 
away with the cooperative model. But even in a preemptive model, there's 
no reason to have code like

while (!done)
{
	done = check_done();
}

when you can have:

while (!done)
{
	yield();
	done = check_done();
}

being preemptive and being cooperative aren't mutually exclusive.

Borrowing your sports car / delivery van metaphor, I'm thinking we could 
come up with something along the lines of a BMW 750iL... room for six 
and still plenty of uumph.

Cheers,

Joe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
