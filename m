Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVB1QNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVB1QNZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 11:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVB1QNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 11:13:25 -0500
Received: from fire.osdl.org ([65.172.181.4]:43208 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261669AbVB1QNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 11:13:19 -0500
Subject: Re: [PATCH] Fix panic in 2.6 with bounced bio and dm
From: Mark Haverkamp <markh@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, dm-devel@redhat.com
In-Reply-To: <20050228155127.GI8868@suse.de>
References: <1109351021.5014.10.camel@markh1.pdx.osdl.net>
	 <20050225161947.5fd6d343.akpm@osdl.org>
	 <Pine.LNX.4.58.0502251640050.9237@ppc970.osdl.org>
	 <20050226123934.GA1254@suse.de>
	 <1109604737.30227.3.camel@markh1.pdx.osdl.net>
	 <20050228155127.GI8868@suse.de>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 08:13:08 -0800
Message-Id: <1109607188.30227.16.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-28 at 16:51 +0100, Jens Axboe wrote:
> On Mon, Feb 28 2005, Mark Haverkamp wrote:
> > On Sat, 2005-02-26 at 13:39 +0100, Jens Axboe wrote:
> > > On Fri, Feb 25 2005, Linus Torvalds wrote:
> > > > 
> > > > 
> > > > On Fri, 25 Feb 2005, Andrew Morton wrote:
> > > > > 
> > > > > It seems very weird for dm to be shoving NULL page*'s into the middle of a
> > > > > bio's bvec array, so your fix might end up being a workaround pending a
> > > > > closer look at what's going on in there.
> > > > 
> > > > Yes. I don't see how this patch can be anything but bandaid to hide the 
> > > > real bug. Where do these "non-page" bvec's originate?
> > > 
> > > Yep that's the fishy part, there should not be NULL pages in the middle
> > > (or empty bios, for that matter) submitted for io.
> > > 
> > > Mark, what was the bug that triggered you to write this patch?
> > 
> > It happened when some pages of IO from a dm device were bounced.  It
> > looks to me when bio's are cloned in the dm code to split it for
> > physical devices that only the pointers to pages that apply to that
> > device are copied and th bi_idx is adjusted to point to the start,
> > leaving some NULL pointers at the start of the bio_vec.
> 
> This should fix it.

Wouldn't this potentially create bounce pages that will never be used?

> 
> Signed-off-by: Jens Axboe <axboe@suse.de>
> 
> 
> ===== mm/highmem.c 1.55 vs edited =====
> --- 1.55/mm/highmem.c	2005-01-08 06:44:13 +01:00
> +++ edited/mm/highmem.c	2005-02-28 16:50:59 +01:00
> @@ -425,7 +425,7 @@
>  	 * at least one page was bounced, fill in possible non-highmem
>  	 * pages
>  	 */
> -	bio_for_each_segment(from, *bio_orig, i) {
> +	__bio_for_each_segment(from, *bio_orig, i) {
>  		to = bio_iovec_idx(bio, i);
>  		if (!to->bv_page) {
>  			to->bv_page = from->bv_page;
> 
-- 
Mark Haverkamp <markh@osdl.org>

