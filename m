Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268503AbRHFN25>; Mon, 6 Aug 2001 09:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268546AbRHFN2r>; Mon, 6 Aug 2001 09:28:47 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:2922 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268503AbRHFN2k>; Mon, 6 Aug 2001 09:28:40 -0400
Date: Mon, 6 Aug 2001 15:29:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Chris Wedgwood <cw@f00f.org>, David Luyer <david_luyer@pacific.net.au>,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: /proc/<n>/maps growing...
Message-ID: <20010806152919.H20837@athlon.random>
In-Reply-To: <997080081.3938.28.camel@typhaon> <20010806105904.A28792@athlon.random> <15214.24938.681121.837470@pizda.ninka.net> <20010806125705.I15925@athlon.random> <20010807002650.B23937@weta.f00f.org> <20010806143603.C20837@athlon.random> <20010807004510.A23992@weta.f00f.org> <20010806145052.F20837@athlon.random> <15214.38470.749251.251809@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15214.38470.749251.251809@pizda.ninka.net>; from davem@redhat.com on Mon, Aug 06, 2001 at 06:06:14AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 06:06:14AM -0700, David S. Miller wrote:
> I wouldn't classify it as a horrible hack... but.

The part I find worse is that we just walk the tree two times.

I believe the best way is to allocate always the new vma, and to hide
the merging into the lowlevel of a new insert_vm_struct (with a special
function ala merge_segments that we can share with mprotect like in 2.2).

For example we could limit such special function to merge only the
anonymous mappings if we don't want to solve the locking issues (the
abortion), so it could remain simple but generic and optimized to avoid
walking the tree, allocating and freeing a slab cache is O(1) operation
when there's no memory pressore, much better than browsing a tree two
times at every malloc with a two liner that avoids hitting the
max_limit while we recall malloc. (of course for mremap we'll keep
browsing the tree twice but we cannot avoid that)

Andrea
