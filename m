Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290242AbSAOSiH>; Tue, 15 Jan 2002 13:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290240AbSAOShs>; Tue, 15 Jan 2002 13:37:48 -0500
Received: from [62.245.135.174] ([62.245.135.174]:31932 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S290241AbSAOShb>;
	Tue, 15 Jan 2002 13:37:31 -0500
Message-ID: <3C4476E4.82FA6E7F@TeraPort.de>
Date: Tue, 15 Jan 2002 19:37:24 +0100
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17-xxx i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Rik van Riel <riel@conectiva.com.br>, andrea@suse.de
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <Pine.LNX.4.33L.0201151131370.32617-100000@imladris.surriel.com>
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 01/15/2002 07:37:23 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 01/15/2002 07:37:30 PM,
	Serialize complete at 01/15/2002 07:37:30 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Tue, 15 Jan 2002, Martin Knoblauch wrote:
> 
> >  How we get there I do not care to much. If -aa can solve the VM
> > problems, fine. If rmap solves them, great. Just bring a working,
> > maintainable solution in.
> 
> It would be nice if you could try -aa and -rmap in your
> situation and give Andrea and me feedback on what needs
> to be improved in our patches (it's software, I assume
> it's not perfect ;)).
> 
> cheers,
> 
> Rik

OK, here we go. Just don't tell my boss what I did this afternoon :-)

My system:
----------

Toshiba Portege 7200, 650 MHz, 320 MB, 640 MB swap

My workload:
------------

- Netscape
- vmware with a 81 page ppt nightmare
- make dep clean modules bzImage

What I measure/observe:
-----------------------

- swapped out memory after starting up netscape and vmware/ppt
- reading mail/news using nestscape, some browsing
- alternating jumping throuth the ppt bullsh..
- swapped out memory after the make has finished
- suspending the vmware session
- how does it feel feelings

 I did the tests with the following setups:

a) 2.4.17+vmscan-d+read_latency
b) 2.4.17-vmscan-d+read_latency+preempt+lock-break+miini-ll
c) 2.4.17+rmap11b
d) 2.4.18pre2aa2 (no aa patch that applies cleanly to 2.4.17 :-(

Results:
--------

a) 2.4.17+vmscan-d+read_latency

- after starting NS and vmware, there are 352K in swap
- when the kernel build is finished, there are less than 1M in swap and
about 210 MB in Cache+Buffer
- vmware is pretty jerky during the make, loosing mouse and keyboard
events
- system feels OK, while vmware suspends
- overall, the system is usable to me

b) 2.4.17-vmscan-d+read_latency+preempt+lock-break+mini-ll

- same VM behaviour as a)
- vmware session feels very smooth. No loss of events, smooth pointer
movement
- no problems suspending vmware
- best result of all tested setups

 OK, now one would have to find out which of the last three patches
gives the good feeling. And one would have to test against mini-ll or
full-ll. Maybe tomorrow.

c) 2.4.17+rmap11b

- after starting netscape and vmware/ppt there are 744K in swap
- after the kernel build there are 40 MB in swap and 250 MB in
Cache+Buffer
- vmware is jerky and sluggish during that time
- when the system is swapping out, it tends to freeze for several
seconds
- system freezes when vmware gets suspended (large amount of writes)

 Definitely, this combination does not the "excessive swap, althought
there is enough cache to shrink" problem. It also does not handle large
IO very well. In the current state no candidate for me. Sorry Rick :-(

d) 2.4.18pre2aa2

- after starting NS and vmware, there are 352K in swap
- after the kernel build, there are 7 MB in swap, 220 MB in cache+buffer
- vmware is sluggish/jerky
- it freezes on swap-out
- it freezes on vmware-suspend

 The swap dissaster looks better than rmap, but still worse than a and
b. Although the patch is big, it does not solve the problem of heavy
writing freezing the system.

Conclusion for me, and maybe only me:
-------------------------------------

- the small fixes in vmscan-d+read_latency fix the swap-dissaster and IO
freeze for me
- adding preempt+lock_break+mini_ll make the system *feel* great. That
is important to me. Remember, this is a workstation. And a slow one. I
really don't care about the last 5-10% of throughput, or the best worst
case latency.

 As a result I love b) and can very well live with a). For me, vmscan-d
and read_latency look like 2.4.18 candidates. For the added
latency-improvement additional patches are acceptable.

 rmap isn't worth the effort on *my* workload. Others may get totally
different mileage. And it is still better than mainline 2.4.17, which
ends up with 60-70 MB in swap and unusable vmware and extended freezes.

 -aa is slightly better in VM usage than rmap, but given the size of the
patch I am *personally* not to thrilled. Again, it doubtlessly fixes
problems with other workloads on larger machines.

 In the end, I still have no idea how to sort out the mess. At least I
know what setup is best for me today :-)

Martin
 -- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
