Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271902AbRHVAhV>; Tue, 21 Aug 2001 20:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271909AbRHVAhL>; Tue, 21 Aug 2001 20:37:11 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:18959 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271902AbRHVAg6>; Tue, 21 Aug 2001 20:36:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: Memory Problem in 2.4.9 ?
Date: Wed, 22 Aug 2001 02:43:37 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010821154617.4671f85d.skraw@ithnet.com> <20010821190414Z16086-32384+294@humbolt.nl.linux.org> <20010822020445.435ec6d5.skraw@ithnet.com>
In-Reply-To: <20010822020445.435ec6d5.skraw@ithnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010822003706Z16145-32383+770@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 22, 2001 02:04 am, Stephan von Krawczynski wrote:
> Daniel Phillips <phillips@bonn-fries.net> wrote:
> 
> > > Aug 21 20:14:51 admin kernel: __alloc_pages: 3-order allocation failed 
> > > (gfp=0x20/0).
> > > Aug 21 20:14:51 admin last message repeated 146 times
> > > 
> > > Next idea?
> > 
> > It's an atomic allocation, the driver is supposed to be able to handle
> > this, and it does since you report that the burn just runs slowly, it 
> > does not stop.  There is way too much in cache:
> > 
> > >         total:    used:    free:  shared: buffers:  cached:
> > > Mem:  1053675520 1047502848  6172672        0 20930560 939307008
> > > Swap: 271392768 15880192 255512576
> > 
> > This is causing the high order allocation failures - with only a small 
> > fraction of memory free the chances of none of it being in contiguous, 
> > aligned 8 page units rises dramatically.
> 
> I basically thought the same. In fact I do not understand why. Are there any
> parameters tunable to balance the whole picture a bit more towards the free
> pages?

I'd like to try to isolate the cause a little more.  Can you please try the 
following patch and see if it improves the cache balance.  (This would not
be a good solution, it will just help show what is happening.)

--- ../2.4.9.clean/mm/filemap.c	Thu Aug 16 14:12:07 2001
+++ ./mm/filemap.c	Wed Aug 22 01:11:44 2001
@@ -980,7 +980,7 @@
 static inline void check_used_once (struct page *page)
 {
 	if (!PageActive(page)) {
-		if (page->age)
+		if (page->age > 8)
 			activate_page(page);
 		else {
 			page->age = PAGE_AGE_START;
