Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263427AbRFEXwo>; Tue, 5 Jun 2001 19:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263430AbRFEXwe>; Tue, 5 Jun 2001 19:52:34 -0400
Received: from mailb.telia.com ([194.22.194.6]:51730 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S263428AbRFEXw1>;
	Tue, 5 Jun 2001 19:52:27 -0400
Message-Id: <200106052351.BAA12041@mailb.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: kswapd and MM overload fix
Date: Wed, 6 Jun 2001 01:48:49 +0200
X-Mailer: KMail [version 1.2.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.31.0106051612500.9908-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.31.0106051612500.9908-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday66 0666 6 June 2001 01:16, Linus Torvalds wrote:
> On Wed, 6 Jun 2001, Andrea Arcangeli wrote:
> > Anybody running on a machine with some zone empty (<16Mbyte boxes (PDAs),
> > <1G x86 with highmem enabled kernel or an arch with an iommu like alpha)
> > probably noticed that the MM was unusable on those hardware
> > configurations (as I also incidentally mentioned a few times on l-k in
> > the last months).
> >
> > Yesterday I checked and here it is the fix (included in 2.4.5aa3).
>
> I think the real problem is that zone->pages_{min,low,high} aren't
> initialized at all for empty zones. If they were initialized (to zero, of
> course), the shortage calculations would have worked automatically.
>
> Using uninitialized variables is always bad. Your patch is certainly fine,
> but I think we should also make the init code clear the zone data for
> empty zones so that these kinds of "use uninitialized stuff" things cannot
> happen. No?
>  

Lets see - that zone will have no free nor inactive pages 

In page_alloc.c:254  function __alloc_pages_limit
where water_mark will be zero too...
              if (z->free_pages + z->inactive_clean_pages >= water_mark) {    
we will attempt a lot of interesting/unnecessary stuff.
But it should be caught by the test a few lines up...
                if (!z->size)
                        BUG();

In page_alloc.c:331 (function __alloc_pages)
                if (z->free_pages >= z->pages_low) {
                        page = rmqueue(z, order);
                        if (page)
                                return page;

Hmm... a lot more than first meets the eye.
Note: >= matches < in another place, removing the = will leave the mm stuck...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

