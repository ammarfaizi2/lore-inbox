Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261945AbSJJLrz>; Thu, 10 Oct 2002 07:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262003AbSJJLrz>; Thu, 10 Oct 2002 07:47:55 -0400
Received: from holomorphy.com ([66.224.33.161]:28393 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261945AbSJJLry>;
	Thu, 10 Oct 2002 07:47:54 -0400
Date: Thu, 10 Oct 2002 04:47:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: andersen@codepoet.org, Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Mark Mielke <mark@mark.mielke.cc>,
       Giuliano Pochini <pochini@denise.shiny.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_STREAMING has insufficient info - how about fadvise() ?
Message-ID: <20021010114751.GP10722@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, andersen@codepoet.org,
	Jamie Lokier <lk@tantalophile.demon.co.uk>,
	Mark Mielke <mark@mark.mielke.cc>,
	Giuliano Pochini <pochini@denise.shiny.it>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1034104637.29468.1483.camel@phantasy> <XFMail.20021009103325.pochini@shiny.it> <20021009170517.GA5608@mark.mielke.cc> <3DA4852B.7CC89C09@denise.shiny.it> <20021009222438.GD5608@mark.mielke.cc> <20021009232002.GC2654@bjl1.asuk.net> <20021010032950.GA11683@codepoet.org> <1034249932.2044.128.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034249932.2044.128.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 12:38:52PM +0100, Alan Cox wrote:
> Im not sure O_STREAMING is what you actually want here, its proper
> working drop behind. That -shouldnt- need a magic flag if the kernel is
> doing the VM things right.

This is a somewhat painful issue. The negative effect of its absence on
UP is quite visible, but multiprogrammed streaming SMP workloads (i.e.
badari's 40 simultaneous dd's) appear to degrade severely in the
presence of the available drop behind implementations.

IIRC akpm suggested in response to the SEGQ/NRU patches that a method
of reducing the arrival rate to the relevant LRU locks for drop behind
would be required to remain performant on multiprogrammed streaming
workloads. This is not entirely simple as methods of deferred LRU list
manipulations are largely unclear, and Rik pointed out that marking the
affected pages for immediate deactivation on scanning like my attempt
at resolving this is a grossly ineffective method of actually
accomplishing drop behind.


On Thu, Oct 10, 2002 at 12:38:52PM +0100, Alan Cox wrote:
> Instead of O_STREAMING therefore I'd much prefer to have
> 	fadvise(filehandle, offset, length, FADV_DONTNEED);

This issue also arose in response to Rik's NRU/SEGQ patches.
Essentially his accounting was on a per-mm basis and I questioned
whether or not it should be done on a finer-grained level. No clear
response or confirming/conflicting opinion was ever posted.


On Thu, Oct 10, 2002 at 12:38:52PM +0100, Alan Cox wrote:
> Its quite possible that most of the rest of the madvise notions aren't
> worth implementing, but we have the flexibility to do. The fadvise
> interface also lets you pick which ranges you evict, so now I can do
> streaming media but not fadvise out of cache key frames so that my
> chapter starts just happen to generally be in cache as do a few I frames
> behind the read pointer - (for rewind).
> Do that with O_STREAMING ?

The level of control you propose is clearly much stronger than
O_STREAMING. Unfortunately I'm not in a position to comment on the need
for or the usefulness of the interface.


Bill
