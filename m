Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291306AbSCTTi0>; Wed, 20 Mar 2002 14:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293010AbSCTTiQ>; Wed, 20 Mar 2002 14:38:16 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:33292 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S291306AbSCTTiG>;
	Wed, 20 Mar 2002 14:38:06 -0500
Date: Wed, 20 Mar 2002 16:35:16 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scalability problem (kmap_lock) with -aa kernels
In-Reply-To: <20020320192625.H4268@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0203201630070.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002, Andrea Arcangeli wrote:

> One design idea I had to avoid the locking in the persistnt kmaps around
> the copy-user, is to rewrite completly the persistnt code with a pool of
> atomic kmaps per-CPU and to pin the task to the current CPU before doing
> the copy-user, and then to count the number of reentrant persistent
> kmaps happening in the current CPU and if it overflows we block waiting
> somebody else to be wakenup and to kunmap.  pros: it would avoid all the
> locks (complete scalability, all per-cpu), it would avoid the IPI and
> the global flush. cons: it will possibly waste some more address space
> since not all NR_CPUS are going to be used in all machines, and it will
> not be able to do any caching, so page->virtual can be dropped enterely
> in x86 then, and it will reduce the ability of the scheduler to
> reschedule in idle cpus during copy users around persistent kmaps.

Ahhhhh, but once you've reached that point, you might
as well make the kmap array PER PROCESS.

This has some advantages over the per-cpu scheme:
- no address space wastage
- caching is possible
- processes can be rescheduled
- the process can sleep while holding a kmap

It would still avoid the locks and flushes because we
can simply mark the address range used for these per
process kmaps as non-global so they'll be carried with
the process just like the user space page tables are.

This should result in somewhat simpler code than either
a global kmap array or a per-cpu kmap array. The fact
that the amount of kmap space scales with the number of
processes should also completely get rid of processes
sleeping on kmap space.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

