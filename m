Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317247AbSEXTrM>; Fri, 24 May 2002 15:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317248AbSEXTrL>; Fri, 24 May 2002 15:47:11 -0400
Received: from mail.storm.ca ([209.87.239.66]:34218 "EHLO mail.storm.ca")
	by vger.kernel.org with ESMTP id <S317247AbSEXTrK>;
	Fri, 24 May 2002 15:47:10 -0400
Message-ID: <3CEE8B6C.86965CB@storm.ca>
Date: Fri, 24 May 2002 14:50:20 -0400
From: Sandy Harris <pashley@storm.ca>
Organization: Flashman's Dragoons
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: hug@toad.com
Subject: Re: Linux crypto?
In-Reply-To: <E17BKDy-00075q-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > well probably everything which isn't plain english written with a pen
> > on white paper would be outlawed by then ;)
> > ... but what about having all the crypto stuff in question beeing handled
> > by modules (developed outside the USSA) and having the networking-related
> > code in the kernel - could the hooks itself be a problem?

Any "crypto-shaped hole" -- any interface exclusively designed for crypto,
or anything like a ipsec_init() call in the networking code -- is covered.

A general-purpose interface is, theoretically at least, not covered. If
the crypto plugs in to a standard kernel module interface, or to
netfilter's interface for proxies and such, then the crypto code itself
may still be restricted, but the kernel side code shouldn't be.
 
> The US types really want to make that possibility exist.

Yes, and the US gov't can change the rules. In particular, they might
invent some interpretation that invalidates my second paragraph above
and try to enforce it.

> FreeSWAN put a huge amount of effort into their project. They don't 
> want to make it possible for the US government to screw them around
> as well.

This is a worthy and, given the history, quite likely a necessary goal.
Most FreeS/WAN work has been done in Canada -- with contributions from 
many places, but no code from the US -- for exactly that reason. See 
discussion at:
http://www.freeswan.org/freeswan_trees/freeswan-1.95/doc/politics.html#exlaw

On the other hand, getting strong crypto -- including IPsec -- into
the main kernel tree is also a thoroughly worthy goal.

On yet another hand, it seems obviously reasonable for kernel maintainers
not to accept code they cannot change.

Is there any way to meet both goals? Would a BOF on the topic at OLS
be useful?

Here are my suggestions as posted to a couple of other lists a week
or so ago. I don't imagine I have it right yet, but perhaps this
would do as a starting point:

Subject: [Design] Re: latest patches
Date: Tue, 21 May 2002 14:59:06 -0700
From: Sandy Harris <sandy@storm.ca>
To: linux-crypto@nl.linux.org
CC: design@lists.freeswan.org, tytso@mit.edu
Followup-To: linux-crypto@nl.linux.org
In-Reply-To: <Pine.LNX.4.44.0205211623020.6721-100000@boris.prodako.se>
<1021999182.2875.135.camel@janus.txd.hvrlab.org>

[added cc to FreeS/WAN list and random.c author, and set followup-to]

Herbert Valerio Riedel wrote:

> > 1. Crypto support (no algorithms).  This can go into the official kernel,
> >    at least once the API is stable. ...
> 
> > 2. Crypto modules.  Can probably not to inte the official kernel due to
> >    crypto export regulations.

That doesn't work, at least not for US export regs. Any "crypto-shaped
hole" -- any interface or plug-in support that is specifically for
cryptography -- is restricted in exactly the same way as the crypto
itself.

However, if you use a generic multi-purpose interface, such as the
Linux kernel modules interface or for IPsec, the interface that
netfilter provides, then that interface is not restricted.

Can the encrypted file system stuff use such an interface? Could
FreeS/WAN?

The good news about export regs is that, after two court losses
in the Bernstein case (http://www.eff.org/bernstein/) the US gov't
"liberalised" their regs so they now partially comply with the
Wassenaar agreement (http://www.fitug.de/news/wa/index.html).
That agreement says "public domain" code is exempt from its
restrictions, period. Until Bernstein, the US ignored that and
applied full restrictions. Now they only require notification
for export of"public domain" source code.

So under current regs, as long as kernel.org does some
paperwork (which I think they have) there's no legal problem
for crypto in the Linux kernel source. 

Of course, that does not cover US companies such as Redhat
who might want to ship compliled code. It should, since the
US has signed the Wassennaar agreement, but ...

Also, it does not change the FreeS/WAN project's policy of
carefully ensuring that their code is entirely developed
outside the US so that even if the US gov't change the rules
again, they cannot restrict FreeS/WAN.

> some people also suggested splitting the ciphers up into
> patented/non-patented, weak/strong, ...

Why on Earth would you want either patented or weak ciphers?

As I see it, you want only a very few ciphers, ideally only one.
Simplicity is a great virtue in security software.

Currently, I think the possible collection of crypto in the
kernel is:
        drivers/char/random.c
                #define for either MD5 or SHA-1
                MD4 for the TCP sequence # part
        ipsec
                both MD5 and SHA-1
                3DES
        JuanJo's patches for ipsec
                AES cipher
                some of SHA-256, -384, -512
        loop stuff
                multiple ciphers

As far as I know, these are independent/duplicated. Many kernels
will have two copies of MD5, one each in the random and ipsec
code. If you use AES in both an encrypted file system and in 
IPsec, you'll have two copies (versions?) of the AES code.

This is not a major problem, but it appears worth fixing. 
  
> > 3. Encrypted loop driver.
> >
> > What do you think?
> good point...
> 
> the crypto api itself almost kernel version independent, so it might
> well justify splitting it from the cryptoloop application, which is the
> biggest headache to keep in sync with the rest of the kernel...
> 
> that's one of the reasons why I started to split off the loop-modifying
> stuff into a patch of it's own (loop-jari/hvr patches)...
> 
> now I'll just have to figure out a way to accomplish the split without
> letting maintenance get unreasonable...

I'd like to see, in the main kernel tree, one good hash and one good
cipher. Then use them in all the above places. 

For AES in IPsec, the default (and the only required) algorithms are 
AES with 128-bit key and SHA-256. That makes them the obvious choices.

You might want somewhat more than that.

IPsec would probably want MD5, SHA-1 and 3DES for interoperability,
RFC compliance and backward compatibility. I'd suggest the standard
kernel not provide these. Keep them as part of FreeS/WAN so they
cannot become "contaminated" with US code during kernel maintenance.

I don't understand why random.c uses MD4; for all I know there are
good reasons to keep it.

There may be overhead issues. How fast is SHA-256 compared to MD5
and SHA-1? This mainly a concern for random.c.

If you are doing AES, then it is likely both easy and a good idea
to add Twofish and  Serpent. These were final round AES candidate
ciphers, so they've survived intensive analysis and there is code
for them with the same interface as AES. Both have completely
open licenses.

If you're doing SHA-256, it may make sense to do SHA-384 and -512
as well. I think they use much the same code.
