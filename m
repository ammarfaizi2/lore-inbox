Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276894AbRJ3RYn>; Tue, 30 Oct 2001 12:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276956AbRJ3RYd>; Tue, 30 Oct 2001 12:24:33 -0500
Received: from s2.relay.oleane.net ([195.25.12.49]:6 "HELO s2.relay.oleane.net")
	by vger.kernel.org with SMTP id <S276894AbRJ3RY1>;
	Tue, 30 Oct 2001 12:24:27 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>,
        Andrea Arcangeli <andrea@suse.de>, Benjamin LaHaise <bcrl@redhat.com>,
        <paulus@samba.org>
Subject: Re: please revert bogus patch to vmscan.c
Date: Tue, 30 Oct 2001 18:23:52 +0100
Message-Id: <20011030172352.16727@smtp.adsl.oleane.com>
In-Reply-To: <Pine.LNX.4.33.0110300835140.8603-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0110300835140.8603-100000@penguin.transmeta.com>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Now, it's not true on _all_ PPC's.
>
>The sane PPC setups actually have a regular soft-filled TLB, and last I
>saw that actually performed _better_ than the stupid architected hash-
>chains. And for the broken OS's (ie AIX) that wants the hash-chains, you
>can always make the soft-fill TLB do the stupid thing..
>
>(Yeah, yeah, I'm sure you can find code where the hash-chains are faster,
>especially big Fortran programs that have basically no tear-down and
>build-up overhead. Which was why those things were designed that way, of
>course. But it _looks_ like at least parts of IBM may finally be wising up
>to the fact that hashed TLB's are a stupid idea).

Well, I lack experience to state which scheme is better, but there is
definitely overhead intruduced by our hash management in linux on ppc,
since we have to evicts pages from the hash as soon as we test&clear
PAGE_ACCESSED or PAGE_DIRTY.
That means we keep flushing pages out of the hash table, which seems
to be defeat the purpose of that big hash table supposed to hold the
PTEs for everybody out there more/less permanently.

However, I was thinking about a possible solution, please tell me
if I'm completely off here or if it makes sense.

Since we can't (AFAIK) have linux use larger PTEs (in which case we
could store a pointer to the hash PTE in the linux PTE), We could
instead layout an array of pointer (one for each page) that would
hold these.

That way, we have a fast way to grab the real accessed and dirty
bits, which means we no longer need to flush hash pages when getting
those bits and have a more realistic PAGE_ACCESSED (currently, any page
in the hash has PAGE_ACCESSED).

Comments ?

Ben.


