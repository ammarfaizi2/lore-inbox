Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbUCJJIi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 04:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbUCJJIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 04:08:38 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:56254 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S262129AbUCJJIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 04:08:36 -0500
Date: Wed, 10 Mar 2004 10:08:11 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Albert Cahalan <albert@users.sourceforge.net>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       corliss@digitalmages.com, riel@redhat.com, jerj@coplanar.net
Subject: Re: [PATCH] 2.6.x BSD Process Accounting w/High UID
In-Reply-To: <1078883951.2232.501.camel@cube>
Message-ID: <Pine.LNX.4.53.0403100940240.12833@gockel.physik3.uni-rostock.de>
References: <1078883951.2232.501.camel@cube>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2004, Albert Cahalan wrote:

> First of all, none of this matters much if the format
> is given a sysctl. The old format is default for now,
> and the new one is default (only?) in a couple years.
> Sun appears to have done something like this.

Yeah, if we even want to introduce a new syscall for this...
But Documentation/Changes is not an empty file, i.e., we require
people to upgrade userspace anyways.

> When fixing it, note that a 5-bit binary exponent
> with denormals would beat the current float format.

Yes, but only by a short head. And, since comp_t is hard-coded into 
current GNU acct tools, we can't keep source compatibility
(not that this matters too much anyways...)
I'm open for suggestions in this direction. Any reasonable ideas to
get more precision? (e.g. 16 bit mantissa and 4 bit base-whatever 
exponent?) 

> Regarding the existing struct though...
> 
> Let's take a close look at this. I think there are 2 bytes
> of padding on all Linux ports, and another 2 available
> on everything except maybe m68k and/or arm. (that is, ports
> that will put a u32 on any u16 boundry) Here is the current
> struct, compactly formatted with 64-bit blocking:
> 
> struct linux_acct {
>         char   ac_flag;        // Flags
> // 1 pad byte

Yep, but depending on architecure I think the compiler is free to insert
the padding either before or after ac_flags.

[...]
> 
> Just a sec... ARRRGH WHY DO PEOPLE LEAVE PADDING AND
> GENERALLY MIS-ALIGN THINGS ALL THE TIME??????

Yupp, I changed this for the new suggested binary-incompatible layout.

> So there you go. You have a pad byte after ac_flag
> at a known location, and a pad byte after ac_pad that
> might move a bit due to mis-alignments above it.

Yes, but I'd prefer an arch-independent and prominent position
(i.e. one that doesn't perturb alignment at the beginning of the struct)

Tim
