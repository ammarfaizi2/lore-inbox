Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267461AbUG2VSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267461AbUG2VSH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 17:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUG2VSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 17:18:07 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:23189 "EHLO
	taverner.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S265102AbUG2VPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 17:15:49 -0400
From: David Wagner <daw@cs.berkeley.edu>
Message-Id: <200407292115.i6TLFTpo017213@taverner.CS.Berkeley.EDU>
Subject: Re: [PATCH] Delete cryptoloop
To: christophe@saout.de (Christophe Saout)
Date: Thu, 29 Jul 2004 14:15:29 -0700 (PDT)
Cc: jmorris@redhat.com (James Morris), linux-kernel@vger.kernel.org
In-Reply-To: <1091116240.12054.9.camel@leto.cs.pocnet.net> from "Christophe Saout" at Jul 29, 2004 05:50:39 PM
Secret-Bounce-Tag: 9a029cbee41caf2ca77a77efa3c13981
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout writes:
> IV = sector number (little endian, 32 bits), pad with zeroes
> The actual content is then encoded using the selected cipher and key in
> CBC mode.
> C[0] = E(IV     xor P[0])
> C[1] = E(C[0]   xor P[1])
> ...

Ok, that's what I thought.  The above is pretty good, but does have some
weaknesses due to the IV selection.  CBC mode needs uniformly random IVs
for security; using a counter can cause occasional information leakage.

1) Accidental leakage can happen, if you're a little unlucky.  Suppose
we have two sectors, numbered S and S' and with content P and P'
(respectively).  Check out what happens if the first block of sector
contents are related by P[0] xor P'[0] = S xor S': in this case (and
only this case), we have C[0] = C'[0].  Notice that an attacker can
recognize when this happens by just looking for a pair of sectors
whose ciphertexts start with the same block.  If he finds a pair of
sectors like this, he will be able to deduce the value P[0] xor P'[0]
(since sector numbers are known), and depending on data formats, this
might reveal relevant information about the corresponding plaintexts.

So if you're unlucky and two plaintexts are related in a special way,
some partial information can leak.  You have to ask how likely it will be
that this special relation will occur.  The answer depends on the format
of plaintexts.  If the first block of plaintexts are totally random,
then this relationship essentially never occurs (it has probability
1/2^128 for any pair of sectors, a truly negligible chance).

But, if blocks have some special formatting that makes them highly
non-random, the chance of information leakage can go up significantly.
For instance, suppose the first block of our data always contains
a 24-bit counter, little endian and padded with zeros, and suppose
we have a disk with 2^24 sectors (64 GB disk?).  Then the probability
of a special relationship between any pair of disk sectors is 1/2^24.
If 2^20 of the sectors hold data of this format, then we expect to find
about 2^20*(2^20 - 1)/2 * 1/2^24 ~= 2^15 pairs of sectors with this
special relationship.  In other words, there are about 2^15 pairs of
sectors where some partial information leaks to the attacker.

You can see that the information leakage is typically modest and limited;
in many cases, there might be no leakage at all.  Nonetheless, this is
not an ideal situation.  As a cryptographer, one would usually consider
this a flawed design (primarily because it is so easy to do better).
There are known ways to prevent this attack; for instance, IV = E(sector
number) or IV = HMAC(sector number) should be much better.

2) Intentional leakage can happen, if the attacker can exert any influence
over the data you store on your disk.  If I remember correctly, I think
this is M.J. Saarinen's scenario: the attacker specially chooses the
contents of your disk sectors to increase the probability of information
leakage (as described above), the attacker can arrange for this leakage
to occur with very high probability.  In the watermarking attack, the
attacker uses the absence/presence of leakage to determine whether your
disk contains a copy of his watermarked file.

The above analysis is only directed towards the threat model where the
attacker gets physical access to your hard disk once, and you never see
it again.  For instance, think of someone who steals your laptop and then
wants to read what's on your hard drive.  I ignored scenarios where the
attacker gets repeated access to your hard disk and can see what's stored
on it each time -- e.g., the janitor pokes around inside your machine
every night at midnight.  I also ignored scenarios where the attacker
gets access to your hard disk, makes some changes to the ciphertext,
and then you continue using the machine afterwards.  There is a big pile
of devastating attacks in these more sophisticated threat models, and
it would be prudent to assume that the current scheme might be totally
insecure in such scenarios.  I can say more if you want, but I suspect
the current scheme wasn't designed for security against repeated or
active attacks.

I also didn't look at key management -- e.g., how keys are generated
(passwords?), derived, stored, and destroyed (do they end up on swap
inadvertently?).  Be aware that this is another big potential source
of vulnerabilities.

I hope this helps get you started.  Sorry that I know nothing about
cryptoloop or dm-crypt; thanks for showing me the basic mode of operation
they use.  Feel free to let me know if you want to know more about any
aspect of this problem.

> Also see: http://clemens.endorphin.org/OnTheProblemsOfCryptoloop

The reasoning on that web page looks pretty confused to me.  It looks
to me like the author of that page does not understand cryptography
very well.  The author tries to calculate the probability of a special
relationship between sectors, but overlooks the possibility that data
might be formatted in a way that increases this probability.  This is
pretty basic, standard stuff in the crypto world, to be honest, so this
kind of mistake is not encouraging.
