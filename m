Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWGARaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWGARaK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 13:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932848AbWGARaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 13:30:10 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:36702 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932395AbWGARaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 13:30:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=xpNzfdrfcgqPctr0O+sn/dKOAeOirIiSBlRpaq1IMGXRqA9ZvFpG/FqlRRnzmFh0RiI0OkPjf2HVH90vL2dC5fAByXjNdBtDNCBpoDWQC0SoylU6ha71XoCuJGrJBSLuUJEX6CR0W2UPXu5XxJp8XRgEPiZaEnqR0rLAw+AUM0s=  ;
Message-ID: <44A6B11B.9080204@yahoo.com.au>
Date: Sun, 02 Jul 2006 03:30:03 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: Eeek! page_mapcount(page) went negative! (-1)
References: <44A6AB99.8060407@gentoo.org>
In-Reply-To: <44A6AB99.8060407@gentoo.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> A user at http://bugs.gentoo.org/138366 reported a one-off crash on x86 
> with 2.6.16.19. Here's hoping it might be useful to somebody:
> 
> Eeek! page_mapcount(page) went negative! (-1)
>   page->flags = 8001003c

They are PG_s referenced|uptodate|dirty|lru|mappedtodisk

So it is a regular pagecache page. Even though X is involved,
I'd be surprised if there is a kernel bug there, but it does
look like more than a simple single-bit flip.


>   page->count = 1
>   page->mapping = f6ad2418

If it is a pagecache page, page->mapping != NULL should add 1
to page->count. Then there should be another reference taken
for this mapping, and not decremented until after page_remove_rmap.

So both page_mapcount is wrong (was 0, should be at least 1) and
either page_count is wrong (was 1, should be at least 2).

If the page was truncated, dirty, mappedtodisk, and ->mapping
should have been cleared AFAIKS.

Oh. I see Arjan's pointed out it is using the nvidia driver (how
did he figure that out?). That couldn't be helping. If the
reporter can reproduce without any binary modules loaded, and
after surviving memtest overnight, it would be very interesting.

Thanks

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
