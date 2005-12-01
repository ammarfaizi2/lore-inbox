Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbVLAVoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbVLAVoT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 16:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbVLAVoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 16:44:19 -0500
Received: from fep30-0.kolumbus.fi ([193.229.0.32]:57436 "EHLO
	fep30-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S932488AbVLAVoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 16:44:18 -0500
Date: Thu, 1 Dec 2005 23:44:27 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Hugh Dickins <hugh@veritas.com>
cc: Ryan Richter <ryan@tau.solarneutrino.net>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
In-Reply-To: <Pine.LNX.4.61.0512012008420.28450@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.63.0512012337080.5777@kai.makisara.local>
References: <20051129092432.0f5742f0.akpm@osdl.org>
 <Pine.LNX.4.63.0512012040390.5777@kai.makisara.local>
 <Pine.LNX.4.64.0512011136000.3099@g5.osdl.org> <20051201195657.GB7236@tau.solarneutrino.net>
 <Pine.LNX.4.61.0512012008420.28450@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2005, Hugh Dickins wrote:

...
> Nick and I had already been looking at drivers/scsi/{sg.c,st.c},
> brought there by __put_page in sg.c's peculiar sg_rb_correct4mmap,
> which we'd like to remove.  But that's irrelevant to your pain, except...
> 
> One extract from the patches I'd like to send Doug and Kai for 2.6.15
> or 2.6.16 is this below: since the incomplete get_user_pages path omits
> to reset res, but has already released all the pages, it will result in
> premature freeing of user pages, and behaviour just like you've seen.
> 
> Though I'd have thought incomplete get_user_pages was an exceptional
> case, and a bit surprised you'd encounter it.  Perhaps there's some
> other premature freeing in the driver, and this instance has nothing
> whatever to do with it.
> 
> If the problem were easily reproducible, it'd be great if you could
> try this patch; but I think you've said it's not :-(
> 
> Hugh
> 
> --- 2.6.14/drivers/scsi/st.c	2005-10-28 01:02:08.000000000 +0100
> +++ linux/drivers/scsi/st.c	2005-12-01 20:06:02.000000000 +0000
> @@ -4511,6 +4511,7 @@ static int sgl_map_user_pages(struct sca
>  	if (res > 0) {
>  		for (j=0; j < res; j++)
>  			page_cache_release(pages[j]);
> +		res = 0;
>  	}
>  	kfree(pages);
>  	return res;
> 
Whether this fix solves the current problem or not, it clearly fixes a 
bug. If someone wants to include this into a patch series, you can add
Signed-off-by: Kai Makisara <kai.makisara@kolumbus.fi>
If not, I will include this when I send patches next time.

Thanks for noticing this problem.

Kai

