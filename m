Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbVJOD15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbVJOD15 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 23:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbVJOD15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 23:27:57 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:43393 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751039AbVJOD14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 23:27:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:Content-Type;
  b=z5WK4HQL1SOZXOSRHwxlrxwRxgDisw5ardx1r6H2ohdGYxqL2HFZKpW5KntZ3q7a+6VdK2TXYUryng9kOixIsmQhTggo+tCdj9m0wcJG8bvNUOzBW3gBCdVfr1qw/wipfhYkm3JuTSQjTcZFJhMhD88kk4TPMyXTLpOskCef6QY=  ;
Message-ID: <4350776D.1060304@yahoo.com.au>
Date: Sat, 15 Oct 2005 13:28:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050914 Debian/1.7.11-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Possible memory ordering bug in page reclaim?
Content-Type: multipart/mixed;
 boundary="------------060001070704090905080907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060001070704090905080907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Is there anything that prevents PageDirty from theoretically being
speculatively loaded before page_count here? (see patch)

It would result in pagecache corruption in the following situation:

1                                2
find_get_page();
write to page                    write_lock(tree_lock);
SetPageDirty();                  if (page_count != 2
put_page();                          || PageDirty())

Now I'm worried that 2 might see PageDirty *before* SetPageDirty in
1, and page_count *after* put_page in 1.

Or am I seeing things that aren't there?

Thanks,

-- 
SUSE Labs, Novell Inc.


--------------060001070704090905080907
Content-Type: text/plain;
 name="mm-reclaim-memorder-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-reclaim-memorder-fix.patch"

Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c
+++ linux-2.6/mm/vmscan.c
@@ -511,7 +511,12 @@ static int shrink_list(struct list_head 
 		 * PageDirty _after_ making sure that the page is freeable and
 		 * not in use by anybody. 	(pagecache + us == 2)
 		 */
-		if (page_count(page) != 2 || PageDirty(page)) {
+		if (page_count(page) != 2) {
+			write_unlock_irq(&mapping->tree_lock);
+			goto keep_locked;
+		}
+		smp_rmb();
+		if (PageDirty(page)) {
 			write_unlock_irq(&mapping->tree_lock);
 			goto keep_locked;
 		}

--------------060001070704090905080907--
Send instant messages to your online friends http://au.messenger.yahoo.com 
