Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263738AbTHJLPe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 07:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264030AbTHJLNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 07:13:53 -0400
Received: from mail.gmx.de ([213.165.64.20]:16267 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263952AbTHJLM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 07:12:58 -0400
Message-Id: <5.2.1.1.2.20030810122144.019bdb00@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sun, 10 Aug 2003 13:17:07 +0200
To: Simon Kirby <sim@netnation.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH]O14int
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20030810084827.GA30869@netnation.com>
References: <200308091036.18208.kernel@kolivas.org>
 <20030808220821.61cb7174.lista1@telia.com>
 <200308091036.18208.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:48 AM 8/10/2003 -0700, Simon Kirby wrote:
>On Sat, Aug 09, 2003 at 10:36:17AM +1000, Con Kolivas wrote:
>
> > On Sat, 9 Aug 2003 06:08, Voluspa wrote:
> > > On 2003-08-08 15:49:25 Con Kolivas wrote:
> > > > More duck tape interactivity tweaks
> > >
> > > Do you have a premonition... Game-test goes down in flames. Volatile to
> > > the extent where I can't catch head or tail. It can behave like in
> > > A3-O12.2 or as an unpatched 2.6.0-test2. Trigger badness by switching to
> > > a text console.
> >
> > Ah. There's the answer. You've totally changed the behaviour of the
> > application in question by moving to the text console. No longer is it the
> > sizable cpu hog that it is when it's in the foreground on X, so you've
> > totally changed it's behaviour and how it is treated.
>
>I haven't been following this as closely as I would have liked to
>(recent vacation and all), but I am definitely seeing issues with the
>recent 2.5.x, 2.6.x-testx secheduler code and have been looking over
>these threads.
>
>I don't really understand why these changes were made at all to the
>scheduler.  As I understand it, the 2.2.x and older 2.4.x scheduler was
>simple in that it allowed any process to wake up if it had available
>ticks, and would switch to that process if any new event occurred and
>woke it up.  The rest was just limiting the ticks based on nice value
>and remembering to switch when the ticks run out.
>
>It seems that newer schedulers are now temporarily postponing the
>waking up of other processes when the running process is running with
>"preemptive" ticks, and that there's all sorts of hacks involved in
>trying to hide the bad effects of this decision.

I don't see this as a bad decision at all, it's just that there are some 
annoying cases where the deliberate starvation which works nicely in my 
favor for both interactivity and throughput in most cases can and does kick 
my ass in others.  This is nothing new.  I have no memory of the scheduler 
ever being perfect (0.96->today).  This scheduler is very nice to me; it's 
very simple, it's generally highly effective, and it's easily 
tweakable.  It just has some irritating rough edges.

>If this is indeed what is going on, what is the reasoning behind it?
>I didn't really see any problems before with the simple scheduler, so
>it seems to me like this may just be a hack to make poorly-written
>applications seem to be a bit "faster" by starving other processes of
>CPU when the poorly-written applications decide they want to do
>something (such as rendering a page with a large table in Mozilla
>-- grr).  Is this really making a large enough difference to be worth
>all of this trouble?
>
>To me it would seem the best algorithm would be what we had before all
>of this started.  Isn't it best to switch to a task as soon as an event
>(such as disk I/O finishing or a mouse move waking up X to read mouse
>input) occurs for both latency and cache reasons (queued in LIFO
>order)?  DMA may make some this more complicated, I don't know.

Hmm.  If a mouse event happened to be queued but not yet run when a slew of 
disk events arrived, LIFO would immediately suck.  LIFO may be good for the 
cache, but it doesn't seem like it could be good for average 
latency.  Other than that, what you describe is generally what 
happens.  Tasks which are waiting for hardware a lot rapidly attain a very 
high priority, and preempt whoever happened to service the interrupt 
(waker) almost instantly.  I'd have to look closer at the old scheduler to 
be sure, but I don't think there's anything much different between old/new 
handling.

>I am seeing similar starvation problems that others are seeing in these
>threads.  At first it was whenever I clicked a link in Mozilla -- xmms
>would stop, sometimes for a second or so, on a Celeron 466 MHz machine.

Do you see this with test-X and Ingo's latest changes too?  I can only 
imagine one scenario off the top of my head where this could happen; if 
xmms exhausted a slice while STARVATION_LIMIT is exceeded, it could land in 
the expired array and remain unserviced for the period of time it takes for 
all tasks remaining in the active array to exhaust their slices.  Seems 
like that should be pretty rare though.

         -Mike 

