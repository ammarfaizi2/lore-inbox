Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274852AbSITD5i>; Thu, 19 Sep 2002 23:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274920AbSITD5i>; Thu, 19 Sep 2002 23:57:38 -0400
Received: from dp.samba.org ([66.70.73.150]:39121 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S274852AbSITD5g>;
	Thu, 19 Sep 2002 23:57:36 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-reply-to: Your message of "Thu, 19 Sep 2002 11:38:43 MST."
             <20020919183843.GA16568@kroah.com> 
Date: Fri, 20 Sep 2002 11:22:08 +1000
Message-Id: <20020920040241.4C03F2C0D9@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020919183843.GA16568@kroah.com> you write:
> On Thu, Sep 19, 2002 at 03:54:40PM +0200, Roman Zippel wrote:
> > I already said often enough, a module has only to answer the simple
> > question: Is it safe to unload the module?
> 
> And with a LSM module, how can it answer that?  There's no way, unless
> we count every time someone calls into our module.  And if you do that,
> no one will even want to use your module, given the number of hooks, and
> the paths those hooks are on (the speed hit would be horrible.)

Well, it's up to you.  You *could* implement:

#define call_security(method , ...)					\
	({ int __ret;							\
	   if (try_module_get(security_ops->owner)) {			\
		__ret = security_ops->method(__VA_ARGS__);		\
		module_put(security_ops->owner);			\
	   } else							\
		/* If unloading or loading, default to "allow" */	\
		__ret = 0;						\
	  __ret;							\
	})

Now, if you don't have CONFIG_MODULES this becomes the code as it is
now.  If you don't have CONFIG_MODULE_UNLOAD, this becomes:

	if (security_ops->owner && security_ops->owner->live)
		__ret = security_ops->method(__VA_ARGS__);
	else
		__ret = 0;

With the case of CONFIG_MODULE_UNLOAD, it looks *really* horrible (53
instructions with 6 branches: ewww...).  So I would recommend
register_security insert a shim and take the hit itself:

#ifdef CONFIG_MODULE_UNLOAD
	if (ops->owner) {
		module_ops->real = ops;
		ops = module_ops;
	}
#endif

Then module_ops does the inc/dec wrappers (well, it can optimize if
the ops can't sleep...).

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
