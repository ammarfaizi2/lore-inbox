Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276486AbRJCQew>; Wed, 3 Oct 2001 12:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276492AbRJCQen>; Wed, 3 Oct 2001 12:34:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5899 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276486AbRJCQe1>; Wed, 3 Oct 2001 12:34:27 -0400
Date: Wed, 3 Oct 2001 09:33:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ben Greear <greearb@candelatech.com>
cc: jamal <hadi@cyberus.ca>, Ingo Molnar <mingo@elte.hu>,
        <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <3BBB31F4.C223E12E@candelatech.com>
Message-ID: <Pine.LNX.4.33.0110030920500.9427-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Oct 2001, Ben Greear wrote:
>
> Will NAPI patch, as it sits today, fix all IRQ lockup problems for
> all drivers (as Ingo's patch claims to do), or will it just fix
> drivers (eepro, tulip) that have been integrated with it?

Note that the big question here is WHO CARES?

There are two issues, and they are independent:
 (a) handling of network packet flooding nicely
 (b) handling screaming devices nicely.

First off, some comments:
 (a) is not a major security issue. If you allow untrusted users full
     100/1000Mbps access to your internal network, you have _other_
     security issues, like packet sniffing etc that are much much MUCH
     worse. So the packet flooding thing is very much a corner case, and
     claiming that we have a big problem is silly.

     HOWEVER, (a) _can_ be a performance issue under benchmark load.
     Benchmarks (unlike real life) are almost always set up to have full
     network bandwidth access, and can show this issue.

 (b) is to a large degree due to a stupid driver interface. I've wanted to
     change the IRQ handler functions to return a flag mask for about
     three years, but with hundreds of drivers it's always been a bit too
     painful.

     Why do we want to return a flag mask? Because we want the _driver_ to
     be able to say "shut me up" (if the driver cannot shut itself up and
     wants to throttle), and we want the _driver_ to be able to say "Hmm,
     that interrupt was not for me", so that the higher levels can quickly
     figure out if we have the case of us having two drivers but three
     devices, and the third device screaming its head off.

Ingo tries to fix both of these with a sledgehammer. I'd rather use a bit
more finesse, and as I do not actually agree with the people who seem to
think that this is a major problem TODAY, I'll be more than happy to have
people think about it. The NAPI people have thought about it - but it has
obviously not been descussed _nearly_ widely enough.

I personally am very nervous about Ingo's approach. I do not believe that
it will work well over a wide range of machines, and I suspect that the
"tunables" have been tuned for one load and one machine. I would not be
surprised if Ingo finds that trying to put the machine under heavy disk
load with multiple disk controllers might also cause interrupt mitigation,
which would be unacceptably BAD.

			Linus

