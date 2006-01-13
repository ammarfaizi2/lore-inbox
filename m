Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423093AbWAMXKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423093AbWAMXKg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 18:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423094AbWAMXKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 18:10:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8157 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423093AbWAMXKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 18:10:36 -0500
Date: Fri, 13 Jan 2006 15:12:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: 76306.1226@compuserve.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] kobject: don't oops on null kobject.name
Message-Id: <20060113151213.61e40f2b.akpm@osdl.org>
In-Reply-To: <20060113225537.GA25522@kroah.com>
References: <200601122004_MC3-1-B5C5-4B72@compuserve.com>
	<20060113143013.0ed0f9c0.akpm@osdl.org>
	<20060113225537.GA25522@kroah.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> > 
> > I'd have thought that we'd want the test right at the start of
> > kobject_add() - fail it if ->name is zero.  I don't know if that'd work for
> > all callers, but kobject_add() does play around with the ->name field and
> > will go oops if ->name==NULL and debugging is enabled.
> 
> Something like this instead?

I think so.

>   (warning, untested...)

Ship it!

> I'll try it out in a reboot cycle...
> 
> --- gregkh-2.6.orig/lib/kobject.c	2006-01-13 09:15:18.000000000 -0800
> +++ gregkh-2.6/lib/kobject.c	2006-01-13 14:54:40.000000000 -0800
> @@ -164,6 +164,11 @@ int kobject_add(struct kobject * kobj)
>  		return -ENOENT;
>  	if (!kobj->k_name)
>  		kobj->k_name = kobj->name;
> +	if (!kobj->k_name) {
> +		pr_debug("kobject attempted to be registered with no name!\n");
> +		WARN_ON(1);
> +		return -EINVAL;
> +	}
>  	parent = kobject_get(kobj->parent);
>  
>  	pr_debug("kobject %s: registering. parent: %s, set: %s\n",

It might be worth emitting the warning and then proceeding rather than
failing - minimise potential disruption.  I guess we'll see...
