Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265706AbUFXXHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265706AbUFXXHU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 19:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265783AbUFXXHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 19:07:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:433 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265706AbUFXXHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 19:07:15 -0400
Date: Thu, 24 Jun 2004 16:09:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: andrea@suse.de, nickpiggin@yahoo.com.au, tiwai@suse.de, ak@suse.de,
       ak@muc.de, tripperda@nvidia.com, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-Id: <20040624160945.69185c46.akpm@osdl.org>
In-Reply-To: <20040624225121.GS21066@holomorphy.com>
References: <s5h4qp1hvk0.wl@alsa2.suse.de>
	<20040624164258.1a1beea3.ak@suse.de>
	<s5hy8mdgfzj.wl@alsa2.suse.de>
	<20040624152946.GK30687@dualathlon.random>
	<40DAF7DF.9020501@yahoo.com.au>
	<20040624165200.GM30687@dualathlon.random>
	<20040624165629.GG21066@holomorphy.com>
	<20040624145441.181425c8.akpm@osdl.org>
	<20040624220823.GO21066@holomorphy.com>
	<20040624224529.GA30687@dualathlon.random>
	<20040624225121.GS21066@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Fri, Jun 25, 2004 at 12:45:29AM +0200, Andrea Arcangeli wrote:
> > Luckily this problem doesn't fall in this scenario and it's trivial to
> > reproduce if you've >= 2G of ram. I still have here the testcase google
> > sent me years ago when this problem seen the light during 2.4.1x. They
> > used mlock, but it's even simpler to reproduce it with a single malloc +
> > bzero (note: no mlock). The few mbytes of lowmem left won't last long if
> > you load some big app after that.
> 
> Well, there are magic numbers here we need to explain to get a testcase
> runnable on more machines than just x86 boxen with exactly 2GB RAM.
> Where do the 2GB and 1GB come from? Is it that 1GB is the size of the
> upper zone?
> 

A testcase would be, on a 2G box:

a) free up as much memory as you can

b) write a 1.2G file to fill highmem with pagecache

c) malloc(800M), bzero(), sleep

d) swapoff -a

You now have a box which has almost all of lowmem pinned in anonymous
memory.  It'll limp along and go oom fairly easily.


Another testcase would be:

a) free up as much memory as you can

b) write a 1.2G file to fill highmem with pagecache

c) malloc(800M), mlock it

You now have most of lowmem mlocked.


In both situations the machine is really sick.  Probably the most risky
scenario is a swapless machine in which lots of lowmem is allocated to
anonymous memory.


It should be the case that increasing lower_zone_peotection will fix all
the above.  If not, it needs fixing.

So we're down the question "what should we default to at bootup".  I find
it hard to justify defaulting to a mode where we're super-defensive against
this sort of thing, simply because nobody seems to be hitting the problems.

Distributors can, if the must, bump lower_zone_protection in initscripts,
and it's presumably pretty simple to write a boot script which parses
/proc/meminfo's MemTotal and SwapTotal lines, producing an appropriate
lower_zone_protection setting.

