Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbTLTDdm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 22:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263791AbTLTDdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 22:33:42 -0500
Received: from port-212-202-159-243.reverse.qsc.de ([212.202.159.243]:39148
	"EHLO mail.onestepahead.de") by vger.kernel.org with ESMTP
	id S263788AbTLTDdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 22:33:39 -0500
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
From: Christian Meder <chris@onestepahead.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <200312201355.08116.kernel@kolivas.org>
References: <1071864709.1044.172.camel@localhost>
	 <1071885178.1044.227.camel@localhost> <3FE3B61C.4070204@cyberone.com.au>
	 <200312201355.08116.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1071891168.1044.256.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 20 Dec 2003 04:32:50 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-12-20 at 03:55, Con Kolivas wrote:
> On Sat, 20 Dec 2003 13:38, Nick Piggin wrote:
> > Christian Meder wrote:
> > >On Sat, 2003-12-20 at 02:26, Nick Piggin wrote:
> > >>Christian Meder wrote:
> > >>>On Sat, 2003-12-20 at 01:48, Nick Piggin wrote:
> > >>>>Sounds reasonable. Maybe its large interrupt or scheduling latency
> > >>>>caused somewhere else. Does disk activity alone cause a problem?
> > >>>>find / -type f | xargs cat > /dev/null
> > >>>>how about
> > >>>>dd if=/dev/zero of=./deleteme bs=1M count=256
> > >>>
> > >>>Ok. I've attached the logs from a run with a call with only an
> > >>>additional dd. The quality was almost undisturbed only very slightly
> > >>>worse than the unloaded case.
> 
> Since so many things have actually changed it's going to be hard to extract 
> what role the cpu scheduler has in this setting, but lets do our best.
> 
> Is there a reason you're running gnomemeeting niced -10? It is hardly using 
> any cpu and the problem is actually audio in your case, not the cpu 
> gnomemeeting is getting. Running dependant things (gnomemeeting, audio 
> server, gnome etc) at different nice levels is not a great idea as it can 
> lead to priority inversion scenarios if those apps aren't coded carefully. 
> 
> What happens if you run gnomemeeting at nice 0?

Exactly the same. It was only reniced to -10 because I tried it and
forgot to set it back. With your scheduler renicing doesn't make a
difference. No matter if I renice the compile to 19 or gnomemeeting to
-10. With Nick's scheduler renicing gnomemeeting to -10 improves the
situation.

> 
> How is your dma working on your disks?

/dev/hda:
 multcount    =  0 (off)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 65535/16/63, sectors = 117210240, start = 0

> What happens if you don't use an audio server (I'm not sure what the audio 
> server is in gnome); or if you're not using one what happens when you do?

esd was running but I'm not sure gnomemeeting with ALSA support was
using it. After killing esd and retrying there was no difference.

> Renice the audio server instead?

gnomemeeting without audio server is showing the same phenomenon like
gnomemeeting with esd.

> You've already tried different audio drivers right?

Yes, the phenomenon occurs for the OSS and the ALSA driver.

> Nice the compile instead of -nicing the other stuff.

Tried it with same result (see above).

> Try the minor interactivity fix I posted only yesterday for different nice 
> level latencies:
> http://ck.kolivas.org/patches/2.6/2.6.0/patch-2.6.0-O21int

Actually all the posted results were on a 2.6.0-test11-mm1 with your
patch added on top. So the patch didn't change anything for me.

> Is your network responsible and the audio unrelated? Some have reported 
> strange problems with ppp or certain network card drivers?

The problem occurs whether I use my WLAN PCMCIA card or my PCMCIA
Ethernet card.

> As you see it's not a straight forward problem but there's some things for you 
> to get your teeth stuck into. As it stands the cpu scheduler from your top 
> output appears to be giving appropriate priorities to the different factors 
> in your equation.

I know that the problem isn't straight forward that's why I refrained a
long time before posting to linux-kernel trying to rule out different
scenarios. As it stands I tried different gnomemeeting versions,
different audio drivers, different nice levels, different schedulers,
preemption on and off, ACPI on and off, -mm kernels and pristine Linus
kernels with no luck. If I put CPU load on my box the gnomemeeting
audiostream gets badly mutilated (unusable). There's not much left I can
think of that's why I'm finally posting to linux-kernel.



				Christian Meder


-- 
Christian Meder, email: chris@onestepahead.de
 
What's the railroad to me ?
I never go to see
Where it ends.
It fills a few hollows,
And makes banks for the swallows, 
It sets the sand a-blowing,
And the blackberries a-growing.
                      (Henry David Thoreau)
 




