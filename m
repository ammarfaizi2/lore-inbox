Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265238AbTLaUtP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 15:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265242AbTLaUtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 15:49:15 -0500
Received: from rs9.luxsci.com ([66.216.98.59]:53480 "EHLO rs9.luxsci.com")
	by vger.kernel.org with ESMTP id S265238AbTLaUtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 15:49:13 -0500
Message-ID: <3FF33643.5080808@acm.org>
Date: Wed, 31 Dec 2003 12:49:07 -0800
From: Javier Fernandez-Ivern <ivern@acm.org>
Reply-To: ivern@acm.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rudi@lambda-computing.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: File change notification
References: <3FF2FC85.5070906@lambda-computing.de>
In-Reply-To: <3FF2FC85.5070906@lambda-computing.de>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rüdiger Klaehn wrote:

Rudiger, I've been reading your code to try and understand it, and I 
found one think I'm not so sure about:

> +++ develop/fs/dnotify.c	2003-12-31 16:59:36.000000000 +0100
> @@ -153,8 +153,9 @@
>  void dnotify_parent(struct dentry *dentry, unsigned long event)
>  {
>  	struct dentry *parent;
> -
>  	spin_lock(&dentry->d_lock);
> +	/* call inotify for this dentry */
> +	inotify_dentrychange(dentry,event);

...

> +/*
> + * This function should be called when something changes about a dentry, such
> + * as attributes, creating, deleting, renaming etc.
> + */
> +void inotify_dentrychange(struct dentry *dentry,unsigned long event)
> +{
> +	in_info info;
> +	struct dentry *parent;
> +	memset(&info,0,sizeof(in_info));
> +	info.event=event;
> +	spin_lock(&dentry->d_lock);

inotify_dentrychange() is called from dnotify_parent() with the 
dentry->d_lock spinlock held.  However, it also tries to attain the 
spinlock.  Wouldn't this deadlock?  I thought spinlocks were not recursive.

Please let me know if I'm not understanding this...I'm a locking newbie.

-- 
Javier Fernandez-Ivern
