Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268377AbRHFNGh>; Mon, 6 Aug 2001 09:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268440AbRHFNG1>; Mon, 6 Aug 2001 09:06:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30337 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268419AbRHFNGQ>;
	Mon, 6 Aug 2001 09:06:16 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15214.38470.749251.251809@pizda.ninka.net>
Date: Mon, 6 Aug 2001 06:06:14 -0700 (PDT)
To: Andrea Arcangeli <andrea@suse.de>
Cc: Chris Wedgwood <cw@f00f.org>, David Luyer <david_luyer@pacific.net.au>,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: /proc/<n>/maps growing...
In-Reply-To: <20010806145052.F20837@athlon.random>
In-Reply-To: <997080081.3938.28.camel@typhaon>
	<20010806105904.A28792@athlon.random>
	<15214.24938.681121.837470@pizda.ninka.net>
	<20010806125705.I15925@athlon.random>
	<20010807002650.B23937@weta.f00f.org>
	<20010806143603.C20837@athlon.random>
	<20010807004510.A23992@weta.f00f.org>
	<20010806145052.F20837@athlon.random>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli writes:
 > On Tue, Aug 07, 2001 at 12:45:10AM +1200, Chris Wedgwood wrote:
 > > for anonymous maps, when it can extend the previos map, mmap will do
 > > so --- it happens to occur quite often in practice
 > 
 > ah, what an horrible hack, so we just walk the tree _two_ times and we
 > don't even take advantage of that (over)work as we should!

I wouldn't classify it as a horrible hack... but.

It isn't doing the "other work" because:

1) The locking is really horrible.  You have to drop/reget the VMA
   and mm locks if you want to link/unlink other vmas to do the
   merging.

2) For mmap() itself these other cases not being handled now happen so
   rarely.

So instead of an abortion like merge_segments() which tried to be
everything to everybody, we have 4 lines of code.

The issue is mprotect() anyways.  I bet we can add something which,
while not as simple as the mmap() code, is not overly complex yet will
make this glibc mprotect() case happy.

On the topic of mmap limits, it is really a job for something like
Andrey Savochkin's bean counter patches.

Later,
David S. Miller
davem@redhat.com
