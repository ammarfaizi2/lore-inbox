Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269947AbRHJQp7>; Fri, 10 Aug 2001 12:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269949AbRHJQpu>; Fri, 10 Aug 2001 12:45:50 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:10253 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269947AbRHJQpd>; Fri, 10 Aug 2001 12:45:33 -0400
Date: Fri, 10 Aug 2001 09:45:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Steven Cole <elenstev@mesatop.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Some dbench 32 results for 2.4.8-pre8, 2.4.7-ac10, and 2.4.7
In-Reply-To: <200108101328.f7ADSue26118@thor.mesatop.com>
Message-ID: <Pine.LNX.4.33.0108100933240.1869-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Aug 2001, Steven Cole wrote:
> Linus Torvalds wrote:
> >Does the numbers change if you do something like
> >
> >	killall -STOP kupdated
> >	echo 80 64 64 256 500 6000 90 > /proc/sys/vm/bdflush
> >
> >In particular, the dirty balancing worked really badly before, and was
> >just fixed.  I suspect that the bdflush numbers were tuned with the
> >badly-working case, and they might be a bit too aggressive for dbench
> >these days..
>
> Sorry Linus for the late reply, but I went to bed just before your message.
> I re-ran dbench 32 with the settings above.  Here are the results:

[ Good, looks more like it ]

Now, the problem with dbench is that no way in hell should you optimize
for dbench in general, because it is a sucky kind of benchmark.

For example, waiting until the last possible minute for writeouts is
definitely the best setting for dbench, but it's a pretty horrible setting
for usability.

I suspect that for optimal dbench performance we'll always have to let teh
system admin do the above kind of horrible tweaking stuff, but at the same
time I personally absolutely detest the need for tweaks in general, and I
would like the default behaviour to be reasonable.

Killing kupdated, for example, is not really "reasonable". But I also
suspect that now that dirty balancing works sanely, the "start writeout at
30% full" is a bit early too.

So instead of the 30/60% split (the first number is "when do we start
writing things out", and the second number is "when do we start actively
waiting for it"), a 50/75% setup might be more reasonable for regular
loads, while making dbench at least a bit happier.

Are you (or others) willing to play around with the numbers a bit and look
at both dbench performance and at interactive feel?

In general

	echo x 64 64 256 500 3000 y > /proc/sys/vm/bdflush

will set the "start writeout" to 'x'%, and the "start synchronous wait" to
'y'% (and restart kupdated with "killall -CONT kupdated"). It would be
interesting to hear where the sweet spot is.

		Linus

