Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWFTVXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWFTVXu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWFTVXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:23:49 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:63152 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751133AbWFTVXY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:23:24 -0400
In-reply-to: <20060620212134.GB18701@us.ibm.com>
From: Mike Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Mike Halcrow <mhalcrow@us.ibm.com>, Mike Halcrow <mike@halcrow.us>
Subject: [PATCH 4/12] Unencrypted key size based on encrypted key size
Message-Id: <E1Fsngt-000793-Rs@localhost.localdomain>
Date: Tue, 20 Jun 2006 16:23:19 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set the unencrypted key size based on the encrypted key size. Code to
handle the special case of AES-192; since the encrypted key size must
be a multiple of the cipher block size, we have 32 bytes of encrypted
key data, and we only take the first 24 bytes of the decrypted key
data.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/keystore.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

de5316936897d0a932f5bf15f5dfb1325db39fc0
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index a83914c..253901a 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -247,15 +247,12 @@ parse_tag_3_packet(struct ecryptfs_crypt
 	/* A little extra work to differentiate among the AES key
 	 * sizes; see RFC2440 */
 	switch(data[(*packet_size)++]) {
-	case 0x07:
-		crypt_stat->key_size_bits = 128;
-		break;
 	case 0x08:
 		crypt_stat->key_size_bits = 192;
 		break;
-	case 0x09:
-		crypt_stat->key_size_bits = 256;
-		break;
+	default:
+		crypt_stat->key_size_bits =
+			(*new_auth_tok)->session_key.encrypted_key_size << 3;
 	}
 	if (unlikely((*packet_size) > max_packet_size)) {
 		ecryptfs_printk(KERN_ERR, "Packet size exceeds max\n");
-- 
1.3.3

