Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267202AbUBMVau (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 16:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267197AbUBMVau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 16:30:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:3822 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267240AbUBMVag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 16:30:36 -0500
Subject: [PATCH 2.6.3-rc2-mm1] __block_write_full patch
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040212015710.3b0dee67.akpm@osdl.org>
References: <20040212015710.3b0dee67.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-vQPS3DX6BdI5JDzw8WLH"
Organization: 
Message-Id: <1076707830.1956.46.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Feb 2004 13:30:30 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vQPS3DX6BdI5JDzw8WLH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

Here is my original __block_write_full_page patch which adds
a wait_on_buffer() to catch the case where i/o might be in flight
from ll_rw_block().

I know that it waits for i/o even the non-blocking writebacks, but
it does make sure filemap_write_and_wait() and  filemap_fdatawrite /
filemap_fdatawait() do wait for all i/o that has been submitted to
complete. (This similar to 2.4 which always does a lock_buffer()).
The direct_read_under test does not see uninitialized data with
this patch.  Without this patch 2.6.3-rc2-mm1 still sees uninitialized
data.

I am worried that the current behavior where PageWriteback can be
cleared with i/o still in flight for a buffer on that page could cause
other problems.

I am still trying to figure out how to fix this some other way,
but, in the mean time, this makes sure the code is correct.

Thoughts?

re-diff against 2.6.3-rc2-mm1.

Daniel

On Thu, 2004-02-12 at 01:57, Andrew Morton wrote:

> 
> O_DIRECT-ll_rw_block-vs-block_write_full_page-fix.patch
>   Fix race between ll_rw_block() and block_write_full_page()
> 


--=-vQPS3DX6BdI5JDzw8WLH
Content-Disposition: attachment; filename=__block_write_full.2.6.3-rc2-mm1.patch
Content-Type: text/plain; name=__block_write_full.2.6.3-rc2-mm1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.3-rc2-mm1.orig/fs/buffer.c	2004-02-12 11:43:39.000000000 -0800
+++ linux-2.6.3-rc2-mm1/fs/buffer.c	2004-02-12 11:42:56.000000000 -0800
@@ -1810,6 +1810,7 @@ static int __block_write_full_page(struc
 
 	do {
 		get_bh(bh);
+		wait_on_buffer(bh);	/* i/o might be in flight */
 		if (!buffer_mapped(bh))
 			continue;
 		if (wbc->sync_mode != WB_SYNC_NONE) {

--=-vQPS3DX6BdI5JDzw8WLH--

