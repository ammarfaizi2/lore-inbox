Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265936AbSLXWSR>; Tue, 24 Dec 2002 17:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265995AbSLXWSR>; Tue, 24 Dec 2002 17:18:17 -0500
Received: from dsl2-09018-wi.customer.centurytel.net ([209.206.215.38]:53664
	"HELO thomasons.org") by vger.kernel.org with SMTP
	id <S265936AbSLXWSP> convert rfc822-to-8bit; Tue, 24 Dec 2002 17:18:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: scott thomason <scott@thomasons.org>
Reply-To: scott@thomasons.org
To: Robert Love <rml@tech9.net>, Con Kolivas <conman@kolivas.net>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] scheduler tunables with contest - prio_bonus_ratio
Date: Tue, 24 Dec 2002 16:26:26 -0600
User-Agent: KMail/1.4.3
References: <200212200850.32886.conman@kolivas.net> <3E0253D9.94961FB@digeo.com> <1040341293.2521.71.camel@phantasy>
In-Reply-To: <1040341293.2521.71.camel@phantasy>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212241626.26478.scott@thomasons.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 December 2002 05:41 pm, Robert Love wrote:
> On Thu, 2002-12-19 at 18:18, Andrew Morton wrote:
> > That is too often not the case.
>
> I knew you would say that!
>
> > I can get the desktop machine working about as comfortably
> > as 2.4.19 with:
> >
> > # echo 10 > max_timeslice
> > # echo 0 > prio_bonus_ratio
> >
> > ie: disabling all the fancy new scheduler features :(
> >
> > Dropping max_timeslice fixes the enormous stalls which happen
> > when an interactive process gets incorrectly identified as a
> > cpu hog.  (OK, that's expected)

My experiences to add to the pot...I started by booting 2.5.52-mm2 and 
launching KDE3. I have a dual AMD MP2000+, 1GB RAM, with most of the 
data used below on striped/RAID0 ATA/133 drives. Taking Andrew's 
advice, I created a continuous load with:

    while [ 1 ]; do ( make -j4 clean; make -j4 bzImage ); done

...in a kernel tree, then sat down for a leisurely email and web 
cruising session. After about fifteen minutes, it became apparent I 
wasn't suffering any interactive slowdown. So I increased the load:

    while [ 1 ]; do ( make -j8 clean; make -j8 bzImage ); done
    while [ 1 ]; do ( cp dump1 dump2; rm dump2; sync ); done

...where file "dump1" is 100MB. Now we're seeing some impact :) 

 To combat this I tried:

    echo 3000 > starvation_limit
    echo 4 > interactive_delta
    echo 200 max_timeslice
    echo 20 min_timeslice

This works pretty well. The "spinning envelope" on the email monitor 
of gkrellm actually corresponds quite nicely with the actual feel of 
my system, so after awhile, I just sat back and observed it. Both the 
tactile response and the gkrellm obervations show this: it's common 
to experience maybe a .1--.3 second lag every 2 or 3 seconds with 
this load, with maybe the odd .5 second lag occurring once or twice a 
minute. Watching the compile job in the background scroll by, I 
noticed that there are times when it comes to a dead stop. The next 
step, I guess, needs to be a ConTest with the final settings...

child_penalty: 95

exit_weight: 3

interactive_delta: 4

max_sleep_avg: 2000

max_timeslice: 300

min_timeslice: 10

parent_penalty: 100

prio_bonus_ratio: 25

starvation_limit: 3000
---scott
    
