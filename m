Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUCIPkm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 10:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUCIPkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 10:40:42 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:56837
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262008AbUCIPkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 10:40:22 -0500
Date: Tue, 9 Mar 2004 16:41:02 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [lockup] Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309154102.GG8193@dualathlon.random>
References: <20040308202433.GA12612@dualathlon.random> <20040309105226.GA2863@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040309105226.GA2863@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 11:52:26AM +0100, Ingo Molnar wrote:
> 
> * Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > This patch avoids the allocation of rmap for shared memory and it uses
> > the objrmap framework to do find the mapping-ptes starting from a
> > page_t which is zero memory cost, (and zero cpu cost for the fast
> > paths)
> 
> this patch locks up the VM.
> 
> To reproduce, run the attached, very simple test-mmap.c code (as
> unprivileged user) which maps 80MB worth of shared memory in a
> finegrained way, creating ~19K vmas, and sleeps. Keep this process
> around.
> 
> Then try to create any sort of VM swap pressure. (start a few desktop
> apps or generate pagecache pressure.) [the 500 MHz P3 system i tried
> this on has 256 MB of RAM and 300 MB of swap.]
> 
> stock 2.6.4-rc2-mm1 handles it just fine - it starts swapping and
> recovers. The system is responsive and behaves just fine.
> 
> with 2.6.4-rc2-mm1 + your objrmap patch the box in essence locks up and
> it's not possible to do anything. The VM is looping within the objrmap
> functions. (a sample trace attached.)
> 
> Note that the test-mmap.c app does nothing that a normal user cannot do. 
> In fact it's not even hostile - it only has lots of vmas but is
> otherwise not actively pushing the VM, it's just sleeping. (Also, the
> test is a very far cry from Oracle's workload of gigabytes of shm mapped
> in a finegrained way to hundreds of processes.) All in one, currently i
> believe the patch is pretty unacceptable in its present form.

this doesn't lockup for me (in 2.6 + objrmap), but the machine is not
responsive, while pushing 1G into swap. Here a trace in the middle of the
swapping while pressing C^c on your program doesn't respond for half a minute.

Mind to leave it running a bit longer before claiming a lockup?

 1 206 615472   4032     84 879332 11248 16808 16324 16808 2618 20311  0 43  0 57
 1 204 641740   1756     96 878476 2852 16980  4928 16980 5066 60228  0 35  1 64
 1 205 650936   2508    100 875604 2248 9928  3772  9928 1364 21052  0 34  2 64
 2 204 658212   2656    104 876904 3564 12052  4988 12052 2074 19647  0 32  1 67
 1 204 674260   1628    104 878528 3236 12924  5608 12928 2062 27114  0 47  0 53
 1 204 678248   1988     96 879004 3540 4664  4360  4664 1988 20728  0 31  0 69
 1 203 683748   4024     96 878132 2844 5036  3724  5036 1513 18173  0 38  0 61
 0 206 687312   1732    112 879056 3396 4260  4424  4272 1704 13222  0 32  0 68
 1 204 690164   1936    116 880364 2844 3400  3496  3404 1422 18214  0 35  0 64
 0 205 696572   4348    112 877676 2956 6620  3788  6620 1281 11544  0 37  1 62
 0 204 699244   4168    108 878272 3140 3528  3892  3528 1467 11464  0 28  0 72
 1 206 704296   1820    112 878604 2576 4980  3592  4980 1386 11710  0 26  0 74
 1 205 710452   1972    104 876760 2256 6684  3092  6684 1308 20947  0 34  1 66
 2 203 714512   1632    108 877564 2332 4876  3068  4876 1295  9792  0 20  0 80
 0 204 719804   3720    112 878128 2536 6352  3100  6368 1441 20714  0 39  0 61
124 200 724708   1636    100 879548 3376 5308  3912  5308 1516 20732  0 38  0 62
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1 204 730908   4344    100 877528 2592 6356  3672  6356 1819 15894  0 35  0 65
 0 204 733556   3836    104 878256 2312 3132  3508  3132 1294 10905  0 33  0 67
 0 205 736380   3388    100 877376 3084 3364  3832  3364 1322 11550  0 30  0 70
 1 206 747016   2032    100 877760 2780 13144  4272 13144 1564 17486  0 37  0 63
 1 205 756664   2192     96 878004 1704 7704  2116  7704 1341 20056  0 32  0 67
 9 203 759084   3200     92 878516 2748 3168  3676  3168 1330 18252  0 45  0 54
 0 205 761752   3928     96 877208 2604 2984  3284  2984 1330 10395  0 35  0 65

most of the time is spent in "wa", though it's a 4-way, so it means at least
two cpus are spinning. I'm pushing the box hard into swap. 2.6 swap extremely
slow w/ or w/o objrmap, not much difference really w/o or w/o your exploit.

now the C^c hit, and I got the prompt back, no lockup.

Note that my swap workload was very heavy too, with 200 tasks all swapping in
the shm segment, so stalls have to be expected.

And if Oracle really mlocks the ram (required anyways if you use rmap as you
admitted) this is a no-issue for oracle.

As Andrew said we've room for improvements too, just checking page_mapped in
the middle of the vma walk (to break it) will make a lot of difference in the
average cpu cost.
