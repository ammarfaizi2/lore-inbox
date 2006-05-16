Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWEPUSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWEPUSL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 16:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWEPUSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 16:18:10 -0400
Received: from thunk.org ([69.25.196.29]:23997 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750776AbWEPUSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 16:18:09 -0400
Date: Tue, 16 May 2006 16:17:49 -0400
From: Theodore Tso <tytso@mit.edu>
To: Zvi Gutterman <zvi@safend.com>
Cc: "'Muli Ben-Yehuda'" <muli@il.ibm.com>,
       "'Kyle Moffett'" <mrmacman_g4@mac.com>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Jonathan Day'" <imipak@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: /dev/random on Linux
Message-ID: <20060516201749.GA10077@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Zvi Gutterman <zvi@safend.com>, 'Muli Ben-Yehuda' <muli@il.ibm.com>,
	'Kyle Moffett' <mrmacman_g4@mac.com>,
	'Alan Cox' <alan@lxorguk.ukuu.org.uk>,
	'Jonathan Day' <imipak@yahoo.com>, linux-kernel@vger.kernel.org
References: <20060516082859.GD18645@rhun.haifa.ibm.com> <00fc01c678f0$30c77520$2c02a8c0@Safend.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00fc01c678f0$30c77520$2c02a8c0@Safend.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 04:54:00PM +0300, Zvi Gutterman wrote:
> 
> I did not get any answer from Matt and was sure that it was of no interest.
> This was my mistake, sorry for not sending it earlier to more people.

Note that Matt toke over maintainance from me, but I was the original
designer of most of the /dev/random algorithms (with much help from
Colin Plumb).  I haven't had time to do a full analysis of the paper,
but let me give a couple comments to set the context.

First of all, the Linux /dev/random generator has been around for a
long time; I did the original implementation back in 1994, back when
the crypto iron curtain was still being maintained by the US
Government.  (As far as I know, the Linux /dev/random driver was the
first OS-based RNG and predates efforts present in other systems such
as OpenBSD, et. al.  Not being an academic trying to get tenure, I
never bothered to write a paper back in '94, so I guess that means I
don't get any credit, which is probably fair if you're playing the
academic game.  Publish or perish, after all.  :-)  In any case,
because of the U.S.  export controls on cryptographic algorithms at
that time, in particular anything relating to encryption algorithms, I
chose to use cryptogaphic hashes as its primary non-linear component,
since these were not problematic from an export control perspective.

In addition, the design philosophy is somewhat different from what has
been considered the general wisdom at least in academic circles.
First of all, as noted above, export controls were a major issue.  In
addition, in that time period, flaws in MD4 and MD5 were coming to
light, and it was clear that some cryptographic algorithms provided by
the US government (in particular, DSA) were deliberately designed to
prevent their usefulness in anything other than their released context
(i.e., There are many who believe that one of the DSA primary design
criteria was that it could only be used for digital signatures, and
*not* provide encryption functionality).  So one of the key design
criteria was that /dev/random use its cryptographic primitives in ways
that were non-brittle --- that is, even if the primary use of that
cryptographic primitive were compromised (e.g., the recent collision
attacks against SHA-1), the security of the system would not be
compromised.

One of the reasons why I did not choose a construction such as Bruce
Schneier's Yarrow, which encrypts an incrementing counter as its
output stage, is that repeated encryptions of plaintexts that have
differ from each other by a small hamming distance is one of the
things that cryptographers look for when attacking a cipher.  Maybe
modern encryption systems are so good that we don't have to worry
about such things any more (and certainly most academic papers ignore
such engineering considerations), but I like to take a much more
humble attitude towards making such assumptions, since I *know* the
cryptographers at the NSA know more than I do, and underestimating
them or any other state-sponsored cryptoanalytic organization is
generally not a good idea.  In any case, while if AES is perfect, yes,
using a key to encrypt a counter might be probably good enough --- but
I'm not sure I want to make that assumption.

Secondly, attacks that assume that the attacker can obtain the
contents of the pool were not a major consideration, mainly because
practically speaking, if an attacker can obtain the contents of the
internal state of the RNG, the attacker generally has enough
privileges that the entire system has been compromised, meaning that
the system can be rooted to a fare-thee-well --- all future session
keys and data to be encrypted can then be collected, etc.  So attacks
of the form, "assume that the attack gains access to the pool, but has
no other illicit access to the system" are particularly practical in
the real world, and are mostly of concern to academics.

This is particularly tree of the criteria put forward by the designers
of the Yarrow RNG, where they were concerned about how quickly the RNG
could recover after the pool state got compromised.  My argument was
always that if an attacker had enough privileges to compromise the
internal state of the RNG, in the real world, recovery would require
re-installing from trusted media.

The desire for forward security is different, admittedly; here the
concern is that if the system has already been compromised, you don't
want to make it easy the attacker to find previously generated session
keys or even long-term keys.  However, it should be noted that it
takes O(2**64) operations to go back a single turn of the crank--- but
that only helps you get the last 10 bytes (80 bits) that were last
generated.  In order to get the next 80 bits, you have to do another
O(2**64) amount of work, and sooner or later (within 18 turns of the
crank, best case) you will run into one of the "unlucky" indexes where
it will take you at least O(2**96) of work effort.  To put this in
perspective, generating a 1024 bit RSA key will require approximately
14 turns of the crank, so if you are lucky with the positioning of the
index *and* you penetrate the machine and capture the state of the
pool (which as I mentioned, probably means you've rooted the box and
the system will probably have to be reinstalled from trusted media
anyway), *and* a 1024-bit RSA key had just been generated, you would
be able to determine that 1024-bit RSA key with a work factor of
approximately O(2**68) if you are lucky (probability 1 in 8), and
O(2**96) if you are not.  Should we try do better, sure, but this is
not the sort of thing where you have to keep a secret and only talk to
the official maintainer about it.

I would also note that one of the things Matt did after he took over
maintainership from me is that he took out a call to
add_timer_randomness() from the extract entropy code.  This bit of
code would have also significantly complicated practical attacks on
backtracking attacks, since it mixes in the TSC cycle counter at the
time of the entropy extraction into the pool.  So even if you capture
the state of the pool, unless you know exactly *when* each of the
various entropy extractions took place, you wouldn't be able to easily
calculate the various candidate pools.

More critically, the paper is seriously flawed in its analysis of
reversing the primary pool.  The only reason why the generic attack
takes only 2**96 when the secondary and urandom pools are only 32
words long, is that the entropy extraction routine is only calls
add_entropy_words ceil(n/32)+1 times.  However, the primary entropy
pool is 128 words long, which means that add_entropy_words() is called
9 times.  The paper recognizes this in Appendix B, which shows that j,
j-1, j-2, ... j-8 is modiified when extracting entropy from the
primary pool.  This makes the generic attack take work factor
O(2**288), and the optimized attack also has to be seriously reworked
before it can be carried out on the primary pool.  This also points
out that the simple expedient of doubling the size of the secondary
and urandom pool would effectively eliminate the practicality of
carrying out an forward attack.

In section 3.4, a comment is made about guessable passwords to seed
the entropy pool, and a recommendation was made to remove the value of
the keyboard from the input to the pool.  I would reject that
recommendation, since the entropy estimated is calulated based only on
the timing of the key, and the inter-key timing values is mixed into
*in* *addition* *to* the value of the keys typed.  If the user types a
known or guessable password, the yes, the value of what is typed is no
help in adding entropy to the pool --- but it doesn't hurt, either.  I
have no argument with the observation that main source of entropy
added is the inter-key arrival time, and even there we are extremely
conservative on estimating the amount of entropy found since obviously
the "fist" of a typist could be analyzed and used to provide some
information about inter-key arrival times, particularly if a
high-resolution time source is not available.

Speaking generally about usage scenarios such as the OpenWRT Linux
distribution, if there is no hard disk and relatively little user
input, the amount of entropy that can be gathered will suffer.  That
however isn't the fault of the /dev/random driver, but how it is put
to use.  One of the things which I would strongly recommend to
security applications, such as those found in the OpenWRT Linux
distribution, is to calculate the cryptographic hash of data which is
to be sent out encrypted, and write that into /dev/random, thus mixing
that hash into the entropy pool.  This will not provide any entropy
credits (since at least one entity would have knowledge of the value
of the hash).  However, to attackers that do *not* have access to the
plaintext of the encrypted communications sent out by the application,
this unknown data will significantly complicate the life of attackers
attempting to analyze the state of the random number generator.  In
the absence of hard drive-generated entropy or human-generated timing
data from a keyboard or pointing device, it's certainly better than
nothing, and in practice is quite effective.

All of this being said, I think the paper does make a number of good
points, and I would recommend making the following changes to Linux's
/dev/random:

1) Restore the add_timer_randomess() call to the entropy extraction
function.  This prevents the forward security attack unless the
attacker can know the exact time when each of the entropy extractions
took place, which in general is going to be quite impractical.

2) Double the size of the secondary and urandom pools from 128 to 256
bytes.

3) Investigate the possibility of adding quotas to /dev/random.  This
is actually much more trickier that the paper suggests, since you want
to allow the user to be able to extract enough entropy to create a
2048 bit (or at least a 1024-bit) RSA key.  The problem is that's a
lot of entropy!  Maybe it would be OK to only allow a 1024-bit RSA key
to be generated every 12 or 24 hours, but suppose someone is
experimenting with GPG and screws up (say they forget their
passphrase); do you tell them that sorry, you can't generating another
key until tomorrow?  So now we have to have an interface so the root
user can reset the user's entropy quota....  And even with a 24-hour
limit, on a diskless system, you don't get a lot of entropy, so even a
1024-bit RSA key could seriously deplete your supply of entropy.   

This last point is a good example of the concerns one faces when
trying to design a working system in the real word, as opposed to the
concerns of academicians, where the presence or lack of forward
security in the event of a pool compromise is issue of massive urgency
and oh-my-goodness-we-can-only-tell-the-maintainer-because-it's-such-a-
critical-security-hole attitude.  Where as my attitude is, "yeah, we
should fix it, but I doubt anyone has actually been harmed by this in
real life", which puts it in a different category than a buffer
overrun attack which is accessible from a publically available network 
service.

						- Ted
