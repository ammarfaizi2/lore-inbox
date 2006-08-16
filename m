Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWHPSVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWHPSVn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 14:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWHPSVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 14:21:42 -0400
Received: from smtp-out.google.com ([216.239.45.12]:44 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751238AbWHPSVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 14:21:41 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=bsHSw641QDUcYBnIRBNG3aR3yF8BryxImmxMvnT6JBz/sNFq6VmOAwuH0cArvIrT3
	cFwkEe16EPQ2p1w2hTk+g==
Subject: Re: [RFC][PATCH 4/7] UBC: syscalls (user interface)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
In-Reply-To: <44E33C3F.3010509@sw.ru>
References: <44E33893.6020700@sw.ru>  <44E33C3F.3010509@sw.ru>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 16 Aug 2006 11:17:57 -0700
Message-Id: <1155752277.22595.70.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 19:39 +0400, Kirill Korotaev wrote:
> Add the following system calls for UB management:
>   1. sys_getluid    - get current UB id
>   2. sys_setluid    - changes exec_ and fork_ UBs on current
>   3. sys_setublimit - set limits for resources consumtions
> 

Why not have another system call for getting the current limits?

But as I said in previous mail, configfs seems like a better choice for
user interface.  That way user has to go to one place to read/write
limits, see the current usage and other stats.

> Signed-Off-By: Pavel Emelianov <xemul@sw.ru>
> Signed-Off-By: Kirill Korotaev <dev@sw.ru>

	...<snip>...
> +
> +/*
> + *	The setbeanlimit syscall
> + */
> +asmlinkage long sys_setublimit(uid_t uid, unsigned long resource,
> +		unsigned long *limits)
> +{

> +	ub = beancounter_findcreate(uid, NULL, 0);
> +	if (ub == NULL)
> +		goto out;
> +
> +	spin_lock_irqsave(&ub->ub_lock, flags);
> +	ub->ub_parms[resource].barrier = new_limits[0];
> +	ub->ub_parms[resource].limit = new_limits[1];
> +	spin_unlock_irqrestore(&ub->ub_lock, flags);
> +

I think there should be a check here for seeing if the new limits are
lower than the current usage of a resource.  If so then take appropriate
action.

-rohit


