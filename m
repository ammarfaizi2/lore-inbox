Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265667AbTFSA6y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 20:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265670AbTFSA6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 20:58:54 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:2759 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265667AbTFSA6u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 20:58:50 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andreas Boman <aboman@midgaard.us>
Subject: Re: [PATCH] 2.5.72 O(1) interactivity bugfix
Date: Thu, 19 Jun 2003 11:12:49 +1000
User-Agent: KMail/1.5.2
References: <200306190043.14291.kernel@kolivas.org> <200306190938.04430.kernel@kolivas.org> <1055983621.1753.23.camel@asgaard.midgaard.us>
In-Reply-To: <1055983621.1753.23.camel@asgaard.midgaard.us>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306191112.49621.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jun 2003 10:47, Andreas Boman wrote:
> On Wed, 2003-06-18 at 19:38, Con Kolivas wrote:
> > On Thu, 19 Jun 2003 08:59, Andreas Boman wrote:
> > > On Wed, 2003-06-18 at 18:43, Con Kolivas wrote:
> > > > On Thu, 19 Jun 2003 03:59, Andreas Boman wrote:
> > > > > On Wed, 2003-06-18 at 10:43, Con Kolivas wrote:
> > > > > > --BEGIN PGP SIGNED MESSAGE--
> > > > > > Hash: SHA1
> > > > > >
> > > > > > Hi Ingo, all
> > > > > >
> > > > > > While messing with the interactivity code I found what appears to
> > > > > > be an uninitialised variable (p->sleep_avg), which is responsible
> > > > > > for all the boost/penalty in the scheduler. Initialising this
> > > > > > variable to 0 seems to have made absolutely massive improvements
> > > > > > to system responsiveness under load and completely removed audio
> > > > > > skips up to doing a make -j64 on my uniprocessor P4 (beyond which
> > > > > > swap starts being used), without changing the scheduler
> > > > > > timeslices. This seems to help all 2.4 O(1) based kernels as
> > > > > > well. Attached is a patch against 2.5.72 but I'm not sure about
> > > > > > the best place to initialise it.
> > > > >
> > > > > Applying this ontop of 2.5.72-mm1 causes more xmms/mpg321/ogg123
> > > > > skipping than with plain -mm1 here. make -j20 on my up athlon 1900+
> > > > > with 512M ram causes extreme skipping until the make is killed.
> > > > > With plain -mm1 I may get _one_ skip at the very begining of a song
> > > > > during make -j20 (about 50% of the time). Plain -mm1 stops skipping
> > > > > after 10-15 sec of playback of a song, and even switching desktops
> > > > > after that doesnt cause skips, with or without make -j20 running
> > > > > (switching to/from desktops with apps like mozilla, evolution etc.
> > > > > will cause skips during the first 10-15 sec of a song regardless
> > > > > what I do it seems).
> > > > >
> > > > > Renicing xmms to -15 doesnt change anything with either kernel.
> > > >
> > > > Hmm. I got too excited with the fact it improved so much on the 2.4
> > > > O(1)
> > >
> > > Well, I got very exited when I saw your post ;) I guess this is a
> > > problem all us UP desktop users would like too see solved.
> > >
> > > > kernels that I didn't try it hard enough on the 2.5 kernels. I have
> > > > had people quietly telling me that it isn't uninitialised, but that I
> > > > am simply resetting it with this patch on new forked processes. It
> > > > seems the extra changes to the 2.5 scheduler make this patch make
> > > > things worse?
> > >
> > > Yeah, I poked around a bit after I sent my earlier mail to see what may
> > > be going on and noticed that too. (In activate_task() and sched_exit()
> > > and some other place iirc)
> > >
> > > > I need more testing of the 2.4 one as well to see if it was just my
> > > > combination of hardware and kernel that was better with this...
> > >
> > > I suspect that is the case, yes, or I got unlucky with mine since it
> > > was extremely bad during the make -j. I'll see if I can get a 2.4.21-ck
> > > patched up with some other things I need here, and try to reproduce my
> > > results. That should tell us if it is infact scheduler differences or
> > > our different setups.
> >
> > I had another look at 2.5 and noticed the max sleep avg is set to 10
> > seconds instead of 2 seconds in 2.4. This could make a _big_ difference
> > to new forked tasks if they all start out penalised as most
> > non-interactive. It can take 5 times longer before they get the balance
> > right. Can you try with this set to 2 or even 1 second on 2.5?
>
> Ahh, thanks Con, setting MAX_SLEEP_AVG to 2 *almost* removes all xmms
> skipping here, a song *may* skip during desktop switches sometime during
> the first 5 sec or so of playback IFF make -j20 is running. On a mostly
> idle box (well LoadAvg 3 or so is mostly idle isnt it? ;) desktop
> switching doesnt cause skips anymore 8)

That's nice; a MAX_SLEEP_AVG of 1 second will shorten that 5 seconds to half 
that as well. What you describe makes perfect sense given that achieving a 
balance is an exponential function where the MSA is the time constant.

> Doing make -j20 and staying on the same desktop doesnt cause any
> skipping at all (but it didnt cause much skipping at all on plain
> 2.5.72-mm1 either).

So it is better than the default mm1? (doesnt cause any vs didnt cause much)

> I also applied your p->sleep_avg = 0; stuff (keeping MAX_SLEEP_AVG 2 and
> HZ 1000) and it behaved just like I described earlier (songs started
> after the make never stop skipping).

Well anything started will be penalised initially as being completely 
non-interactive with the p->sleep_avg = 0. This seems to work fine for normal 
usage patterns I've found on -ck1, as after a short while it gets a bonus up 
to interactive. But you say that doesn't happen on 2.5?

> I am fairly sure the winner for me here was the MAX_SLEEP_AVG since I
> have fiddled with HZ before without it making big noticable differences.

Yes you're confirming pretty much what I'm finding now that I've played with 
it a lot more.

> I havent gotten a 2.4 kernel patched up yet (lazy), but I'll get that
> done and see how that sleep_avg patch behaves here then.

Shouldn't be any different than what you've described on 2.5 now, if you make 
CHILD_PENALTY match that on 2.5 (is 50 in 2.5, was 95 in -ck1)

Con

P.S. I've cc'ed lkml since others might find this information interesting

