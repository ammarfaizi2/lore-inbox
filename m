Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWFUOuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWFUOuA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWFUOuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:50:00 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:34203 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750972AbWFUOt7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:49:59 -0400
Subject: Re: [PATCH 2/12] Support for larger maximum key size
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
To: Mike Halcrow <mhalcrow@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, Mike Halcrow <mike@halcrow.us>
In-Reply-To: <E1FsngZ-00078k-Jc@localhost.localdomain>
References: <E1FsngZ-00078k-Jc@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 09:49:57 -0500
Message-Id: <1150901397.24002.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

> @@ -806,24 +815,18 @@ write_tag_3_packet(char *dest, int max, 
>  			  ECRYPTFS_SIG_SIZE);
>  	(*key_rec).enc_key_size_bits = crypt_stat->key_size_bits;
>  	encrypted_session_key_valid = 0;
> -	if (auth_tok->session_key.encrypted_key_size == 0)
> -		auth_tok->session_key.encrypted_key_size =
> -		    ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES;
> -	for (i = 0; i < auth_tok->session_key.encrypted_key_size; i++)
> +	for (i = 0; i < (crypt_stat->key_size_bits / 8); i++)

Hey Mike,

Why don't you just do this particular calculation once?  Just looking
down, you do this same calculation at least 4 other potential times.

int key_size_bytes = crypt_stat->key_size_bits / 8;
for (i = 0; i < key_size_bytes; i++)

-tim

>  		encrypted_session_key_valid |=
>  		    auth_tok->session_key.encrypted_key[i];
> -	if (auth_tok->session_key.encrypted_key_size == 0) {
> -		ecryptfs_printk(KERN_WARNING, "auth_tok->session_key."
> -				"encrypted_key_size == 0");
> -		auth_tok->session_key.encrypted_key_size =
> -		    ECRYPTFS_DEFAULT_KEY_BYTES;
> -	}
>  	if (encrypted_session_key_valid) {
>  		memcpy((*key_rec).enc_key,
>  		       auth_tok->session_key.encrypted_key,
>  		       auth_tok->session_key.encrypted_key_size);
>  		goto encrypted_session_key_set;
>  	}
> +	if (auth_tok->session_key.encrypted_key_size == 0)
> +		auth_tok->session_key.encrypted_key_size =
> +			(crypt_stat->key_size_bits / 8);
>  	if (ECRYPTFS_CHECK_FLAG(auth_tok->token.password.flags,
>  				ECRYPTFS_SESSION_KEY_ENCRYPTION_KEY_SET)) {
>  		ecryptfs_printk(KERN_DEBUG, "Using previously generated "
> @@ -832,8 +835,7 @@ write_tag_3_packet(char *dest, int max, 
>  				session_key_encryption_key_bytes);
>  		memcpy(session_key_encryption_key,
>  		       auth_tok->token.password.session_key_encryption_key,
> -		       auth_tok->token.password.
> -		       session_key_encryption_key_bytes);
> +		       (crypt_stat->key_size_bits / 8));
>  		ecryptfs_printk(KERN_DEBUG,
>  				"Cached session key " "encryption key: \n");
>  		if (ecryptfs_verbosity > 0)
> @@ -870,7 +872,7 @@ write_tag_3_packet(char *dest, int max, 
>  		goto out;
>  	}
>  	rc = crypto_cipher_setkey(tfm, session_key_encryption_key,
> -				  ECRYPTFS_DEFAULT_KEY_BYTES);
> +				  (crypt_stat->key_size_bits / 8));
>  	if (rc < 0) {
>  		ecryptfs_printk(KERN_ERR, "Error setting key for crypto "
>  				"context\n");
> @@ -880,7 +882,7 @@ write_tag_3_packet(char *dest, int max, 
>  	ecryptfs_printk(KERN_DEBUG, "Encrypting [%d] bytes of the key\n",
>  			crypt_stat->key_size_bits / 8);
>  	crypto_cipher_encrypt(tfm, dest_sg, src_sg,
> -			      crypt_stat->key_size_bits / 8);
> +			      (crypt_stat->key_size_bits / 8));
>  	ecryptfs_printk(KERN_DEBUG, "This should be the encrypted key:\n");
>  	if (ecryptfs_verbosity > 0)
>  		ecryptfs_dump_hex((*key_rec).enc_key,
> @@ -889,7 +891,7 @@ encrypted_session_key_set:
>  	/* Now we have a valid key_rec.  Append it to the
>  	 * key_rec set. */
>  	key_rec_size = (sizeof(struct ecryptfs_key_record)
> -			- ECRYPTFS_MAX_KEY_BYTES
> +			- ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES
>  			+ ((*key_rec).enc_key_size_bits / 8) );
>  	/* TODO: Include a packet size limit as a parameter to this
>  	 * function once we have multi-packet headers (for versions

