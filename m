Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314751AbSD2Ckc>; Sun, 28 Apr 2002 22:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314752AbSD2Ckb>; Sun, 28 Apr 2002 22:40:31 -0400
Received: from [202.135.142.196] ([202.135.142.196]:16141 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S314751AbSD2Cka>; Sun, 28 Apr 2002 22:40:30 -0400
Date: Mon, 29 Apr 2002 12:42:00 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: torvalds@transmeta.com, kaos@ocs.com.au, linux-kernel@vger.kernel.org,
        rusty@rustcorp.com.au
Subject: Re: [RFC] race in request_module()
Message-Id: <20020429124200.4ee11312.rusty@rustcorp.com.au>
In-Reply-To: <Pine.GSO.4.21.0204222027360.5686-100000@weyl.math.psu.edu>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2002 20:49:40 -0400 (EDT)
Alexander Viro <viro@math.psu.edu> wrote:

> 	Looks like request_module() has quite a few problems:

Um, yes.

> * there is no way to distinguish between failing modprobe and successful
>   one followed by rmmod -a (e.g. called by cron).  For one thing, we
>   don't pass exit value of modprobe to caller of request_module().

But that's kind of the point.  You can *never* do:

	ptr = lookup("foo");
	if (!ptr) {
		if (request_module("mymod-foo") == 0)
			ptr = lookup("foo");
		else
			goto out;
	}

	... Assume ptr is non-null...

> * even if we would pass it, obvious attempt to cope with rmmod -a races
>   fails.  I.e. something like
> 
> 	while (object doesn't exist) {
> 		if (request_module(module_name) < 0)
> 			break;
> 	}
> 
>   would screw up for something like
> 
> mount -t floppy <whatever>
> 
>   since we would happily load floppy.o and look for fs type called "floppy".
>   And keep doing that forever, since floppy.o doesn't define any fs.

Yes, we don't try to cache failures, and you must *never* loop on request_module.

> * we could try to protect against rmmod -a by changing semantics of module
>   syscalls and modprobe(8).  Namely, let modprobe called by request_module()
>   pin the module(s) down and make request_module() (actually its caller)
>   decrement refcounts.  That would solve the problem, but we get another one:
>   how to find all modules pulled in by modprobe(8) and its children.
>   Notice that argument of request_module() doesn't help at all - it can have
>   nothing to name of module we load (block-major-2 -> floppy) and we could have
>   other modules grabbed by the same modprobe.

Yes, and modules pulled in indirectly (see "pre-install")...

> * we might try to pull the following trick: in sys_create_module() follow
>   ->parent until we step on request_module()-spawned task.  Then put the new
>   module on a list for that instance of request_module().  That would solve
>   the problem, but I'm not too happy about such solution - IMO it's ugly.
>   However, I don't see anything else...

I had some code to do this and threw it out.  It assumes alot about the nature
of modprobe (ie. won't get reparented to init).  Having a special inherited
"I am modprobe" flag in the task struct which is inherited across exec & fork,
and is checked in request_module is the "correct" way.  Barf.

> Comments?

<SIGH>.

Wanna get ambitious?  Replace all occurances of:
	ptr = find(xxx);
	if (!ptr && request_module(SOMENAME) == 0)
		ptr = find(xxx);

With a more generic global registration mechanism:
	/* Find in list, try loading module (sleeps) */
	void *find_feature(const char *, int);

	/* Static registration of feature */
	#define FEATURE(name, desc, feature) ...
	/* Dynamic registration of feature */
	int feature(const char *name, int desc, void *feature);
	void unfeature(const char *name, int desc);

Both module loading and the boot code gather and register all the
FEATUREs mentioned in the macro.  modprobe then loads by FEATURE,
not module name.

If we then go down the path that FreeBSD is, then we can have a
context during soft interrupts, allowing us to sleep almost anywhere.
This means we can, for example on receipt of a network packet:

	struct packet_type *ptype;
	ptype = find_feature("net-packet-type", skb->protocol);
	...

ie. As IPX packets come in, we load the ipx module.

This should give us the microkernel we're all waiting for!
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
