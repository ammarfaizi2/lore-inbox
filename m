Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135232AbRDLRJd>; Thu, 12 Apr 2001 13:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135233AbRDLRJY>; Thu, 12 Apr 2001 13:09:24 -0400
Received: from dfmail.f-secure.com ([194.252.6.39]:47752 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S135232AbRDLRJT>; Thu, 12 Apr 2001 13:09:19 -0400
Date: Thu, 12 Apr 2001 20:18:24 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Hugh Dickins <hugh@veritas.com>, <Valdis.Kletnieks@vt.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: scheduler went mad?
In-Reply-To: <Pine.LNX.4.21.0104121209000.2774-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.30.0104122008590.19377-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Apr 2001, Marcelo Tosatti wrote:

> This patch is broken, ignore it.
> Just removing wakeup_bdflush() is indeed correct.
> We already wakeup bdflush at try_to_free_buffers() anyway.

I still feel a bit unconfortable about processes looping forever in
__alloc_pages and because of this oom_killer also can't be moved to page
fault handler where I think its place should be. I'm using the patch
below.

	Szaka

--- mm/page_alloc.c.orig      Sat Mar 31 19:07:22 2001
+++ mm/page_alloc.c     Mon Apr  2 21:05:31 2001
@@ -453,8 +453,12 @@
                 */
                if (gfp_mask & __GFP_WAIT) {
                        memory_pressure++;
-                       try_to_free_pages(gfp_mask);
-                       wakeup_bdflush(0);
+                       if (!try_to_free_pages(gfp_mask));
+                               return NULL;
                        goto try_again;
                }
        }


