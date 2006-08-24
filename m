Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965256AbWHXAbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965256AbWHXAbB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 20:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965257AbWHXAbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 20:31:01 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:13232 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965256AbWHXAbA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 20:31:00 -0400
Subject: Re: [PATCH 4/6] BC: user interface (syscalls)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Rohit Seth <rohitseth@google.com>
In-Reply-To: <44EC369D.9050303@sw.ru>
References: <44EC31FB.2050002@sw.ru>  <44EC369D.9050303@sw.ru>
Content-Type: text/plain
Organization: IBM
Date: Wed, 23 Aug 2006 17:30:56 -0700
Message-Id: <1156379456.7154.28.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 15:06 +0400, Kirill Korotaev wrote:
<snip>

> +asmlinkage long sys_set_bclimit(uid_t id, unsigned long resource,
> +		unsigned long *limits)
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
> +
> +	error = -EINVAL;
> +	if (new_limits[0] > BC_MAXVALUE || new_limits[1] > BC_MAXVALUE)
> +		goto out;
> +
> +	error = -ENOENT;
> +	bc = beancounter_findcreate(id, 0);
> +	if (bc == NULL)
> +		goto out;
> +
> +	spin_lock_irqsave(&bc->bc_lock, flags);
> +	bc->bc_parms[resource].barrier = new_limits[0];
> +	bc->bc_parms[resource].limit = new_limits[1];

	No check for barrier <= limit
> +	spin_unlock_irqrestore(&bc->bc_lock, flags);
> +
> +	put_beancounter(bc);
> +	error = 0;
> +out:
> +	return error;
> +}
<snip>
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


