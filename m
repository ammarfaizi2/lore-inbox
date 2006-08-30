Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWH3TPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWH3TPa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 15:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWH3TPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 15:15:30 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:13239 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751345AbWH3TP3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 15:15:29 -0400
Subject: Re: [ckrm-tech] [PATCH 5/7] BC: user interface (syscalls)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matt Helsley <matthltc@us.ibm.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <44F45568.6000204@sw.ru>
References: <44F45045.70402@sw.ru>  <44F45568.6000204@sw.ru>
Content-Type: text/plain
Organization: IBM
Date: Wed, 30 Aug 2006 12:15:23 -0700
Message-Id: <1156965323.12403.44.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-29 at 18:55 +0400, Kirill Korotaev wrote:
> Add the following system calls for BC management:
>  1. sys_get_bcid     - get current BC id
>  2. sys_set_bcid     - change exec_ and fork_ BCs on current
>  3. sys_set_bclimit  - set limits for resources consumtions 
>  4. sys_get_bcstat   - return br_resource_parm on resource
> 
> Signed-off-by: Pavel Emelianov <xemul@sw.ru>
> Signed-off-by: Kirill Korotaev <dev@sw.ru>
> 
> ---
<snip>

> +
> +asmlinkage long sys_set_bclimit(bcid_t id, unsigned long resource,
> +		unsigned long __user *limits)
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
> +	if (new_limits[0] > BC_MAXVALUE || new_limits[1] > BC_MAXVALUE ||
> +			new_limits[0] > new_limits[1])
> +		goto out;
> +
> +	error = -ENOENT;
> +	bc = beancounter_findcreate(id, BC_LOOKUP);
> +	if (bc == NULL)
> +		goto out;

Moving this to be before copy_from_user() would be efficient.
> +
> +	spin_lock_irqsave(&bc->bc_lock, flags);
> +	bc->bc_parms[resource].barrier = new_limits[0];
> +	bc->bc_parms[resource].limit = new_limits[1];
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


