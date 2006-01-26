Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWAZTuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWAZTuT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWAZTuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:50:19 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:33706 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751385AbWAZTuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:50:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=B+mbuY8G0YzAcs2+eH3/k49iDt4I9d6YKBG76sLxrExmraRFmcnZfuuOO2mgQruaOoxM3qvSnd+iW5lx3yGVMLzzOClCu4lbmMiIJvXMU7XDrb50PH34BLTJgevHvZNrBIkT2p1XkRYtdXpNYFLgQKzHXopfa9KCEhSZzAHM35M=  ;
Message-ID: <43D927F6.9080807@yahoo.com.au>
Date: Fri, 27 Jan 2006 06:50:14 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm3
References: <20060124232406.50abccd1.akpm@osdl.org>	 <6bffcb0e0601250340x6ca48af0w@mail.gmail.com>	 <43D7A047.3070004@yahoo.com.au> <6bffcb0e0601261102j7e0a5d5av@mail.gmail.com> <43D92754.4090007@yahoo.com.au>
In-Reply-To: <43D92754.4090007@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------040404090104000801030407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040404090104000801030407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:

> Thanks, it confirms my suspicions.
> 
> Can you try the following patch, please?
> It appears the warnings were brought out by my improvement to
> the put_page_testzero debugging code (which previously did not
> check that we might be attempting to free a constituent compound
> page).
> 
> Can you test the following patch please?
> 

Sorry, wrong patch.

Note the warnings you are seeing should not result in memory
corruption, but will result in the given hugepage leaking.

-- 
SUSE Labs, Novell Inc.

--------------040404090104000801030407
Content-Type: text/plain;
 name="mm-fix-release.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-fix-release.patch"

Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -294,6 +294,8 @@ struct page {
  */
 static inline int put_page_testzero(struct page *page)
 {
+	if (unlikely(PageCompound(page)))
+		page = (struct page *)page_private(page);
 	BUG_ON(atomic_read(&page->_count) == 0);
 	return atomic_dec_and_test(&page->_count);
 }

--------------040404090104000801030407--
Send instant messages to your online friends http://au.messenger.yahoo.com 
