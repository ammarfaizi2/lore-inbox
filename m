Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269641AbRHVBHF>; Tue, 21 Aug 2001 21:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271909AbRHVBGz>; Tue, 21 Aug 2001 21:06:55 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:11536 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269641AbRHVBGp>; Tue, 21 Aug 2001 21:06:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: Memory Problem in 2.4.9 ?
Date: Wed, 22 Aug 2001 03:13:23 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0108212146470.5646-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108212146470.5646-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010822010649Z16145-32383+774@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 22, 2001 02:48 am, Rik van Riel wrote:
> On Wed, 22 Aug 2001, Daniel Phillips wrote:
> 
> > --- ../2.4.9.clean/mm/filemap.c	Thu Aug 16 14:12:07 2001
> > +++ ./mm/filemap.c	Wed Aug 22 01:11:44 2001
> > @@ -980,7 +980,7 @@
> >  static inline void check_used_once (struct page *page)
> >  {
> >  	if (!PageActive(page)) {
> > -		if (page->age)
> > +		if (page->age > 8)
> >  			activate_page(page);
> >  		else {
> >  			page->age = PAGE_AGE_START;
> 
> This makes absolutely no sense since you'll never set the
> page age higher than PAGE_AGE_START until the is actually
> on the active list.

Oops, yes, I forgot for the moment that we no longer age up in 
__find_page_nolock.  Lets try this instead, which should capture the intended 
effect of requiring 4 hits to activate a page (n.b., it's just a test):

--- ../2.4.9.clean/mm/filemap.c	Thu Aug 16 14:12:07 2001
+++ ./mm/filemap.c	Wed Aug 22 02:02:24 2001
@@ -980,10 +980,9 @@
 static inline void check_used_once (struct page *page)
 {
 	if (!PageActive(page)) {
-		if (page->age)
+		if (++page->age >= 4)
 			activate_page(page);
 		else {
-			page->age = PAGE_AGE_START;
 			ClearPageReferenced(page);
 		}
 	}
