Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759445AbWLGPmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759445AbWLGPmF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 10:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759440AbWLGPmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 10:42:05 -0500
Received: from smtp.osdl.org ([65.172.181.25]:36327 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759384AbWLGPmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 10:42:02 -0500
Date: Thu, 7 Dec 2006 07:36:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Christoph Lameter <clameter@sgi.com>,
       David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <4577DF5C.5070701@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0612070730110.3615@woody.osdl.org>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
 <20061206190025.GC9959@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com>
 <20061206195820.GA15281@flint.arm.linux.org.uk> <4577DF5C.5070701@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Dec 2006, Nick Piggin wrote:
> 
> It might be reasonable to implement this watered down version, but:
> don't some architectures have restrictions on what instructions can
> be issued between the ll and the sc?

Yes. You really probably do not want to expose ll/sc on a C level because 
of this.

On alpha, the architecture manual says (I didn't go back and check, but 
I'm pretty sure) that a ld.l and st.c cannot have a taken branch in 
between then, for example. That basically means that you can't allow the 
compiler to reorder the basic blocks (which it often will with a 
while-loop).

Now, I actually suspect that this was not a microarchitectural flaw, and 
that a branch would _work_ there, and that the architecture manual was 
just being anal, but strictly speaking, it means that these things had 
better always be in assembly, and you can sadly not expose them (on alpha, 
at least) as higher-level primitives as such - you can only expose the 
end result ("cmpxchg" or similar).

		Linus
