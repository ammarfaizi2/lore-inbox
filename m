Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143363AbRA1QQn>; Sun, 28 Jan 2001 11:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143451AbRA1QQd>; Sun, 28 Jan 2001 11:16:33 -0500
Received: from blackdog.wirespeed.com ([208.170.106.25]:5 "EHLO
	blackdog.wirespeed.com") by vger.kernel.org with ESMTP
	id <S143436AbRA1QQ1>; Sun, 28 Jan 2001 11:16:27 -0500
Message-ID: <3A74462A.80804@redhat.com>
Date: Sun, 28 Jan 2001 10:17:46 -0600
From: Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: yodaiken@fsmlabs.com, Nigel Gamble <nigel@nrg.org>,
        linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <200101220150.UAA29623@renoir.op.net> <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>,
					<Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>; from Nigel Gamble on Sun, Jan 21, 2001 at 06:21:05PM -0800 <20010128061428.A21416@hq.fsmlabs.com> <3A742A79.6AF39EEE@uow.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> There has been surprisingly little discussion here about the
> desirability of a preemptible kernel.
> 

And I think that is a very intersting topic... (certainly more 
interesting than hotmail's firewalling policy ;o)

Alright, so suppose I dream up an application which I think really 
really needs preemption (linux heart pacemaker project? ;o) I'm just not 
convinced that linux would ever be the correct codebase to start with. 
The fundamental design of every driver in the system presumes that there 
is no preemption.

A recent example I came across is in the MTD code which invokes the 
erase algorithm for CFI memory. This algorithm spews a command sequence 
to the flash chips followed by a list of sectors to erase. Following 
each sector adress, the chip will wait for 50usec for another address, 
after which timeout it begins the erase cycle. With a RTLinux-style 
approach the driver is eventually going to fail to issue the command in 
time. There isn't any logic to detect and correct the preemption case, 
so it just gets confused and thinks the erase failed. Ergo, RTLinux and 
MTD are mutually exclusive. (I should probably note that I do not intend 
this as an indictment of RTLinux or MTD, but just an example of why 
preemption breaks the Linux driver model).

So what is the solution in the preemption case? Should we re-write every 
driver to handle the preemption? Do we need a cli_yes_i_mean_it() for 
the cases where disabling interrupts is _absolutely_ required? Do we 
push drivers like MTD down into preemptable-Linux? Do we push all 
drivers down?
In the meantime, fixing the few places where the kernel spends an 
extended period of time performing a task makes sense to me. If you're 
going to be busy for a while it is 'courteous' to allow the scheduler a 
chance to give some time to other threads. Of course it's hard to know 
when to draw the line.

So now I am starting to wonder about what needs to be profiled. Is there 
a mechanism in place now to measure the time spent with interrupts off, 
for instance? I know this has to have been quantified to some extent, right?

-- 
Joe deBlaquiere
Red Hat, Inc.
307 Wynn Drive
Huntsville AL, 35805
voice : (256)-704-9200
fax   : (256)-837-3839

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
