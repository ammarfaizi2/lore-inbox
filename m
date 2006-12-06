Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937759AbWLFWi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937759AbWLFWi7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 17:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937758AbWLFWi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 17:38:58 -0500
Received: from smtp.osdl.org ([65.172.181.25]:49847 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937752AbWLFWi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 17:38:57 -0500
Date: Wed, 6 Dec 2006 14:38:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
cc: Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       akpm@osdl.org, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <Pine.LNX.4.64.0612061345160.28672@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0612061430420.3542@woody.osdl.org>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
 <20061206190025.GC9959@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com>
 <20061206195820.GA15281@flint.arm.linux.org.uk> <20061206213626.GE3013@parisc-linux.org>
 <Pine.LNX.4.64.0612061345160.28672@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2006, Christoph Lameter wrote:
> 
> This means we tolerate the assignment race for SMP that was pointed out 
> earlier?

The assignment "race" doesn't really exist in real code, I suspect.

There's two cases of assignment:

 - pure initialization. This one isn't racy, since it's literally the 
   initial setting of some data structure, and if it's visible in 
   uninitialized state on other CPU's before being initialized, you have 
   bigger problems than some silly assignment race ;)

   So the race doesn't exist for this class of assignment at all, and 
   that's the _common_ case of a pure assignment (ie the "we start out 
   with this field having value X")

 - mixing assignment on one CPU (and not using "atomic_set()") and using 
   "cmpxchg()". 

   This would be a problem on architectures that use an external spinlock 
   or something, but I don't really see how it could be a valid code 
   sequence ANYWAY.

   Any code that does this had better have some _higherlevel_ 
   serialization around that data structure, since while it's not a _bug_ 
   on architectures that do "cmpxchg()" in hardware (as far as the cmpxchg 
   itself is concerned), the fact is, in the absense of any other locking, 
   what the hell is such code supposed to _mean_?

In other words - the second case would be a bug in that it bypasses the 
serialization of the spinlock, but why would you ever do that anyway? What 
could _possibly_ be a valid use of such a "set value blindly" kind of 
sequence? Since another CPU is clearly doing something to the value (ie 
the cmpxchg), the "set it to value X" is just not a well-defined 
operation in the first place, since you don't know what the end result is 
(will it be "X", or will the "cmpxchg" on the other CPU have set it to 
something else?).

So I don't think the race really exists for any sane code anyway. Even if 
people don't use "atomic_set()".

But hey, maybe I'm just ignoring some really odd usage case.

		Linus
