Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992734AbWJTVOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992734AbWJTVOA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992725AbWJTVN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:13:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39145 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030332AbWJTVN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:13:58 -0400
Date: Fri, 20 Oct 2006 14:12:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       ralf@linux-mips.org, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       anemo@mba.ocn.ne.jp, linux-arch@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
In-Reply-To: <20061020205929.GE8894@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0610201408070.3962@g5.osdl.org>
References: <Pine.LNX.4.64.0610200846260.3962@g5.osdl.org>
 <20061020.123635.95058911.davem@davemloft.net> <Pine.LNX.4.64.0610201251440.3962@g5.osdl.org>
 <20061020.125851.115909797.davem@davemloft.net> <Pine.LNX.4.64.0610201302090.3962@g5.osdl.org>
 <20061020205929.GE8894@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Oct 2006, Russell King wrote:
> 
> Well, looking at do_wp_page() I'm now quite concerned about ARM and COW.
> I can't see how this code could _possibly_ work with a virtually indexed
> cache as it stands.  Yet, the kernel does appear to work.

It really shouldn't need any extra code, exactly because by the time it 
hits any page-fault, the caches had better be in sync with the physical 
page contents _anyway_ (yes, being virtual, the caches will _duplicate_ 
the contents, but since the pages are read-only, that aliasing should be 
perfectly fine).

> I'm afraid I'm utterly confused with the Linux MM in this day and age, so
> I don't think I can even consider commenting on this change.

Well, we'd need somebody to verify that it still works, but quite frankly, 
the likelihood of it breaking anything seems basically nil.

> However, when I look at this code now, I see _no where_ where we synchronise
> the cache between the userspace mapping and the kernel space mapping before
> copying a COW page.

At the COW, it should be synchronized already, exactly because we did the 
cache_flush_mm() when we _created_ the COW mapping in the first place.

It's just that we weren't quite careful enough at that time (and even 
then, that would only matter for some really really unlikely and strange 
situations that only happen when you fork() from a _threaded_ environment, 
so it shouldn't be anything you'd notice under normal load).

I think.

> So I'm afraid I'm going to have to hold up my hand and say "I don't
> understand the Linux MM anymore".

There are few enough people who understand it even though they're supposed 
to. I certainly have to always go back and look and read the code when 
there is anything subtle going on, and even then I want to be backed up by 
one of the _competent_ people ;)

			Linus
