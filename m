Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWHWNmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWHWNmH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 09:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWHWNmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 09:42:07 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:30934 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932205AbWHWNmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 09:42:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Mp5x7q+6PYaUPfYMCoIbQgV+EAEHEny5PerU+oL1o/BlL1owdrUAu8JoX1s2yLhw0qRsBNGxuqtwgy3+qM0eItvCS6NqMBFHhWrd9IVEkLBv7bNh1tJAle4P4HPyEtUtsQP5pMI4a5p3wxvTvzbid/JymTij9zaVEO8N9wDATXo=
Date: Wed, 23 Aug 2006 17:41:47 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: [PATCH 4/6] BC: user interface (syscalls)
Message-ID: <20060823134147.GC10449@martell.zuzino.mipt.ru>
References: <44EC31FB.2050002@sw.ru> <44EC369D.9050303@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EC369D.9050303@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 03:06:05PM +0400, Kirill Korotaev wrote:
> --- ./kernel/bc/sys.c.ve3
> +++ ./kernel/bc/sys.c

> +asmlinkage long sys_set_bclimit(uid_t id, unsigned long resource,
> +		unsigned long *limits)

		unsigned long __user *limits

> +{
> +	int error;
> +	unsigned long flags;
> +	struct beancounter *bc;
> +	unsigned long new_limits[2];
> +
> +	error = -EPERM;
> +	if(!capable(CAP_SYS_RESOURCE))
> +		goto out;
> +
> +	error = -EINVAL;
> +	if (resource >= BC_RESOURCES)
> +		goto out;
> +
> +	error = -EFAULT;
> +	if (copy_from_user(&new_limits, limits, sizeof(new_limits)))
> +		goto out;

> +int sys_get_bcstat(uid_t id, unsigned long resource,
> +		struct bc_resource_parm *uparm)

				__user *uparm
> +{
> +	int error;
> +	unsigned long flags;
> +	struct beancounter *bc;
> +	struct bc_resource_parm parm;
> +
> +	error = -EINVAL;
> +	if (resource > BC_RESOURCES)
> +		goto out;
> +
> +	error = -ENOENT;
> +	bc = beancounter_findcreate(id, 0);
> +	if (bc == NULL)
> +		goto out;
> +
> +	spin_lock_irqsave(&bc->bc_lock, flags);
> +	parm = bc->bc_parms[resource];
> +	spin_unlock_irqrestore(&bc->bc_lock, flags);
> +	put_beancounter(bc);
> +
> +	error = 0;
> +	if (copy_to_user(uparm, &parm, sizeof(parm)))
> +		error = -EFAULT;

