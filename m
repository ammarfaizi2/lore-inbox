Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272383AbTHECkI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 22:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272388AbTHECkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 22:40:08 -0400
Received: from holomorphy.com ([66.224.33.161]:24449 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S272383AbTHECkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 22:40:00 -0400
Date: Mon, 4 Aug 2003 19:41:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O11int for interactivity
Message-ID: <20030805024103.GM32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <200307301038.49869.kernel@kolivas.org> <20030802225513.GE32488@holomorphy.com> <200308030119.47474.m.c.p@wolk-project.de> <200308042106.51676.m.c.p@wolk-project.de> <20030804195335.GK32488@holomorphy.com> <3F2F00B0.9050804@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2F00B0.9050804@cyberone.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 10:56:16AM +1000, Nick Piggin wrote:
> I'm an IO scheduler type person! What help do you need? I haven't been
> following the thread.

I'm not sure it was in the thread. Basically, the testers appear to
associate skips with changes in writeout and/or readin behavior (either
large amounts of writeout or low amounts of readin), though the effect
of behavior similar to that surrounding a skip doesn't appear to
guarantee a skip.

e.g. on line 448 (this is a vmstat log passed through cat -n) there was
a skip:

438	procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
439	 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
440	 1  6      0   3452 160248 274696    0    0 34960  7936 1450  1776  7 23  0 70
441	 4  3      0   4416 155824 277712    0    0  9744 27736 1348  1430 30 25  0 45
442	 0  7      0   4172 148604 285688    0    0  9040 16476 1395  1296 25 33  0 43
443	 2  7      0   3456 145228 289160    0    0  6160 32728 1592  1317 29 26  0 46
444	 0  6      0   6200 142256 289732    0    0 10512 20596 1323   794 25 26  0 48
445	 0  6      0   3420 139124 295700    0    0  6680 20160 1283   853 14 22  0 64
446	11  6      0   3740 133528 301032    0    0  8084 20216 1308   941 21 34  0 45
447	 0  7      0   2480 131044 304496    0    0  1424 24480 1290  1093 26 32  0 41
448	 0  9      0   2372 128616 307008    0    0   908 27260 1263   258  6 18  0 76
449	 1  6      0   5316 120960 311976    0    0  2064 19252 1243   698  9 24  0 67
450	 3  5      0   2080 100960 334900    0    0 13964 16076 1685  1340  8 43  0 50
451	 2  6      0   1932  74936 360496    0    0 22176 12292 1495  1359  8 92  0  0
452	 2  5      0   5004  67216 365220    0    0 12944 12316 1280  1079  5 42  0 53
453	 0  8      0   2264  56148 379780    0    0  1808 29180 1293   629  9 43  0 49
454	 0  6      0   2476  64688 371320    0    0 11536 15608 1262   551  7 40  0 53
455	 0  9      0   3620  52776 382020    0    0  2468 23836 1283   463  8 34  0 58
456	 5  8      0   3012  52904 382600    0    0  1796 30540 1348   400  5 26  0 69
457	 1  5      0   4440  45332 388380    0    0  1620 27980 1263   323 16 28  0 56

The load IIRC was some kind of io to an IDE disk while xmms played.

About all I can tell is that when there is a skip, bi is low, but
the converse does not hold. This appears to be independent of io
scheduler (I had them try deadline too), and I'm very unsure what to
make of it. I originally suspected thundering herds from waitqueue
hashing but things appear to contradict that given the low cs rates.

I'm collecting instrumentation patches to see what's going on. The
first order of business is probably getting the testers to run with
sleepometer to see if and where they're blocking, but given the io bits
that are observable some elevator instrumentation might help too (and
whatever it takes to figure out if a driver is spinning wildly too!).


Thanks.

-- wli
