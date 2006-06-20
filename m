Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWFTVX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWFTVX7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWFTVXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:23:51 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:32943 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751136AbWFTVXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:23:46 -0400
In-reply-to: <20060620212134.GB18701@us.ibm.com>
From: Mike Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Mike Halcrow <mhalcrow@us.ibm.com>, Mike Halcrow <mike@halcrow.us>
Subject: [PATCH 6/12] Add ecryptfs_ prefix to mount options; key size parameter
Message-Id: <E1FsnhD-00079L-Tj@localhost.localdomain>
Date: Tue, 20 Jun 2006 16:23:39 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add ecryptfs_ prefix to ecryptfs-specific mount options to avoid
conflicts from changes to /bin/mount. Debian's addition of ``keybits''
in its mount program left us scratching our heads when we happened to
pick the exact same parameter name at first for this patch. This patch
includes an aptly-named parameter to set the number of key bytes.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/ecryptfs_kernel.h |    1 +
 fs/ecryptfs/main.c            |   36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletions(-)

5488f5ad764088bb99ba1980d9967da3aeb2ff12
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 1fd6039..4dc95af 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -220,6 +220,7 @@ struct ecryptfs_mount_crypt_stat {
 	/* Pointers to memory we do not own, do not free these */
 	struct ecryptfs_auth_tok *global_auth_tok;
 	struct key *global_auth_tok_key;
+	unsigned int global_default_cipher_key_bits;
 	unsigned char global_default_cipher_name[ECRYPTFS_MAX_CIPHER_NAME_SIZE
 						 + 1];
 	unsigned char global_auth_tok_sig[ECRYPTFS_SIG_SIZE_HEX + 1];
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 5cbc948..57bbce7 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -125,13 +125,19 @@ out:
 	return rc;
 }
 
-enum { ecryptfs_opt_sig, ecryptfs_opt_debug, ecryptfs_opt_cipher,
+enum { ecryptfs_opt_sig, ecryptfs_opt_ecryptfs_sig, ecryptfs_opt_debug,
+       ecryptfs_opt_ecryptfs_debug, ecryptfs_opt_cipher,
+       ecryptfs_opt_ecryptfs_cipher, ecryptfs_opt_ecryptfs_key_bytes,
        ecryptfs_opt_err };
 
 static match_table_t tokens = {
 	{ecryptfs_opt_sig, "sig=%s"},
+	{ecryptfs_opt_ecryptfs_sig, "ecryptfs_sig=%s"},
 	{ecryptfs_opt_debug, "debug=%u"},
+	{ecryptfs_opt_ecryptfs_debug, "ecryptfs_debug=%u"},
 	{ecryptfs_opt_cipher, "cipher=%s"},
+	{ecryptfs_opt_ecryptfs_cipher, "ecryptfs_cipher=%s"},
+	{ecryptfs_opt_ecryptfs_key_bytes, "ecryptfs_key_bytes=%u"},
 	{ecryptfs_opt_err, NULL}
 };
 
@@ -192,6 +198,8 @@ static int ecryptfs_parse_options(struct
 	int rc = 0;
 	int sig_set = 0;
 	int cipher_name_set = 0;
+	int cipher_key_bytes;
+	int cipher_key_bytes_set = 0;
 	struct key *auth_tok_key = NULL;
 	struct ecryptfs_auth_tok *auth_tok = NULL;
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat =
@@ -203,6 +211,7 @@ static int ecryptfs_parse_options(struct
 	char *debug_src;
 	char *cipher_name_dst;
 	char *cipher_name_src;
+	char *cipher_key_bytes_src;
 	int cipher_name_len;
 
 	if (!options) {
@@ -215,6 +224,7 @@ static int ecryptfs_parse_options(struct
 		token = match_token(p, tokens, args);
 		switch (token) {
 		case ecryptfs_opt_sig:
+		case ecryptfs_opt_ecryptfs_sig:
 			sig_src = args[0].from;
 			sig_dst =
 				mount_crypt_stat->global_auth_tok_sig;
@@ -227,6 +237,7 @@ static int ecryptfs_parse_options(struct
 			sig_set = 1;
 			break;
 		case ecryptfs_opt_debug:
+		case ecryptfs_opt_ecryptfs_debug:
 			debug_src = args[0].from;
 			ecryptfs_verbosity =
 				(int)simple_strtol(debug_src, &debug_src,
@@ -236,6 +247,7 @@ static int ecryptfs_parse_options(struct
 					ecryptfs_verbosity);
 			break;
 		case ecryptfs_opt_cipher:
+		case ecryptfs_opt_ecryptfs_cipher:
 			cipher_name_src = args[0].from;
 			cipher_name_dst =
 				mount_crypt_stat->
@@ -248,6 +260,20 @@ static int ecryptfs_parse_options(struct
 					"[%s]\n", cipher_name_dst);
 			cipher_name_set = 1;
 			break;
+		case ecryptfs_opt_ecryptfs_key_bytes:
+			cipher_key_bytes_src = args[0].from;
+			cipher_key_bytes =
+				(int)simple_strtol(cipher_key_bytes_src,
+						   &cipher_key_bytes_src, 0);
+			mount_crypt_stat->global_default_cipher_key_bits =
+				cipher_key_bytes << 3;
+			ecryptfs_printk(KERN_DEBUG,
+					"The mount_crypt_stat "
+					"global_default_cipher_key_bits "
+					"set to: [%d]\n", mount_crypt_stat->
+					global_default_cipher_key_bits);
+			cipher_key_bytes_set = 1;
+			break;
 		case ecryptfs_opt_err:
 		default:
 			ecryptfs_printk(KERN_WARNING,
@@ -277,6 +303,14 @@ static int ecryptfs_parse_options(struct
 		mount_crypt_stat->global_default_cipher_name[cipher_name_len]
 		    = '\0';
 	}
+	if (!cipher_key_bytes_set) {
+		mount_crypt_stat->global_default_cipher_key_bits =
+				ECRYPTFS_DEFAULT_KEY_BYTES << 3;
+		ecryptfs_printk(KERN_DEBUG, "Cipher key bits were not "
+				"specified.  Defaulting to [%d]\n",
+				mount_crypt_stat->
+				global_default_cipher_key_bits);
+	}
 	ecryptfs_printk(KERN_DEBUG, "Requesting the key with description: "
 			"[%s]\n", mount_crypt_stat->global_auth_tok_sig);
 	/* The reference to this key is held until umount is done The
-- 
1.3.3

