Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbVJONfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbVJONfF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 09:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbVJONfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 09:35:04 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:22975 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751147AbVJONfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 09:35:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=HzaiGwN3C81QpXnAKq8Fwoz8mEzR7WB0O30mF892UonSaAV/JNeybX+ltDyJDjpvgGTyCPvYSWpn+oeVB5rgZnbox9RN+ovYa2gGyC6U1yn8QhEI/oRMoPFzyNaECZ3G9FCHaVbMJoG/ssX5PlkSgXXl9GrdPuszG9oeyo/UyBY=  ;
Message-ID: <435105B6.4040507@yahoo.com.au>
Date: Sat, 15 Oct 2005 23:35:50 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050914 Debian/1.7.11-1
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: benh@kernel.crashing.org, hugh@veritas.com, paulus@samba.org,
       anton@samba.org, torvalds@osdl.org, akpm@osdl.org, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: Possible memory ordering bug in page reclaim?
References: <E1EQkpc-0007FI-00@gondolin.me.apana.org.au>
In-Reply-To: <E1EQkpc-0007FI-00@gondolin.me.apana.org.au>
Content-Type: multipart/mixed;
 boundary="------------090003050907010403050501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090003050907010403050501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Herbert Xu wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>Well yes, that's on the store side (1, above). However can't a CPU
>>still speculatively (eg. guess the branch) load the page->flags
>>cacheline which might be satisfied from memory before the page->count
>>cacheline loads? Ie. you can still have the correct write ordering
>>but have incorrect read ordering?
>>
>>Because neither PageDirty nor page_count is a barrier, and there is
>>no read barrier between them.
> 
> 
> Yes you're right.  A read barrier is required here.
> 
> I think Ben was actually agreeing with you.  He's just questioning
> whether the corresponding write barrier existed on CPU 1 (the answer
> to which is affirmative).
>  

Ah, that clears up my misunderstanding.

Yes I agree the write side is OK.

Thanks Ben and Herbert. I guess I should do a proper patch then.

-- 
SUSE Labs, Novell Inc.


--------------090003050907010403050501
Content-Type: text/plain;
 name="mm-reclaim-memorder-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-reclaim-memorder-fix.patch"

In mm/vmscan.c, the page reclaim may have the following sequence 2
running concurrently with sequence 1 on another CPU:

1                                2
find_get_page();
write to page                    write_lock(tree_lock);
SetPageDirty();                  if (page_count != 2
put_page();                              || PageDirty())
                                     /* page dirty or busy */
				 else
				     /* free it */

The comment indicates that PageDirty must be checked *after* page_count
indicates there are no users of this page, which prevents the dirty bit
from being lost in the case that that sequence 2 might see the state of
PageDirty() *before* SetPageDirty() in 1, but page_count *after* put_page
in 1.

However, there is no read memory barrier there, and so nothing to stop a
CPU from loading page_count before PageDirty (ie. ->flags). Theoretically,
data corruption is possible.

Signed-off-by: Nick Piggin <npiggin@suse.de>

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

--------------090003050907010403050501--
Send instant messages to your online friends http://au.messenger.yahoo.com 
