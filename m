Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUHaQ2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUHaQ2v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 12:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268757AbUHaQ2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 12:28:50 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:60863 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262406AbUHaQ05
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 12:26:57 -0400
Subject: Re: [RFC] buddy allocator without bitmap(2) [0/3]
From: Dave Hansen <haveblue@us.ibm.com>
To: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <41345491.1020209@jp.fujitsu.com>
References: <41345491.1020209@jp.fujitsu.com>
Content-Type: text/plain
Message-Id: <1093969590.26660.4806.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 31 Aug 2004 09:26:30 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-31 at 03:36, Hiroyuki KAMEZAWA wrote:
> Disadvantage:
>   - using one more PG_xxx flag.
>   - If mem_map is not aligned, reserve one page as a victim for buddy allocater.
> 
> How about this approach ?

Granted, we have some free wiggle room in page->flags right now, but
using another bit effectively shifts the entire benefit of your patch. 
Instead of getting rid of the buddy bitmaps, you simply consume a
page->flag instead.  While you don't have to allocate anything (because
of the page->flags use), the number of bits consumed in the operation is
still the same as before.  And the patch is getting more complex by the
minute.

Something ate your patch:

   * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -290,6 +297,9 @@ extern unsigned long __read_page_state(u
  #define SetPageCompound(page) set_bit(PG_compound, &(page)->flags)
  #define ClearPageCompound(page)       clear_bit(PG_compound, &(page)->flags)

+#define PageBuddyend(page)      test_bit(PG_buddyend, &(page)->flags)
+#define SetPageBuddyend(page)   set_bit(PG_buddyend, &(page)->flags)
+
  #ifdef CONFIG_SWAP
  #define PageSwapCache(page)   test_bit(PG_swapcache, &(page)->flags)
  #define SetPageSwapCache(page)        set_bit(PG_swapcache, &(page)->flags)


-- Dave

