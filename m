Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbTFJSfw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbTFJSfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:35:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:30627 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261454AbTFJSfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:35:50 -0400
Message-Id: <5.2.0.9.2.20030610193426.00cd9528@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Tue, 10 Jun 2003 20:53:51 +0200
To: William Lee Irwin III <wli@holomorphy.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.70-mm6
Cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20030610114123.GP15692@holomorphy.com>
References: <5.2.0.9.2.20030610125606.00cd04a0@pop.gmx.net>
 <Pine.LNX.4.51.0306101052160.14891@dns.toxicfilms.tv>
 <46580000.1055180345@flay>
 <Pine.LNX.4.51.0306092017390.25458@dns.toxicfilms.tv>
 <51250000.1055184690@flay>
 <Pine.LNX.4.51.0306092140450.32624@dns.toxicfilms.tv>
 <20030609200411.GA26348@holomorphy.com>
 <Pine.LNX.4.51.0306101052160.14891@dns.toxicfilms.tv>
 <5.2.0.9.2.20030610125606.00cd04a0@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:41 AM 6/10/2003 -0700, William Lee Irwin III wrote:
>At 02:20 AM 6/10/2003 -0700, William Lee Irwin III wrote:
> >> Mike, any chance you can turn your series of patches into one that
> >> applies atop mingo's intra-timeslice priority preemption patch? If
> >> not, I suppose someone else could.
>
>On Tue, Jun 10, 2003 at 01:31:32PM +0200, Mike Galbraith wrote:
> > I've never seen it.  Is this the test-starve fix I heard mentioned on lkml
> > once?
>
>No idea what the posted name was. What it does is obvious enough. It
>was posted earlier in this thread.
>
>
>At 02:20 AM 6/10/2003 -0700, William Lee Irwin III wrote:
> >> There also appears to be some kind of issue with using monotonic_clock()
> >> with timer_pit as well as some locking overhead concerns. Something
> >> should probably be done about those things before trying to merge the
> >> fine-grained time accounting patch.
>
>On Tue, Jun 10, 2003 at 01:31:32PM +0200, Mike Galbraith wrote:
> > Ingo had me measure impact with lat_ctx, and it wasn't very encouraging
> > (and my box is UP).  I'm not sure that I wasn't seeing some cache effects
> > though, because the numbers jumped around quite a bit.  Per Ingo, the
> > sequence lock change will greatly improve scalability.  Doing anything
> > extra in that path is going to cost some pain though, so I'm trying to
>
>Okay, so mitigating the hit to context switch is ongoing.

If it's used, seems some work will be required to measure the true (and 
practical) impact.

>On Tue, Jun 10, 2003 at 01:31:32PM +0200, Mike Galbraith wrote:
> > figure out a way to do something ~similar.  (ala perfect is the enemy of
> > good mantra).
>
>\vomit{Next you'll be telling me worse is better.}

That's an unearned criticism.

Timeslice management is currently an approximation.  IFF the approximation 
is good enough, it will/must out perform pedantic bean-counting.  Current 
timeslice management apparently isn't quite good enough, so I'm trying to 
find a way to increase it's informational content without the (in general 
case useless) overhead of attempted perfection.  I'm failing miserably btw ;-)

>On Tue, Jun 10, 2003 at 01:31:32PM +0200, Mike Galbraith wrote:
> > wrt pit, yeah, that diff won't work if you don't have a tsc.  If something
> > like it were used, it'd have to have ifdefs to continue using
> > jiffies.  (the other option being only presentable on April 1:)
>
>The issue is the driver returning garbage; not having as good of
>precision from hardware is no fault of the method. I'd say timer_pit
>should just return jiffies converted to nanoseconds.

That's the option that I figured was April 1 material, because of the 
missing precision.  If it could be made (somehow that I don't understand) 
to produce a reasonable approximation of a high resolution clock, sure.

>Also, I posted the "thud" fix earlier in this thread in addition to the
>monotonic_clock() bits. AFAICT it mitigates (or perhaps even fixes) an
>infinite priority escalation scenario.

(yes, mitigates... maybe cures with round down, not really sure)

Couple that change with reintroduction of backboost to offset some of it's 
other effects and a serious reduction of CHILD_PENALTY and you'll have a 
very snappy desktop.  However, there is another side of the 
equation.  Large instantaneous variance in sleep_avg/prio also enables the 
scheduler to react quickly such that tasks which were delayed for whatever 
reason rapidly get a chance collect their ticks and catch up.  It can and 
does cause perceived unfairness... which is in reality quite fair.  It's 
horrible for short period concurrency, but great for long period 
throughput.  AFAIKT, it's a hard problem.

         -Mike 

