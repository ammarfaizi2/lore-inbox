Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbVHCSBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbVHCSBL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 14:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVHCSBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 14:01:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18590 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262375AbVHCSBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 14:01:07 -0400
Date: Wed, 3 Aug 2005 10:57:42 -0700
From: Chris Wright <chrisw@osdl.org>
To: serue@us.ibm.com
Cc: James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Stacker - single-use static slots
Message-ID: <20050803175742.GI7762@shell0.pdx.osdl.net>
References: <20050727181732.GA22483@serge.austin.ibm.com> <Lynx.SEL.4.62.0507271527390.1844@thoron.boston.redhat.com> <Lynx.SEL.4.62.0507271535150.1844@thoron.boston.redhat.com> <20050803164516.GB13691@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803164516.GB13691@serge.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* serue@us.ibm.com (serue@us.ibm.com) wrote:
> Index: linux-2.6.12/include/linux/security.h
> ===================================================================
> --- linux-2.6.12.orig/include/linux/security.h	2005-08-01 20:00:51.000000000 -0500
> +++ linux-2.6.12/include/linux/security.h	2005-08-01 20:23:52.000000000 -0500
> @@ -44,24 +44,65 @@ struct security_list {
>  };
>  
>  
> +static inline void *__get_value(void *head, int idx)
> +{
> +	void **p = head + sizeof(struct hlist_head);
> +#if 0
> +	printk(KERN_NOTICE "__get_value: %s (%d): head %lx p %lx idx %d returning %lx at %lx\n",
> +		__FUNCTION__, __LINE__, (long)head, (long)p, idx, (long)p[idx], (long)&p[idx]);
> +#endif
> +	return p[idx];

pr_debug

> +}
> +
> +static inline void __set_value(void *head, int idx, void *v)
> +{
> +	void **p = head + sizeof(struct hlist_head);
> +	p[idx] = v;
> +#if 0
> +	printk(KERN_NOTICE "%s (%d): hd %lx, p %lx, idx %d,"
> +		"v %lx, p[idx] %lx at %lx\n",
> +		__FUNCTION__, __LINE__, (long) (head),
> +		(long) p, idx, (long) (v),
> +		(long)p[idx], (long)&p[idx]);
> +#endif

pr_debug

> Index: linux-2.6.12/security/Kconfig
> ===================================================================
> --- linux-2.6.12.orig/security/Kconfig	2005-08-01 20:00:51.000000000 -0500
> +++ linux-2.6.12/security/Kconfig	2005-08-01 20:24:11.000000000 -0500
> @@ -112,5 +112,17 @@ config SECURITY_STACKER
>  	help
>  	  Stack multiple LSMs.
>  
> +config SECURITY_STACKER_NUMFIELDS
> +	int "Number of security fields to reserve"
> +	depends on SECURITY_STACKER
> +	default 1

Not sure config is worth it, also, James had suggested smth like 3
slots.

>  		INIT_HLIST_HEAD(&inode->i_security);
> +		memset(&inode->i_security_p, 0,
> +			CONFIG_SECURITY_STACKER_NUMFIELDS*sizeof(void *));

This CONFIG... is a bit rough.  Can we use a simple name, and if config
is necessary, assign config to simple name?

>  		inode->dirtied_when = 0;
>  		if (security_inode_alloc(inode)) {
>  			if (inode->i_sb->s_op->destroy_inode)
> Index: linux-2.6.12/include/linux/binfmts.h
> ===================================================================
> --- linux-2.6.12.orig/include/linux/binfmts.h	2005-08-01 20:00:50.000000000 -0500
> +++ linux-2.6.12/include/linux/binfmts.h	2005-08-01 20:24:41.000000000 -0500
> @@ -30,6 +30,7 @@ struct linux_binprm{
>  	int e_uid, e_gid;
>  	kernel_cap_t cap_inheritable, cap_permitted, cap_effective;
>  	struct hlist_head security;
> +	void * security_p[CONFIG_SECURITY_STACKER_NUMFIELDS];
>  	int argc, envc;
>  	char * filename;	/* Name of binary as seen by procps */
>  	char * interp;		/* Name of the binary really executed. Most
> Index: linux-2.6.12/include/linux/fs.h
> ===================================================================
> --- linux-2.6.12.orig/include/linux/fs.h	2005-08-01 20:00:50.000000000 -0500
> +++ linux-2.6.12/include/linux/fs.h	2005-08-01 20:24:55.000000000 -0500
> @@ -486,6 +486,7 @@ struct inode {
>  
>  	atomic_t		i_writecount;
>  	struct hlist_head	i_security;
> +	void			*i_security_p[CONFIG_SECURITY_STACKER_NUMFIELDS];

James had suggested to effectively stash the list in the last slot, so
there's only the array with one reserved slot.

thanks,
-chris
