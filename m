Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262133AbSJJXO3>; Thu, 10 Oct 2002 19:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262147AbSJJXO3>; Thu, 10 Oct 2002 19:14:29 -0400
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:10112 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262133AbSJJXO1> convert rfc822-to-8bit; Thu, 10 Oct 2002 19:14:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [BENCHMARK] 2.5.40-mm2 with contest
Date: Fri, 11 Oct 2002 09:17:27 +1000
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1021010133332.17862B-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1021010133332.17862B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210110917.52546.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 11 Oct 2002 3:40 am, Bill Davidsen wrote:
> On Tue, 8 Oct 2002, Con Kolivas wrote:
> > > Problem is, users have said they don't want that.  They say that they
> > > want to copy ISO images about all day and not swap.  I think.
> >
> > But do they really want that or do they think they want that without
> > knowing the consequences of such a setting?
>
> I have been able to tune bdflush in 2.4-aa kernels to be much more
> aggressive about moving data to disk under write pressure, and that has
> been a big plus in terms of both getting the write completed in less real
> time and fewer big pauses doing trivial things like uncovering a window. I
> see less swap used.
>
> > > It worries me.  It means that we'll be really slow to react to sudden
> > > load swings, and it increases the complexity of the analysis and
> > > testing.  And I really do want to give the user a single knob,
> > > which has understandable semantics and for which I can feasibly test
> > > all operating regions.
> > >
> > > I really, really, really, really don't want to get too fancy in there.
> >
> > Well I made it as simple as I possibly could. It seems to do what they
> > want (not swappy) but not at the expense of making the machine never
> > swapping when it really needs to - and the performance seems to be better
> > all round in real usage. I guess the only thing is it isn't a fixed
> > number... unless we set a maximum swappiness level or... but then it
> > starts getting unnecessarily complicated with questionable benefits.
>
> I'm going to try this patch, but building a kernel on my standard test
> machine is painfully slow, so it will come after 41-ac2. It appears to
> address the balance issue dynamically.
>

I've been playing with the feedback loop a bit more and made it respond more 
relative to the pressure present, and not have the "magic number" of 10 times 
the gain on the positive arm. I'm getting good results with it. Check it out 
below. I think if you want to give the users a "knob" then limiting the 
max_vm_swappiness rather than the current vm_swappiness would work.

> > > I have changed this code a bit, and have added other things.  Mainly
> > > over on the writer throttling side, which tends to be the place where
> > > the stress comes from in the first place.
> >
> > /me waits but is a little disappointed
>
> I actually like the idea of writer throttling, I just wonder how it will
> work at the corner cases like only one big writer (mkisofs) or the
> alternative, lots of little writers.

Worth trying it out I guess.

- --- linux-2.5.41/mm/vmscan.c    2002-10-11 09:11:20.000000000 +1000
+++ linux-2.5.41-new/mm/vmscan.c 2002-10-11 00:51:06.000000000 +1000
@@ -44,7 +44,8 @@
 /*
  * From 0 .. 100.  Higher means more swappy.
  */
- -int vm_swappiness = 50;
+int vm_swappiness = 0;
+int vm_swap_feedback;
 static long total_memory;

 #ifdef ARCH_HAS_PREFETCH
@@ -587,7 +588,18 @@
         * A 100% value of vm_swappiness will override this algorithm almost
         * altogether.
         */
- -       swap_tendency = mapped_ratio / 2 + distress + vm_swappiness;
+       swap_tendency = mapped_ratio / 2 + distress;
+
+        vm_swap_feedback = (swap_tendency - 50)/10;
+        vm_swappiness += vm_swap_feedback;
+        if (vm_swappiness < 0){
+               vm_swappiness = 0;
+       }
+       else
+       if (vm_swappiness > 100){
+               vm_swappiness = 100;
+       }
+        swap_tendency += vm_swappiness;

        /*
         * Well that all made sense.  Now for some magic numbers.  Use the




Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9pgqLF6dfvkL3i1gRAo87AKCT2QL/4yihdGoRQZFxFL4/Az9RNgCeJjhJ
Xew01Xff9t31p9Bi2TODj44=
=OEcn
-----END PGP SIGNATURE-----
