Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbUEEFZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbUEEFZr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 01:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUEEFZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 01:25:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:13705 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261920AbUEEFZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 01:25:45 -0400
Date: Tue, 4 May 2004 22:25:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shantanu Goel <sgoel01@yahoo.com>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [VM PATCH 2.6.6-rc3-bk5] Dirty balancing in the presence of
 mapped pages
Message-Id: <20040504222524.23a83c02.akpm@osdl.org>
In-Reply-To: <20040505043115.92441.qmail@web12823.mail.yahoo.com>
References: <20040504195753.0a9e4a54.akpm@osdl.org>
	<20040505043115.92441.qmail@web12823.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shantanu Goel <sgoel01@yahoo.com> wrote:
>
> > In this case, given that we have an actively mapped
>  > MAP_SHARED pagecache
>  > page, marking it dirty will cause it to be written
>  > by pdflush.  Even though
>  > we're not about to reclaim it, and even though the
>  > process which is mapping
>  > the page may well modify it again.  This patch will
>  > cause additional I/O.
>  > 
> 
>  True, but is that really very different from normal
>  file I/O where we actively balance # dirty pages? 
>  Also, the I/O will only happen if the dirty thresholds
>  are exceeded.  It probably makes sense though to skip
>  SwapCache pages to more closely mimic file I/O
>  behaviour.

We need to think about why real applications (as opposed to benchmarks) use
MAP_SHARED.  I suspect many of them will modify pages again and again and
again.  We really want to avoid writing these pages out until the
application has truly finished with them.

I think it is probably the case that pages which were dirtied with write(2)
are much less likely to be redirtied than pages which were dirtied via
MAP_SHARED.

One thing you might like to look at is to give these pages another trip
around the LRU after they have been unmapped from pagetables, and to give
pdflush a poke.  Add instrumentation to record how many pages end up
getting written via vmscan's writepage versus via pdflush (use
current_is_pdflush()).


diff -puN mm/vmscan.c~a mm/vmscan.c
--- 25/mm/vmscan.c~a	2004-05-04 22:21:41.613856240 -0700
+++ 25-akpm/mm/vmscan.c	2004-05-04 22:23:16.016504856 -0700
@@ -318,7 +318,9 @@ shrink_list(struct list_head *page_list,
 				rmap_unlock(page);
 				goto keep_locked;
 			case SWAP_SUCCESS:
-				; /* try to free the page below */
+				if (PageDirty(page))
+					goto keep_locked;
+				break;
 			}
 		}
 		rmap_unlock(page);

_

