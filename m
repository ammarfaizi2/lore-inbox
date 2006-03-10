Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752237AbWCJWsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237AbWCJWsO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 17:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752242AbWCJWsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 17:48:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53932 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752237AbWCJWsM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 17:48:12 -0500
Date: Fri, 10 Mar 2006 14:50:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] autofs4 - follow_link missing funtionality
Message-Id: <20060310145016.39b028be.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603102003110.3032@eagle.themaw.net>
References: <Pine.LNX.4.64.0603102003110.3032@eagle.themaw.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent <raven@themaw.net> wrote:
>
> @@ -337,10 +340,34 @@ static void *autofs4_follow_link(struct 
>  	if (oz_mode || !lookup_type)
>  		goto done;
>  
> +	/*
> +	 * If the dentry contains directories then it is an
> +	 * autofs multi-mount with no root offset. So don't
> +	 * try to mount it again.
> +	 */
> +	spin_lock(&dcache_lock);
> +	if (!list_empty(&dentry->d_subdirs)) {
> +		spin_unlock(&dcache_lock);
> +		goto done;
> +	}
> +	spin_unlock(&dcache_lock);
> +

Can list_empty(&dentry->d_subdirs) become false right here, after the lock
was dropped?  If so, what happens?


>  	status = try_to_fill_dentry(dentry, 0);
