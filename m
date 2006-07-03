Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWGCUkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWGCUkS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 16:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWGCUkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 16:40:17 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:58514 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751112AbWGCUkQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 16:40:16 -0400
Date: Mon, 3 Jul 2006 22:36:09 +0200
To: Fengguang Wu <fengguang.wu@gmail.com>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New readahead - ups and downs new test
Message-ID: <20060703203609.GB9707@aitel.hist.no>
References: <44A12D84.5010400@aitel.hist.no> <20060702235516.GA6034@mail.ustc.edu.cn> <20060703135027.GA4440@aitel.hist.no> <20060703153930.GC5874@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060703153930.GC5874@mail.ustc.edu.cn>
User-Agent: Mutt/1.5.11+cvs20060403
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 11:39:30PM +0800, Fengguang Wu wrote:
> On Mon, Jul 03, 2006 at 03:50:27PM +0200, Helge Hafting wrote:
> > On Mon, Jul 03, 2006 at 07:55:16AM +0800, Fengguang Wu wrote:
> > > Hi Helge,
> > > 
> > > On Tue, Jun 27, 2006 at 03:07:16PM +0200, Helge Hafting wrote:
> > > > I made my own little io-intensive test, that shows a case where
> > > > performance drops.
> > > > 
> > > > I boot the machine, and starts "debsums", a debian utility that
> > > > checksums every file managed by debian package management.
> > > > As soon as the machine starts swapping, I also start
> > > > start a process that applies an mm-patch to the kernel tree, and
> > > > times this.
> > > > 
> > > > This patching took 1m28s with cold cache, without debsums running.
> > > > With the 2.6.15 kernel (old readahead), and debsums running, this
> > > > took 2m20s to complete, and 360kB in swap at the worst.
> > > > 
> > > > With the new readahead in 2.6.17-mm3 I get 6m22s for patching,
> > > > and 22MB in swap at the most.  Runs with mm1 and mm2 were
> > > > similiar, 5-6 minutes patching and 22MB swap.
> > > > 
> > > > My patching clearly takes more times this way.  I don't know
> > > > if debsums improved though, it could be as simple as a fairness
> > > > issue.  Memory pressure definitely went up.
> > > 
> > > There are a lot changes between 2.6.15 and 2.6.17-mmX. Would you use
> > > the single 2.6.17-mm5 kernel for benchmarking? It's easy:
> > > 
> > >         - select old readahead:
> > >                 echo 1 > /proc/sys/vm/readahead_ratio
> > > 
> > >         - select new readahead:
> > >                 echo 50 > /proc/sys/vm/readahead_ratio
> > > 
> > >
> > I just tried this with 2.5.17-mm5.  I did in on a faster
> > machine (opteron cpu, but still 512MB) so don't compare with
> > my previous test which ran on a pentium-IV.
> > Single cpu in both cases.
> > 
> > Test procdure:
> > 1. Reboot, log in through xdm
> > 2. run vmstat 10 for swap monitoring
> > 3. time debsums -s
> > 4. As soon as the machine touches swap, launch
> >    time bzcat 2.6.15-mm5.bz2 | patch -p1
> > 
> > In either case, testing starts with 320MB free memory after boot,
> > which debsums caching eats in about a minute and swapping starts.
> > Then I start the patching, which finished before debsums.
> > 
> > Old readahed:
> > Max swap was 700kB, but it dropped back to 244kB after 10s
> > and stayed there.  
> > Patch timing:
> > real    0m37.662s
> > user    0m5.002s
> > sys     0m2.023s
> > debsums timing:
> > real    5m50.333s
> > user    0m21.127s
> > sys     0m14.506s
> > 
> > New readahead:
> > Max swap: 244kB.  (On another try it jumped to 816kB and then fell back
> > to 244kB).
> > patch timing:
> > real    0m40.951s
> > user    0m5.043s
> > sys     0m2.061s
> > debsums timing:
> > real    5m46.555s
> > user    0m21.195s
> > sys     0m13.918s
> > 
> > Timing and memory load seems to be almost identical this time,
> > perhaps this is a load where the type of readahead doesn't
> > matter.  
> 
> Thanks. You are right, the readahead logic won't affect the swap cache.
> Nor will the readahead size, I guess. But to be sure, you can do one
> more test on it with the following command, using the same 2.5.17-mm5:

Well, I did not expect readahead to directly affect swap, but there was
this very noticeable difference on the pentium-IV machine.  
Different io patterns & disk head movement patterns may alter timing
and make the memory pressure situation seem different (and more/less
data coming in as readahead might affect memory pressure also.)
369k vs 22M swap is a lot.

I have found an important difference between the two machines,
the one with the big differences with/without new readahead
has /usr and /usr/src on the same physical disk, although
separate partitions.  That makes for _lots_ of head movement,
when bzcat & patch is operating on /usr/src and debsums
is reading /usr.

That machine is not available for testing right now, but I'll
re-do my test with/without new readahed with a kernel source
tree on the same device as /usr.

> 
>         blockdev --setra /dev/hda1 256
> 
Using blockdev --getra on the two disks that holds /usr and
/usr/src gives me 2048.  So, now we get a test with 1/8 
of the normal readahead?

Results: Swap went up to 500k and was down at the usual 244k
10s later.

patch timing:
real    0m38.265s
user    0m5.010s
sys     0m2.097s

debsums timing:
real    5m48.367s
user    0m21.015s
sys     0m13.950s

Seems --setra made no difference.

I'll copy the kernel tree to /usr, to see if anything interesting
happes when the two processes actually compete for the
same device.  That's what got so different last time, although with
differing kernel versions.

Helge Hafting

