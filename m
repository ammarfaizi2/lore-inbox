Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289615AbSAWB1N>; Tue, 22 Jan 2002 20:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289617AbSAWB1D>; Tue, 22 Jan 2002 20:27:03 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:19258 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289615AbSAWB05>; Tue, 22 Jan 2002 20:26:57 -0500
Date: Wed, 23 Jan 2002 02:27:43 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: pte-highmem-5
Message-ID: <20020123022743.A18053@athlon.random>
In-Reply-To: <20020122201002.E1547@athlon.random> <Pine.LNX.4.21.0201222045450.1352-100000@localhost.localdomain> <20020123003449.F1547@athlon.random> <15438.2595.750370.978428@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <15438.2595.750370.978428@argo.ozlabs.ibm.com>; from paulus@samba.org on Wed, Jan 23, 2002 at 11:56:03AM +1100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2002 at 11:56:03AM +1100, Paul Mackerras wrote:
> Andrea Arcangeli writes:
> 
> > Let's speak about this later. We should ring a bell as soon as we know
> > what's really faster (invlpg at every kmap or global tlb flush once
> > every 1024 kmaps?).
> 
> It would be really good if we could have whatever hooks are necessary
> for each architecture to decide this issue in its own way.  On PPC for

you could implement pte_offset_nowait as you prefer (it has to
be implemented in include/asm like pte_offset), so yes, if we implement
nowait, you should be free to choose what's best to do on pcc
automatically while fixing the compilation failures.

at the moment there is either "persistent across schedule" or "atomic
local" (not the optimized "_nowait" suggested by Hugh in replacement of
"_atomic") and most of the time we depend on the requirements of the
caller about nonblocking due spinlocks, or persistence for schedules. So
there's not much to choose, only a few places could use both pte_offset
or pte_offset_atomic (on the long run we could turn those, and the other
_atomic into _nowait ones per Hugh suggestion, that would give you the
"hook").

> example a global tlb flush is really expensive, it would be quicker
> for us to either flush each kmap page individually or to flush the
> range of addresses used for kmaps when we wrap.  At the very least I
> would like to have a flush_tlb_kernel_range function which would get
> called at the end of flush_all_zero_pkmaps instead of flush_tlb_all.

that's certainly doable, on x86 it will just default to the
global tlb flush because we can't flush it more efficiently than that.

Andrea
