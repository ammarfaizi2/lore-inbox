Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266158AbRHAJnq>; Wed, 1 Aug 2001 05:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266220AbRHAJng>; Wed, 1 Aug 2001 05:43:36 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:27153 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266158AbRHAJnb>; Wed, 1 Aug 2001 05:43:31 -0400
Date: Wed, 1 Aug 2001 05:13:52 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrew Tridgell <tridge@valinux.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: 2.4.8preX VM problems
In-Reply-To: <20010801081344.8A6C04603@lists.samba.org>
Message-ID: <Pine.LNX.4.21.0108010504160.9379-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew, 

The problem is pretty nasty: if there is no global shortage and only a 
given zone with shortage, we set the zone free target to freepages.min
(basically no tasks can make progress with that amount of free memory). 

The following patch sets the zone free target to freepages.high. Can you
test it ? (I tried here and got the expected results)

Maybe pages_high is _too_ high to set the free target. 

We may want to use pages_low for page freeing and pages_high for page
writeout, or something like that. (this way we keep the necessary amount
of pages to reach pages_high being written out)

I'll keep looking into this tomorrow. Going home now.


--- linux.orig/mm/page_alloc.c	Mon Jul 30 17:06:49 2001
+++ linux/mm/page_alloc.c	Wed Aug  1 06:21:35 2001
@@ -630,8 +630,8 @@
 		goto ret;
 
 	if (zone->inactive_clean_pages + zone->free_pages
-			< zone->pages_min) {
-		sum += zone->pages_min;
+			< zone->pages_high) {
+		sum += zone->pages_high;
 		sum -= zone->free_pages;
 		sum -= zone->inactive_clean_pages;
 	}


On Wed, 1 Aug 2001, Andrew Tridgell wrote:

> Marcelo,
> 
> I'm afraid that didn't help. I get:
> 
> [root@skurk /root]# ./readfiles /dev/ddisk 
> 362 MB    181.145 MB/sec
> 695 MB    166.455 MB/sec
> 811 MB    57.6077 MB/sec
> 812 MB    0.439532 MB/sec
> 813 MB    0.463901 MB/sec
> 814 MB    0.416093 MB/sec
> 815 MB    0.409958 MB/sec
> 816 MB    0.410413 MB/sec
> 
> 
> 
> 
> > Could you please try the patch below ? (against 2.4.8pre3)
> > 
> > --- linux.orig/mm/vmscan.c	Wed Aug  1 04:26:36 2001
> > +++ linux/mm/vmscan.c	Wed Aug  1 04:33:22 2001
> > @@ -593,13 +593,9 @@
> >  			 * If we're freeing buffer cache pages, stop when
> >  			 * we've got enough free memory.
> >  			 */
> > -			if (freed_page) {
> > -				if (zone) {
> > -					if (!zone_free_shortage(zone))
> > -						break;
> > -				} else if (!free_shortage()) 
> > -					break;
> > -			}
> > +			if (freed_page && !total_free_shortage())
> > +				break;
> > +
> >  			continue;
> >  		} else if (page->mapping && !PageDirty(page)) {
> >  			/*
> > 
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

