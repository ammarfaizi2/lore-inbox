Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261424AbSJMJYQ>; Sun, 13 Oct 2002 05:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261476AbSJMJYP>; Sun, 13 Oct 2002 05:24:15 -0400
Received: from holomorphy.com ([66.224.33.161]:1673 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261424AbSJMJYP>;
	Sun, 13 Oct 2002 05:24:15 -0400
Date: Sun, 13 Oct 2002 02:26:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: "Joseph D. Wagner" <wagnerjd@prodigy.net>,
       "'Rob Mueller'" <robm@fastmail.fm>,
       "'Mark Hahn'" <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org,
       "'Jeremy Howard'" <jhoward@fastmail.fm>
Subject: Re: Strange load spikes on 2.4.19 kernel
Message-ID: <20021013092602.GB27878@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>,
	"Joseph D. Wagner" <wagnerjd@prodigy.net>,
	'Rob Mueller' <robm@fastmail.fm>,
	'Mark Hahn' <hahn@physics.mcmaster.ca>,
	linux-kernel@vger.kernel.org, 'Jeremy Howard' <jhoward@fastmail.fm>
References: <113001c27282$93955eb0$1900a8c0@lifebook> <000001c27286$6ab6bc60$7443f4d1@joe> <20021013085938.GA23575@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021013085938.GA23575@krispykreme>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 06:59:38PM +1000, Anton Blanchard wrote:
> My 24 way SMP disagrees with your analysis:
> http://samba.org/~anton/linux/2.5.40/dbench/
> Thats just ext2. dbench is a filesystem benchmark that is heavy on
> inode/block allocation.
> Please show us your profiles which show linux filesystems do not
> utilise SMP.

Low-level fs driver block allocation etc. does appear to be an issue in
the fs-intensive benchmarks I run. In fact, the it's the only remaining
serious lock contention issue besides the dcache_lock, and that's
solved in akpm's tree. I have assurances work is being done on block
allocation and am not too concerned about it.

The rest of the trouble I see is lock contention in the page allocator
(solved in akpm's tree), stability (%$#*!), scheduler/VM/vfs/block I/O
data structure space consumption, and raw cpu cost of various
algorithms. pmd's are particularly pernicious (dmc had something for
this), followed by buffer_heads, task_structs, names_cache (mostly an
artifact of the benchmarks, but worth fixing), and inodes.

Last, but not least, when OOM does occur, the algorithm for OOM
recovery does not degrade well in the presence of many tasks. There is
also an issue with the arrival rate to out_of_memory() being O(cpus)
and the OOM killer being based on arrival rates, but not scaling its
threshholds appropriately. The former means that the OOM killer is
triggered falsely, and the latter means the box is unresponsive for so
long in OOM kill sprees it is dead period.

Bill
