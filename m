Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbUCIQC3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 11:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbUCIQC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 11:02:29 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:23559
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262017AbUCIQCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 11:02:25 -0500
Date: Tue, 9 Mar 2004 17:03:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [lockup] Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309160307.GI8193@dualathlon.random>
References: <20040308202433.GA12612@dualathlon.random> <20040309105226.GA2863@elte.hu> <20040309110233.GA3819@elte.hu> <20040309030907.71a53a7c.akpm@osdl.org> <20040309114924.GA4581@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040309114924.GA4581@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 12:49:24PM +0100, Ingo Molnar wrote:
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > > or run the attached test-mmap2.c code, which simulates a very small DB
> > >  app using only 1800 vmas per process: it only maps 8 MB of shm and
> > >  spawns 32 processes. This has an even more lethal effect than the
> > >  previous code.
> > 
> > Do these tests actually make any forward progress at all, or is it some bug
> > which has sent the kernel into a loop?
> 
> i think they make a forward progress so it's more of a DoS - but a very
> effective one, especially considering that i didnt even try hard ...
> 
> what worries me is that there are apps that generate such vma patterns
> (for various reasons).

those vmas in those apps are forced to be mlocked with the rmap VM, so
it's hard for me to buy that rmap is any better. You can't even allow
those vmas to be non-mlocked or you'll finish your zone-normal even with
4:4.

on 64bit those apps will work _absolutely_best_ with objrmap and they'll
waste tons of ram (and some amount of cpu too) with rmap. objrmap is the
absolutely best model for those apps in any 64bit arch.

the argument you're making about those apps are all in favour of objrmap
IMO.

> I do believe that scanning ->i_mmap & ->i_mmap_shared is fundamentally
> flawed.

If it's the DoS that you worry about, vmtruncate will do the trick too.

overall machine remains usable for me, despite the increased cpu load.
