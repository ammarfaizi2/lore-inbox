Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbWHAHST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbWHAHST (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 03:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbWHAHST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 03:18:19 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:21596 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932532AbWHAHSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 03:18:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=48Eq4kNOx0RDWKlsDLc50KKVRyVo0qQMQcicnaxecL12/rylVnNV030W6NKwIVM4jD5jKIe1xTX3Dh2jC9EPSjgah/DW1AxW/yph/BKBDcloqVYvpH54ElT31QQkTARg6g1ouGOyrt4lL+m77ZcVSMv5H6oKjpubtyb8MvoYGMQ=  ;
Message-ID: <44CF0036.9080701@yahoo.com.au>
Date: Tue, 01 Aug 2006 17:18:14 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Evgeniy Dushistov <dushistov@mail.ru>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH]: ufs: ufs_get_locked_patch race fix
References: <20060731125702.GA5094@rain> <20060731230251.3b149902.akpm@osdl.org>
In-Reply-To: <20060731230251.3b149902.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>On Mon, 31 Jul 2006 16:57:02 +0400
>Evgeniy Dushistov <dushistov@mail.ru> wrote:
>
>
>>As discussed earlier:
>>http://lkml.org/lkml/2006/6/28/136
>>this patch fixes such issue:
>>`ufs_get_locked_page' takes page from cache
>>after that `vmtruncate' takes page and deletes it from cache
>>`ufs_get_locked_page' locks page, and reports about EIO error.
>>
>>Also because of find_lock_page always return valid page or NULL,
>>we have no need check it if page not NULL.
>>
>>Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>
>>
>>
>>---
>>
>>
>>Index: linux-2.6.18-rc2-mm1/fs/ufs/util.c
>>===================================================================
>>--- linux-2.6.18-rc2-mm1.orig/fs/ufs/util.c
>>+++ linux-2.6.18-rc2-mm1/fs/ufs/util.c
>>@@ -257,6 +257,7 @@ try_again:
>> 		page = read_cache_page(mapping, index,
>> 				       (filler_t*)mapping->a_ops->readpage,
>> 				       NULL);
>>+
>> 		if (IS_ERR(page)) {
>> 			printk(KERN_ERR "ufs_change_blocknr: "
>> 			       "read_cache_page error: ino %lu, index: %lu\n",
>>@@ -266,6 +267,13 @@ try_again:
>> 
>> 		lock_page(page);
>> 
>>+		if (unlikely(page->mapping != mapping ||
>>+			     page->index != index)) {
>>+			unlock_page(page);
>>+			page_cache_release(page);
>>+			goto try_again;
>>+		}
>>+
>> 		if (!PageUptodate(page) || PageError(page)) {
>> 			unlock_page(page);
>> 			page_cache_release(page);
>>
>
>Looks good to me.
>
>Is there any need to be checking ->index?  Normally we simply use the
>sequence:
>
>	lock_page(page);
>	if (page->mapping == NULL)
>		/* truncate got there first */
>
>to handle this case.
>

If you already have a reference on the page, I believe no. We have to
be a bit careful about it in the core vm now that splice can move
pages between different parts of the same mapping, but any code outside
mm/ shouldn't need to worry (exactly because they should have a ref
before doing the lock_page).
--

Send instant messages to your online friends http://au.messenger.yahoo.com 
