Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935728AbWK1QVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935728AbWK1QVT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 11:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935729AbWK1QVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 11:21:19 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:11949 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S935728AbWK1QVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 11:21:18 -0500
Message-ID: <456C63FB.40604@openvz.org>
Date: Tue, 28 Nov 2006 19:29:47 +0300
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, sct@redhat.com,
       linux-kernel@vger.kernel.org, saw@sw.ru, adilger@clusterfs.com,
       devel@openvz.org
Subject: [PATCH] ext3: small fix for previous retries patch in ext3_prepare_write()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch from Dmitry Monakhov:
Previous fix for retries in ext3_prepare_write() violation
was a bit errorneuos:
- it missed return of error code from ext3_journal_stop()
- it missed do_journal_get_write_access() before commit_write

a few comments added also.

Signed-Off-By: Dmitry Monakhov <dmonakhov@openvz.org>
Signed-Off-By: Kirill Korotaev <dev@openvz.org>


diff --git a/fs/ext3/inode.c b/fs/ext3/inode.c
index a48ada9..1acb528 100644
--- a/fs/ext3/inode.c
+++ b/fs/ext3/inode.c
@@ -1162,13 +1162,14 @@ static int ext3_prepare_failure(struct f
 	struct buffer_head *bh, *head, *next;
 	unsigned block_start, block_end;
 	unsigned blocksize;
+	int ret;
+	handle_t *handle = ext3_journal_current_handle();
 
 	mapping = page->mapping;
 	if (ext3_should_writeback_data(mapping->host)) {
 		/* optimization: no constraints about data */
 skip:
-		ext3_journal_stop(ext3_journal_current_handle());
-		return 0;
+		return ext3_journal_stop(handle);
 	}
 
 	head = page_buffers(page);
@@ -1186,7 +1187,19 @@ skip:
 			break;
 		}
 		if (!buffer_mapped(bh))
+		/* prepare_write failed on this bh */
 			break;
+		if (ext3_should_journal_data(mapping->host)) {
+			ret = do_journal_get_write_access(handle, bh);
+			if (ret) {
+				ext3_journal_stop(handle);
+				return ret;
+			}
+		}
+	/*
+	 * block_start here becomes the first block where the current iteration
+	 * of prepare_write failed.
+	 */
 	}
 	if (block_start <= from)
 		goto skip;
