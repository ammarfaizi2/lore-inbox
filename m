Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266477AbUHaEIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266477AbUHaEIN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 00:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266479AbUHaEIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 00:08:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:3981 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266477AbUHaEIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 00:08:09 -0400
Date: Mon, 30 Aug 2004 21:08:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Tom Vier <tmv@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040831033950.GA32404@zero>
Message-ID: <Pine.LNX.4.58.0408302055270.2295@ppc970.osdl.org>
References: <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com>
 <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy>
 <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy>
 <20040826053200.GU31237@waste.org> <20040826075348.GT1284@nysv.org>
 <20040826163234.GA9047@delft.aura.cs.cmu.edu> <Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org>
 <20040831033950.GA32404@zero>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Aug 2004, Tom Vier wrote:

> On Thu, Aug 26, 2004 at 09:48:04AM -0700, Linus Torvalds wrote:
> >  - safely synchronize globally visible data structures
> > That's quite fundamental. 99% of what a kernel does is exactly that. TCP
> > would be in user space too, if it wasn't for _exactly_ this issue. A lot
> 
> What about microkernels? They do tcp in userspace.

No they don't. They do TCP in a separate address space from user space, 
that just also happens to be separate from the "microkernel address 
space".

So a microkernel will have _more_ address spaces, and they won't be "user
space". They'll be "server deamon space" or something. Now, that's also
why they tend to have performance problems - because you need to copy the
data between different address spaces, and switch the CPU context etc
around.

Not user space. They may be "ring 3" from a CPU standpoint, but they 
aren't user space from a _user_ standpoint - it's still very much a 
separate address space, with domain protection.

> So did winsock, iirc.

Now that is a different case. Things like the PalmOS TCP stack (and, I
believe, Winsock) are true "user space" TCP stacks, in that they really
do live as libraries in the same address space as the user app.

It sucks. Exactly because now the data structures are _not_ protected, and
they are _not_ shared. So your library basically ends up being a "single
client" library, with no protection between clients (or no sharing: you
can have "protected" single-stream TCP, but then you won't share the TCP
state that needs to be shared like listen queues etc).

This works in an environment like Palm or Win-3.0, which are really just
single-client _anyway_, without any protection. But notice how Windows
started doing TCP in the kernel, and notice how you can actually use it as
a server these days?

In short: you _need_ to have a separate address space (either kernel, or
"TCP server" or whatever) if you want to have reliable, secure and
generally usable TCP.


> As long as a trusted process keeps data such as free ports, what's the
> problem?

None - because it's not user space any more. 

Well, performance might still suck, of course. And it does. 

		Linus
