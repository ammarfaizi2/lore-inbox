Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311334AbSCLVY4>; Tue, 12 Mar 2002 16:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311347AbSCLVYr>; Tue, 12 Mar 2002 16:24:47 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:54704 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311334AbSCLVYZ>; Tue, 12 Mar 2002 16:24:25 -0500
Date: Tue, 12 Mar 2002 13:22:50 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 23 second kernel compile / pagemap_lru_lock improvement
Message-ID: <192090000.1015968170@flay>
In-Reply-To: <128210000.1015892845@flay>
In-Reply-To: <Pine.LNX.4.33.0203111526160.17864-100000@penguin.transmeta.com> <128210000.1015892845@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Linus:
>>>>
>>>> Anyway, some obvious LRU lock improvements are clearly available: 
>>>> activate_page_nolock() shouldn't even need to take the lru lock if the 
>>>> page is already active. 

Your suggestion seems to improve the pagemap_lru_lock contention a little:
(make bzImage , 16 way NUMA-Q, 5 runs each)

before:

lockstat.1: 20.6% 59.2%  5.2us(  81us)  104us(  11ms)(15.2%)    994575 40.8% 59.2%    0%  pagemap_lru_lock
lockstat.2: 19.0% 54.8%  4.8us(  84us)  102us(  10ms)(13.7%)   1007488 45.2% 54.8%    0%  pagemap_lru_lock
lockstat.3: 19.5% 55.6%  4.9us(  78us)  105us(  11ms)(14.4%)   1000062 44.4% 55.6%    0%  pagemap_lru_lock
lockstat.4: 17.8% 51.6%  5.2us( 105us)   90us(  12ms)(10.0%)   1008310 48.4% 51.6%    0%  pagemap_lru_lock
lockstat.5: 20.2% 57.1%  5.4us(  86us)  111us(  16ms)(14.7%)   1014988 42.9% 57.1%    0%  pagemap_lru_lock
 
after:

lockstat.1: 18.0% 54.3%  4.7us( 155us)   92us(  14ms)(11.9%)    999140 45.7% 54.3%    0%  pagemap_lru_lock
lockstat.2: 17.7% 52.8%  4.6us( 151us)   94us(  14ms)(12.0%)    997999 47.2% 52.8%    0%  pagemap_lru_lock
lockstat.3: 18.3% 54.4%  5.2us(1581us)  111us(  10ms)(13.2%)   1005149 45.6% 54.4%    0%  pagemap_lru_lock
lockstat.4: 20.2% 57.8%  5.3us( 210us)  108us(  12ms)(14.9%)    998813 42.2% 57.8%    0%  pagemap_lru_lock
lockstat.5: 14.4% 44.2%  3.8us( 167us)   81us(  11ms)( 8.5%)   1004476 55.8% 44.2%    0%  pagemap_lru_lock

It's a little difficult to see, as there's quite some variablity between runs.

If we look at activate_page_nolock, it's easier to understand the context of
the patch:

------------------

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

---------------------

Patch is below - any comments?

--- virgin-2.4.18/mm/swap.c	Tue Nov  6 22:44:20 2001
+++ linux-2.4.18-lrufix/mm/swap.c	Mon Mar 11 15:55:56 2002
@@ -46,9 +46,15 @@
 
 void activate_page(struct page * page)
 {
-	spin_lock(&pagemap_lru_lock);
-	activate_page_nolock(page);
-	spin_unlock(&pagemap_lru_lock);
+	if (PageLRU(page) && !PageActive(page)) {
+		/* 
+		 * no point in grabbing the lock if we don't have to do
+		 * anything with it, but check twice in case of a race 
+		 */
+		spin_lock(&pagemap_lru_lock);
+		activate_page_nolock(page);
+		spin_unlock(&pagemap_lru_lock);
+	}
 }
 
 /**

