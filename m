Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbVD0BC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVD0BC4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 21:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbVD0BC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 21:02:56 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:54185 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261873AbVD0BCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 21:02:52 -0400
Message-ID: <426EE4B5.8040909@yahoo.com.au>
Date: Wed, 27 Apr 2005 11:02:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] __block_write_full_page bug
References: <426C6A63.80408@yahoo.com.au> <20050426045039.702d9075.akpm@osdl.org>
In-Reply-To: <20050426045039.702d9075.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------030308040805020208060100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030308040805020208060100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

> Those tests for buffer_async_write(bh) are redundant now, aren't they?
> 

Like this?

-- 
SUSE Labs, Novell Inc.

--------------030308040805020208060100
Content-Type: text/plain;
 name="__block_write_full_page-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="__block_write_full_page-cleanup.patch"

Previous patch made buffer_async_write tests superfluous.
As suggested by Andrew Morton.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c	2005-04-25 13:14:52.000000000 +1000
+++ linux-2.6/fs/buffer.c	2005-04-27 11:00:01.000000000 +1000
@@ -1843,8 +1843,8 @@ static int __block_write_full_page(struc
 
 	for (nr_underway = 0; nr_underway < idx; nr_underway++) {
 		bh = arr[nr_underway];
-		if (buffer_async_write(bh))
-			submit_bh(WRITE, bh);
+		BUG_ON(!buffer_async_write(bh));
+		submit_bh(WRITE, bh);
 		put_bh(bh);
 	}
 
@@ -1904,10 +1904,9 @@ recover:
 	unlock_page(page);
 	for (nr_underway = 0; nr_underway < idx; nr_underway++) {
 		bh = arr[nr_underway];
-		if (buffer_async_write(bh)) {
-			clear_buffer_dirty(bh);
-			submit_bh(WRITE, bh);
-		}
+		BUG_ON(!buffer_async_write(bh));
+		clear_buffer_dirty(bh);
+		submit_bh(WRITE, bh);
 		put_bh(bh);
 	}
 	goto done;

--------------030308040805020208060100--

