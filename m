Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbTLTERb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 23:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbTLTERb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 23:17:31 -0500
Received: from port-212-202-159-243.reverse.qsc.de ([212.202.159.243]:53996
	"EHLO mail.onestepahead.de") by vger.kernel.org with ESMTP
	id S263805AbTLTEQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 23:16:56 -0500
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
From: Christian Meder <chris@onestepahead.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <3FE3C6FC.7050401@cyberone.com.au>
References: <1071864709.1044.172.camel@localhost>
	 <1071885178.1044.227.camel@localhost> <3FE3B61C.4070204@cyberone.com.au>
	 <200312201355.08116.kernel@kolivas.org>
	 <1071891168.1044.256.camel@localhost>  <3FE3C6FC.7050401@cyberone.com.au>
Content-Type: multipart/mixed; boundary="=-byfqrIV9Xrfxi9OXzbKf"
Message-Id: <1071893802.1363.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 20 Dec 2003 05:16:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-byfqrIV9Xrfxi9OXzbKf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2003-12-20 at 04:50, Nick Piggin wrote:
> Christian Meder wrote:
> 
> >On Sat, 2003-12-20 at 03:55, Con Kolivas wrote:
> >
> >>On Sat, 20 Dec 2003 13:38, Nick Piggin wrote:
> >>
> >>>Christian Meder wrote:
> >>>
> >>>>On Sat, 2003-12-20 at 02:26, Nick Piggin wrote:
> >>>>
> >>>>>Christian Meder wrote:
> >>>>>
> >>>>>>On Sat, 2003-12-20 at 01:48, Nick Piggin wrote:
> >>>>>>
> >>>>>>>Sounds reasonable. Maybe its large interrupt or scheduling latency
> >>>>>>>caused somewhere else. Does disk activity alone cause a problem?
> >>>>>>>find / -type f | xargs cat > /dev/null
> >>>>>>>how about
> >>>>>>>dd if=/dev/zero of=./deleteme bs=1M count=256
> >>>>>>>
> >>>>>>Ok. I've attached the logs from a run with a call with only an
> >>>>>>additional dd. The quality was almost undisturbed only very slightly
> >>>>>>worse than the unloaded case.
> >>>>>>
> >>Since so many things have actually changed it's going to be hard to extract 
> >>what role the cpu scheduler has in this setting, but lets do our best.
> >>
> >>Is there a reason you're running gnomemeeting niced -10? It is hardly using 
> >>any cpu and the problem is actually audio in your case, not the cpu 
> >>gnomemeeting is getting. Running dependant things (gnomemeeting, audio 
> >>server, gnome etc) at different nice levels is not a great idea as it can 
> >>lead to priority inversion scenarios if those apps aren't coded carefully. 
> >>
> >>What happens if you run gnomemeeting at nice 0?
> >>
> >
> >Exactly the same. It was only reniced to -10 because I tried it and
> >forgot to set it back. With your scheduler renicing doesn't make a
> >difference. No matter if I renice the compile to 19 or gnomemeeting to
> >-10. With Nick's scheduler renicing gnomemeeting to -10 improves the
> >situation.
> >
> 
> (although not much Con)

right. Ok I'm running now 2.6.0 with Nick's v28p1: The results without
load and with kernel compile load are attached. On nice level 0 I get
now the stuttering sound which I described in the previous mail. When I
renice gnomemeeting to -10 it's actually usable but not as good as in
2.4.2x. It's still sensitive to window movement and X activity. Two
subjective observations are that the nice levels haven't got such a big
impact in Nick's scheduler they used to have and that the default
behaviour gnomemeetingwise is better than in earlier Nick schedulers.

> >
> >>How is your dma working on your disks?
> >>
> >
> >/dev/hda:
> > multcount    =  0 (off)
> > IO_support   =  0 (default 16-bit)
> > unmaskirq    =  0 (off)
> > using_dma    =  1 (on)
> > keepsettings =  0 (off)
> > readonly     =  0 (off)
> > readahead    = 256 (on)
> > geometry     = 65535/16/63, sectors = 117210240, start = 0
> >
> 
> This might be a problem - try turning unmaskirq on, and possibly
> 32-bit IO support on (hdparm -u1 -c1 /dev/hda). I think there is
> a remote possibility that doing this will corrupt your data just
> to let you know.

Tried it and doesn't make a difference.

> >
> >>What happens if you don't use an audio server (I'm not sure what the audio 
> >>server is in gnome); or if you're not using one what happens when you do?
> >>
> >
> >esd was running but I'm not sure gnomemeeting with ALSA support was
> >using it. After killing esd and retrying there was no difference.
> >
> 
> So the 1 gnomemeeting process is doing everything? (except display of 
> course)

AFAIK yes.


				Christian

> >
> >>Renice the audio server instead?
> >>
> >
> >gnomemeeting without audio server is showing the same phenomenon like
> >gnomemeeting with esd.
> >
> >
> >>You've already tried different audio drivers right?
> >>
> >
> >Yes, the phenomenon occurs for the OSS and the ALSA driver.
> >
> >
> >>Nice the compile instead of -nicing the other stuff.
> >>
> >
> >Tried it with same result (see above).
> >
> >
> >>Try the minor interactivity fix I posted only yesterday for different nice 
> >>level latencies:
> >>http://ck.kolivas.org/patches/2.6/2.6.0/patch-2.6.0-O21int
> >>
> >
> >Actually all the posted results were on a 2.6.0-test11-mm1 with your
> >patch added on top. So the patch didn't change anything for me.
> >
> >
> >>Is your network responsible and the audio unrelated? Some have reported 
> >>strange problems with ppp or certain network card drivers?
> >>
> >
> >The problem occurs whether I use my WLAN PCMCIA card or my PCMCIA
> >Ethernet card.
> >
> >
> >>As you see it's not a straight forward problem but there's some things for you 
> >>to get your teeth stuck into. As it stands the cpu scheduler from your top 
> >>output appears to be giving appropriate priorities to the different factors 
> >>in your equation.
> >>
> >
> >I know that the problem isn't straight forward that's why I refrained a
> >long time before posting to linux-kernel trying to rule out different
> >scenarios. As it stands I tried different gnomemeeting versions,
> >different audio drivers, different nice levels, different schedulers,
> >preemption on and off, ACPI on and off, -mm kernels and pristine Linus
> >kernels with no luck. If I put CPU load on my box the gnomemeeting
> >audiostream gets badly mutilated (unusable). There's not much left I can
> >think of that's why I'm finally posting to linux-kernel.
> >
> 
> Thanks for your effort.
> 
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
 




--=-byfqrIV9Xrfxi9OXzbKf
Content-Disposition: attachment; filename=nickload.tar.bz2
Content-Type: application/x-bzip; name=nickload.tar.bz2
Content-Transfer-Encoding: base64

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
JH5KX/4u5IpwoSCYwEhW

--=-byfqrIV9Xrfxi9OXzbKf
Content-Disposition: attachment; filename=nicknoload.tar.bz2
Content-Type: application/x-bzip; name=nicknoload.tar.bz2
Content-Transfer-Encoding: base64

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

--=-byfqrIV9Xrfxi9OXzbKf--

