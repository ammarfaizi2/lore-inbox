Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbTCGRCL>; Fri, 7 Mar 2003 12:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261757AbTCGRCL>; Fri, 7 Mar 2003 12:02:11 -0500
Received: from air-2.osdl.org ([65.172.181.6]:24194 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261495AbTCGRCI>;
	Fri, 7 Mar 2003 12:02:08 -0500
Date: Fri, 7 Mar 2003 09:12:31 -0800
From: Bob Miller <rem@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Roman Zippel <zippel@linux-m68k.org>, adam@yggdrasil.com,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com, akpm@zip.com.au
Subject: Re: Patch/resubmit linux-2.5.63-bk4 try_module_get simplification
Message-ID: <20030307171231.GA16655@doc.pdx.osdl.net>
References: <20030228203039.A12990@baldur.yggdrasil.com> <Pine.LNX.4.44.0303021457010.32518-100000@serv> <20030307070646.C85322C07D@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030307070646.C85322C07D@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below was included by Linus around 2/14/03.

On Fri, Mar 07, 2003 at 05:34:18PM +1100, Rusty Russell wrote:
> Three other requests, if I may.
> 
> It'd be nice to have a comment for the two smp_mb() eg. /* Must increment
> before checking state */ and vice-versa above the one in module.c.  Secondly
> probably nicer to just rename the modlist_lock to module_lock and use that,
> and thirdly merge with the racefix patch below if Linus hasn't already
> taken it.
> 
> 
> Name: Fix two module races
> Author: Bob Miller, Rusty Russell
> Status: Trivial
> 
> D: Bob Miller points out that the try_module_get in use_module() can,
> D: of course, fail.  Secondly, there is a race between setting the module
> D: live, and a simultaneous removal of it.
> 
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.62-bk6/kernel/module.c working-2.5.62-bk6-modraces/kernel/module.c
> --- linux-2.5.62-bk6/kernel/module.c	2003-02-18 11:18:57.000000000 +1100
> +++ working-2.5.62-bk6-modraces/kernel/module.c	2003-02-24 13:42:44.000000000 +1100
> @@ -173,16 +173,19 @@ static int use_module(struct module *a, 
>  	struct module_use *use;
>  	if (b == NULL || already_uses(a, b)) return 1;
>  
> +	if (!strong_try_module_get(b))
> +		return 0;
> +
>  	DEBUGP("Allocating new usage for %s.\n", a->name);
>  	use = kmalloc(sizeof(*use), GFP_ATOMIC);
>  	if (!use) {
>  		printk("%s: out of memory loading\n", a->name);
> +		module_put(b);
>  		return 0;
>  	}
>  
>  	use->module_which_uses = a;
>  	list_add(&use->list, &b->modules_which_use_me);
> -	try_module_get(b); /* Can't fail */
>  	return 1;
>  }
>  
> @@ -1456,10 +1459,12 @@ sys_init_module(void *umod,
>  	}
>  
>  	/* Now it's a first class citizen! */
> +	down(&module_mutex);
>  	mod->state = MODULE_STATE_LIVE;
>  	module_free(mod, mod->module_init);
>  	mod->module_init = NULL;
>  	mod->init_size = 0;
> +	up(&module_mutex);
>  
>  	return 0;
>  }
> 

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
