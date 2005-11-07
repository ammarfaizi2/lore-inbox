Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbVKGNc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbVKGNc7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 08:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbVKGNc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 08:32:59 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:48473 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932482AbVKGNc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 08:32:58 -0500
Message-ID: <436F5994.2070703@sw.ru>
Date: Mon, 07 Nov 2005 16:41:40 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       ext3-users@redhat.com, sct@redhat.com, den@sw.ru
Subject: [PATCH] ext3: journal handling on error path in ext3_journalled_writepage()
Content-Type: multipart/mixed;
 boundary="------------050002030007030400050905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050002030007030400050905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Forwarded original patch from Denis Lunev:

This patch fixes lost referrence on ext3 current handle in
ext3_journalled_writepage()

Signed-Off-By: Denis Lunev <den@sw.ru>

P.S. against 2.6.14

--------------050002030007030400050905
Content-Type: text/plain;
 name="diff-ms-ext3handle-20051031"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ms-ext3handle-20051031"

--- ./fs/ext3/inode.c.msext3	2005-10-23 23:36:27.000000000 +0400
+++ ./fs/ext3/inode.c	2005-10-31 17:03:34.000000000 +0300
@@ -1375,8 +1375,11 @@ static int ext3_journalled_writepage(str
 		ClearPageChecked(page);
 		ret = block_prepare_write(page, 0, PAGE_CACHE_SIZE,
 					ext3_get_block);
-		if (ret != 0)
-			goto out_unlock;
+		if (ret != 0) {
+			ext3_journal_stop(handle);
+			unlock_page(page);
+			return ret;
+		}
 		ret = walk_page_buffers(handle, page_buffers(page), 0,
 			PAGE_CACHE_SIZE, NULL, do_journal_get_write_access);
 
@@ -1402,7 +1405,6 @@ out:
 
 no_write:
 	redirty_page_for_writepage(wbc, page);
-out_unlock:
 	unlock_page(page);
 	goto out;
 }



--------------050002030007030400050905--

