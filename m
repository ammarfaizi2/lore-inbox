Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423040AbWAMWae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423040AbWAMWae (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423041AbWAMWae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:30:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50131 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423040AbWAMWad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:30:33 -0500
Date: Fri, 13 Jan 2006 14:30:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] kobject: don't oops on null kobject.name
Message-Id: <20060113143013.0ed0f9c0.akpm@osdl.org>
In-Reply-To: <200601122004_MC3-1-B5C5-4B72@compuserve.com>
References: <200601122004_MC3-1-B5C5-4B72@compuserve.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
> kobject_get_path() will oops if one of the component names is
> NULL.  Fix that by returning NULL instead of oopsing.
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
> ---
> 
> Helge, this fixes your "2.6.15 OOPS while trying to mount cdrom".
> 
> Probably not the best fix, but It Works For Me (TM).
> 
> --- 2.6.15a.orig/lib/kobject.c
> +++ 2.6.15a/lib/kobject.c
> @@ -72,6 +72,8 @@ static int get_kobj_path_length(struct k
>  	 * Add 1 to strlen for leading '/' of each level.
>  	 */
>  	do {
> +		if (kobject_name(parent) == NULL)
> +			return 0;
>  		length += strlen(kobject_name(parent)) + 1;
>  		parent = parent->parent;
>  	} while (parent);
> @@ -107,6 +109,8 @@ char *kobject_get_path(struct kobject *k
>  	int len;
>  
>  	len = get_kobj_path_length(kobj);
> +	if (len == 0)
> +		return NULL;
>  	path = kmalloc(len, gfp_mask);
>  	if (!path)
>  		return NULL;

I'd have thought that we'd want the test right at the start of
kobject_add() - fail it if ->name is zero.  I don't know if that'd work for
all callers, but kobject_add() does play around with the ->name field and
will go oops if ->name==NULL and debugging is enabled.

Why did you choose kobject_get_path()?
