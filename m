Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVEXAQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVEXAQm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 20:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVEXAQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 20:16:35 -0400
Received: from fire.osdl.org ([65.172.181.4]:31377 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261253AbVEXAN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 20:13:26 -0400
Date: Mon, 23 May 2005 17:14:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [bugfix] try_to_unmap_cluster() passes out-of-bounds pte to
 pte_unmap()
Message-Id: <20050523171406.483cdf69.akpm@osdl.org>
In-Reply-To: <20050522212734.GF2057@holomorphy.com>
References: <20050516021302.13bd285a.akpm@osdl.org>
	<20050522212734.GF2057@holomorphy.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> --- ./mm/rmap.c.orig	2005-05-20 01:29:14.066467151 -0700
> +++ ./mm/rmap.c	2005-05-20 01:30:06.620649901 -0700
> @@ -694,7 +694,7 @@
>  		(*mapcount)--;
>  	}
>  
> -	pte_unmap(pte);
> +	pte_unmap(pte-1);
>  out_unlock:
>  	spin_unlock(&mm->page_table_lock);
>  }

I must say that I continue to find this approach a bit queazifying.

After some reading of the code I'd agree that yes, it's not possible for us
to get here with `pte' pointing at the first slot of the pte page, but it's
not 100% obvious and it's possible that someone will come along later and
will change things in try_to_unmap_cluster() which cause this unmap to
suddenly do the wrong thing in rare circumstances.

IOW: I'd sleep better at night if we took a temporary and actually unmapped
the thing which we we got back from pte_offset_map()..  Am I being silly?

