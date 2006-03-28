Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWC1Ni7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWC1Ni7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 08:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWC1Ni7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 08:38:59 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:25987 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S932179AbWC1Ni5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 08:38:57 -0500
Subject: Re: [PATCH] split security_key_alloc into two functions
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: James Morris <jmorris@namei.org>, lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org,
       David Howells <dhowells@redhat.com>
In-Reply-To: <20060328130533.GB19243@sergelap.austin.ibm.com>
References: <20060328130533.GB19243@sergelap.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 28 Mar 2006 08:43:26 -0500
Message-Id: <1143553407.3037.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 07:05 -0600, Serge E. Hallyn wrote:
> The security_key_alloc() function acted as both an authorizer and
> security structure allocation function.  These roles should be
> separated.  There are two reasons for this.
> 
> First, if two modules are stacked, the first module might grant
> permission and allocate security data, after which the second
> module refuses permission.
> 
> Second, by adding a security_post_alloc() function after the
> serial number has been assigned, security modules can append
> useful info.

Are you sure that the key cannot be accessed (looked up) by another
process as soon as it is assigned a serial number?  If it can be, then
you risk having it accessed before its security structure is set up.

> Note that currently there is no LSM using these hooks, so the
> question of whether an LSM needs to recored the serial number
> can't really be answered.
> 
> An alternative to this patch, supported by the historical approach
> to LSM hooks, would be to remove all these hooks.  However as
> the keystore starts being used - in particular by, eg, ecryptfs -
> one might expect LSMs to be more interested in key activity.

We are interested in using these hooks for SELinux, as we need complete
mediation for MAC.  But we aren't yet clear on the precise usage model,
so we don't have a well-defined set of controls just yet.

> 
> :100644 100644 aaa0a5c... 3d8602e... M	include/linux/security.h
> :100644 100644 fd99429... 1eff777... M	security/dummy.c
> :100644 100644 a057e33... 6be6269... M	security/keys/key.c
> 
> Signed-off-by: Serge Hallyn <serue@us.ibm.com>
> 
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -844,10 +844,14 @@ struct swap_info_struct;
>   * Security hooks affecting all Key Management operations
>   *
>   * @key_alloc:
> - *	Permit allocation of a key and assign security data. Note that key does
> - *	not have a serial number assigned at this point.
> + *	Check permission to allocate a key and assign security data. Note
> + *	that key does not have a serial number assigned at this point.
>   *	@key points to the key.
>   *	Return 0 if permission is granted, -ve error otherwise.
> + * @key_post_alloc:
> + * 	Allocate and attach a security structure to a key structure.
> + * 	At this point there is a serial number attached to the key.
> + *	@key points to the key.
>   * @key_free:
>   *	Notification of destruction; free security data.
>   *	@key points to the key.
> @@ -1312,6 +1316,7 @@ struct security_operations {
>  	/* key management security hooks */
>  #ifdef CONFIG_KEYS
>  	int (*key_alloc)(struct key *key);
> +	void (*key_post_alloc)(struct key *key);
>  	void (*key_free)(struct key *key);
>  	int (*key_permission)(key_ref_t key_ref,
>  			      struct task_struct *context,
> @@ -3001,6 +3006,11 @@ static inline int security_key_alloc(str
>  	return security_ops->key_alloc(key);
>  }
>  
> +static inline void security_key_post_alloc(struct key *key)
> +{
> +	security_ops->key_post_alloc(key);
> +}
> +
>  static inline void security_key_free(struct key *key)
>  {
>  	security_ops->key_free(key);
> @@ -3020,6 +3030,10 @@ static inline int security_key_alloc(str
>  	return 0;
>  }
>  
> +static inline void security_key_post_alloc(struct key *key)
> +{
> +}
> +
>  static inline void security_key_free(struct key *key)
>  {
>  }
> diff --git a/security/dummy.c b/security/dummy.c
> index fd99429..1eff777 100644
> --- a/security/dummy.c
> +++ b/security/dummy.c
> @@ -860,6 +860,10 @@ static inline int dummy_key_alloc(struct
>  	return 0;
>  }
>  
> +static inline void dummy_key_post_alloc(struct key *key)
> +{
> +}
> +
>  static inline void dummy_key_free(struct key *key)
>  {
>  }
> @@ -1036,6 +1040,7 @@ void security_fixup_ops (struct security
>  #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
>  #ifdef CONFIG_KEYS
>  	set_to_dummy_if_null(ops, key_alloc);
> +	set_to_dummy_if_null(ops, key_post_alloc);
>  	set_to_dummy_if_null(ops, key_free);
>  	set_to_dummy_if_null(ops, key_permission);
>  #endif	/* CONFIG_KEYS */
> diff --git a/security/keys/key.c b/security/keys/key.c
> index a057e33..6be6269 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -325,6 +325,7 @@ struct key *key_alloc(struct key_type *t
>  	/* publish the key by giving it a serial number */
>  	atomic_inc(&user->nkeys);
>  	key_alloc_serial(key);
> +	security_key_post_alloc(key);
>  
>  error:
>  	return key;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Stephen Smalley
National Security Agency

