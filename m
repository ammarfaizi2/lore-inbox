Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262112AbSJVELJ>; Tue, 22 Oct 2002 00:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262119AbSJVELJ>; Tue, 22 Oct 2002 00:11:09 -0400
Received: from zero.aec.at ([193.170.194.10]:3847 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S262112AbSJVELI>;
	Tue, 22 Oct 2002 00:11:08 -0400
Date: Tue, 22 Oct 2002 06:15:24 +0200
From: Andi Kleen <ak@muc.de>
To: Jeff Dike <jdike@karaya.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andi Kleen <ak@muc.de>,
       john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
Message-ID: <20021022041524.GA11474@averell>
References: <20021020023321.GS23930@dualathlon.random> <200210220507.AAA06089@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210220507.AAA06089@ccure.karaya.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > My problem is that mapping user code into the vsyscall fixmap is
> > complex and not very clean at all, breaks various concepts in the mm
> > and last but not the least it is slow
> 
> Can you explain, in small words, why mapping user code is so horrible?

Currently Linux has neatly separated kernel and user page tables.
On architectures which have tree type tables in hardware you just have
a user level table and you stick a pointer to the kernel level tables
somewhere at the end of the first page. The normal user level page
handling doesn't know about the kernel pages. The vsyscall code is in
the kernel mapping in the fixmaps. Allowing the user to map arbitary
pages into the vsyscall area would blur this clear separation and
require much more special case handling. 

In addition it would break a lot of assumptions that user mappings are
only < __PAGE_OFFSET, probably having security implications. For example
you would need to special case this in uaccess.h's access_ok(), which 
would be quite a lot of overhead (any change to this function causes
many KB of binary bloat because *_user is so heavily used all over the kernel)

-Andi
