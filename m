Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317648AbSIEPgy>; Thu, 5 Sep 2002 11:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317673AbSIEPgy>; Thu, 5 Sep 2002 11:36:54 -0400
Received: from dsl-213-023-039-222.arcor-ip.net ([213.23.39.222]:42150 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317648AbSIEPgy>;
	Thu, 5 Sep 2002 11:36:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Subject: Re: [RFC] Alternative raceless page free
Date: Thu, 5 Sep 2002 17:21:31 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, Christian Ehrhardt <ulcae@in-ulm.de>
References: <3D644C70.6D100EA5@zip.com.au> <E17moT6-00064X-00@starship> <20020905123413.21580.qmail@thales.mathematik.uni-ulm.de>
In-Reply-To: <20020905123413.21580.qmail@thales.mathematik.uni-ulm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17myRo-00068H-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 September 2002 14:34, Christian Ehrhardt wrote:
> @@ -455,7 +458,7 @@
>                         } else {
>                                 /* failed to drop the buffers so stop here */
>                                 UnlockPage(page);
> -                               page_cache_release(page);
> +                               put_page(page);
> 
>                                 spin_lock(&pagemap_lru_lock);
>                                 continue;
> 
> looks a bit suspicious. put_page is not allowed if the page is still
> on the lru and there is no other reference to it. As we don't hold any
> locks between UnlockPage and put_page there is no formal guarantee that
> the above condition is met. I don't have another path that could race
> with this one though and chances are that there actually is none.

The corresponding get_page is just above, you must have overlooked it.

Besides that, we have a promise that the page still has buffers, worth
another count, and the page will never be freed here.  That's fragile
though, and this particular piece of code can no doubt be considerably
simplified, while improving robustness and efficiency at the same time.
But that goes beyond the scope of this patch.

The whole try_to_free_buffers path is hairy, scary and disgusting.  It
could use some critical analysis, if anybody has time.

-- 
Daniel
