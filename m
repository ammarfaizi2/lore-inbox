Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965205AbWADRbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965205AbWADRbF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965235AbWADRbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:31:05 -0500
Received: from fsmlabs.com ([168.103.115.128]:62360 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S965205AbWADRbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:31:02 -0500
X-ASG-Debug-ID: 1136395859-2619-47-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Wed, 4 Jan 2006 09:36:11 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Matt Mackall <mpm@selenic.com>
cc: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       Adrian Bunk <bunk@stusta.de>, Ingo Molnar <mingo@elte.hu>,
       tim@physik3.uni-rostock.de, arjan@infradead.org,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
X-ASG-Orig-Subj: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
In-Reply-To: <20060104042822.GA3356@waste.org>
Message-ID: <Pine.LNX.4.64.0601040930210.1579@montezuma.fsmlabs.com>
References: <1135897092.2935.81.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de>
 <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de>
 <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de>
 <20060102103721.GA8701@elte.hu> <20060102134228.GC17398@stusta.de>
 <20060102102824.4c7ff9ad.akpm@osdl.org> <43BB0B8B.1000703@mbligh.org>
 <20060104042822.GA3356@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.6920
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2006, Matt Mackall wrote:

> On Tue, Jan 03, 2006 at 03:40:59PM -0800, Martin J. Bligh wrote:
> > It seems odd to me that we're doing this by second-hand effect on
> > code size ... the objective of making the code smaller is to make it
> > run faster, right? So ... howcome there are no benchmark results
> > for this?
> 
> Because it's extremely hard to design a benchmark that will show a
> significant change one way or the other for single kernel functions
> that doesn't also make said functions unusually cache-hot. And part of
> the presumed advantage of uninlining is that it leaves icache room for
> random other code that you're _not_ benchmarking.
> 
> In other words, if it's not a microbenchmark, it generally can't be
> measured, directly or indirectly. And if it is a microbenchmark, the
> result is known to be biased.
> 
> In the rare case of functions that are extremely popular (like
> spinlock and friends), we _can_ actually see small improvements in
> macrobenchmarks like kernel compiles. So it's fairly reasonable to
> assume that reducing icache footprint really does matter more than
> cycle count and extrapolate that to other functions.
> 
> (Unfortunately, Zwane is an enemy of history and the URL for the
> benchmarks he posted for out-of-line spinlock has gone stale.)

Hey i resent that :P luckily my ~ directory hasn't been cleaned in years, 
the following bonnie runs were based on an initial implementation, i was 
only able to conclude that there was no negative cost to out of lining. 
-cool is completely out of line.

-cool
Version  @version@      ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
stp4-000      7336M  5755  99 62465  40 11037  10  5384  94 73519  29 299.0   1
stp4-000      7336M  5777  99 67203  44 14018  13  5392  94 69436  27 300.2   1
stp4-000      7336M  5725  99 61389  40 19385  18  5196  91 75178  30 307.5   1
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
files:max:min        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
stp4-000        100    80  99 +++++ +++ 62151 100    80 100 +++++ +++   276 100
stp4-000        100    80  99 +++++ +++ 62775 100    81  99 +++++ +++   277 100
stp4-000        100    80  99 +++++ +++ 62857 100    80  99 +++++ +++   271 100

Version  @version@      ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
stp2-000         2G  7018  99 64560  36 21694  16  6789  97 43729  14 340.6   1
stp2-000         2G  7055  99 64836  39 21899  16  6752  97 44827  17 330.8   2
stp2-000         2G  7023  99 64525  38 22987  17  6704  96 44777  14 337.3   1
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
files:max:min        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
stp2-000        100    93  99 +++++ +++ 82831  99    94  99 +++++ +++   351  99
stp2-000        100    93  99 +++++ +++ 82211 100    94  99 +++++ +++   350  99
stp2-000        100    93  99 +++++ +++ 81940 100    94  99 +++++ +++   350  99

-mainline
Version  @version@      ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
stp4-000      7336M  5726  99 65615  42 10112   9  4854  85 70211  28 295.4   1
stp4-000      7336M  5764  99 64931  43 13884  13  5242  93 67963  27 302.5   1
stp4-000      7336M  5748  99 68806  46 18061  17  5139  91 70335  28 310.0   1
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
files:max:min        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
stp4-000        100    80  99 +++++ +++ 60958  99    79  99 +++++ +++   282 100
stp4-000        100    79  99 +++++ +++ 60120 100    80  99 +++++ +++   275 100
stp4-000        100    80  99 +++++ +++ 62174  99    81 100 +++++ +++   278 100

Version  @version@      ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
stp2-000         2G  7048  99 64912  38 22510  17  6732  96 43900  14 332.0   1
stp2-000         2G  7018  99 63821  39 21732  16  6787  97 44889  17 326.7   2
stp2-000         2G  7063  99 63834  38 22361  17  6738  97 43310  14 338.3   1
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
files:max:min        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
stp2-000        100    93  99 +++++ +++ 80963 100    94  99 +++++ +++   344  99
stp2-000        100    93  99 +++++ +++ 80998  99    94  99 +++++ +++   348  99
stp2-000        100    93  99 +++++ +++ 81237 100    94  99 +++++ +++   349  99
