Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbTLaTNS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 14:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbTLaTNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 14:13:18 -0500
Received: from pirx.hexapodia.org ([65.103.12.242]:50603 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S265232AbTLaTNO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 14:13:14 -0500
Date: Wed, 31 Dec 2003 13:13:13 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: Ed Tomlinson <edt@aei.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0 - Watchdog patches (BK consistency checks)
Message-ID: <20031231131313.B14164@hexapodia.org>
References: <20030906125136.A9266@infomag.infomag.iguana.be> <20031230195632.GB6992@bounceswoosh.org> <20031230141655.A30003@hexapodia.org> <200312311133.58684.edt@aei.ca> <20030906125136.A9266@infomag.infomag.iguana.be> <200312300836.16559.edt@aei.ca> <20031230131350.A32120@hexapodia.org> <200312311001.48154.edt@aei.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200312311001.48154.edt@aei.ca>; from edt@aei.ca on Wed, Dec 31, 2003 at 10:01:48AM -0500
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 10:01:48AM -0500, Ed Tomlinson wrote:
> On December 30, 2003 02:13 pm, Andy Isaacson wrote:
> > On Tue, Dec 30, 2003 at 08:36:15AM -0500, Ed Tomlinson wrote:
> > > Is there a way to tell BK when to do consistency checks?  Here they
> > > easily take 15-20 min each time.  I would love to be able to tell BK
> > > to defer these checks.
> >
> > The consistency check definitely should not take 15 minutes.  It should
> > be (much) less than 30 seconds.  What is the hardware you're running on?
> >
> > I'm running on an Athlon 2 GHz (XP 2400+) with 512MB and a 7200RPM IDE
> > disk, and I can do a complete clone (with full data copy and consistency
> > check) of the 2.4 tree in 1:40.  That was with cold caches; with the
> > sfile copies and "checkout:get", a half-gig isn't enough to cache
> > everything.  The consistency check is about 19 seconds (bk -r check -acv).
> 
> Its not a fast box.  Its an old K6-III 400 with 512MB with UDMA2 harddrives.

I haven't run bk on a K6, but for a WAG I will guess that it's about 75%
of a clock-scaled Duron.  Based on Eric Mudama's numbers, that would put
your CPU load at about 133 seconds.  You've got enough RAM that you
shouldn't be thrashing, and maybe even enough to cache the sfiles.  For
a cold-cache machine, disk seek time is more important than
UDMA33/66/100; are you using a 5400 RPM disk or a 7200 RPM disk?

> > If you keep all your trees on one filesystem, you can use "bk clone -l"
> > to make hard-links for the s. files.  This means you can create a
> > complete copy of the tree in about 6 MB, in 40 seconds or so.  BK is
> > very careful to check the links and break them when necessary.
> 
> I use -ql for clones

Glad to hear it, I wasn't sure if l-k people in general know about that
trick, which is a giant savings.

[snip]

> > If the consistency check is problematic, let's fix that problem -- don't
> > turn it off, it's valuable.  It's found IDE corruption, it's found BK
> > bugs, it's found users who move s. files around behind BK's back.
> 
> I am not saying I do not want do have consistency checks done.  I do want
> to control _when_ and how often they run

Ideally the consistency check is fast enough that you want to run it
after every significant data-modification operation.  Sorta like a
testsuite in XP, it should be run *all the time* so you can say with
confidence "everything was OK until I did X, then it broke" rather than
"oops, at some point in the last week somebody did something that broke
it".

Obviously on an archive as large and complex as the linux kernel, it's
challenging to get a consistency check to go that fast.

On Wed, Dec 31, 2003 at 11:33:58AM -0500, Ed Tomlinson wrote:
> Here are the numbers from my box:
> 
> oscar% cd /usr/src/linux
> oscar% time bk -r check -acv
> 100% |=================================================================| OK
> bk -r check -acv  80.63s user 16.18s system 21% cpu 7:32.06 total
> 
> oscar% time bk clone -ql linux yy
> bk clone -ql linux yy  77.57s user 23.49s system 17% cpu 9:50.51 total

So you're actually going faster than I predicted, CPU-wise.  But that
wallclock time is scary.  On my box the same operation takes less than a
minute:

bk clone -ql linux-2.4 foo  27.73s user 3.12s system 74% cpu 41.200 total

I'm running 2.4.22, Athlon 2 GHz, 512MB.  Why am I getting 74% CPU
utilization when you're getting 17%?  Can you run 'vmstat 10' while the
clone is going?  Here's what I got:

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0 153584  11668  33352 338216    1    1     3     8    3     7  3  0 96  0
 1  0 153584 142132  33536 207536    0    0    31   486  317   389  3  5 92  0
 2  0 153584  88776  33760 217800    0    0    45  2518  362   830 60  9 31  0
 1  0 153584  85776  33808 218084    0    0    26   148  304   466 98  2  0  0
 1  1 153584  32504  33972 298940    0    0    38 10298  506   437 73 11 16  0
 1  0 153584  15284  19864 353544    0  163    27  8026  483   452 58 12 30  0
 0  0 153584  14964  19928 353800    0    0    26  2304  345   344  0  1 99  0
 0  0 153584  14552  19956 354184    0    0    40     2  302   320  2  1 97  0
 1  0 153584  14272  19980 354440    0    0    26    16  316   389  3  1 97  0

bk clone -ql linux-2.4 fooz  28.19s user 2.82s system 85% cpu 36.099 total

(warm caches, that time.)

Is there something else running on the box, perhaps?

-andy
