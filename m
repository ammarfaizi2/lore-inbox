Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266930AbRGMFOm>; Fri, 13 Jul 2001 01:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266931AbRGMFOc>; Fri, 13 Jul 2001 01:14:32 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:46345 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266930AbRGMFOQ>; Fri, 13 Jul 2001 01:14:16 -0400
Date: Fri, 13 Jul 2001 00:42:47 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-mm@kvack.org, lkml <linux-kernel@vger.kernel.org>
Subject: per-zone inactive shortage information
Message-ID: <Pine.LNX.4.21.0107130020050.2821-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

I was doing some tests with the VM stats code and now we can see in
practice how bad the lack of a "per-zone inactivation" scheme in the
current kernel is.

Simple test: 4 setiathome's plus 1 big (1GB) fillmem running on a 900MB
total RAM machine.

Here is one vmstat output from the configuration above. (Ok, its just one,
but this is how the machine looks like most of the time during the test)

 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 5  1  1 702748   2548    360 600188   46 31060    48 31068  473  2759 50 6 44
launder launder_w ref_inact alloc_r kswapd_w krec_w kflush_w
     1        1        16       0        0   1187       18
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
    DMA      0    255      0      0      0      0      0      0      0
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
    319     319      48      0        319          0    1172    735    688
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
 Normal      0      0  32639   5167   5434  11882   7858   2318      0
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
  33011   32784    8671  11890      20477        644       0  13447   5061


 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 4  1  1 702748   2796    360 571668   92 23930    92 23950  394   286 49 3 48
launder launder_w ref_inact alloc_r kswapd_w krec_w kflush_w
     1        1         0     129        0     29        3
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
    DMA      1    257      0      0      0      0      0      0      0
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
      0       0       0      0          0          0      28      0      0
   Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue
 Normal      0      0  24492   1305   4836  11230   6007   1117      1
agescan agedown   ageup  deact deactf_age deactf_ref recfail   ptes   pteu
      0       0       0      0          0          0     129      0      0


The DMA inactive/free shortage does not change for quite some time, while
pages from the normal zone are laundered/freed/pte's deactivated, even if
its OK wrt free/inactive pages. That keeps going until the DMA zone has
its inactive/free shortage gone.

Well, everybody knew that the "non-zoned" behaviour was a theorical
problem.

Now everybody know that its a practical live problem, and a big one.



