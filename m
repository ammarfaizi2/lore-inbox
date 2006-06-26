Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWFZQvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWFZQvs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWFZQvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:51:48 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:40838 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750818AbWFZQvj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:51:39 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 2/2] [Suspend2] Make cryptoapi deflate module handle full pages.
Date: Tue, 27 Jun 2006 02:51:42 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626165141.10864.27861.stgit@nigel.suspend2.net>
In-Reply-To: <20060626165135.10864.53686.stgit@nigel.suspend2.net>
References: <20060626165135.10864.53686.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The cryptoapi deflate module currently returns an error when it
successfully handles a full page of data at the end of a compressed stream.
This patch addresses that behaviour.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 crypto/deflate.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/crypto/deflate.c b/crypto/deflate.c
index f209368..2a38593 100644
--- a/crypto/deflate.c
+++ b/crypto/deflate.c
@@ -142,8 +142,15 @@ static int deflate_compress(void *ctx, c
 
 	ret = zlib_deflate(stream, Z_FINISH);
 	if (ret != Z_STREAM_END) {
-		ret = -EINVAL;
-		goto out;
+	    	if (!(ret == Z_OK && !stream->avail_in && !stream->avail_out)) {
+			ret = -EINVAL;
+			goto out;
+		} else {
+			u8 zerostuff = 0;
+			stream->next_out = &zerostuff;
+			stream->avail_out = 1; 
+			ret = zlib_deflate(stream, Z_FINISH);
+		}
 	}
 	ret = 0;
 	*dlen = stream->total_out;

--
Nigel Cunningham		nigel at suspend2 dot net
