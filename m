Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267325AbUH1Jel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267325AbUH1Jel (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 05:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267361AbUH1Jel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 05:34:41 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:6374 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S267325AbUH1Jef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 05:34:35 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Ram Pai <linuxram@us.ibm.com>
Subject: Re: data loss in 2.6.9-rc1-mm1
Date: Sat, 28 Aug 2004 11:44:50 +0200
User-Agent: KMail/1.5
Cc: Hugh Dickins <hugh@veritas.com>, Gergely Tamas <dice@mfa.kfki.hu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0408271950460.8349-100000@localhost.localdomain> <1093669312.11648.80.camel@dyn319181.beaverton.ibm.com> <41301E27.2020504@yahoo.com.au>
In-Reply-To: <41301E27.2020504@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408281144.50704.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, guys, to make it 100% clear: if I apply the Nick's patch to the 
2.6.9-rc1-mm1 tree, it will fix the data loss issue.  Is that right?

RJW

On Saturday 28 of August 2004 07:54, Nick Piggin wrote:
> Ram Pai wrote:
> > On Fri, 2004-08-27 at 21:35, Nick Piggin wrote:
> >>Ram Pai wrote:
> >>>got it!  Everything got changed to the new convention except that
> >>>the calculation of 'nr' just before the check "nr <= offset" .
> >>>
> >>>I have generated this patch which takes care of that and hence fixes the
> >>>data loss problem as well. I guess it is cleaner too.
> >>>
> >>>This patch is generated w.r.t 2.6.8.1. If everybody blesses this patch I
> >>>will forward it to Andrew.
> >>
> >>It looks like it should be OK... but at what point does it become
> >>simpler to use my patch which just moves the original calculation
> >>up, and does it again if we have to ->readpage()?
> >>
> >>(assuming you agree that it solves the problem)
> >
> > I agree your patch also solves the problem.
> >
> > Either way is fine. Even Hugh's patch almost does the same thing as
> > yours.
>
> Ahh, yep - Hugh just forgot to also move the "nr" calculation
> into the ->readpage path, so it hits twice on the fast path.
>
> > The only advantage with my page is it does the calculation in
> > only one place and does not repeat it. Also I feel its more intuitive to
>
> Well kind of - but you are having to jump through hoops to get there.
> Yours does the following checks:
>
> 	/* fast path, read nr_pages from pagecache */
> 	if (!isize)
> 		goto out;
> 	for (i = 0; i < nr_pages; i++) {
> 		if (index > end_index)
> 			goto out;
> 		if (index == end_index) {
> 			nr = ((isize - 1) & ~PAGE_CACHE_MASK) + 1;
> 			if (nr <= offset) {
> 				page_cache_release(page);
> 				goto out;
> 			}
> 		}
>
> 		/* slowpath, ->readpage */
> 		if (unlikely(!isize || index > end_index)) {
> 			page_cache_release(page);
> 			goto out;
> 		}
> 	}
>
>
> Mine does:
> 	if (index > end_index)
> 		goto out;
> 	for (i = 0; i < pages_to_read; i++) {
> 		if (index == end_index) {
> 			nr = isize & ~PAGE_CACHE_MASK;
> 			if (nr <= offset)
> 				goto out;
> 		}
>
> 		/* slowpath, ->readpage */
> 		if (index > end_index) {
> 			page_cache_release(page);
> 			goto out;
> 		}
> 		if (index == end_index) {
> 			nr = isize & ~PAGE_CACHE_MASK;
> 			if (nr <= offset) {
> 				page_cache_release(page);
> 				goto out;
> 			}
> 		}
> 	}
>
> So my fastpath is surely leaner, while the slowpath isn't a clear loser.
>
> What's more, it looks like mine handles the corner case of reading off the
> end of a non-PAGE_SIZE file (but within the same page). I think yours will
> drop through and do the ->readpage, while mine doesn't...?
>
> > assume that index 0 covers range 0 to 4095 i.e index n covers range
> > n*PAGE_SIZE to ((n+1)*PAGE_SIZE)-1.  Currently the code assumes index 0
> > covers range 1 to 4096  i.e index n covers range (n*PAGE_SIZE)+1 to
> > (n+1)*PAGE_SIZE.
>
> It is definitely a pretty ugly function all round. I like the 0-4095 thing
> better too, but my counter argument to that is that this is the minimal
> change, and similar to how it has previously worked.
>
> > this is the 4th time we are trying to nail down the same thing. We
> > better get it right this time. So any correct patch is ok with me.
>
> I agree. We'll leave it to someone else to decide, then ;)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
