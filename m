Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751503AbWF1RqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbWF1RqM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWF1RqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 13:46:11 -0400
Received: from mga03.intel.com ([143.182.124.21]:45209 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751503AbWF1RqJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 13:46:09 -0400
X-IronPort-AV: i="4.06,189,1149490800"; 
   d="scan'208"; a="58747273:sNHT22211452340"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] ia64: change usermode HZ to 250
Date: Wed, 28 Jun 2006 10:36:35 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A27FC5F@scsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ia64: change usermode HZ to 250
Thread-Index: Acaa0h69R3d2t9QcQf2R0oRbH0zJIQAA0Wsw
From: "Luck, Tony" <tony.luck@intel.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "John Daiker" <jdaiker@osdl.org>
Cc: "John Hawkes" <hawkes@sgi.com>, "Arjan van de Ven" <arjan@infradead.org>,
       "Tony Luck" <tony.luck@gmail.com>, "Andrew Morton" <akpm@osdl.org>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "Jack Steiner" <steiner@sgi.com>, "Dan Higgins" <djh@sgi.com>,
       "Jeremy Higdon" <jeremy@sgi.com>
X-OriginalArrivalTime: 28 Jun 2006 17:36:37.0152 (UTC) FILETIME=[68167200:01C69AD9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In the cached HZ case there will be no performance hit of measure
> anyway. The bigger problem is existing user space. That is why we've
> always kept the user visible HZ based values the same when changing the
> kernel HZ. You can't automatically regenerate all the old binaries you
> might otherwise break.

No we haven't kept user visible HZ the same ... look at times(2)
it reports in "clock ticks", and has a note on the manual page
that you must use sysconf(_SC_CLK_TCK) to find out how many ticks
are in a second.  So dusty deck binaries with hard-coded 100 (or
even older ones with 60 or 50) have been broken for a while now.

Also note that the sysconf(_SC_CLK_TCK) call doesn't take a
system call, the kernel passes CLOCKS_PER_SEC in the AT_CLKTCK
auxilliary vector during fs/binfmt_elf.c:create_elf_tables(),
so glibc can complete this call with a simple table lookup in
userspace.

Fixing param.h to have #define HZ sysconf(_SC_CLK_TCK) sounds
like a plausible solution, many incorrect uses will be fixed
automagically by the next rebuild.  But some more obscure usages
of HZ may not compile (which is good, then they can be fixed
properly) or worse may compile, but not do the right thing.

Removing it completely might be better, it may force people to
look at how they are using HZ.  But there are probably many old
programs that have:

#ifndef HZ
#define HZ 60
#endif

So this won't catch them.

The ultimate safe solution might be:

#define HZ Fix your program to use sysconf(_SC_CLK_TCK)! \
	(and BTW, you should not include kernel headers)

Which is highly likely to cause a compile failure (but should
at least provide a clue to the user on what they should do).

-Tony
