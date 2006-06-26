Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933286AbWFZXtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933286AbWFZXtW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933285AbWFZXtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:49:21 -0400
Received: from mail.sdi-munich.org ([62.245.203.250]:14841 "EHLO
	linux.sdi-muenchen.de") by vger.kernel.org with ESMTP
	id S933286AbWFZXtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 19:49:20 -0400
From: Stephan =?iso-8859-1?q?M=FCller?= <smueller@chronox.de>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 05/06] ecryptfs: Change the maximum size check when writing header
Date: Tue, 27 Jun 2006 01:49:14 +0200
User-Agent: KMail/1.9.1
Cc: Michael Halcrow <mhalcrow@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606270149.14230.smueller@chronox.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel version: 2.6.17-mm1

When generating an encrypted file, the first page contains the header 
information. ecryptfs allocates one page to be filled with the meta 
information. ecryptfs_write_headers_virt() writes the header into the 
page. The code in this function up to the call of 
ecryptfs_generate_key_packet_set() already writes some bytes into the page 
and moves the pointer forward accordingly.

This patch now tells ecryptfs_generate_key_packet_set() exactly how many 
bytes it is allowed to write. Prior to that, the function would allow 
PAGE_MAX_SIZE to be written which is longer than the allocated space 
(remember, some bytes are already filled).

This problem does not really materialize in the current code as 
ecryptfs_generate_key_packet_set() only writes a Tag 3 and Tag 11 with 
less than 100 bytes. But this fix ensures that when development continues, 
nobody stumbles over the problem without being warned.

Signed-off-by: Stephan Mueller <smueller@chronox.de>

---

 fs/ecryptfs/crypto.c          |    3 ++-
 fs/ecryptfs/ecryptfs_kernel.h |    3 ++-
 fs/ecryptfs/keystore.c        |   15 +++++++++++----
 3 files changed, 15 insertions(+), 6 deletions(-)

eb9ccb4c29456d611de189ae4ca95ad9111df751
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 91b350e..02e4600 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1224,7 +1224,8 @@ int ecryptfs_write_headers_virt(char *pa
 	write_header_metadata((page_virt + offset), crypt_stat, &written);
 	offset += written;
 	rc = ecryptfs_generate_key_packet_set((page_virt + offset), crypt_stat,
-					      ecryptfs_dentry, &written);
+					      ecryptfs_dentry, &written,
+					      PAGE_CACHE_SIZE - offset);
 	if (rc)
 		ecryptfs_printk(KERN_WARNING, "Error generating key packet "
 				"set; rc = [%d]\n", rc);
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index c37a452..4ce23f5 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -466,7 +466,8 @@ int ecryptfs_cipher_code_to_string(char 
 void ecryptfs_set_default_sizes(struct ecryptfs_crypt_stat *crypt_stat);
 int ecryptfs_generate_key_packet_set(char *dest_base,
 				     struct ecryptfs_crypt_stat *crypt_stat,
-				     struct dentry *ecryptfs_dentry, int *len);
+				     struct dentry *ecryptfs_dentry, int *len,
+				     int max);
 int process_request_key_err(long err_code);
 int
 ecryptfs_parse_packet_set(struct ecryptfs_crypt_stat *crypt_stat,
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 4b9b742..a91b8b4 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -983,6 +983,7 @@ out:
  * @ecryptfs_dentry: The dentry, used to retrieve the mount crypt stat
  *                   for the global parameters
  * @len: The amount written
+ * @max: The maximum amount of data allowed to be written
  *
  * Generates a key packet set and writes it to the virtual address
  * passed in.
@@ -992,7 +993,8 @@ out:
 int
 ecryptfs_generate_key_packet_set(char *dest_base,
 				 struct ecryptfs_crypt_stat *crypt_stat,
-				 struct dentry *ecryptfs_dentry, int *len)
+				 struct dentry *ecryptfs_dentry, int *len,
+				 int max)
 {
 	int rc = 0;
 	struct ecryptfs_auth_tok *auth_tok;
@@ -1007,7 +1009,7 @@ ecryptfs_generate_key_packet_set(char *d
 		auth_tok = mount_crypt_stat->global_auth_tok;
 		if (ECRYPTFS_CHECK_FLAG(auth_tok->flags, ECRYPTFS_PASSWORD)) {
 			rc = write_tag_3_packet((dest_base + (*len)),
-						PAGE_CACHE_SIZE, auth_tok,
+						max, auth_tok,
 						crypt_stat, &key_rec,
 						&written);
 			if (rc) {
@@ -1019,7 +1021,7 @@ ecryptfs_generate_key_packet_set(char *d
 			/* Write auth tok signature packet */
 			rc = write_tag_11_packet(
 				(dest_base + (*len)),
-				(PAGE_CACHE_SIZE - (*len)),
+				(max - (*len)),
 				key_rec.sig, ECRYPTFS_SIG_SIZE, &written);
 			if (rc) {
 				ecryptfs_printk(KERN_ERR, "Error writing "
@@ -1043,7 +1045,12 @@ ecryptfs_generate_key_packet_set(char *d
 		}
 	} else
 		BUG();
-	dest_base[(*len)] = 0x00;
+	if (likely((max - (*len)) > 0)) {
+		dest_base[(*len)] = 0x00;
+	} else {
+		ecryptfs_printk(KERN_ERR, "Error writing boundary byte\n");
+		rc = -EIO;
+	}
 out:
 	if (rc)
 		(*len) = 0;
