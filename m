Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbULTID0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbULTID0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 03:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbULTICX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 03:02:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:10373 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261492AbULTHJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 02:09:10 -0500
Date: Sun, 19 Dec 2004 23:07:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: riel@redhat.com, kernel@kolivas.org, mr@ramendik.ru, akpm@digeo.com,
       lista4@comhem.se, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Message-Id: <20041219230754.64c0e52e.akpm@osdl.org>
In-Reply-To: <1103517225.5093.12.camel@npiggin-nld.site>
References: <14514245.1103496059334.JavaMail.tomcat@pne-ps4-sn2>
	<41C6073B.6030204@yahoo.com.au>
	<20041219155722.01b1bec0.akpm@digeo.com>
	<200412200303.35807.mr@ramendik.ru>
	<41C640DE.7050002@kolivas.org>
	<Pine.LNX.4.61.0412192220450.4315@chimarrao.boston.redhat.com>
	<1103517225.5093.12.camel@npiggin-nld.site>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> On Sun, 2004-12-19 at 22:21 -0500, Rik van Riel wrote:
> > On Mon, 20 Dec 2004, Con Kolivas wrote:
> > 
> > > I still suspect the thrash token patch even with the swap token timeout 
> > > at 0. Is it completely disabled at 0 or does it still do something?
> > 
> > It makes it harder to page out pages from the task holding the
> > token.  I wonder if kswapd should try to steal the token away
> > from the task holding it, so in effect nobody holds the token
> > when the system isn't under a heavy swapping load.
> > 
> 
> In that case, the first thing we need to do is disable thrash token
> completely, and retest that. We still don't know for sure that it is
> the problem.
> 
> I don't have the code in front of me at the moment, but I'll be able
> to send a patch to do that in a couple of hours, if nobody beats me
> to it.

This should disable the thrashing control code?

--- 25/mm/rmap.c~a	2004-12-19 23:05:58.759420936 -0800
+++ 25-akpm/mm/rmap.c	2004-12-19 23:06:43.105679280 -0800
@@ -395,6 +395,8 @@ int page_referenced(struct page *page, i
 {
 	int referenced = 0;
 
+	ignore_token = 1;
+
 	if (page_test_and_clear_young(page))
 		referenced++;
 
_

