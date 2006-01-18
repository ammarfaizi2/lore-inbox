Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbWARAuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbWARAuZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbWARAuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:50:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41117 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964957AbWARAuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:50:24 -0500
Date: Tue, 17 Jan 2006 16:52:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/9] uml: fix spinlock recursion and
 sleep-inside-spinlock in error path
Message-Id: <20060117165217.0f9d9add.akpm@osdl.org>
In-Reply-To: <20060118001931.14622.17211.stgit@zion.home.lan>
References: <20060117235659.14622.18544.stgit@zion.home.lan>
	<20060118001931.14622.17211.stgit@zion.home.lan>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
>
> 
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> In this error path, when the interface has had a problem, we call dev_close(),
> which is disallowed for two reasons:
> 
> *) takes again the UML internal spinlock, inside the ->stop method of this
>    device
> *) can be called in process context only, while we're in interrupt context.
> 
> I've also thought that calling dev_close() may be a wrong policy to follow, but
> it's not up to me to decide that.
> 
> However, we may end up with multiple dev_close() queued on the same device.
> But the initial test for (dev->flags & IFF_UP) makes this harmless, though -
> and dev_close() is supposed to care about races with itself. So there's no harm
> in delaying the shutdown, IMHO.
> 
> Something to mark the interface as "going to shutdown" would be appreciated, but
> dev_deactivate has the same problems as dev_close(), so we can't use it either.
> 
> ...
> +		/* dev_close can't be called in interrupt context, and takes
> +		 * again lp->lock.
> +		 * And dev_close() can be safely called multiple times on the
> +		 * same device, since it tests for (dev->flags & IFF_UP). So
> +		 * there's no harm in delaying the device shutdown. */
> +		schedule_work(&close_work);
>  		goto out;
>  	}

This callback can be pending for an arbitrary amount of time.  I'd have
expected to see a flush_sceduled_work() somewhere in the driver to force
all such pending work to complete before we destroy things which that
callback wil be using.
