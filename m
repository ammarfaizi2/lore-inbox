Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbTEEPoU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 11:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbTEEPoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 11:44:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61968 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262356AbTEEPoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 11:44:19 -0400
Date: Mon, 5 May 2003 08:56:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David van Hoose <davidvh@cox.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.69
In-Reply-To: <3EB602ED.3080207@cox.net>
Message-ID: <Pine.LNX.4.44.0305050851080.18785-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Linux-kernel added to the cc, since I got several queries about what the 
  crashes were.. ]

On Mon, 5 May 2003, David van Hoose wrote:
> 
> Can I get some details regarding the AGP problem? I had some really bad 
> random crashes, panics, and hardlocks up through 2.5.68, and I'm 
> wondering if this is the same issue. I first noticed them around 2.5.63. 

They actually started in 2.5.60 if it's the same bug.

And yes, you'd get random crashes, panics, lockups and even reboots. The 
problem was that the pmd/pgd's were put in the slab cache in between 
2.5.59 and 2.5.60, and that was simply wrong because the AGP code changes 
the cacheability of the kernel pages when it maps stuff into the AGP 
aperture. That in turn will change the page tables but it won't update the 
cached entries in the pmd slab caches. 

So what happens is that once you exit X, and the page tables are put back
together without the cacheability changes, and you start a new program,
that program may get a page table with partly bogus kernel page table
entries.

That, in turn, when it happens will cause _major_ memory corruption, and
your machine is toast, often in very interesting ways because the internal
kernel data structures got corrupted. It can also cause random SIGSEGV's
etc.

But it only happens with AGP, and a lot of people either don't use it or 
run only one X session.

			Linus

