Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265632AbTFXCYG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 22:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265633AbTFXCYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 22:24:06 -0400
Received: from dp.samba.org ([66.70.73.150]:18048 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265632AbTFXCXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 22:23:55 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: corbet@lwn.net (Jonathan Corbet)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Allow arbitrary number of init funcs in modules 
In-reply-to: Your message of "Mon, 23 Jun 2003 13:11:41 CST."
             <20030623191141.31814.qmail@eklektix.com> 
Date: Tue, 24 Jun 2003 12:29:34 +1000
Message-Id: <20030624023802.5D4DA2C04C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030623191141.31814.qmail@eklektix.com> you write:
> > Feedback is extremely welcome,
> 
> OK...you asked for it.  I found three separate bugs, two of them oopsed the
> system, and the other prevented module unloading.  Did you try it with
> CONFIG_MODULE_UNLOAD? :) You also need to test for null init functions,
> because the module_init/module_exit mode creates them.  Patch appended.

Wow, someone actually tested it!  I do sometimes wonder.

It turns out that I tested an older version with modules, and only
tested this rewrite with in-built code.  Mea culpa.

> Also...some guy once posted (http://lwn.net/Articles/22763/):
> 
> 	I appeciate the series in modernizing modules, but just FYI, I
> 	don't think the old-style init_module/cleanup_module stuff will
> 	break any time soon: there are still a large number of drivers
> 	which use it, and there's not much point making such changes.
> 
> This patch breaks the old init_module/cleanup_module scheme; those
> functions no longer get called.  Was that intentional?

<SIGH> I'd forgotten about that; there are about 100 places where this
technique is still used.  The change would be trivial, but this isn't
2.5.lownum anymore.  Workaround incorporated.

> P.S. Beyond that, I think the patch makes sense :)

Thanks...

> --- 2.5.73-rr/kernel/module.c	Tue Jun 24 02:58:32 2003
> +++ 2.5.73/kernel/module.c	Tue Jun 24 03:00:36 2003
> @@ -617,9 +617,10 @@
>  {
>  	int i, balance = 0;
>  
> -	for (i = 0; i < num_pairs; i++)
> +	for (i = 0; i < num_pairs; i++) {
>  		balance += (pairs->init ? 1 : 0) - (pairs->exit ? 1 : 0);
> -
> +		pairs++;
> +	}
>  	return balance == 0;
>  }
>  

I prefer to use pairs[i].init.  Rest applied untouched.

I'll test and release a new on soon...
Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
