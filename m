Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277094AbRJDDAe>; Wed, 3 Oct 2001 23:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277095AbRJDDA0>; Wed, 3 Oct 2001 23:00:26 -0400
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:3599 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id <S277094AbRJDDAJ>; Wed, 3 Oct 2001 23:00:09 -0400
Date: Thu, 4 Oct 2001 04:00:35 +0100
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: minor mmap bug ?
Message-ID: <20011004040035.A16861@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: Truant - Neither Work Nor Leisure
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.4.10

In do_mmap_pgoff() :

    422         addr = get_unmapped_area(file, addr, len, pgoff, flags);
    423         if (addr & ~PAGE_MASK)
    424                 return addr;

in get_unmapped_area() :

    621         if (flags & MAP_FIXED) {
    622                 if (addr > TASK_SIZE - len)
    623                         return -EINVAL;
    624                 if (addr & ~PAGE_MASK)
    625                         return -EINVAL;
    626                 return addr;
    627         }


So it seems that if we hit the first case (addr > TASK_SIZE - len),
we don't return with EINVAL immediately. This code is a little weird anyway.

Is this a bug ?

Also, what's the reason for :

    405         if ((len = PAGE_ALIGN(len)) == 0)
    406                 return addr;


Also, shouldn't calc_vm_flags() mention MAP_LOCKED and the others specifically ?
The current "oh, it happens to be the same value" is distinctly non-obvious to me.


Also, why do several (all ?) of the do_mmap2()s do this :

     51         flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);

Is it something to do with mm->def_flags ?

thanks
john

-- 
" It is quite humbling to realize that the storage occupied by the longest line
from a typical Usenet posting is sufficient to provide a state space so vast
that all the computation power in the world can not conquer it."
	- Dave Wallace
