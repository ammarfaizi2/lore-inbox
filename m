Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbVLIWuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbVLIWuX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 17:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbVLIWuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 17:50:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41380 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932493AbVLIWuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 17:50:22 -0500
Date: Fri, 9 Dec 2005 14:51:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, rml@novell.com
Subject: Re: [patch] add two inotify_add_watch flags
Message-Id: <20051209145144.4b118f09.akpm@osdl.org>
In-Reply-To: <1133927688.20396.8.camel@localhost.localdomain>
References: <1133927688.20396.8.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John McCutchan <ttb@tentacle.dhs.org> wrote:
>
> -static int find_inode(const char __user *dirname, struct nameidata *nd)
> +static int find_inode(const char __user *dirname, struct nameidata *nd,
> +		      int only_dir, int dont_follow_symlink)
>  {
>  	int error;
> +	unsigned flags = 0;
>  
> -	error = __user_walk(dirname, LOOKUP_FOLLOW, nd);
> +	if (!dont_follow_symlink)
> +		flags |= LOOKUP_FOLLOW;
> +	if (only_dir)
> +		flags |= LOOKUP_DIRECTORY;
> +
> +	error = __user_walk(dirname, flags, nd);
>  	if (error)
>  		return error;
>  	/* you can only watch an inode if you have read permissions on it */
> @@ -943,7 +950,7 @@
>  		goto fput_and_out;
>  	}
>  
> -	ret = find_inode(path, &nd);
> +	ret = find_inode(path, &nd, mask & IN_ONLYDIR, mask & IN_DONT_FOLLOW);
>  	if (unlikely(ret))
>  		goto fput_and_out;

I'd have thought that it'd be more general to pass the __user_walk flags
into find_inode(), rather than calculating them in the callee.  Slightly
more efficient too.  
