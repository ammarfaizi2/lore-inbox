Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263133AbUDBCiV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 21:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbUDBCiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 21:38:21 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:669
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263133AbUDBCiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 21:38:17 -0500
Date: Fri, 2 Apr 2004 04:38:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040402023817.GR18585@dualathlon.random>
References: <20040401135920.GF18585@dualathlon.random> <20040401170705.Y22989@build.pdx.osdl.net> <20040402011804.GL18585@dualathlon.random> <20040401173014.Z22989@build.pdx.osdl.net> <20040402013547.GM18585@dualathlon.random> <20040401180441.B22989@build.pdx.osdl.net> <20040402021323.GP18585@dualathlon.random> <20040401182122.Y21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401182122.Y21045@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 06:21:27PM -0800, Chris Wright wrote:
> Ah, yes I see what you are saying.  This is the same issue with normal
> pages and SHM_LOCK that I mentioned earlier, I believe.  I don't see the
> best solution, because once you detach w/out any destroy, there could be
> nobody to assign the accounting to.  Do you agree?

yes, rlimit just can't account for shmget(SHM_HUGETLB) and
shmctl(SHM_LOCK) either, because it can only account the stuff that you
temporarily have in the address space.

the exploit is simply to shmget tons of 2M hugepage segments, and to
shmat/shmdt all of them, then you'll pin N times those 2M largepages,
and they will not be accounted anywhere allowing anybody to pin as much
memory as they want.

Both shmctl(SHM_LOCK) and shmget(SHM_HUGETLB) cannot be allowed in
function of any rlimit check, a system wide sysctl (as we implemented)
or some other method (can be implemented in userspace too of course, as
Andrew suggested) is needed for that. Using rlimit for that is broken
and in turn insecure.

the rlimit however works fine for _mlock_.

the fundamental difference between mlock and SHM_LOCK/SHM_HUGETLBFS is
that mlock is about locking pages in the address space, after the
address space is unmapped the mlock is gone too, so when the rlimit is
ok with it, you can mlock more ram. SHM_LOCK/SHM_HUGETLB is about
allocating physical pages, the mapping in the address space has no
effect on those, those pages will never be released after the mapping
is gone. So the rlimit can't help here.
