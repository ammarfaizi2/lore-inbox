Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262628AbUKEItg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262628AbUKEItg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 03:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbUKEItg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 03:49:36 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:18600 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262628AbUKEItJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 03:49:09 -0500
Date: Fri, 5 Nov 2004 09:49:00 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
Message-ID: <20041105084900.GN8229@dualathlon.random>
References: <20041028192104.GA3454@dualathlon.random> <20041105080716.GL8229@dualathlon.random> <20041105083102.GD16992@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105083102.GD16992@wotan.suse.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 09:31:02AM +0100, Andi Kleen wrote:
> At least the NX handling is still broken on i386 (when reverting
> back it doesn't clear the NX bit for kernel text) 

I'd never use a 32bit kernel on a x86-64 box, so that's sort of low
interest bug to me, but acked.

> I still don't like how you remove the reversal handling completely.

that's to make it fully symmetric. If you're so attached to the old
API, I'm not going to care if you want it back, but if there are 3
symmetric users with the third going to work on a different page, my
code will work the previous code will corrupt the mapping due the
refcount going down too fast. If you could mention a single case where
it would make sense not to be symmetric, I would change my mind. I find
so much simpler to remember that as far as I'm always symmetric the
refcounting will go right no matter what the other tasks are doing
around. The below special case just complicates the API for no good
reason. My problem is that it requires somebody understanding pageattr.c
and fixing bugs on it daily to remember and to be able to use your below
API IMHO (I had no idea myself of this undocumented below subtle detail
until I read the code, infact it was the first thing I've removed after
I noticed the asymmetry it generated). Bug again no problem, I'll try
hard to remember it if we're going to keep it ;).

> > > -           if (pte_same(old,standard))
> > > -               get_page(kpte_page);
