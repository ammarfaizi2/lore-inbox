Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135814AbRDTGYq>; Fri, 20 Apr 2001 02:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135818AbRDTGYg>; Fri, 20 Apr 2001 02:24:36 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:48902 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135814AbRDTGYR>; Fri, 20 Apr 2001 02:24:17 -0400
Date: Fri, 20 Apr 2001 01:43:47 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Allocated swap space versus used swap space
In-Reply-To: <Pine.LNX.4.21.0104200123110.2180-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0104200130320.2180-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Apr 2001, Marcelo Tosatti wrote:

> 
> Hi, 

Argh. Silly. 

Well... 

Right now we can get a task killed by the OOM killer even if there is a
lot of _unused_ (but allocated) swap space. The reason for that is the
pre allocation of swap.

Practical example (128MB swap, 960MB ram): 

# fillmem 960 

...

   procs                      memory    swap          io     system cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us sy
 0  0  0      0 873548   1760   9244   0   0    25    11   32    24   0 1 98
 0  0  0      0 873540   1760   9244   0   0     0     0  103     8   0 0 100
 1  0  0      0 469040   1760   9248   0   0     2     0  221   562   2 17 80
 1  0  1  91980   2068     80  98480   0 362     0   456  277   724   2 26 72
 0  1  2 128516   1560     80 106564  30 24724    44 24724  443  8090   0 9  91
 0  1  0  64840 820804     84  66396 112 22436   148 22438  413  9197   1 13  87
 0  0  0  64840 820416    104  66768   0   0   198     0  119    22   0 0 100
 0  0  0  64840 820416    104  66768   0   0     0     0  102     9   0 0 100

...

Out of Memory: Killed process 763 (fillmem).

Around 60MB was written to swap, so there was unused swap space available,
which means the task should _not_ get killed.

We cannot simply check for "(swapper_space.nrpages > 0)" or count the
number of dirty swap cache pages to avoid the OOM killer from triggering,
obviously.

We can split the swap map in "used" / "allocated" bits (or something which
gives us that information), but that would be painful to do, I guess. 

Comments ?

