Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263089AbSJFBZS>; Sat, 5 Oct 2002 21:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263108AbSJFBZR>; Sat, 5 Oct 2002 21:25:17 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:32248 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S263089AbSJFBZN>; Sat, 5 Oct 2002 21:25:13 -0400
Message-Id: <200210060130.g961UjY2206214@pimout2-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Date: Sat, 5 Oct 2002 16:30:32 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 October 2002 07:13 pm, Linus Torvalds wrote:
> On Fri, 4 Oct 2002, Martin J. Bligh wrote:
> > When you say we have "some of" that (NuMA support) ... what else would
> > you like to see?
>
> The main thing that I think is lacking is any relevance to any significant
> user base, thanks to lack of interesting hardware. So even if Linux itself
> was doing everything perfectly, as long as there is no wide hw base and
> users, it's all pretty much academic, the same way SMP was during the
> early 1.x days.
>
> And I'm not trying to put you or any of the Linux NuMA work down here, I'm
> just saying that what makes it not important as a "3.0 feature" is just
> that deployment doesn't merit it yet.

Linux isn't going to get  a new order of magnitude surge from the server 
space, because there isn't an order of magnitude left.  The figures I've seen 
from several sources broadly agree that Linux currently has somewhere between 
a fifth and a third of the server market, has been doing quite well on that 
score for some time, and continues to make steady incremental advances 
(taking about equal amounts of market share away from proprietary unixen and 
NT boxen).  2.4 is already pretty darn good on a server (assuming you never 
hit swap. :).  Even 2.2 wasn't at all bad at it.

The new uncharted territory for Linux, and the next major order-of-magnitude 
jump in the installed base, is the desktop.  A kernel that could make a 
credible stab at the desktop  would certainly be 3.0 material.  And the work 
that matters for the desktop  is LATENCY work.  Not SMP, not throughput, not 
more memory.  Latency.  O(1), deadline I/O scheduler, rmap, preempt, shorter 
clock ticks, 

Yeah, a lot of the necessary work is user space stuff.  But not all.  We've 
focused on the "MP3 skipping/cd burner underrun" type stuff, which is 
important, but in reality an awful lot of the windows "look and feel" issues 
boil down to the simple fact that enough of their windowing system is welded 
into the kernel that their mouse pointer keeps updating smoothly no matter 
how  heavily loaded the system is, and when you click on a window its Z-order 
gets  promoted snappily under just about all circumstances.  That's it.  
That's the  big secret.  The mouse pointer doesn't stall, and the windows 
respond immediately when you click on 'em.

This may not be a USEFUL response, but it's an immediate one.  The inside of 
the window may not redraw for 30 seconds, and the pulldown menus and buttons 
will just ignore you for a while after that, but what the user EXPERIENCES is 
snappy response to commands and smooth interactive feel.  Just from those two 
things.  The system is listening.  It may not do anything but drool in 
response, but you can see that it's LISTENING.  And it's not just a cosmetic  
thing: try using a touchpad or nipple mouse on a laptop when the pointer 
stalls: you have to wait for it to start up again or you overshoot your 
target.  It's not a question of "queue up the next three clicks and wait for 
it to get around to them", you need interactive feedback to get your mouse in 
the right place.  Having it stall is really annoying in that case.  The 
instant an app blocks on a swapped out page, or any other read, and then I/O 
starvation occurs with reads blocked by a ton of writes...  BANG.  User 
twiddles thumb while their mouse pointer ignores them.  (Speculatively 
swapping out a page or two of the X server because it's easy to swap them 
back in doesn't help if reads are blocked behind three seconds worth of 
writes and your mouse pointer stalls at the edge of the window because of 
this.)

Now to fake this in Linux, you theoretically just need to run your X server 
and  your window manager at a priority of -10 (and somebody needs to club the 
distributions on the head until they start DOING this).  But in the past, 
that wouldn't guarantee your mouse cursor didn't do a half-second pause at a 
window boundary when the swap file went nuts.  There was NOTHING you could do 
under the first dozen 2.4 kernels to make sure your mouse pointer wouldn't 
stall at a window boundary, or go into la-la land for five minutes for that 
matter.  (It improved noticeably after that, but by then most people's 
opinions of 2.4's desktop suitability were already formed.  And it's STILL 
not fully fixed in 2.4: the instant an app blocks on a swapped out page and 
then I/O starvation happens with reads blocked by writes...  BANG.  User 
twiddles thumb while their mouse pointer ignores them.  Solution?  Never do 
anything disk intensive in the background unless you want interactive feel to 
go into the toilet.)

The new deadline I/O scheduler directly addresses this, and the ability to 
get "nice" to affect I/O priority is going to be a big win as well.  Andrea 
and Rik's VM work help here: rmap adds a lot of future tuning potential, such 
as the ability to make SWAP care about niceness (swap out pages from the 
nice+20 process before the nice-20 process).  The O(1) scheduler helps here 
by making niceness levels more meaningful in general.  All of these help X11 
at nice level -10 to not stall.  The faster clock tick helps here too, the 
low  latency work at the start of 2.5 helps here, and preempt helps here.  
There has been a LOT of work on general latency improvement and interactive 
feel.

Even the new threading work can potentially help X spin off a dedicated 
high-priority "update the mouse position, and manipulate window borders and z 
order, and never swap this thread out" thread.  (I remember the way OS/2 used 
to cheat and give extra time slices to anything that got a Presentation 
Manager window event, so you could literally speed up your program on a 
loaded system by "scrubbing" the mouse across it repeatedly.  The resulting 
perception was a snappy desktop, whatever the reality was.)

Sure there's a psychological "third time's the charm" thing that MS has 
conditioned the unwashed masses into believing, and a 3.0 kernel would make a 
bigger marketing splash than a 2.6 kernel.  And for that reason we should NOT 
go to 3.0 until we ARE ready for a horde of desktop users to give Linux a try 
(and potentially get burned and run away and hide and never look at us 
again).  But 2.5 DOES contain some significant attempts at addressing the 
needs of desktop (and laptop) users.  And THAT is what makes it 3.0 material. 
 To me, anyway. :)

Rob

(P.S.  The fact Apple's conditioning the market to take unix seriously on the 
desktop with OS X is just a case of convenient timing.  And now that floppies 
have gone the way of the dodo, the conceptual incompatabilty between "mount" 
and removable media is largely a question of CDs, which are software 
ejected...)

(P.P.S.  There was some argument way back that 2.4 should have been 3.0 due 
to the amount of new stuff in it.  Old hat now, but the residue is a tendency 
to compare 2.5 and 2.3 and say "if we didn't do it then, why do it now".  But 
looking at it the other way, doesn't that just make the jump between 2.0 and 
2.5 even bigger, and INCREASE the rationale for calling the new release 3.0?)

(P.P.P.S.  I'll stop now. :)

