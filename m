Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266326AbUBQQ6n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 11:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266332AbUBQQ6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 11:58:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:47758 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266326AbUBQQ5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 11:57:45 -0500
Date: Tue, 17 Feb 2004 08:57:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: tridge@samba.org
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <Pine.LNX.4.58.0402170704210.2154@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0402170833110.2154@home.osdl.org>
References: <16433.38038.881005.468116@samba.org> <Pine.LNX.4.58.0402162034280.30742@home.osdl.org>
 <16433.47753.192288.493315@samba.org> <Pine.LNX.4.58.0402170704210.2154@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004, Linus Torvalds wrote:
> 
> It assumes that there is only one way to do lower/upper case, which just 
> isn't true. What about different locales that have different case rules? 
> Your "one bit per dentry" becomes "one bit per locale per dentry". That's 
> just horribly hard to do.

It's also hard to know what to do when there are two filenames that
literally _are_ the same when not comparing cases. Which can obviously
happen under Linux - you'd have a case-sensitive app that creates a both
"makefile" and "Makefile", and now you have a case-insensitive app that
looks it up (or worse, removes it), and what the *heck* is the dcache now
supposed to really do?

This is why I'd hate for the generic Linux dcache to know about case
sensitivity, and I'd be a lot happier having a separate path (which isn't
as speed-critical) that can be used to help implement helper functions for
doing case-insensitive things.

That way the bugs and strange behaviour would be all be limited to the 
case-insensitive special code, and not pollute the "sane" side.

For example, I fundamentally can't easily do an atomic exclusive
case-insensitive "create" or "rename", but we _could_ expose things like
directory generation counts to the special interfaces, and thus allow at
least "local-atomic" operations (but they would _not_ be atomic over a
network, to give you an idea of the kinds of _fundamental_ limitations
there are here).

That's why I'd advocate having a few very special system calls for doing
the operations that samba (and I'll throw wine into the pot too) wants to
do. So you could literally do an atomic create with something like

 - regular atomic create of random case-_sensitive_ name using something 
   tempnam()-like (use a prefix that is invalid on windows or something: 
   make the first character be 0xff or whatever).
 - "read directory local sequence count"
 - readdir to make sure that the new name is still unique even in the
   case-insensitive sense
 - "atomic move conditionally on the local sequence count still being X"

The thing is, we can do hack like the above, and yes, we could do them all 
inside the kernel, and give user space a reasonably nice interface with 
"pseudo-atomic" behaviour (ie it will _not_ be atomic if multiple clients 
do this over NFS, but I doubt you care).

But it wouldn't be "open()" and "rename()". It would be a totally separate
kernel path. It would be in the "case-insensitivity-module". It would be 
_outside_ the regular VFS layer, although it would have some visibility 
into it (ie it could follow dentries on its own, and know about the RCU 
etc locking rules).

We can even allow that case-insensitive module to set some flags in the 
dentries (so that you can create negative dentries that have a flag set 
"this is negative for all cases").

Trust me, this is much less intrusive, and a lot easier to debug too. It 
won't be as fast as the regular path operations, but depending on what the 
common cases are (hopefully "look up name that is exact"), it would likely 
not be horrible either. And it could probably be debugged as a real 
module, without impacting any existing code, which would make it a lot 
easier to create.

See where I'm going? Would this be acceptable to you? Are there any samba 
people who are knowledgeable about the VFS-layer and have the time/energy 
to try something like this?

Al? What do you think?

		Linus
