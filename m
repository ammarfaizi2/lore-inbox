Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271600AbRHUIdL>; Tue, 21 Aug 2001 04:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271601AbRHUIdC>; Tue, 21 Aug 2001 04:33:02 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:7655 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271600AbRHUIcw>;
	Tue, 21 Aug 2001 04:32:52 -0400
Date: Tue, 21 Aug 2001 09:33:02 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Oliver Xymoron <oxymoron@waste.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Theodore Tso <tytso@mit.edu>, David Schwartz <davids@webmaster.com>,
        Andreas Dilger <adilger@turbolinux.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: /dev/random in 2.4.6
Message-ID: <605104920.998386381@[169.254.45.213]>
In-Reply-To: <Pine.LNX.4.30.0108200942060.4612-100000@waste.org>
In-Reply-To: <Pine.LNX.4.30.0108200942060.4612-100000@waste.org>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver,

--On Monday, 20 August, 2001 10:07 AM -0500 Oliver Xymoron 
<oxymoron@waste.org> wrote:

>> OK; well in which case it doesn't solve the problem. I assert there are
>> configurations where using the network to generate accounted for entropy
>> is no worse than the other available options. In that case, if my entropy
>> pool is low, I want to wait long enough for it to fill up (i.e. have the
>> /dev/random blocking behaviour) before reading my random number.
>
> No you don't, that's your whole complaint to start with. You're clearly
> entropy-limited. If you were willing to block waiting for enough entropy,
> you'd be fine with the current scheme.

Yes I /do/. I want to wait for sufficient entropy. I count inter-IRQ
timing from network as a source of entropy. IE if the entropy pool
is exhausted, I'm prepared to, and desire to, block, until a few packets
have arrived. However, I do not wish to block indefinitely (actually
about 3 minutes as there's a little periodic block I/O) which is what
happens if I do not count network IRQ timing as an entropy source
(current /dev/random result, without Robert's patch, on most NICs).
Equally, I do not want want to read /dev/urandom (and not block)
which, in an absence of entropy, is (arguably) cryptographically weaker
(see below).

> Now you've just pushed the problem
> out a little further.  Let's just assume that your application is some
> sorta secure web server, generating session keys for SSL. For short
> transactions, you'll need possibly hundreds of bits of entropy for a small
> handful of packets. With packet queueing on your NIC, under load you might
> only see a couple interrupts for an entire transaction.

Well it's mostly doing SMTP/IMAP over SSL, and on port 25, yes.

Measuring it there at least 16 network IRQs for the minimum
SSL transaction. That generates 16x12 = 192 bits of
entropy (each IRQ contributes 12 bits). However, that's aside from the
2 to 3 packets a second of other stuff arriving on the server (unencrypted
port 25, ARP broadcast, VRRP, all the rest of the crap on the LAN).

It's a point worth making that I'm not talking about theory here. It's
there, tested, both ways, in a real environment. Opening an IMAP folder
over SSL stalls 3 times, for between 30 seconds and 3 minutes *EACH*
from an idle machine without Robert's patch (well I just patched eepro).
With the patch, no stalls > about 3 secs, which are far rarer (quite
acceptable).

> Look, /dev/urandom _is_ cryptographically strong, and there's no attack
> against it that's even vaguely practical. It's good enough, and we can
> make it better. Overestimating entropy makes /dev/random no better in
> theory than /dev/urandom, blocking or no. What's the point?

You can't have your cake and eat it.

The point is simple: We say to authors of cryptographic applications
(ssl, ssh etc.) that they should use /dev/random, because /dev/urandom
is not cryptographically strong enough. Let's say I buy into this statement
(as if I don't, as one other poster has mentioned, we should just scrap
the blocking behaviour entirely). Well, I'd like /dev/random to be
functional in a headless environment. Perhaps not /quite/ as 'wonderful'
as it is in a non-headless environment, but better than /dev/urandom.

Saying 'well if you are writing a cryptographic application use should
use /dev/random, as this is the best source, but by the way, this means
your app will be dysfunctional on a headless machine, and we aren't
going to give you a config option to fix it' is the wrong approach
to OS design.

>> An alternative approach to all of this, perhaps, would be to use
>> extremely finely grained timers (if they exist), in which case more bits
>> of entropy could perhaps be derived per sample, and perhaps sample them
>> on more operations. I don't know what the finest resolution timer we have
>> is, but I'd have thought people would be happier using ANY existing
>> mechanism (including network IRQs) if the timer resolution was (say) 1
>> nanosecond.
>
> We can use cycle counters where they exist. They're already used on x86
> where available. I suspect that particular code could be made more
> generic.

Would you accept that if you are actually counting CPU clock cycles, then
in practice, timing between network IRQs is, in a substantial number of
configurations, a non-externally observable property, without access or
equipment that would allow you to observe the innards of the machine too?

--
Alex Bligh
