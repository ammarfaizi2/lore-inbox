Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266503AbUBLQhH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 11:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266506AbUBLQhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 11:37:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:54994 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266503AbUBLQhE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 11:37:04 -0500
Date: Thu, 12 Feb 2004 08:36:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Andi Kleen <ak@suse.de>, Jamie Lokier <jamie@shareable.org>,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [BUG] get_unmapped_area() change -> non booting machine
In-Reply-To: <20040212100446.GA2862@elte.hu>
Message-ID: <Pine.LNX.4.58.0402120833000.5816@home.osdl.org>
References: <1076384799.893.5.camel@gaston> <Pine.LNX.4.58.0402100814410.2128@home.osdl.org>
 <20040210173738.GA9894@mail.shareable.org> <20040213002358.1dd5c93a.ak@suse.de>
 <20040212100446.GA2862@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Feb 2004, Ingo Molnar wrote:
> 
> i've pasted the relevant glibc malloc code below - it does use mmap() as
> a fallback.
> 
> why in this particular case it failed i dont know - i believe some
> _minimal_ brk space is supposed to be available though, so if you break
> mmap() to fill in the brk space then that might break glibc assumptions.

I really think that we should aim for "brk()" just working. It's often
faster than mmap, and it's one of those very basic things (ie we should
_not_ assume we have glibc and malloc(), and others may well want to use
brk() too).

For now, the fix is to just revert the change that triggered this. But in 
the long run I'd like to make it less fragile without having magic special 
cases.

One option is to mark the brk() VMA's as being grow-up (which they are), 
and make get_unmapped_area() realize that it should avoid trying to 
allocate just above grow-up segments or just below grow-down segments. 
That's still something of a special case, but at least it's not "magic" 
any more, now it's more of a "makes sense".

Hmm?

		Linus
