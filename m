Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbVBBQAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbVBBQAP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 11:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbVBBQAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 11:00:14 -0500
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:38337 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262403AbVBBP4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 10:56:42 -0500
Subject: Re: RFC: [PATCH-2.6] Add helper function to lock multiple page
	cache pages.
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andrew Morton <akpm@osdl.org>, Nathan Scott <nathans@sgi.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       lkml <linux-kernel@vger.kernel.org>,
       fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20050202154307.GG10088@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.60.0502021354540.16084@hermes-1.csi.cam.ac.uk>
	 <20050202154307.GG10088@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Date: Wed, 02 Feb 2005 15:56:38 +0000
Message-Id: <1107359798.18444.42.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Wed, 2005-02-02 at 15:43 +0000, Matthew Wilcox wrote:
> On Wed, Feb 02, 2005 at 03:12:50PM +0000, Anton Altaparmakov wrote:
> 
> I think the below loop would be clearer as a for loop ...
> 
> 	err = 0;
> 	for (nr = 0; nr < nr_pages; nr++, start++) {
> 		if (start == lp_idx) {
> 			pages[nr] = locked_page;
> 			if (!nr)
> 				continue;
> 			lock_page(locked_page);
> 			if (!wbc)
> 				continue;
> 			if (wbc->for_reclaim) {
> 				up(&inode->i_sem);
> 				up_read(&inode->i_sb->s_umount);
> 			}
> 			/* Was the page truncated under us? */
> 			if (page_mapping(locked_page) != mapping) {
> 				err = -ESTALE;
> 				goto err_out_locked;
> 			}
> 		} else {
> 			pages[nr] = find_lock_page(mapping, start);
> 			if (pages[nr])
> 				continue;
> 			if (!cached_page) {
> 				cached_page = alloc_page(gfp_mask);
> 				if (unlikely(!cached_page))
> 					goto err_out;
> 			}
> 			err = add_to_page_cache_lru(cached_page,
> 					mapping, start, gfp_mask);
> 			if (unlikely(err)) {
> 				if (err == -EEXIST)
> 					continue;
> 				goto err_out;
> 			}
> 			pages[nr] = cached_page;
> 			cached_page = NULL;
> 		}
> 	}
> 
> The above fixes two bugs in the below:
>  - if (!unlikely(cached_page)) should be if (unlikely(!cached_page))

Ah, oops.  Thanks!  Well spotted!  I did say it was only compile
tested...  (-;

>  - The -EEXIST case after add_to_page_cache_lru() would result in
>    an infinite loop in the original as nr wasn't being incremented.

That was exactly what was meant to happen.  It is not a bug.  It is a
feature.  This is why it is a while loop instead of a for loop.  I need
to have @nr and @start incremented only if the code reaches the end of
the loop.

The -EEXIST case needs to repeat for the same @nr and @start.  It
basically means that someone else allocated the page with index @start
and added it to the page cache in between us running find_lock_page()
and add_to_page_cache_lru().  So what we want to do is to run
find_lock_page() again which should then find and lock the page that the
other process created.

Of course what could happen is that between us getting the -EEXIST and
us repeating the find_lock_page() the page is freed again so the
find_lock_page() fails again.  Perhaps this time we will succeed with
add_to_page_cache_lru() and if not we repeat again.  Eventually either
find_lock_page() or add_to_page_cache_lru() will succeed so in practise
it will never be an endless loop.

If the while loop is changed to a for loop, the "continue;" on -EEXIST
would need to be changed to "goto repeat;" and a label "repeat:" would
need to be placed at the beginning of the loop.  I considered this but
decided the while loop looks nicer.  (-:

Thanks for the review!

> > +	err = nr = 0;
> > +	while (nr < nr_pages) {
> > +		if (start == lp_idx) {
> > +			pages[nr] = locked_page;
> > +			if (nr) {
> > +				lock_page(locked_page);
> > +				if (wbc) {
> > +					if (wbc->for_reclaim) {
> > +						up(&inode->i_sem);
> > +						up_read(&inode->i_sb->s_umount);
> > +					}
> > +					/* Was the page truncated under us? */
> > +					if (page_mapping(locked_page) !=
> > +							mapping) {
> > +						err = -ESTALE;
> > +						goto err_out_locked;
> > +					}
> > +				}
> > +			}
> > +		} else {
> > +			pages[nr] = find_lock_page(mapping, start);
> > +			if (!pages[nr]) {
> > +				if (!cached_page) {
> > +					cached_page = alloc_page(gfp_mask);
> > +					if (!unlikely(cached_page))
> > +						goto err_out;
> > +				}
> > +				err = add_to_page_cache_lru(cached_page,
> > +						mapping, start, gfp_mask);
> > +				if (unlikely(err)) {
> > +					if (err == -EEXIST)
> > +						continue;
> > +					goto err_out;
> > +				}
> > +				pages[nr] = cached_page;
> > +				cached_page = NULL;
> > +			}
> > +		}
> > +		nr++;
> > +		start++;
> > +	}

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

