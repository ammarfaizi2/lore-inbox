Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263764AbTLTBMJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 20:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbTLTBMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 20:12:09 -0500
Received: from port-212-202-159-243.reverse.qsc.de ([212.202.159.243]:51435
	"EHLO mail.onestepahead.de") by vger.kernel.org with ESMTP
	id S263764AbTLTBL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 20:11:56 -0500
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
From: Christian Meder <chris@onestepahead.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3FE39C7A.7050507@cyberone.com.au>
References: <1071864709.1044.172.camel@localhost>
	 <20031219203227.GR31393@holomorphy.com>
	 <1071876632.1044.179.camel@localhost>  <3FE39603.9000501@cyberone.com.au>
	 <1071880660.1044.194.camel@localhost>  <3FE39C7A.7050507@cyberone.com.au>
Content-Type: multipart/mixed; boundary="=-0RvE3v91X4mpHke8toCo"
Message-Id: <1071882705.1044.207.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 20 Dec 2003 02:11:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0RvE3v91X4mpHke8toCo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2003-12-20 at 01:48, Nick Piggin wrote:
> Christian Meder wrote:
> 
> >On Sat, 2003-12-20 at 01:21, Nick Piggin wrote:
> >
> >>Christian Meder wrote:
> >>
> >>
> >>>On Fri, 2003-12-19 at 21:32, William Lee Irwin III wrote:
> >>>
> >>>
> >>>>On Fri, Dec 19, 2003 at 09:11:50PM +0100, Christian Meder wrote:
> >>>>
> >>>>
> >>>>>I've got a longstanding regression in gnomemeeting usage when switching
> >>>>>between 2.4 and 2.6 kernels.
> >>>>>Phenomenon: 
> >>>>>Without load gnomemeeting VOIP connections are fine. As soon as some
> >>>>>load like a kernel compile is put on the laptop the gnomemeeting audio
> >>>>>stream is cut to pieces and gets unintelligible . On 2.4.2x I don't get
> >>>>>even the slightest distortion in the audio stream under load. I played
> >>>>>around with different nice levels with no success. The problem persisted
> >>>>>during the whole 2.6.0-test series no matter whether I used -mm kernels
> >>>>>or pristine Linus kernels. Even when nicing the kernel compile to +19
> >>>>>the distortions start right away. I tried Nick Piggin's scheduler which
> >>>>>fared slightly better after changing the nice level of gnomemeeting to
> >>>>>-10 but it's still a far cry from the 2.4.2x feeling without any
> >>>>>fiddling with nice values.
> >>>>>Any hints where to start looking are greatly appreciated.
> >>>>>
> >>>>>
> >>>>Please instrument your workload with the following, and send logs of the
> >>>>output (preferably compressed) to me and possibly others:
> >>>>
> >>>>top b d 5
> >>>>vmstat 5
> >>>>while true; do cat /proc/vmstat; sleep 5; done
> >>>>while true; do cat /proc/meminfo; sleep 5; done
> >>>>
> >>>>A good way to log commands like this is:
> >>>>
> >>>>(command) > /home/foo.log.1 2>&1 &
> >>>>
> >>>>where parentheses surround the command in the actual shell input.
> >>>>
> >>>>
> >>>Hi,
> >>>
> >>>I've attached the tarred output of a gnomemeeting run without load and
> >>>without distortions and another tarred output of a gnomemeeting run
> >>>while compiling a kernel with severe distortions in the audio stream.
> >>>
> >>>
> >>You're getting a lot fewer interrupts in the loaded case. Maybe its
> >>the sound card driver that has the regression from 2.4? It could be
> >>that 2.6 allows a smaller sound fragment size which is more stressful.
> >>
> >>
> >
> >Well I had the same problem with the OSS driver on 2.6. Now I use the
> >ALSA driver because I thought that could possibly improve things. The
> >ALSA driver is better indeed but it doesn't change this particular
> >phenomenon. Additionally I'd guess that the latest ALSA driver in 2.4
> >and 2.6 doesn't differ significantly and 2.4.2x with the latest ALSA
> >works great while 2.6 doesn't.
> >
> >
> 
> Sounds reasonable. Maybe its large interrupt or scheduling latency
> caused somewhere else. Does disk activity alone cause a problem?
> find / -type f | xargs cat > /dev/null
> how about
> dd if=/dev/zero of=./deleteme bs=1M count=256

Ok. I've attached the logs from a run with a call with only an
additional dd. The quality was almost undisturbed only very slightly
worse than the unloaded case.

> You said it faired slightly better with my scheduler when renicing
> gnome meeting to -10. How much better is that?

Worse than unloaded and worse than the disk loaded case from above. But
all (CPU) loaded cases were producing almost complete audio dropouts
while with your scheduler and renicing to -10 I got at least a
stuttering audio stream (a regular pattern of very short slices of audio
mixed with very short slices of silence).

> whats your /proc/cpuinfo?

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 1
cpu MHz         : 451.193
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 447.48



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
 




--=-0RvE3v91X4mpHke8toCo
Content-Disposition: attachment; filename=diskload.tar.bz2
Content-Type: application/x-bzip; name=diskload.tar.bz2
Content-Transfer-Encoding: base64

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
UnZOydU9ielPNPkmvYnJOaeqXLtR5J3aFYnNNv9E7k1XJORSyPWmR5ivfSfXJqXlHso4VXzj8vy/
H9X+vSTsn1p7E7J7E96eUfDzj4UbVLeFb0mifZRkl3E5RkfCOdJck5p1jaPimkwm9TUZW0dExPCE
3TE6iuaaj5pzTl+ZS4j40mdU708EyNCvgmyc6TeT8k2TxTdPWmkyPAVyjxjhOick9dG4r1Jid6aT
vTE4TpCudJ2xPyjaNJ5pyT1JyJ7KN06x3qrl8U6dYyTyTvThMT6FWqT0o4TaTUak8KVc5MjUK2o3
k7qNSW1SZJepMjyFbJqOicpNUfUnZBdqNk0m0F805pqCV0T6U+6OSbJ9mu5X0JleicJ3J2jmmJsn
7KOI/1TYVvwnjHOPWm6ZwmydUxNJunEe2P8fbJ8k809adKTvTdOybJ74/zjeCVpeCfyptR6o7JzS
rSd1J2oTST3/lfh+Qflcm0d1lwuIN3dFuuZdElxpG0bmCYxeMS5KGjAZUfQv7EqlqTJPNZJiZSft
o2TuT9afan56bRiySwsFepMirE0nSP7I3k5Se+jcVke+k/M4jKmRV3p7F1qNJyTUffXROE4pNJ3p
+ijrJ9aq/OK+KfKT98n+Hxyssss+M2ZZfwV/esWGk4k+cmcr58xXEm6fSnCcpNk+9Nk5FiraWKWB
IGQLR4hbGdZUtGDiGImSia8jSlptC8kzKc6pmdRCHlknzEIduT9Ee5NCvOT5J6JqFaTomk/z/Dmn
onuTl9sbp8ZOkbpPoTdMT9o0K3Fd+SYmCu+ao5xqrYV/dG6dk5CvuT8E5p+1OScJ0TWkxVWJ+lNJ
2JumqPQi6JyTSfoT9Kv6ckryTrGJiYnenl93difn1J90rzT1pqo1kmZG0m1HJNpS9or2J/MnBF/R
HvpOknWTBX7E702VKXzqXsTlyTUK96pS3Ff8oq5R2Fc0/3p746R7Y/GjmnJN09E4k70708U9yaTj
MJPsj4RkfNPUnenykxPgnv6KW6q2TxUvinaKvOMoyMpL1J6k6x605piZSfsTsRbx3E9aYFfb9PtT
8E5+ieNHtT5J6o+pPRPaK8JXmqr2pkndie6ksTcVzUvySrqnNJwmJ/wgle2P/MdE4T1pwnvukneq
UusbJqT4JzqWye9NqPqjhPWm+8vJMpJXcnrTp1Fd2Rvr8k0c0yd6YmSd6co3j6E0nzT2pyjuT1J+
5PUninRO+T747k0nwk6Sa/pxGKY9CLhPaK4jE9q3T1xuK/2JiepOya6J7E4FcJuK8E849I8F9KdE
y9QdC+k/VISSSSSSSQoXz4qH5VD0jBWJ6vUpdE29lGE36SclSliepOieSeibp9keUZGRwMTZNCvb
HfGydUTahkdE4TdMUt6jajUecd6b1LuTvTomwrSck0mydpMTqnRNpOExPantSrxToK7k+v6qfZum
4rpHinenenqjSeCZCtJtCu6PNMjI+SYn54/+R0o7pOUcoxPbHsTdPNNJ6JtGJgrFV/qtqO5Osm4r
aPBKvFN5OadfPcV9grnRxHs/cJil4pibJ8E0jrHMVuK7kyTon1p7fTCwszKF0jton60+Sbp9YrOi
dU/wVX/8XckU4UJCrjxV2O==

--=-0RvE3v91X4mpHke8toCo--

