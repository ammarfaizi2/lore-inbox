Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVEKQIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVEKQIY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 12:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVEKQIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 12:08:24 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:15533 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261241AbVEKQIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 12:08:20 -0400
Date: Wed, 11 May 2005 17:08:56 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Kirill Korotaev <dev@sw.ru>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm acct accounting fix
In-Reply-To: <428223E0.2070200@sw.ru>
Message-ID: <Pine.LNX.4.61.0505111701110.7331@goblin.wat.veritas.com>
References: <428223E0.2070200@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 11 May 2005 16:08:18.0395 (UTC) 
    FILETIME=[A52D8AB0:01C55643]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2005, Kirill Korotaev wrote:

> Sorry, forgot to write that all these patches are against 2.6.12-rc4...
> 
> This patch fixes mm->total_vm and mm->locked_vm acctounting in case
> when move_page_tables() fails inside move_vma().
> 
> Signed-Off-By: Kirill Korotaev <dev@sw.ru>
> 
> --- ./mm/mremap.c.mmacct	2005-05-10 16:10:40.000000000 +0400
> +++ ./mm/mremap.c	2005-05-10 18:12:13.000000000 +0400
> @@ -213,6 +213,7 @@ static unsigned long move_vma(struct vm_
>  		old_len = new_len;
>  		old_addr = new_addr;
>  		new_addr = -ENOMEM;
> +		new_len = 0;
>  	}
>  
>  	/* Conceal VM_ACCOUNT so old reservation is not undone */

Are you sure?

The way it's supposed to work is that the do_munmap(,,old_len) which
follows, which normally unmaps the area moved from, when unsuccessful
unmaps the area moved to: which will "mistakenly" decrement total_vm etc.
by old_len, which needs to be bumped back up by that amount before leaving.

Hugh
