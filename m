Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWGPPgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWGPPgX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 11:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWGPPgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 11:36:22 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:64404
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S1750934AbWGPPgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 11:36:22 -0400
Date: Sun, 16 Jul 2006 17:36:49 +0200
From: andrea@cpushare.com
To: Pavel Machek <pavel@suse.cz>
Cc: Valdis.Kletnieks@vt.edu, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       Lee Revell <rlrevell@joe-job.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       bunk@stusta.de, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
Message-ID: <20060716153649.GA7822@opteron.random>
References: <20060711041600.GC7192@opteron.random> <200607111619.37607.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060712210545.GB24367@opteron.random> <1152741776.22943.103.camel@localhost.localdomain> <20060712234441.GA9102@opteron.random> <20060713212940.GB4101@ucw.cz> <20060713231118.GA1913@opteron.random> <200607150255.k6F2tS2R008742@turing-police.cc.vt.edu> <20060716005108.GK18774@opteron.random> <20060716015426.GB21162@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060716015426.GB21162@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2006 at 03:54:27AM +0200, Pavel Machek wrote:
> You won't know for sure... but. Let t be time takes to reload the
> cache. Let your random noise be in <0, t> interval. According to you,
> that would be okay. IT IS NOT.
> 
> If the original delay was long, and your generator returned t,
> attacker sees 2*t. He can be _sure_ delay was long now.

Well, it could be a random internet delay that made it 2*t. So you
certainly can't be sure, but I agree you can hope that you were lucky ;).

> If the delay was short, and your generator returns 0, attacker sees 0,
> and _knows_ delay was short. (Chance that generator produces 0 or t
> is

Yes, when you see zero you're sure there was no randomization, but the
zero is what you pay for adding randomization in the first place
(i.e. you need this zero delay for all the other points to become
random).

> small, but non zero).
> 
> Even if you do random noise in <0, 2*t) interval, I'll be able to
> gather some statistics.

And how would those statistic help you in extracting any meaningful
data out of the system? It's like if you've a .wav file completely
random except for a few points that you may guess they could be in
their original position (or close). With a few points scattered
randomly, you won't have any hope to listen to the wav music. It's not
like you're sampling a signal that repeat itself exactly the same
again and again so that you can reconstruct it by mixing the
zero-error points. To make an example when you measure the same point
again, and you won't get 0, you'll never know if it was the
artificial-random delay that made it non-zero, or if the randomizer
was 0 and this time the time measurement was non zero, or if it was a
network delay.

Even you were right that it would be theoretically feasible, at first
glance it sounds easier to crack the ssh key with brute force, than to
try to sniff the private key using your statistics on top of the
randomizer (even ignoring the number of network packets that you would
need to transfer ;).

Now going back to the current server code that doesn't have any
randomizer at all, keep in mind the attack in the paper happened in a
strictly artificial environment (not even close to real life), and the
TSC was used because it takes a nanosecond or so to run, so that you
can measure time at full cpu bandwidth (not at the rate of an
adsl). So if it could take 1 day of sniffing for the guy to extract
anything meaningful with the TSC in real life (which sounds very
unlikely too unless you run ssh in a loop), and you would find a way
to reliably measure the nanoseconds using a millisecond clock (and
here I mean there is no randomizer at all in the system, if I add the
randomizer the whole network attack would fall apart), it would take
you one million of days to sample the same data that the tsc can
sample in one day. And really it's double RTT because it's not a pure
p2p, and it'll be more likely in the order of 20msec if you're both an
adsl. That change alone will raise the time from 1 million days to 20
million days. Not only this assumes no randomizer, this also doesn't
account in any way the several repetition of measurements required to
apply ntp-like algorithms which would explode the number of days to
orders of magnitude bigger than the 1-20 million days mentioned above.

All the above considerations should be combined with the fact that a
CPUShare transaction takes 1 hour, not 1-20 million days. Once the
transaction is complete you will never know who you attach with next
time, so after one hour passes, your above statistic would be sampling
a different ssh private key, not the same one.

No matter from what point of view you revolt the problem, the network
attack sounds the least thing I could be concerned about, attacks
against urandom for the ssh private key generation sounds more likely
than this one.

And if somebody attempts this kind of attack, I'll be noticing with
the network bill ;). Once my network bill will be high enough I may
decide to add the randomizer just in case. The sell orders could have
network quotas as well in the future, so a seller can specify the max
amount of network data he accepts to transfer during the transaction
to be more secure and to generate less network traffic spread over the
hour of computations (so he can still leave a good portion of his adsl
free to surf or run other p2p software).

Last but not the least, completely closing the cache timing side
channel is possible if I wanted to by simply invalidate the whole l2
cache in the same place were I flip the cr4 (plus a change of the
scheduler to forbid seccomp and non-seccomp tasks to mix in the same
physical cpu). It's just not worth it.

While I want the best security available in the basic computing mode
supported by all clients (i.e. seccomp), CPUShare is very clear that
any exposure of confidential data through the internet, or any other
damage like spread of troyans, spyware, adware or viruses is at your
risk. While I'm convinced the network timing attack is a total
hogwash, CPU bugs are very possible, kernel bugs are very possible
too, those are orders of magnitude likely to be exploitable than
whatever network timing attack. No matter what technology I use,
everything can be buggy at both the hardware and software layer, even
the math itself of the crypto could have been proven wrong. There's no
way for me to provide any guarantee, the kernel itself is under the
GPL with no warranty, and so is seccomp under the GPL and with no
warranty too. I only can guarantee that I'm doing my best for anything
that makes sense (i.e. the tsc, since the tsc being so fast [and so
accurate too], million times more risky than whatever remote
clock). Worrying about the TSC sounds paranoid enough already,
worrying about the network attack is just way over I can consider to
have practical security relevance as of 2006 internet network
bandwidth and latency in connection with the current CPUShare code. As
I said I'd be glad to check again 10 years from now in the hope
latencies will go down to the usec and bandwidth up to the gigabits
like I strongly hope.

If you don't believe me and you want to be sure, feel free to add a
seccomp mode that flushes the cache at every context switch from
non-seccomp to seccomp plus the HT hack as I suggested above. You
don't have to trust me, all code that runs on your computer is free
software and not covered by any pending-patent at all, so you can
change it as you want, though if it was me I wouldn't do that since I
don't like to run slow for no apparent good reason.

If you've more doubts please feel free to go ahead, but I recommend to
move this thread on the security attacks on cpushare-devel mailing
list. This is way offtopic here (I'm answering in CC just to express
my point of view on the matter, but I don't think it's much relevant
for this list).

Thanks Pavel.
