Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbTEGDjP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 23:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbTEGDjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 23:39:15 -0400
Received: from dp.samba.org ([66.70.73.150]:40069 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262801AbTEGDjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 23:39:14 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, acme@conectiva.com.br
Subject: Re: [2.5.69-mm1] kernel BUG at include/linux/module.h:284! 
In-reply-to: Your message of "06 May 2003 06:22:12 MST."
             <1052227331.983.46.camel@rth.ninka.net> 
Date: Wed, 07 May 2003 13:48:15 +1000
Message-Id: <20030507035148.31D332C117@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1052227331.983.46.camel@rth.ninka.net> you write:
> Arnaldo, ipv6 creates a socket of it's own type during
> module init, try_module_get() on the current module fails
> during module load... do you see the problem?
> 
> Rusty, you said you were working on a solution for modules
> that call themselves during their own init?

In fact, it's backwards.  Currently we *do* allow try_module_get()
during init:

/* FIXME: It'd be nice to isolate modules during init, too, so they
   aren't used before they (may) fail.  But presently too much code
   (IDE & SCSI) require entry into the module during init. */
static inline int module_is_live(struct module *mod)
{
	return mod->state != MODULE_STATE_GOING;
}

This probably won't change before 2.6: sure, there are races, but
we've lived with them so far.  I don't like it, but that's the
Realpolitik of the Linux Kernel.

There are a few ways of fixing it.  Viro suggested every interface be
explicitly split into "reserve and commit".  To put it mildly, I shy
away from changing every module for an obscure race which so few
people understand anyway.  There's the make_module_live() function,
where a module says "I'm finished init already".  Of course, you can't
fail initialization after this.  Or, the current module notifier could
be extended, to have an event after module init.

None of these would be one-liners for IPv6, AFAICT.

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
