Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbTIKISj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 04:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbTIKISi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 04:18:38 -0400
Received: from dp.samba.org ([66.70.73.150]:29651 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261156AbTIKISh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 04:18:37 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] add kobject to struct module 
In-reply-to: Your message of "Wed, 10 Sep 2003 23:26:49 MST."
             <20030911062649.GA10454@kroah.com> 
Date: Thu, 11 Sep 2003 18:18:12 +1000
Message-Id: <20030911081836.E8AFD2C04D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030911062649.GA10454@kroah.com> you write:
> On a site note, can't you just use a "struct completion" to use for your
> waiting?  Or do you need to do something special here?

Hmm, *good* question.  Think...

Ah, it's because when someone's waiting for the reference count to hit
zero, we wake them *every* time we decrement.  With the reference
count spread across every cpu, it's the only way:

 static inline void module_put(struct module *module)
 {
 	if (module) {
 		unsigned int cpu = get_cpu();
 		local_dec(&module->ref[cpu].count);
 		/* Maybe they're waiting for us to drop reference? */
 		if (unlikely(!module_is_live(module)))
 			wake_up_process(module->waiter);
 		put_cpu();
 	}
 }

This doesn't really fit with a completion, unfortunately.

> > 1) Adopt a faster, smaller implementation of alloc_percpu (this patch
> >    exists, needs some arch-dependent love for ia64).
> > 2) Use it to generalize the current module reference count scheme to
> >    a "bigref_t" (I have a couple of these)
> > 3) Use that in kobjects.
> 
> Hm, I don't know if kobjects really need to get that heavy.

I'm not sure either: really depends on kobject usage.  I was thinking
struct netdevice.  The size for UP is the same, the size for SMP is
ptr + sizeof(int) + sizeof(atomic_t)*NR_CPUs.

> But yes, that's all 2.7 dreams :)

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
