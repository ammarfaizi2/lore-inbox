Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbTDHIw5 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 04:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbTDHIw5 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 04:52:57 -0400
Received: from [12.47.58.221] ([12.47.58.221]:44672 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262662AbTDHIw4 (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 04:52:56 -0400
Date: Tue, 8 Apr 2003 02:04:39 -0700
From: Andrew Morton <akpm@digeo.com>
To: "dada1" <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG linux-2.5.67
Message-Id: <20030408020439.16c8322b.akpm@digeo.com>
In-Reply-To: <035401c2fdac$6e6aa400$5600a8c0@edumazet>
References: <Pine.LNX.4.44.0304071051190.1385-100000@penguin.transmeta.com>
	<035401c2fdac$6e6aa400$5600a8c0@edumazet>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Apr 2003 09:04:26.0380 (UTC) FILETIME=[DAEB04C0:01C2FDAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"dada1" <dada1@cosmosbay.com> wrote:
>
> Hello
> 
> I tried linux-2.5.67 this morning...
> 
> instant oops with a small multi-threaded program using futex()

Was the futex placed inside a hugetlb page?  Please say yes.

There is a stunning bug.

--- 25/include/linux/mm.h~a	2003-04-08 02:03:19.000000000 -0700
+++ 25-akpm/include/linux/mm.h	2003-04-08 02:03:24.000000000 -0700
@@ -231,8 +231,8 @@ static inline void get_page(struct page 
 static inline void put_page(struct page *page)
 {
 	if (PageCompound(page)) {
+		page = (struct page *)page->lru.next;
 		if (put_page_testzero(page)) {
-			page = (struct page *)page->lru.next;
 			if (page->lru.prev) {	/* destructor? */
 				(*(void (*)(struct page *))page->lru.prev)(page);
 			} else {

_

