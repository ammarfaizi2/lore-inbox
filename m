Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbUDNSsV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 14:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUDNSsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 14:48:21 -0400
Received: from mail.shareable.org ([81.29.64.88]:39585 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261551AbUDNSsT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 14:48:19 -0400
Date: Wed, 14 Apr 2004 19:46:03 +0100
From: Jamie Lokier <jamie@shareable.org>
To: davidm@hpl.hp.com
Cc: linux-ia64@linuxia64.org, "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Kurt Garloff <garloff@suse.de>,
       linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] (IA64) Fix ugly __[PS]* macros in <asm-ia64/pgtable.h>
Message-ID: <20040414184603.GA12105@mail.shareable.org>
References: <9AB83E4717F13F419BD880F5254709E5011EBABA@scsmsx402.sc.intel.com> <20040414082355.GA8303@mail.shareable.org> <20040414113753.GA9413@mail.shareable.org> <16509.25006.96933.584153@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16509.25006.96933.584153@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
> Huh?  You haven't actually checked, have you?

Yes I have.  Quite thoroughly.

> I don't pollute namespace for no good reason.

In this instance, there is a certain amount of arch variation.  parisc
defines PAGE_EXECREAD and PAGE_RWX.  ppc defines PAGE_COPY_X,
PAGE_SHARED_X, PAGE_READONLY_X (X is for exec).  m68k defines
PAGE_COPY_C, PAGE_READONLY_C, PAGE_SHARED_C.  x86_64 defines
PAGE_COPY_EXEC, PAGE_SHARED_EXEC and PAGE_READONLY_EXEC.

Those are all arch-private names, some of them used in code in arch/*,
some just to define the __[PS]* constants.

>  Jamie> Here is a page (untested) which cleans up those definitions.
>  Jamie> It was made from 2.6.5.
> 
> If the same names are adopted by the other platforms, I'm fine with it.
> Otherwise, see my comment above.

I copied <asm-x86_64/pgtable.h>, which closely matches ia64, except
for PAGE_EXEC which I named because nothing else has it.  That name
isn't used anywhere.  On reflection, a better name for it is
PAGE_EXECONLY (like PAGE_READONLY).

In theory the Alpha can do exec-only pages, but it's __[PS]* map
always gives read permission when there's execute permission.  I'm not
sure if there's a reason for that, or if it just historically copied
the i386 behaviour (Alpha was the first port).

The constants PAGE_KERNEL and PAGE_READONLY are used in
arch-independent code with a common meaning.  Otherwise, the constants
are used only to defined __[PS]* and a few in arch-dependent
initialisation code.

I agree it is best to avoid namespace pollution.  However this is one
area where ia64 sticks out because it's approach is different from
other ports.  All of them except Alpha used PAGE_* names to clarify
the __[PS]* map, defining additional names as needed.

The Alpha is quite clean in a different way, or looks like it until
you realise the _PAGE_P() macro is equivalent to identity so just
obfuscates the code.  (The _PAGE_P() macro which is absurd because
it's a complicated expression that's equivalent to identity).

The thing I don't like about the ia64 file is the mixing of two
different styles of definition in the same table.  When I had to read
all the arch pgtable.h files to discover what is Linux's mmap()
behaviour on each one, ia64 stood out awkwardly.

-- Jamie
