Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264493AbTFQAot (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 20:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264494AbTFQAot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 20:44:49 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:63877
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264493AbTFQAoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 20:44:46 -0400
Date: Tue, 17 Jun 2003 02:59:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Larry Auton <lkml@winux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: direct i/o problem with 2.4.21
Message-ID: <20030617005916.GP1571@dualathlon.random>
References: <16110.17820.740483.866151@eagle.skarven.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16110.17820.740483.866151@eagle.skarven.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 06:33:00PM -0400, Larry Auton wrote:
> > Message-ID: <16107.26375.67524.817817@nv.winux.com>
> > Date:   Sat, 14 Jun 2003 14:18:47 -0400
> > To:     linux-kernel@vger.kernel.org
> > From:   Larry Auton <lkml@winux.com>
> > Subject: direct i/o problem with 2.4.20 and 2.4.21rc7
> >
> > I have an application that requires direct i/o to thousands of files.
> > On 2.4.19 the open's would eventually fail (at around 7200 files).
> > On 2.4.20 and 2.4.21rc7 the machine hangs.
> > 
> > Here's a sample program to do the deed:
> > 
> >     wget http://www.skarven.net/lda/crashme.c
> >     cc -o crashme crashme.c     # compile it
> >     ./crashme 4000              # OK
> >     ./crashme 9999              # CRASH
> > 
> > It's a little obfuscated to eliminate the need for root privileges to
> > mess with rlimit. It simply opens a bunch of files with O_DIRECT and,
> > when enough files are open, the system will hang.
> > 
> > The system hangs when '/proc/slabinfo' reports that 'kiobuf' reaches 
> > just over 7230 active objects. I don't believe that this problem is
> > specific to any particular file system as the failure occurs when
> > using both ext2 and reiserfs.
> > 
> > Larry Auton
> 
> The hang I reported on 2.4.21rc7 persists in the released version 2.4.21.

can you try to reproduce with 2.4.21rc8aa1? (you can apply my full patch
to 21 final too of course since rc8 is the same as final) The fix for
this that also fixes the performance problem with rawio from the same
file but multiple fd is already in tree since several months, we should
push it into mainline ASAP. The basic idea of the patch that moves the
bh allocation flood down to the slab to take advantage of a shared
shrinkable cache was developed at intel AFIK.

the single patch is this but I doubt it would apply cleanly as 90% of
the other patches:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc8aa1/9996_kiobuf-slab-1

so you can make a quick test with the full 2.4.21rc8aa1.gz applied.

as for the hang, that's because the vm in mainline probably isn't
capable of returning -ENOMEM from syscalls under a zone normal shortage
(previously it wouldn't touch the vm side because it used vmalloc that
returns -ENOMEM w/o entering the VM). With the vm in my tree you
shouldn't experience hangs even w/o the fix for the kiobuf bh flood
allocation patch applied.

Andrea
