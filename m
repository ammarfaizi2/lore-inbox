Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265139AbUHWSKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbUHWSKg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbUHWSKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:10:36 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3715 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265139AbUHWSKH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:10:07 -0400
Date: Mon, 23 Aug 2004 14:09:27 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Stephen Hemminger <shemminger@osdl.org>
cc: Andreas Dilger <adilger@clusterfs.com>,
       Jean-Luc Cooke <jlcooke@certainkey.com>,
       "David S. Miller" <davem@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Theodore Ts'o" <tytso@mit.edu>,
       netdev@oss.sgi.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] enhanced version of net_random()
In-Reply-To: <20040823100547.33b7a448@dell_ss3.pdx.osdl.net>
Message-ID: <Pine.LNX.4.53.0408231338370.8564@chaos>
References: <20040812104835.3b179f5a@dell_ss3.pdx.osdl.net>
 <20040820175952.GI5806@certainkey.com> <20040820185956.GV8967@schnapps.adilger.int>
 <Pine.LNX.4.53.0408201518250.25319@chaos> <20040823100547.33b7a448@dell_ss3.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2004, Stephen Hemminger wrote:

>
> > The attached code will certainly work on Intel machines. It is
> > in the public domain, having been modified by myself to produce
> > a very long sequence...
> >
> > I wouldn't suggest converting it to 'C' because the rotation
> > takes many CPU instructions when one tries to do the test, shift,
> > and OR in 'C',
> >
>
> My choice of PRNG was not random. I am not a mathematician (IANAM),
> but what I was looking for was:
>
> + well researched
> + fast
> + good distribution
> + small seed (since per cpu)
> + Free and open
>
> The second version uses tausworthe because it was the fastest in the GNU scientific
> library and had good properties.
>
> See:
>
> http://www1.physik.tu-muenchen.de/~gammel/matpack/html/LibDoc/Numbers/Random.html
> ----------
> Returns integer pseudorandom numbers uniformly distributed within [0,4294967295].
> The period length is approximately 288 (which is 3*1026).
>
> This is Pierre L'Ecuyer's 1996 three-component Tausworthe generator "taus88"
>
> This generator is very fast and passes all standard statistical tests.
>
> P. L'Ecuyer, Maximally equidistributed combined Tausworthe generators, Mathematics of Computation 65, 203-213 (1996), see Figure 4.
> P. L'Ecuyer, Random number generation, chapter 4 of the Handbook on Simulation, Ed. Jerry Banks, Wiley, 1997.
> --------
> http://www.gnu.org/software/gsl/manual/gsl-ref_17.html
>
> Performance
> The following table shows the relative performance of a selection the available random number generators. The fastest simulation quality generators are taus, gfsr4 and mt19937. The generators which offer the best mathematically-proven quality are those based on the RANLUX algorithm.
>
> 1754 k ints/sec,    870 k doubles/sec, taus
> 1613 k ints/sec,    855 k doubles/sec, gfsr4
> 1370 k ints/sec,    769 k doubles/sec, mt19937
>  565 k ints/sec,    571 k doubles/sec, ranlxs0
>  400 k ints/sec,    405 k doubles/sec, ranlxs1
>  490 k ints/sec,    389 k doubles/sec, mrg
>  407 k ints/sec,    297 k doubles/sec, ranlux
>  243 k ints/sec,    254 k doubles/sec, ranlxd1
>  251 k ints/sec,    253 k doubles/sec, ranlxs2
>  238 k ints/sec,    215 k doubles/sec, cmrg
>  247 k ints/sec,    198 k doubles/sec, ranlux389
>  141 k ints/sec,    140 k doubles/sec, ranlxd2
>
> 1852 k ints/sec,    935 k doubles/sec, ran3
>  813 k ints/sec,    575 k doubles/sec, ran0
>  787 k ints/sec,    476 k doubles/sec, ran1
>  379 k ints/sec,    292 k doubles/sec, ran2


The rnd that I submitted is fast. That's all. For communications
it has been found to be good enough. Remember the saying; "Better
is the enemy of good enough". It obviously can't have a period
of better than 2^32 and, in fact, it has a period of:

	4294896635 [0xfffeebfb].

This generates 199,962,632 integers per second on this 2.8 GHz machine.
This is a callable procedure that uses a pointer to private
data. The speed could be improved if this overhead is not required.

The distribution has also been found to be good enough for spread-
spectrum use. There are no missing codes although a sorted-
list of return values will show that there are some values (codes)
that are generated close together, in other words some people
expect that if you get a return code of '1', the next one won't
be '2', but something "very far away". This generator seems
to work more like "real world" noise sources except that such
noise sources may give you duplicate values, which this won't.

Depending upon how much time you wish to waste for making it
better than "good enough", this can be cascaded to give a
period of any length (you use one generator to produce the
"magic number" for another, etc.)



Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


