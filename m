Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWDGFeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWDGFeK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 01:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWDGFeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 01:34:10 -0400
Received: from adsl-71-140-189-62.dsl.pltn13.pacbell.net ([71.140.189.62]:26245
	"EHLO aexorsyst.com") by vger.kernel.org with ESMTP id S932269AbWDGFeI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 01:34:08 -0400
From: "John Z. Bohach" <jzb@aexorsyst.com>
Reply-To: jzb@aexorsyst.com
To: linux-kernel@vger.kernel.org, akpm <akpm@osdl.org>
Subject: Re: [PATCH] mpparse: prevent table index out-of-bounds
Date: Thu, 6 Apr 2006 22:34:00 -0700
User-Agent: KMail/1.5.2
References: <200603212005.58274.jzb@aexorsyst.com> <200604060918.45185.jzb@aexorsyst.com> <20060406131805.d6eb0fe7.rdunlap@xenotime.net>
In-Reply-To: <20060406131805.d6eb0fe7.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604062234.00455.jzb@aexorsyst.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 April 2006 13:18, Randy.Dunlap wrote:
> On Thu, 6 Apr 2006 09:18:45 -0700 John Z. Bohach wrote:
>
> Re: mem= causes oops (was Re: BIOS causes (exposes?) modprobe (load_module)
> kernel oops)
>
> > I found the root cause, but don't know if its worth fixing.  If the board
> > has more than 32 PCI busses on it, the mptable bus array will overwrite
> > its bounds for the PCI busses, and stomp on anything that's after it.  In
> > this case, what got stomped on is the PAGE_KERNEL_EXEC variable, which
> > changed the bit-field settings for the page tables (cleared the 'present'
> > bit, and screwed up the rest), hence accounting for the page fault.
>
> Well, > 32 busses or just one busid value >= 32.
>
> > This can only happen if there are more than 32 PCI busses, so I'd say its
> > an _extremely_ rare condition on a desktop system.  At any rate, the fix
> > would simply be to change the value of the #define in the mptable.h
> > header file (I forget which exactly, but its easy to find) from 32 to
> > 256. The side effect of that is that the kernel data area would grow, and
> > mostly be a total waste, since I can't fathom a desktop system with more
> > than 32 PCI busses.  On arch's where more than 32 PCI busses are likely,
> > the #define is already 256.
>
> I think that the kernel init code should detect and prevent the
> data corruption.  Here's a patch to do that, by ignoring busses
> whose busid value is too large.

Yeah, I follow your thinking, and was about to do the same thing, until
I consulted the book of armaments, in this case, the MP Spec. ver. 1.4.

Section 4.3.2, Bus Entries, Bus ID:

"An integer that identifies the bus entry.  The BIOS assigns identifiers
starting at zero, sequentially."

Given this, I considered the kernel adequate.  Nevertheless, your patch is a good
defensive programming method against buggy BIOS's.  I haven't actually tested it,
but it looks like it'll be okay.

--john

