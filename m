Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbTLPXPk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 18:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbTLPXPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 18:15:40 -0500
Received: from mail.kroah.org ([65.200.24.183]:36571 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264368AbTLPXPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 18:15:39 -0500
Date: Tue, 16 Dec 2003 15:14:47 -0800
From: Greg KH <greg@kroah.com>
To: Linda Xie <lxiep@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, scheel@us.ibm.com, wortman@us.ibm.com
Subject: Re: PATCPATCH -- add unlimited name lengths support to sysfs
Message-ID: <20031216231447.GA4781@kroah.com>
References: <3FDF902A.4000903@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDF902A.4000903@us.ltcfwd.linux.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 16, 2003 at 05:07:22PM -0600, Linda Xie wrote:
> diff -Nru a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
> --- a/fs/sysfs/symlink.c	Sun Dec 14 21:19:29 2003
> +++ b/fs/sysfs/symlink.c	Sun Dec 14 21:19:29 2003
> @@ -42,7 +42,10 @@
>  	struct kobject * p = kobj;
>  	int length = 1;
>  	do {
> -		length += strlen(p->name) + 1;
> +		if (p->k_name)
> +			length += strlen(p->k_name) + 1;
> +		else
> +			length += strlen(p->name) + 1;

Shouldn't this just be:
		length += strlen(kobject_name(p)) + 1;


> @@ -54,11 +57,20 @@
> 
>  	--length;
>  	for (p = kobj; p; p = p->parent) {
> -		int cur = strlen(p->name);
> -
> +		int cur;
> +		char *name;
> +		
> +		if (p->k_name) {
> +			cur = strlen(p->k_name);
> +			name = p->k_name;
> +		}
> +		else {
> +			cur = strlen(p->name);
> +			name = p->name;
> +		}

Same here, just use kobject_name() to get the proper pointer.

thanks,

greg k-h
