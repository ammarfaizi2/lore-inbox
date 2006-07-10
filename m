Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161321AbWGJDm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161321AbWGJDm7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 23:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161325AbWGJDm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 23:42:59 -0400
Received: from thunk.org ([69.25.196.29]:11702 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1161321AbWGJDm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 23:42:58 -0400
Date: Sun, 9 Jul 2006 23:42:50 -0400
From: Theodore Tso <tytso@mit.edu>
To: linux-kernel@tux.tmfweb.nl
Cc: David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [OT] 'volatile' in userspace
Message-ID: <20060710034250.GA15138@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>, linux-kernel@tux.tmfweb.nl,
	David Schwartz <davids@webmaster.com>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <44B0FAD5.7050002@argo.co.il> <MDEHLPKNGKAHNMBLJOLKMEPGNAAB.davids@webmaster.com> <20060709195114.GB17128@thunk.org> <20060709204006.GA5242@nospam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060709204006.GA5242@nospam.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 10:40:06PM +0200, Rutger Nijlunsing wrote:
> > So if a userspace progam ever uses volatile, it's almost certainly a
> > bug, one way or another.
> 
> Without 'volatile' and disabling optimizations altogether, how do we
> prevent gcc from optimizing away pointers? As can be seen on
> http://wiki.rubygarden.org/Ruby/page/show/GCAndExtensions (at
> 'Compiler over-optimisations and "volatile"'), volatile is used to
> prevent a specific type of optimization. This is because of the
> garbage collector, which scans the stack and registers to find
> referenced objects. So you don't want local variables containing
> references to objects optimized away.

Well, if you look at the Wiki, it admits that this is a bug:

	(Warning: This section is not strictly correct. volatile
	instructs the C compiler that it should not do certain
	optimisations to code that accesses the variable - the value
	cannot be stored in a register and must be read from memory
	each time it is accessed. It is still perfectly legal for the
	compiler to overwrite the VALUE's stack location with other
	data, if the compiler decides there are no further uses of the
	VALUE. Fortunately, a side effect of volatile in common C
	compilers like GCC and Visual Studio is to prevent the
	dangerous optimisation described above. The Ruby source itself
	uses volatile for this purpose, so it is an "accepted hack"
	for Ruby C extensions.)

"Accepted hack" is basically another way of saying bug.  Some day GCC
will be made smart enough to optimize the use of str on the stack, and
then the Ruby will be screwed.  (Mental note to self: don't use Ruby
in any future project.)

This is really an architectural bug.  RSTRING() should have explicitly
bumped a use pointer, which the C code should have then explicitly
decremented, to protect the underlying pointer from getting GC'ed
unexpectedly.  It would have made RSTRING() more difficult to use, but
that's the price you pay when you try to graft a garbage-collected
paradigm into C code, since the C language really was never designed
for it.

So this would tend to confirm the rule of thumb: use of "volatile" in
a userspace progam tends to indicate a bug.  

						- Ted
