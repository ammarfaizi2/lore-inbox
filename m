Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262331AbVBBPnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbVBBPnz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 10:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbVBBPno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 10:43:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40590 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262583AbVBBPnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 10:43:11 -0500
Date: Wed, 2 Feb 2005 15:43:07 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Andrew Morton <akpm@osdl.org>, Nathan Scott <nathans@sgi.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: RFC: [PATCH-2.6] Add helper function to lock multiple page cache pages.
Message-ID: <20050202154307.GG10088@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.60.0502021354540.16084@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0502021354540.16084@hermes-1.csi.cam.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 03:12:50PM +0000, Anton Altaparmakov wrote:

I think the below loop would be clearer as a for loop ...

	err = 0;
	for (nr = 0; nr < nr_pages; nr++, start++) {
		if (start == lp_idx) {
			pages[nr] = locked_page;
			if (!nr)
				continue;
			lock_page(locked_page);
			if (!wbc)
				continue;
			if (wbc->for_reclaim) {
				up(&inode->i_sem);
				up_read(&inode->i_sb->s_umount);
			}
			/* Was the page truncated under us? */
			if (page_mapping(locked_page) != mapping) {
				err = -ESTALE;
				goto err_out_locked;
			}
		} else {
			pages[nr] = find_lock_page(mapping, start);
			if (pages[nr])
				continue;
			if (!cached_page) {
				cached_page = alloc_page(gfp_mask);
				if (unlikely(!cached_page))
					goto err_out;
			}
			err = add_to_page_cache_lru(cached_page,
					mapping, start, gfp_mask);
			if (unlikely(err)) {
				if (err == -EEXIST)
					continue;
				goto err_out;
			}
			pages[nr] = cached_page;
			cached_page = NULL;
		}
	}

The above fixes two bugs in the below:
 - if (!unlikely(cached_page)) should be if (unlikely(!cached_page))
 - The -EEXIST case after add_to_page_cache_lru() would result in
   an infinite loop in the original as nr wasn't being incremented.

> +	err = nr = 0;
> +	while (nr < nr_pages) {
> +		if (start == lp_idx) {
> +			pages[nr] = locked_page;
> +			if (nr) {
> +				lock_page(locked_page);
> +				if (wbc) {
> +					if (wbc->for_reclaim) {
> +						up(&inode->i_sem);
> +						up_read(&inode->i_sb->s_umount);
> +					}
> +					/* Was the page truncated under us? */
> +					if (page_mapping(locked_page) !=
> +							mapping) {
> +						err = -ESTALE;
> +						goto err_out_locked;
> +					}
> +				}
> +			}
> +		} else {
> +			pages[nr] = find_lock_page(mapping, start);
> +			if (!pages[nr]) {
> +				if (!cached_page) {
> +					cached_page = alloc_page(gfp_mask);
> +					if (!unlikely(cached_page))
> +						goto err_out;
> +				}
> +				err = add_to_page_cache_lru(cached_page,
> +						mapping, start, gfp_mask);
> +				if (unlikely(err)) {
> +					if (err == -EEXIST)
> +						continue;
> +					goto err_out;
> +				}
> +				pages[nr] = cached_page;
> +				cached_page = NULL;
> +			}
> +		}
> +		nr++;
> +		start++;
> +	}

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
