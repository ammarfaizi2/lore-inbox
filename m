Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135225AbRDLQt7>; Thu, 12 Apr 2001 12:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135226AbRDLQtt>; Thu, 12 Apr 2001 12:49:49 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:61711 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135224AbRDLQta>; Thu, 12 Apr 2001 12:49:30 -0400
Date: Thu, 12 Apr 2001 12:08:00 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
        Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: scheduler went mad?
In-Reply-To: <Pine.LNX.4.21.0104121327450.18260-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0104121207130.2774-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Apr 2001, Rik van Riel wrote:

> On Thu, 12 Apr 2001, Alan Cox wrote:
> 
> > > 2.4.3-pre6 quietly made a very significant change there:
> > > it used to say "if (!order) goto try_again;" and now just
> > > says "goto try_again;".  Which seems very sensible since
> > > __GFP_WAIT is set, but I do wonder if it was a safe change.
> > > We have mechanisms for freeing pages (order 0), but whether
> > > any higher orders come out of that is a matter of chance.
> > 
> > The fundamental problem is that it should say
> > 
> > 	wait_for_mm_progress();
> > 	goto try_again;
> > 
> > and we dont have that facility right now.
> 
> >From mm/page_alloc.c, around line 453:
> 
>                 if (gfp_mask & __GFP_WAIT) {
>                         memory_pressure++;
>                         try_to_free_pages(gfp_mask);
>                         wakeup_bdflush(0);
>                         goto try_again;
>                 }
> 
> I guess we should remove the wakeup_bdflush(0) ... who put it
> there anyway ?

I did :)

This should fix it 

--- mm/page_alloc.c.orig   Thu Apr 12 13:47:53 2001
+++ mm/page_alloc.c        Thu Apr 12 13:48:06 2001
@@ -454,7 +454,7 @@
                if (gfp_mask & __GFP_WAIT) {
                        memory_pressure++;
                        try_to_free_pages(gfp_mask);
-                       wakeup_bdflush(0);
+                       balance_dirty(NODEV);
                        goto try_again;
                }


