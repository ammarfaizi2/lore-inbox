Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030533AbVKCXhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030533AbVKCXhX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030537AbVKCXhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:37:23 -0500
Received: from mail23.sea5.speakeasy.net ([69.17.117.25]:5514 "EHLO
	mail23.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1030533AbVKCXhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:37:22 -0500
Date: Thu, 3 Nov 2005 18:37:16 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Phillip Hellewell <phillip@hellewell.homeip.net>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mike@halcrow.us, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
Subject: Re: [PATCH 5/12: eCryptfs] Header declarations
In-Reply-To: <20051103035039.GE3005@sshock.rn.byu.edu>
Message-ID: <Pine.LNX.4.63.0511031833150.22256@excalibur.intercode>
References: <20051103033220.GD2772@sshock.rn.byu.edu> <20051103035039.GE3005@sshock.rn.byu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, Phillip Hellewell wrote:

> +struct ecryptfs_password {
> +	char password[ECRYPTFS_MAX_PASSWORD_LENGTH];
> +	int password_size;
> +	unsigned char salt[ECRYPTFS_SALT_SIZE];
> +	int saltless;		/* If set, this is the ``seed'' token from which
> +				 * other salted tokens are derived. Note that
> +				 * this is _not_ the same as a token that just
> +				 * has not received its salt yet. */
> +	int hash_algo;
> +	int hash_iterations;
> +	/* Iterated-hash concatenation of salt and passphrase */
> +	unsigned char session_key_encryption_key[ECRYPTFS_MAX_KEY_BYTES];
> +	int session_key_encryption_key_size;	/* In bytes */
> +	int session_key_encryption_key_set;
> +	/* Always in expanded hex */
> +	unsigned char signature[ECRYPTFS_PASSWORD_SIG_SIZE + 1];
> +};

Generally, you should put the smallest components of a data structure at 
the front, so the compiler can optimize alignment.

> +#define RECORDS_PER_PAGE(crypt_stats) (crypt_stats->extent_size / \
> +                                       (crypt_stats->iv_bytes))
> +#define PG_IDX_TO_LWR_PG_IDX(crypt_stats, idx) \
> +        ((idx / crypt_stats->records_per_page) + idx \
> +         + crypt_stats->num_header_pages + 1)
> +#define RECORD_IDX(crypt_stats, idx) (idx % crypt_stats->records_per_page)
> +#define RECORD_OFFSET(crypt_stats, idx) \
> +        (RECORD_IDX(crypt_stats, idx) * (crypt_stats->iv_bytes \
> +                                         + crypt_stats->hmac_bytes))
> +#define LAST_RECORDS_PAGE_IDX(crypt_stats, idx) \
> +        (PG_IDX_TO_LWR_PG_IDX(crypt_stats, idx) \
> +         - RECORD_IDX(crypt_stats,idx) - 1)

These should all be static inline (and any other similar).

> + */
> +#define FILE_TO_PRIVATE(file) ((struct ecryptfs_file_info *)((file)->private_data))
> +#define FILE_TO_PRIVATE_SM(file) ((file)->private_data)
> +#define FILE_TO_LOWER(file) ((FILE_TO_PRIVATE(file))->wfi_file)
> +#define INODE_TO_PRIVATE(ino) ((struct ecryptfs_inode_info *)(ino)->u.generic_ip)
> +#define INODE_TO_PRIVATE_SM(ino) ((ino)->u.generic_ip)
> +#define INODE_TO_LOWER(ino) (INODE_TO_PRIVATE(ino)->wii_inode)
> +#define SUPERBLOCK_TO_PRIVATE(super) ((struct ecryptfs_sb_info *)(super)->s_fs_info)
> +#define SUPERBLOCK_TO_PRIVATE_SM(super) ((super)->s_fs_info)
> +#define SUPERBLOCK_TO_LOWER(super) (SUPERBLOCK_TO_PRIVATE(super)->wsi_sb)
> +#define DENTRY_TO_PRIVATE_SM(dentry) ((dentry)->d_fsdata)
> +#define DENTRY_TO_PRIVATE(dentry) ((struct ecryptfs_dentry_info *)(dentry)->d_fsdata)
> +#define DENTRY_TO_LOWER(dentry) (DENTRY_TO_PRIVATE(dentry)->wdi_dentry)

These macro names are too generic.


- James
-- 
James Morris
<jmorris@namei.org>
