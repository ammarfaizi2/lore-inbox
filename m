Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262647AbVDYQ0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbVDYQ0n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 12:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbVDYQZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 12:25:41 -0400
Received: from mail.dif.dk ([193.138.115.101]:55428 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262659AbVDYQXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 12:23:12 -0400
Date: Mon, 25 Apr 2005 18:26:25 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 6/7] dlm: debug fs
In-Reply-To: <20050425151317.GG6826@redhat.com>
Message-ID: <Pine.LNX.4.62.0504251816080.2941@dragon.hyggekrogen.localhost>
References: <20050425151317.GG6826@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2005, David Teigland wrote:

> 
> A CONFIG setting optionally adds this file which creates a debugfs file
> for each lockspace: /debug/dlm/<lockspace_name>.  Reading the debugfs file
> displays all resources/locks currently managed in the given lockspace.
> 
> Signed-Off-By: Dave Teigland <teigland@redhat.com>
> Signed-Off-By: Patrick Caulfield <pcaulfie@redhat.com>
> 
> ---
> 
[...]
> +static int rsb_iter_next(struct rsb_iter *ri)
> +{
> +	struct dlm_ls *ls = ri->ls;
> +	int i;
> +
> + top:
> +	if (!ri->next) {
> +		/* Find the next non-empty hash bucket */
> +		for (i = ri->entry; i < ls->ls_rsbtbl_size; i++) {
> +			read_lock(&ls->ls_rsbtbl[i].lock);
> +			if (!list_empty(&ls->ls_rsbtbl[i].list)) {
> +				ri->next = ls->ls_rsbtbl[i].list.next;
> +				read_unlock(&ls->ls_rsbtbl[i].lock);
> +				break;
> +			}
> +			read_unlock(&ls->ls_rsbtbl[i].lock);
> +                }
> +		ri->entry = i;
> +
> +		if (ri->entry >= ls->ls_rsbtbl_size)
> +			return 1;
> +	} else {
> +		i = ri->entry;
> +		read_lock(&ls->ls_rsbtbl[i].lock);
> +		ri->next = ri->next->next;
> +		if (ri->next->next == ls->ls_rsbtbl[i].list.next) {
> +			/* End of list - move to next bucket */
> +			ri->next = NULL;
> +			ri->entry++;
> +			read_unlock(&ls->ls_rsbtbl[i].lock);
> +			goto top;
> +                }
> +		read_unlock(&ls->ls_rsbtbl[i].lock);
> +	}
> +	ri->rsb = list_entry(ri->next, struct dlm_rsb, res_hashchain);
> +
> +	return 0;
> +}
Personally I think there must be a way to construct this function to be a 
bit more readable, I'm playing with that, perhaps I'll come up with 
something. But, in any case you might as well move the label 'top' inside 
the if just before the for loop, since the only place you ever  goto top  
you've just set ri->next to NULL, so you know you are going to end up 
inside the if in any case, no need to actually do the test every time.


-- 
Jesper Juhl


