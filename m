Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261859AbSIYAls>; Tue, 24 Sep 2002 20:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261861AbSIYAls>; Tue, 24 Sep 2002 20:41:48 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:14599 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261859AbSIYAln>; Tue, 24 Sep 2002 20:41:43 -0400
Date: Wed, 25 Sep 2002 02:46:29 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: kaos@ocs.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-Reply-To: <20020924150424.504A42C07A@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0209241739460.338-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 25 Sep 2002, Rusty Russell wrote:

> > Look at the unregister example in the last mail. It will suceed silently.
>
> Does that really seem consistent?  Unregister functions don't fail if
> you're not registered, but fail if it can't unregister you because
> you're busy?

Unregister functions fail, if the resource is busy, if nothing is busy,
they'll suceed. It's like kfree() which silently accepts NULL pointers.

> > This shouldn't be the standard method, so any module author using such
> > hooks should be aware of it's problems, so I don't see a problem here.
>
> I still worry that they don't *know* when they need to do something
> special.  This is true of almost any implementation.

As I said already earlier, anyone _exporting_ interfaces has to be aware
of the problems and document its usage.

> Roman, I'm determined to put the in-kernel module linker in 2.5, and
> these races will be solved in some way.  It's too much obviously the
> right thing, especially now I've implemented modversions, parameters
> and licensing stuff on top of it.  Now the implementations can change
> between kernel versions without any pain, even if you don't agree that
> it's markedly simpler and makes initramdisk feasible.

Will the usage of an initramdisk be a requirement for 2.6? Otherwise I
don't see a reason for such hurry. I don't know of Linus plans, but I
don't think it's ready yet. So far we have only lots of little pieces,
that still needs to be put together to a consistent system and not rushing
it sounds like a good idea to me.

> In summary, your approach requires (I hope I am being fair?):
>
> 1) Registration interfaces (where callbacks can sleep) must keep track
>    of reference counts of current users.

Rusty, read my lips: They only have to know whether they are busy. It's a
_Bool not an atomic_t, e.g. this would work too:

	if (!list_empty(users))
		return -EBUSY;

> 2) They must also implement two-stage delete (ie. proc_net_unlink()).

That's a "can" requirement.

> See why I like the "extend try_inc_mod_count()" solution?  It's not
> perfect, but it's already there and it's simple.

I explained already earlier why try_inc_mod_count() is a bad interface and
renaming it doesn't change much. The consequences of its usage are not
simple and its existence is not a good argument (at least not a technical
one).
My approach offers a gradual switch to a much more flexible interface,
which doesn't force drivers to use only module approved synchronization
methods. I keep most of the complexity (the module loading/relocation) in
user space, that means my patch has far less impact on the kernel. My
patch doesn't require new tools, but allows for an userspace insmod of
similiar complexity as your kernel loader. Making module removal a config
option is a really bad idea, either it works or it doesn't.
Can we please judge the approaches on a technical level and forget for a
moment the impending code freeze?

bye, Roman

