Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030508AbVKWXoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030508AbVKWXoI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030515AbVKWXnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:43:43 -0500
Received: from nevyn.them.org ([66.93.172.17]:62118 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1030516AbVKWXnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:43:06 -0500
Date: Wed, 23 Nov 2005 18:42:56 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
       Andi Kleen <ak@suse.de>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051123234256.GA27337@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@suse.de>,
	Gerd Knorr <kraxel@suse.de>, Dave Jones <davej@redhat.com>,
	Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Pratap Subrahmanyam <pratap@vmware.com>,
	Christopher Li <chrisl@vmware.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Ingo Molnar <mingo@elte.hu>
References: <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051123214835.GA24044@nevyn.them.org> <Pine.LNX.4.64.0511231416490.13959@g5.osdl.org> <20051123222056.GA25078@nevyn.them.org> <Pine.LNX.4.64.0511231502250.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511231502250.13959@g5.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 03:08:59PM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 23 Nov 2005, Daniel Jacobowitz wrote:
> > 
> > Why should we use a silicon based solution for this, when I posit that
> > there are simpler and equally effective userspace solutions?
> 
> Name them.
> 
> In user space, doing things like clever run-time linking things is 
> actually horribly bad. It causes COW faults at startup, and/or makes the 
> compiler have to do indirections unnecessarily.  Both of which actually 
> make caches less effective, because now processes that really effectively 
> do have exactly the same contents have them in different pages.

Those are the wrong ways of doing this in userspace.  There are right
ways.  For instance, tag the binary at link time "single-threaded". 
Use dynamic linking and the existing hwcap mechanism to select
single-threaded libraries instead of the default ones.  Your
single-threaded applications will no longer mmap the same copy of glibc
as your multi-threaded applications; this does make caching mildly less
effective but only if you have a single-threaded app and a
multi-threaded one fighting for CPU time.

> The other alternative (which apparently glibc actually does use) is to 
> dynamically branch over the lock prefixes, which actually works better: 
> it's more work dynamically, but it's much cheaper from a startup 
> standpoint and there's no memory duplication, so while it is the "stupid" 
> approach, it's actually better than the clever one.

Glibc does not do this to the best of my knowledge.  It does select
different code paths in various places based on the presence of
multiple threads, but that's for cancellation, not for locking.

> The third alternative is to know at link-time that the process never does 
> anything threaded, but that needs more developer attention and 
> non-standard setups, and you _will_ get it wrong (some library will create 
> some thread without the developer even realizing).

This is also a trivially solvable problem in userspace; you make the
dynamic linker enforce consistency of the tags.

> I'm sure you can make up alternatives every time you hit one _particular_ 
> library, but that just doesn't scale in the real world.

The number of userspace libraries that use atomic operations is, in
practice, quite small.

> In contrast, the simple silicon support scales wonderfully well. Suddenly 
> libraries can be thread-safe _and_ efficient on UP too. You get to eat 
> your cake and have it too.

By buying new hardware and only caring about people using the magic
architecture.  No thanks.

Maybe I'll implement this some weekend.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
