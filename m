Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262439AbSJKNnS>; Fri, 11 Oct 2002 09:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262444AbSJKNnS>; Fri, 11 Oct 2002 09:43:18 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:56838 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262439AbSJKNnR>; Fri, 11 Oct 2002 09:43:17 -0400
Date: Fri, 11 Oct 2002 15:48:17 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Alexander Viro <viro@math.psu.edu>,
       Linus Torvalds <torvalds@transmeta.com>,
       Patrick Mochel <mochel@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.LNX.4.44.0210101315240.10911-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0210102140390.338-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Oct 2002, Kai Germaschewski wrote:

> Well, a rmmod could potentially leave the module in "deleted" but not
> "freed" state for a long time. Basically the same thing which happens for
> your solution, where you call the state "cleanup". But I agree, this is
> not desirable at all (nor do I think your cleanup state is).

If exit() can fail, it avoids at least an unkillable rmmod, what makes a
module in the cleanup state IMO acceptable. It might look strange, but
it's still possible to remove the remaining users. The race is small
enough to be not really relevant and even if it does happen, it's not
exploitable, the cleanup will simply continue at a later point.
start()/stop() would give you better control over this. If a module still
has users after stopping it, you can still decide to start it again.

> However, the try_inc_mod_count() is only ever used in the slow
> registration paths (in the example e.g. for mounting, but not for accesses
> to a mounted file system), so performance is not an issue. And getting
> APIs exported to drivers right needs thinking, yes, but the module
> locking isn't even the hard part there, I would claim.

The problem is that we have conflicting methods for object management.
Driver objects have to use the module count, device object cannot use it
and have to use something else. Some objects (like proc entries) even have
to provide both.
Concentrating on a single mechanism will give us more flexibility and
simplicity.

> What you are doing is basically removing the infrastructure to get the use
> count right in a race-free way, and cope with the race by leaving modules
> in 'cleanup' but not 'freed' state until the users you raced with have
> gone away.

That "race" is nothing negativ here. You can also remove a file, while
it's still open and this will delay the release of the resources, until
then the file stays usable. A filesystem would behave the same, you
couldn't mount it anymore, but you can still see it used in /proc/mounts.
I don't think this is necessarly bad, it's just new and unfamiliar.

> BTW, the patch below also needs changes to each filesystem driver to
> return &fs->refcnt as ->use_count(), I think.

That's the other part of my proposal. A new style module would be defined
like this:

DEFINE_MODULE
	.init = ...
	...
DEFINE_MODULE_END

The new module layout allows to stack initialiations:

DEFINE_FS_MODULE
	.name = ...
	.init = ...
	...
DEFINE_FS_MODULE_END

This would already take care of most of the generic management of an fs
module.

bye, Roman

