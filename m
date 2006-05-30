Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWE3LcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWE3LcP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 07:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWE3LcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 07:32:15 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:36279 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1750730AbWE3LcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 07:32:14 -0400
Message-ID: <348988729.55410@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Tue, 30 May 2006 19:32:21 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Jens Axboe <axboe@suse.de>
Cc: Michael Tokarev <mjt@tls.msk.ru>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 00/32] Adaptive readahead V14
Message-ID: <20060530113221.GA8665@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Jens Axboe <axboe@suse.de>, Michael Tokarev <mjt@tls.msk.ru>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <348745084.15239@ustc.edu.cn> <44788C8A.2070900@tls.msk.ru> <348818092.32485@ustc.edu.cn> <4479F8B5.90906@tls.msk.ru> <20060529030152.GA5994@mail.ustc.edu.cn> <20060530092309.GH4199@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530092309.GH4199@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 11:23:10AM +0200, Jens Axboe wrote:
> On Mon, May 29 2006, Wu Fengguang wrote:
> > On Sun, May 28, 2006 at 11:23:33PM +0400, Michael Tokarev wrote:
> > > Wu Fengguang wrote:
> > > > 
> > > > It's not quite reasonable for readahead to worry about media errors.
> > > > If the media fails, fix it. Or it will hurt read sooner or later.
> > > 
> > > Well... In reality, it is just the opposite.
> > > 
> > > Suppose there's a CD-rom with a scratch/etc, one sector is unreadable.
> > > In order to "fix" it, one have to read it and write to another CD-rom,
> > > or something.. or just ignore the error (if it's just a skip in a video
> > > stream).  Let's assume the unreadable block is number U.
> > > 
> > > But current behavior is just insane.  An application requests block
> > > number N, which is before U. Kernel tries to read-ahead blocks N..U.
> > > Cdrom drive tries to read it, re-read it.. for some time.  Finally,
> > > when all the N..U-1 blocks are read, kernel returns block number N
> > > (as requested) to an application, successefully.
> > > 
> > > Now an app requests block number N+1, and kernel tries to read
> > > blocks N+1..U+1.  Retrying again as in previous step.
> > > 
> > > And so on, up to when an app requests block number U-1.  And when,
> > > finally, it requests block U, it receives read error.
> > > 
> > > So, kernel currentry tries to re-read the same failing block as
> > > many times as the current readahead value (256 (times?) by default).
> > 
> > Good insight... But I'm not sure about it.
> > 
> > Jens, will a bad sector cause the _whole_ request to fail?
> > Or only the page that contains the bad sector?
> 
> Depends entirely on the driver, and that point we've typically lost the
> fact that this is a read-ahead request and could just be tossed. In
> fact, the entire request may consist of read-ahead as well as normal
> read entries.
> 
> For ide-cd, it tends do only end the first part of the request on a
> medium error. So you may see a lot of repeats :/

Another question about it:
        If the block layer issued a request, which happened to contain
        R ranges of B bad blocks, i.e. 3 ranges of 9 bad-blocks:
                ___b_____bb___________bbbbbb____
        How many retries will incur? 1, 3, 9, or something else?
        If it is 3 or more, then we are even more bad luck :(

Will it be suitable to _automatically_ apply the following retracting
policy on I/O error? Please comment if there's better ways:

--- linux-2.6.17-rc4-mm3.orig/mm/filemap.c
+++ linux-2.6.17-rc4-mm3/mm/filemap.c
@@ -983,6 +983,7 @@ readpage:
 				}
 				unlock_page(page);
 				error = -EIO;
+				ra.ra_pages /= 2;
 				goto readpage_error;
 			}
 			unlock_page(page);
@@ -1535,6 +1536,7 @@ page_not_uptodate:
 	 * Things didn't work out. Return zero to tell the
 	 * mm layer so, possibly freeing the page cache page first.
 	 */
+	ra->ra_pages /= 2;
 	page_cache_release(page);
 	return NULL;
 }

