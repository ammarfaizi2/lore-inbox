Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263026AbVCDUWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263026AbVCDUWM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 15:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263046AbVCDUSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 15:18:07 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19113 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263109AbVCDUJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:09:27 -0500
Date: Fri, 4 Mar 2005 21:09:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@zip.com.au>, Hu Gang <hugang@soulinfo.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][0/3] swsusp: use non-contiguous memory
Message-ID: <20050304200903.GA2385@elf.ucw.cz>
References: <200503042049.36873.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503042049.36873.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following set of patches is designed to fix a problem in the current
> implementation of swsusp in mainline kernels.  Namely, swsusp uses
> an array of page backup entries (aka pagedir) to store pointers to memory
> pages that must be saved during suspend and restored during resume.
> 
> Unfortunately, the pagedir has to be located in a contiguous chunk of memory
> and it sometimes turns out that an 8-order or even 9-order allocation is needed
> for this purpose.  It sometimes is impossible to get such an allocation and
> swsusp may fail during either suspend or resume due to the lack of memory,
> although theoretically there is enough free memory for it to succeed.
> 
> Moreover, swsusp is more likely to fail for this reason during resume, which
> means that it may fail during resume after a successful suspend
> (this actually has happened for some people, including me :-)) and this,
> potentially, may lead to the loss of data.
> 
> The problem is fixed by replacing the pagedir with a linklist so that
> high-order memory allocations are avoided (the patches make swsusp use only
> 0-order allocations).  Unfortunately this means that it's necessary to change
> assembly routines used to restore the image after it's been loaded from
> swap so that they walk the list instead of walking the array.
> 
> The patches are organized in the following way:
> 
> [1] suspend part
> 	This patch makes swsusp allocate only individual pages during suspend.
> 	It does not require any changes to assembly routines and is
> 	architecture-independent.
> 	It has been present in the -mm kernels for some time.
> 	It contains some additional clean-ups and fixes from Pavel Machek
> 	and Adrian Bunk.
> 
> [2] main resume part (core, i386, x86-64)
> 	This patch makes swsusp allocate only individual pages during resume.
> 	It contains the necessary changes to the assembly routines etc. for i386
> 	and x86-64.
> 	It depends on the suspend part.
> 
> [3] resume part - ppc support
> 	This patch contains the necessary changes to the assembly routines
> 	etc. for ppc.
> 	It depends on the main resume part.
> 	It's a Hu Gang's patch.
> 
> The patches are against 2.6.11.
> 
> Well, I hope I did it right. ;-)  Please consider for applying.

Wow, very nice summary. ACK on all 3 patches...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
