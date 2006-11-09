Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161441AbWKIBQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161441AbWKIBQV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 20:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161780AbWKIBQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 20:16:21 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:3501 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161441AbWKIBQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 20:16:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=ohb/0dn2wjJnoAV669U4hjIulCDeosTk9Wn5qpZlj7eWh2oXnME3CSnHDC0J4mGiOdW+9jEDfTE0b9/wvshTI7R79Xtcy/Lt8o54onhkiLKm43fHi43vuKXTZsWHTjQmaxVC95Hp4Jq3sq4thC/OlNgr+NNDnas/mRodqEOIggM=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/5] direct-io: fix page_errors handling
In-Reply-To: <11630349713427-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Thu, 9 Nov 2006 10:16:11 +0900
Message-Id: <1163034971471-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: zach.brown@oracle.com, pbadari@us.ibm.com, suparna@in.ibm.com,
       jmoyer@redhat.com, akpm@osdl.org, cwyang@aratech.co.kr,
       linux-kernel@vger.kernel.org, htejun@gmail.com
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a page error occurs during write request, dio_refill_page() sets
dio->page_errors, maps zero page instead and proceeds as usual if
mapped blocks exist to clear mapped blocks.  After clearing all
blocks, get_more_blocks() is called to map more blocks.  The function
fails if dio->page_errors is set thus propagating the delayed error
condition.

However, the delayed propagation doesn't work if page error occurs for
the last chunk.  get_more_blocks() is not called after clearing
currently mapped buffers; thus, the error condition is not reflected
in the return value.  dio->page_errors is later taken into account in
synchronous completion path but not in async completion path.

This bug can be exposed by direct aio writing a buffer which has the
tailing pages munmapped.  The file blocks corresponding to the
unmapped area are cleared to zero but the write successfully completes
with result set to full length of the request.

This patch fixes the bug by making do_direct_IO() always propagate
page_errors to its return value.  As this makes page_errors
propagation the responsibility of do_direct_IO() proper,
dio->page_errors handling in synchronous completion path is removed.

This patch also fixes error precedence bug in synchronous completion
path.  If both page_errors and io_error occur, page_errors should be
reported to user but the original code gave precedence to IO error
reported from dio_await_completion().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 fs/direct-io.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 5981e17..25721b2 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -940,6 +940,8 @@ next_block:
 		block_in_page = 0;
 	}
 out:
+	if (ret == 0)
+		ret = dio->page_errors;
 	return ret;
 }
 
@@ -1125,8 +1127,6 @@ direct_io_worker(int rw, struct kiocb *i
 		ret2 = dio_await_completion(dio);
 		if (ret == 0)
 			ret = ret2;
-		if (ret == 0)
-			ret = dio->page_errors;
 		if (dio->result) {
 			loff_t i_size = i_size_read(inode);
 
-- 
1.4.3.3


