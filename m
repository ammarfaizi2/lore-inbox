Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262158AbSJVFEf>; Tue, 22 Oct 2002 01:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262159AbSJVFEf>; Tue, 22 Oct 2002 01:04:35 -0400
Received: from [195.223.140.120] ([195.223.140.120]:10568 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262158AbSJVFEe>; Tue, 22 Oct 2002 01:04:34 -0400
Date: Tue, 22 Oct 2002 07:08:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@muc.de>
Cc: Jeff Dike <jdike@karaya.com>, john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
Message-ID: <20021022050848.GN19337@dualathlon.random>
References: <20021020023321.GS23930@dualathlon.random> <200210220507.AAA06089@ccure.karaya.com> <20021022041524.GA11474@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021022041524.GA11474@averell>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 06:15:24AM +0200, Andi Kleen wrote:
> > > My problem is that mapping user code into the vsyscall fixmap is
> > > complex and not very clean at all, breaks various concepts in the mm
> > > and last but not the least it is slow
> > 
> > Can you explain, in small words, why mapping user code is so horrible?
> 
> Currently Linux has neatly separated kernel and user page tables.
> On architectures which have tree type tables in hardware you just have
> a user level table and you stick a pointer to the kernel level tables
> somewhere at the end of the first page. The normal user level page
> handling doesn't know about the kernel pages. The vsyscall code is in
> the kernel mapping in the fixmaps. Allowing the user to map arbitary
> pages into the vsyscall area would blur this clear separation and
> require much more special case handling. 
> 
> In addition it would break a lot of assumptions that user mappings are
> only < __PAGE_OFFSET, probably having security implications. For example
> you would need to special case this in uaccess.h's access_ok(), which 
> would be quite a lot of overhead (any change to this function causes
> many KB of binary bloat because *_user is so heavily used all over the kernel)

that's not the problem. you would use get_user_pages to pin the page,
after that such a page it's like a normal plain kernel page allocated
with GFP_KERNEL provided that you never write to it (that's fine, it's
mapped readonly like the regular vsyscall page) and that you don't
pretend it to be constant (again that's fine since if uml changes it
under itself that's its own problem ;).  It's not *that* messy as
breaking the whole copy-user concept. See my other email for more
details on this issue.

Andrea
