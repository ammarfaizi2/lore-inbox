Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262059AbTCJGr0>; Mon, 10 Mar 2003 01:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262100AbTCJGrZ>; Mon, 10 Mar 2003 01:47:25 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:63761 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262059AbTCJGrY>;
	Mon, 10 Mar 2003 01:47:24 -0500
Date: Sun, 9 Mar 2003 22:47:38 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@mail.wirex.com
Subject: Re: [PATCH] kobject support for LSM core
Message-ID: <20030310064738.GD6512@kroah.com>
References: <20030310001310.GU3917@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030310001310.GU3917@pasky.ji.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 10, 2003 at 01:13:10AM +0100, Petr Baudis wrote:
> 
>   the following patch (against 2.5.64) introduces kobject infrastructure
> scaffolding to the LSM framework. It does nothing but allocating security root
> subsystem for the LSMs, so that they are tied to one specific point in the
> kobject hierarchy. They are suggested to create own subsystems under the
> security subsystem, however such things are completely up to the individual
> LSMs and not regulated by core in any way (it's not that I would so much like
> such an approach, but I was advised so by GregKH and it makes sense in its own
> way as well).

Hm, I thought I advised not doing this at all :)

Anyway, if we were to add this, you might want to:

> +
> +/* kobject stuff */
> +
> +/* We define only the base subsystem here and leave everything to a LSM. It is
> + * heavily recommended that the LSM should create own subsystem under this one,
> + * so that it can be easily made stackable and it doesn't confuse userland by
> + * exporting its stuff directly to /sys/security/. */
> +decl_subsys(security,NULL);

Add a prototype of this variable to security.h so that everyone can
actually see it who wants to use it.

> +/**
> + * security_kobj_init - initializes the security kobject subsystem
> + *
> + * This is called after security_scaffolding_startup as a regular initcall,
> + * since we need sysfs mounted already.
> + */
> +static int __init security_kobj_init (void)
> +{
> +	subsystem_register (&security_subsys);
> +	return 0;
> +}
> +
> +subsys_initcall(security_kobj_init);

Why not initialize this when the security core is initialized?  Why
have a new initcall?

And when do you unregister this subsystem?

> +EXPORT_SYMBOL(security_subsys);

No EXPORT_SYMBOL_GPL() for it?  :)

thanks,

greg k-h

