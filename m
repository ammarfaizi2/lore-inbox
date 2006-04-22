Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWDVR17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWDVR17 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 13:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWDVR16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 13:27:58 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:45973 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750786AbWDVR15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 13:27:57 -0400
Date: Sat, 22 Apr 2006 11:33:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [PATCH] 'make headers_install' kbuild target.
Message-ID: <20060422093328.GM19754@stusta.de>
References: <1145672241.16166.156.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145672241.16166.156.camel@shinybook.infradead.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2006 at 03:17:20AM +0100, David Woodhouse wrote:
>...
> Implementation details aside, the point is that we can now work on
> refining the choice of headers to be exported, and more importantly we
> can start fixing the _contents_ of those headers so that nothing which
> should be private is exported in them outside #ifdef __KERNEL__.
> 
> I've chosen headers in the generic directories and in asm-powerpc; the
> other asm directories could do with a proper selection being made; the
> rest of the current list is just inherited from Fedora's
> glibc-kernheaders package for now.
> 
> For a start, the headers I've marked for export are sometimes including
> headers which _weren't_ so marked, and hence which don't exist in our
> exported set of headers. I've started to move those inclusions into
> #ifdef __KERNEL__ where appropriate, but there's more of that to do
> before we can even use these for building anything and actually start to
> test them in earnest.
> 
> Adrian, I'm hoping we can persuade you to help us audit the resulting
> contents of usr/include/* and apply your usual treatment to the headers
> until it looks sane. That assistance would be very much appreciated.

My thirst thought is:
Is this really the best approach, or could this be done better?

I'm currently more a fan of a separate kabi/ subdir with headers used by 
both headers under linux/ and userspace.

Why?

Unless I'm misunderstanding this, your changes are giving a result 
identical result to simply using the current kernel headers (stripping 
the #ifdef __KERNEL__ stuff doesn't change anything).

If we want to define an ABI and do it right, the resulting ABI headers
should be write-only, and should even continue to contain the ABI for
code already removed from the kernel.

It should be possible to do this incrementically:
- without breaking the kernel at any time
- with no userspace breakages when switching to the ABI headers for 
  userspace (there might be corner cases, and if e.g. the asm-i386/atomic.h
  abuse by MySQL breaks that's not a loss)

This might take a bit longer, but as a result we have:
- an ABI where diffstat is able to tell us if someone has touched the ABI
  (can git trigger electric shocks for everyone trying to commit or pull 
   changes to the kabi/ subdir?  ;-)  )
- as a side effect, some cleanup of the current kernel headers

Unless someone can tell me a reason why this wouldn't work (except for 
being a bit more work than your approach), this is the approach I have 
in mind for working on.

> dwmw2

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

