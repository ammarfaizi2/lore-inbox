Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316753AbSE0UCo>; Mon, 27 May 2002 16:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316758AbSE0UCn>; Mon, 27 May 2002 16:02:43 -0400
Received: from inje.iskon.hr ([213.191.128.16]:21971 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S316757AbSE0UCm>;
	Mon, 27 May 2002 16:02:42 -0400
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.5.18 / ext3 / oracle trouble
In-Reply-To: <877klr2ank.fsf@atlas.iskon.hr> <d6vi836v.fsf@sap.com>
	<3CF1E5CF.2B11258F@zip.com.au> <dnvg9am14i.fsf@magla.zg.iskon.hr>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: Mon, 27 May 2002 22:02:14 +0200
Message-ID: <871ybx4awp.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zlatko Calusic <zlatko.calusic@iskon.hr> writes:
>
> Obviously I need to perform tests on ext2 with swap load, and repeat
> them few times. Will do this evening (it takes some time to recover a
> database after a corruption, so it's slightly time consuming).
>

And I did get some interesting results. :)
I found a great test case, rebuilding database after corruption. :)

It consists of recreation of all tablespaces, initializing data
dictionary and finally importing useful data. The whole process takes
between 11 and 14 minutes, depending on the type of FS. It's write
intensive workload and induces some paging even with 768 MB RAM I
have. Did I forgot to say that all this is on a SMP machine, dual
PIII? It might matter.

And you know what, corruption doesn't depend on the type of FS. It
happens on both ext2 & ext3. It's just more likely to see it when
running on ext3.

Anyway, I managed to pinpoint the problem, it's paging that's the
culprit. When I turned off my swap partition (swapoff -a), rebuild
went correctly. So I was right, swapping will get you in
trouble.

I also tried to push the machine harder into swap, with artificial
load (typical malloc() in the loop), and it locked up hard after some
time (minute or two).

And during one of the tests on ext3, when machine actually survived,
just after exiting X I had a welcome message waiting, saying something
like this:

 Assertion failure: journal_dirty_metadata() at transaction.c:1146
 "jh->b_frozen_data == 0"

Don't know if it's related, but could be useful to someone.

That's it. I'm back to 2.4.19-pre8 for the time being, but if anybody
needs more testing...

Regards,
-- 
Zlatko
