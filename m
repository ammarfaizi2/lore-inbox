Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272454AbTHMMtB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 08:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272540AbTHMMtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 08:49:01 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:12280 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S272454AbTHMMs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 08:48:59 -0400
Subject: Re: 2.6.0-test3-mm1: scheduling while atomic (ext3?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <p7365l17o70.fsf@oldwotan.suse.de>
References: <20030813045638.GA9713@middle.of.nowhere.suse.lists.linux.kernel>
	 <20030813014746.412660ae.akpm@osdl.org.suse.lists.linux.kernel>
	 <20030813091958.GA30746@gates.of.nowhere.suse.lists.linux.kernel>
	 <20030813025542.32429718.akpm@osdl.org.suse.lists.linux.kernel>
	 <1060772769.8009.4.camel@localhost.localdomain.suse.lists.linux.kernel>
	 <20030813042544.5064b3f4.akpm@osdl.org.suse.lists.linux.kernel>
	 <1060774803.8008.24.camel@localhost.localdomain.suse.lists.linux.kernel>
	 <p7365l17o70.fsf@oldwotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060778924.8008.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 13 Aug 2003 13:48:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-08-13 at 13:10, Andi Kleen wrote:
> > Beats me, but then the prefetch code in 2.6 seems broken from
> > 5 seconds of inspection anyway. We are testing the XMM feature
> > and using prefetchnta for Athlon, thats wrong for lots of athlon
> > processors that dont have XMM but do have prefetch/prefetchw,
> > (which btw also seem to work properly on all these processors
> >  while prefetchnta seems to do funky things)
> 
> The early Athlon Specific test was not done to avoid too much bloat.
> (three alternatives instead of two)

Lets replace working code with broken macros whoooo.. progress. Lots of
Athlons don't have XMM, most of the older ones where prefetch has the
most impact in fact. (The XMM using ones have the hw prefetcher too).

> Most Athlons in existence should have XMM already and the rest works.

Lots don't have XMM

> You can hardly call that broken.

I just did. Its worse than 2.4 behaviour.

> That's done for write prefetches correctly.
> (as Intel does not have a write prefetch)

Actually its iffy too. 3Dnow doesnt imply prefetchw. You
must test 3Dnow && vendor==AMD && Athlon. (K6 prefetchw
is slower than not using it, other 3Dnow chips dont have it
eg the Cyrix MII which may explain a couple of things. I don't
see anywhere we mask the 3Dnow property by these but I've not
dug through the CPU code right now to see if we have a "3Dnowplus"
type definition we can check.

I suspect the best way to do prefetch cleanly would be something
like this

#if defined(CONFIG_MK7)
    alternative_input("prefetch" or "prefetchnta")
#else
    alternative_input(ASM_NOP4 or "prefetchnta");
#endif

Ideally we want a 3 way patch table to fix up at boot time but the if
case at least gets us back to desirable situations. Also if I remember
the prefetch exception thing rightly you can misalign the prefetch
instruction as a workaround.

Alan

