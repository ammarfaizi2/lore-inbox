Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317393AbSHOUEJ>; Thu, 15 Aug 2002 16:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317398AbSHOUEI>; Thu, 15 Aug 2002 16:04:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41998 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317393AbSHOUEH>;
	Thu, 15 Aug 2002 16:04:07 -0400
Message-ID: <3D5C0995.CEE36FC8@zip.com.au>
Date: Thu, 15 Aug 2002 13:05:41 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: j-nomura@ce.jp.nec.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18(19) swapcache oops
References: <20020815.213929.846960657.nomura@hpc.bs1.fc.nec.co.jp> <Pine.LNX.4.44.0208151515420.1610-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> On Thu, 15 Aug 2002 j-nomura@ce.jp.nec.com wrote:
> >
> > I'm using 2.4.18 kernel and suspect there are swapcache race.
> > I looked into 2.4.19 patch but could not find the fix to it.
> 
> I see a benign race but no oops.
> 

But look at lru_cache_add():

void lru_cache_add(struct page * page)
{
        if (!TestSetPageLRU(page)) {
/* window here */
                spin_lock(&pagemap_lru_lock);
                add_page_to_inactive_list(page);
                spin_unlock(&pagemap_lru_lock);
        }
}

It sets PG_lru before adding the page to the LRU.

static inline void activate_page_nolock(struct page * page)
{
        if (PageLRU(page) && !PageActive(page)) {
                del_page_from_inactive_list(page);
                add_page_to_active_list(page);
        }
}

void activate_page(struct page * page)
{
        spin_lock(&pagemap_lru_lock);
        activate_page_nolock(page);
        spin_unlock(&pagemap_lru_lock);
}

So if activate_page gets the lock inside that window, it will
delete a page from the LRU which isn't on it (memory corruption).
Then activate_page will set PG_active and will drop the lock.

lru_cache_add gets the lock, runs add_page_to_inactive_list which
BUGs over PG_active.


--- 2.4.19/mm/swap.c~lru-race	Thu Aug 15 13:03:48 2002
+++ 2.4.19-akpm/mm/swap.c	Thu Aug 15 13:04:19 2002
@@ -57,9 +57,10 @@ void activate_page(struct page * page)
  */
 void lru_cache_add(struct page * page)
 {
-	if (!TestSetPageLRU(page)) {
+	if (!PageLRU(page)) {
 		spin_lock(&pagemap_lru_lock);
-		add_page_to_inactive_list(page);
+		if (!TestSetPageLRU(page))
+			add_page_to_inactive_list(page);
 		spin_unlock(&pagemap_lru_lock);
 	}
 }

.
