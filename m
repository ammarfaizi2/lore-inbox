Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317799AbSHaRhz>; Sat, 31 Aug 2002 13:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317833AbSHaRhz>; Sat, 31 Aug 2002 13:37:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5132 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317799AbSHaRhz>;
	Sat, 31 Aug 2002 13:37:55 -0400
Message-ID: <3D7102C1.CF3A961C@zip.com.au>
Date: Sat, 31 Aug 2002 10:54:09 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>
CC: Daniel Phillips <phillips@arcor.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Include LRU in page count
References: <3D644C70.6D100EA5@zip.com.au> <3D6989F7.9ED1948A@zip.com.au> <akdq8h$fqn$1@penguin.transmeta.com> <E17kunE-0003IO-00@starship> <20020831161448.12564.qmail@thales.mathematik.uni-ulm.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Ehrhardt wrote:
> 
> ...
> Solution: Change the PageLRU bit inside the lock. Looks like
> lru_cache_add is the only place that doesn't hold the lru lock to
> change the LRU flag and it's probably not a good idea even without
> the patch.
> 

2.4.20-pre already does that:

void lru_cache_add(struct page * page)
{
        if (!PageLRU(page)) {
                spin_lock(&pagemap_lru_lock);
                if (!TestSetPageLRU(page))
                        add_page_to_inactive_list(page);
                spin_unlock(&pagemap_lru_lock);
        }
}

there was an oopsing race with activate_page()...
