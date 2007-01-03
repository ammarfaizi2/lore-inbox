Return-Path: <linux-kernel-owner+w=401wt.eu-S1750895AbXACQKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbXACQKT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 11:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbXACQKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 11:10:19 -0500
Received: from smtp.osdl.org ([65.172.181.25]:54613 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895AbXACQKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 11:10:17 -0500
Date: Wed, 3 Jan 2007 08:03:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Grzegorz Kulewski <kangur@polcom.net>
cc: Alan <alan@lxorguk.ukuu.org.uk>, Mikael Pettersson <mikpe@it.uu.se>,
       s0348365@sms.ed.ac.uk, 76306.1226@compuserve.com, akpm@osdl.org,
       bunk@stusta.de, greg@kroah.com, linux-kernel@vger.kernel.org,
       yanmin_zhang@linux.intel.com
Subject: Re: kernel + gcc 4.1 = several problems
In-Reply-To: <Pine.LNX.4.63.0701031128420.14187@alpha.polcom.net>
Message-ID: <Pine.LNX.4.64.0701030731080.4473@woody.osdl.org>
References: <200701030212.l032CDXe015365@harpo.it.uu.se>
 <20070103102944.09e81786@localhost.localdomain> <Pine.LNX.4.63.0701031128420.14187@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-1679182674-1167840217=:4473"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-1679182674-1167840217=:4473
Content-Type: TEXT/PLAIN; charset=US-ASCII



On Wed, 3 Jan 2007, Grzegorz Kulewski wrote:
> 
> Could you explain why CMOV is pointless now? Are there any benchmarks proving
> that?

CMOV (and, more generically, any "predicated instruction") tends to 
generally a bad idea on an aggressively out-of-order CPU. It doesn't 
always have to be horrible, but in practice it is seldom very nice, and 
(as usual) on the P4 it can be really quite bad.

On a P4, I think a cmov basically takes 10 cycles.

But even ignoring the usual P4 "I suck at things that aren't totally 
normal", cmov is actually not a great idea. You can always replace it by

		j<negated condition> forward
		mov ..., %reg
	forward:

and assuming the branch is AT ALL predictable (and 95+% of all branches 
are), the branch-over will actually be a LOT better for a CPU.

Why? Becuase branches can be predicted, and when they are predicted they 
basically go away. They go away on many levels, too. Not just the branch 
itself, but the _conditional_ for the branch goes away as far as the 
critical path of code is concerned: the CPU still has to calculate it and 
check it, but from a performance angle it "doesn't exist any more", 
because it's not holding anything else up (well, you want to do it in 
_some_ reasonable time, but the point stands..)

Similarly, whichever side of the branch wasn't taken goes away. Again, in 
an out-of-order machine with register renaming, this means that even if 
the branch isn't taken above, and you end up executing all the non-branch 
instructions, because you now UNCONDITIONALLY over-write the register, the 
old data in the register is now DEAD, so now all the OTHER writes to that 
register are off the critical path too!

So the end result is that with a conditional branch, ona good CPU, the 
_only_ part of the code that is actually performance-sensitive is the 
actual calculation of the value that gets used!

In contrast, if you use a predicated instruction, ALL of it is on the 
critical path. Calculating the conditional is on the critical path. 
Calculating the value that gets used is obviously ALSO on the critical 
path, but so is the calculation for the value that DOESN'T get used too. 
So the cmov - rather than speeding things up - actually slows things down, 
because it makes more code be dependent on each other.

So here's the basic rule:

 - cmov is sometimes nice for code density. It's not a big win, but it 
   certainly can be a win.

 - if you KNOW the branch is totally unpredictable, cmov is often good for 
   performance. But a compiler almost never knows that, and even if you 
   train it with input data and profiling, remember that not very many 
   branches _are_ totally unpredictable, so even if you were to know that 
   something is unpredictable, it's going to be very rare.

 - on a P4, branch mispredictions are expensive, but so is cmov, so all 
   the above is to some degree exaggerated. On nicer microarchitectures 
   (the Intel Core 2 in particular is something I have to say is very nice 
   indeed), the difference will be a lot less noticeable. The loss from 
   cmov isn't very big (it's not as sucky as P4), but neither is the win 
   (branch misprediction isn't that expensive either).

Here's an example program that you can test and time yourself. 

On my Core 2, I get

	[torvalds@woody ~]$ gcc -DCMOV -Wall -O2 t.c
	[torvalds@woody ~]$ time ./a.out
	600000000

	real    0m0.194s
	user    0m0.192s
	sys     0m0.000s

	[torvalds@woody ~]$ gcc -Wall -O2 t.c
	[torvalds@woody ~]$ time ./a.out
	600000000
	
	real    0m0.167s
	user    0m0.168s
	sys     0m0.000s

ie the cmov is quite a bit slower. Maybe I did something wrong. But note 
how cmov not only is slower, it's fundamnetally more limited too (ie the 
branch-over can actually do a lot of things cmov simply cannot do).

So don't use cmov. Except for non-performance-critical code, or if you 
really care about code-size, and it helps (which is actually fairly rare: 
quite often cmov isn't even smaller than a conditional jump and a regular 
move, partly because a regular move can take arguments that a cmov cannot: 
move to memory, move from an immediate etc etc, so depending on what 
you're moving, cmov simply isn't good even if it's _just_ a move).

(For me, the "cmov" version of the function ends up being three bytes 
shorter. So it's actually a good example of everything above)

			Linus

(*) x86 only has "move to register" as a predicated instruction, but some 
other architectures have lots of them, potentially all instructions. I 
don't count conditional branches as "predicated", although some crazy 
people do. ARM has predicated instructions (but they are gone in Thumb, I 
think), and ia64 obviously has predicated instructions (but it will be 
gone in a few years ;)
---1463790079-1679182674-1167840217=:4473
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=t.c
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0701030803370.4473@woody.osdl.org>
Content-Description: 
Content-Disposition: attachment; filename=t.c

I2luY2x1ZGUgPHN0ZGlvLmg+DQoNCi8qIEhvdyBtYW55IGl0ZXJhdGlvbnM/
ICovDQojZGVmaW5lIElURVJBVElPTlMgKDEwMDAwMDAwMCkNCg0KLyogV2hp
Y2ggYml0IG9mIHRoZSBjb3VudGVyIHRvIHRlc3Q/ICovDQojZGVmaW5lIEJJ
VCAxDQoNCiNpZmRlZiBDTU9WDQoNCiNkZWZpbmUgY2hvb3NlKGksIGEsIGIp
ICh7CQkJXA0KCXVuc2lnbmVkIGxvbmcgcmVzdWx0OwkJCVwNCglhc20oInRl
c3RsICUxLCUyIDsgY21vdm5lICUzLCUwIglcDQoJCToiPXIiIChyZXN1bHQp
CQkJXA0KCQk6ImkiIChCSVQpLAkJCVwNCgkJICJnIiAoaSksCQkJXA0KCQkg
InJtIiAoYSksCQkJXA0KCQkgIjAiIChiKSk7CQkJXA0KCXJlc3VsdDsgfSkN
Cg0KI2Vsc2UNCg0KI2RlZmluZSBjaG9vc2UoaSwgYSwgYikgKHsJCQlcDQoJ
dW5zaWduZWQgbG9uZyByZXN1bHQ7CQkJXA0KCWFzbSgidGVzdGwgJTEsJTIg
OyBqZSAxZiA7IG1vdiAlMywlMFxuMToiCVwNCgkJOiI9ciIgKHJlc3VsdCkJ
CQlcDQoJCToiaSIgKEJJVCksCQkJXA0KCQkgImciIChpKSwJCQlcDQoJCSAi
ZyIgKGEpLAkJCVwNCgkJICIwIiAoYikpOwkJCVwNCglyZXN1bHQ7IH0pDQoN
CiNlbmRpZg0KDQppbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQp7
DQoJaW50IGk7DQoJdW5zaWduZWQgbG9uZyBzdW0gPSAwOw0KDQoJZm9yIChp
ID0gMDsgaSA8IElURVJBVElPTlM7IGkrKykgew0KCQl1bnNpZ25lZCBsb25n
IGEgPSA1LCBiID0gNzsNCgkJc3VtICs9IGNob29zZShpLCBhLCBiKTsNCgl9
DQoJcHJpbnRmKCIlbHVcbiIsIHN1bSk7DQoJcmV0dXJuIDA7DQp9DQo=

---1463790079-1679182674-1167840217=:4473--
