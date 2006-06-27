Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161148AbWF0QP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161148AbWF0QP0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161149AbWF0QP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:15:26 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:23705 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161148AbWF0QPZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:15:25 -0400
Date: Tue, 27 Jun 2006 11:15:06 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Stephan M?ller <smueller@chronox.de>
Subject: Re: [PATCH 03/06] ecryptfs: Validate packet length prior to parsing, add comments
Message-ID: <20060627161505.GC2795@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <200606270147.42167.smueller@chronox.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606270147.42167.smueller@chronox.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 01:47:41AM +0200, Stephan M?ller wrote:
> @@ -180,19 +180,27 @@ parse_tag_3_packet(struct ecryptfs_crypt
>  	struct ecryptfs_auth_tok_list_item *auth_tok_list_item;
>  	int length_size;
>  
> +	/* we check that:
> +	 *   one byte for the Tag 3 ID flag
> +	 *   two bytes for the body size
> +	 * do not exceed the maximum_packet_size
> +	 */
> +	if (unlikely((*packet_size) + 3 > max_packet_size)) {
> +		ecryptfs_printk(KERN_ERR, "Packet size exceeds max\n");
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
>  	(*packet_size) = 0;

We need this fix on top of this patch.

---

Set the packet size to 0 prior to any parse calls.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/keystore.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

ae120bff8aba7b5368107f668fffb5279379fba0
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index a91b8b4..791fb3b 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -191,7 +191,6 @@ parse_tag_3_packet(struct ecryptfs_crypt
 		goto out;
 	}
 
-	(*packet_size) = 0;
 	(*new_auth_tok) = NULL;
 
 	/* check for Tag 3 identifyer - one byte */
@@ -585,7 +584,7 @@ int ecryptfs_parse_packet_set(struct ecr
 		&ecryptfs_superblock_to_private(
 			ecryptfs_dentry->d_sb)->mount_crypt_stat;
 	struct ecryptfs_auth_tok *candidate_auth_tok = NULL;
-	int packet_size;
+	int packet_size = 0;
 	struct ecryptfs_auth_tok *new_auth_tok;
 	unsigned char sig_tmp_space[ECRYPTFS_SIG_SIZE];
 	int tag_11_contents_size;
-- 
1.3.3

