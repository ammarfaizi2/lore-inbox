Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130198AbRBZIh2>; Mon, 26 Feb 2001 03:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130199AbRBZIhS>; Mon, 26 Feb 2001 03:37:18 -0500
Received: from cc1004783-a.catv1.md.home.com ([24.3.31.39]:6284 "EHLO
	red-sonja.sanctuary.arbutus.md.us") by vger.kernel.org with ESMTP
	id <S130198AbRBZIhN>; Mon, 26 Feb 2001 03:37:13 -0500
Date: Mon, 26 Feb 2001 03:37:13 -0500
From: "Mordechai T. Abzug" <morty@sanctuary.arbutus.md.us>
To: linux-kernel@vger.kernel.org
Subject: cache/swap issues under 2.4.1, 2.4.2
Message-ID: <20010226033713.A7120@red-sonja.sanctuary.arbutus.md.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been noticing some weird cache/swap behavior under 2.4.1 and
2.4.2.  If there is a large amount of allocated cache space, a program
requests a lot of RAM, and then the program exits, then one can end up
using lots of swap while having a hefty cache, which doesn't make much
sense.  Here is a sample run: ("allocram N" is a trivial program to
allocate and dirty N MB of RAM.)

# free
             total       used       free     shared    buffers     cached
Mem:        255564      49344     206220          0        420       5496
-/+ buffers/cache:      43428     212136
Swap:       163832          0     163832

# find / -type f|xargs cat > /dev/null

# free
             total       used       free     shared    buffers     cached
Mem:        255564     253248       2316          0       7764     189300
-/+ buffers/cache:      56184     199380
Swap:       163832          0     163832

# allocram 300 &

# free
             total       used       free     shared    buffers     cached
Mem:        255564     254004       1560          0        316      32764
-/+ buffers/cache:     220924      34640
Swap:       163832     130172      33660

# [1]+  Done                    allocram 300

# free
             total       used       free     shared    buffers     cached
Mem:        255564      65508     190056          0        400      39852
-/+ buffers/cache:      25256     230308
Swap:       163832      48444     115388


Why do I have 47MB of swap in use?  I thought at first that it might
be due to the minimum allowable cache size, but considering that there
was only 48MB of RAM in use to begin with, that still seems
suspicious.  Even weirder, if I then turn off swap, the usage looks
more reasonable:

# swapoff -a

# free
             total       used       free     shared    buffers     cached
Mem:        255564      53900     201664          0        840       9356
-/+ buffers/cache:      43704     211860
Swap:            0          0          0

This system is an Athlon T-bird 900 on a Asus A7V (KTX-133-based)
motherboard, if that matters.  I don't have any other 2.4.x systems to
try it on.  NB: X 4.0.1 with tdfx freezes for a few seconds during the
swapoff -a process, but it does recover.

- Morty
