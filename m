Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277108AbRJDEMt>; Thu, 4 Oct 2001 00:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277109AbRJDEMj>; Thu, 4 Oct 2001 00:12:39 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:34566 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S277108AbRJDEM1>; Thu, 4 Oct 2001 00:12:27 -0400
Date: Thu, 4 Oct 2001 00:12:52 -0400
Message-Id: <200110040412.f944CqS08736@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
X-Newsgroups: linux.dev.kernel
In-Reply-To: <Pine.LNX.4.33.0110030920500.9427-100000@penguin.transmeta.com>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0110030920500.9427-100000@penguin.transmeta.com> 
    torvalds@transmeta.com wrote:
>Note that the big question here is WHO CARES?
>
>There are two issues, and they are independent:
> (a) handling of network packet flooding nicely
> (b) handling screaming devices nicely.
>
>First off, some comments:
> (a) is not a major security issue. If you allow untrusted users full
>     100/1000Mbps access to your internal network, you have _other_
>     security issues, like packet sniffing etc that are much much MUCH
>     worse. So the packet flooding thing is very much a corner case, and
>     claiming that we have a big problem is silly.

  Did something give you the idea that this only happens on internal
networks? Generally we have untrusted users on external networks, and
lots of them. I have seen problems on heavily loaded DNS and news
servers, and can easily imagine that routers would get it as well. It
doesn't take someone running a load generator to generate load! I have a
syslog server which gets packets from the cluster, and the irq rate on
that gets high enough to worry me, although that tends to be spike load.

|      HOWEVER, (a) _can_ be a performance issue under benchmark load.
|      Benchmarks (unlike real life) are almost always set up to have full
|      network bandwidth access, and can show this issue.

| Ingo tries to fix both of these with a sledgehammer. I'd rather use a bit
| more finesse, and as I do not actually agree with the people who seem to
| think that this is a major problem TODAY, I'll be more than happy to have
| people think about it. The NAPI people have thought about it - but it has
| obviously not been descussed _nearly_ widely enough.

  It is a problem which happens today, on production servers in use
today, and is currently solved by using more servers than would be
needed if the system didn't fall over under this type of load.

| I personally am very nervous about Ingo's approach. I do not believe that
| it will work well over a wide range of machines, and I suspect that the
| "tunables" have been tuned for one load and one machine. I would not be
| surprised if Ingo finds that trying to put the machine under heavy disk
| load with multiple disk controllers might also cause interrupt mitigation,
| which would be unacceptably BAD.

  I will agree that some care is going to be needed to avoid choking the
system, but honestly I doubt that there will be a rush of people going
out and bothering with the feature unless they neeed it. There is some
rate limiting stuff in iptables, and I would bet a six pack of good beer
very few people bother to use them at all unless they are having a
problem. I don't recall any posts saying "I shot myself in the foot with
packet rate limiting."

  As I understand the patch, it applies to individual irq and not to the
system as a whole. I admit I read the description and not the source.
But even with multiple SCSI controllers, I can't imagine hitting 20k
irq/sec, which you can with a few NICs. I am amazed that Linux can
function at 70k context switches/sec, but it sure doesn't function well!

  I think the potential for harm is pretty small, and generally when you
have the problem you run vmstat (or vmstat2) to see what's happening,
and if the system melts just after irq rate hits N, you might start with
80% of N as a first guess. The performance of a locked-up system is
worse than one dropping packets.

  The full fix you want is probably a good thing for 2.5, I think it's
just too radical to drop into a stable serveis (my opinion only).

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe
