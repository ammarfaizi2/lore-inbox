Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVGBWzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVGBWzi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 18:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVGBWzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 18:55:38 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:21917 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261318AbVGBWz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 18:55:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pQKYmzJaC8YObkWw342+xPEWn3jMKu55AieC/G6nmQlHoN8UGawf0vs9Ne9V7u6A9EPuEWiaXBvEN5Qpv1XpOGidVxo+ERst13y72gWVRxyJTE1DeAwTxwc8GT01lp4xtS9OXpH+LlTYU5X7JKn+Qi3Gs9TevI1+Rz+dldscFlA=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Nicholas Hans Simmonds <nhstux@gmail.com>
Subject: Re: [PATCH] Filesystem capabilities support
Date: Sun, 3 Jul 2005 03:01:48 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, "Andrew G. Morgan" <morgan@transmeta.com>,
       Alexander Kjeldaas <astor@guardian.no>
References: <20050702214108.GA755@laptop>
In-Reply-To: <20050702214108.GA755@laptop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507030301.48862.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 July 2005 01:41, Nicholas Hans Simmonds wrote:
> This is a simple attempt at providing capability support through extended
> attributes. Setting security.cap_set to contain a struct cap_xattr_data which
> defines the desired capabilities will switch on the new behaviour otherwise
> there is no change. When a file is written to then the xattr (if it exists) is
> removed to prevent tampering with priveleged executables. Whilst I'm not sure
> this provides a secure implementation, I can't see any problem with it myself.

> --- a/security/commoncap.c
> +++ b/security/commoncap.c

>  int cap_bprm_set_security (struct linux_binprm *bprm)
>  {
> +	ssize_t (*bprm_getxattr)(struct dentry *,const char *,void *,size_t);
> +	struct dentry *bprm_dentry;
> +	ssize_t ret;
> +	struct cap_xattr_data caps;
> +	

$ make security/commoncap.o
  CC      security/commoncap.o
security/commoncap.c: In function `cap_bprm_set_security':
security/commoncap.c:114: warning: unused variable `bprm_getxattr'
security/commoncap.c:115: warning: unused variable `bprm_dentry'
security/commoncap.c:116: warning: unused variable `ret'
security/commoncap.c:117: warning: unused variable `caps'

with an obvious change in .config

> +#ifdef CONFIG_SECURITY_FS_CAPABILITIES
> +	/* Locate any VFS capabilities: */
> +
> +	bprm_dentry = bprm->file->f_dentry;
> +	if(!(bprm_dentry->d_inode->i_op &&
> +				bprm_dentry->d_inode->i_op->getxattr))
> +		return 0;
> +	bprm_getxattr = bprm_dentry->d_inode->i_op->getxattr;
> +	
> +	down(&bprm_dentry->d_inode->i_sem);
> +	ret = bprm_getxattr(bprm_dentry,XATTR_CAP_SET,&caps,sizeof(caps));
> +	if(ret == sizeof(caps)) {
> +		if(caps.version == _LINUX_CAPABILITY_VERSION) {
> +			cap_t(bprm->cap_effective) &= caps.mask_effective;
> +			cap_t(bprm->cap_effective) |= caps.effective;
> +			
> +			cap_t(bprm->cap_permitted) &= caps.mask_permitted;
> +			cap_t(bprm->cap_permitted) |= caps.permitted;
> +			
> +			cap_t(bprm->cap_inheritable) &= caps.mask_inheritable;
> +			cap_t(bprm->cap_inheritable) |= caps.inheritable;
> +		} else
> +			printk(KERN_WARNING "Warning: %s capability set has "
> +				"incorrect version\n",bprm->filename);

You may want to print this incorrect version.

> +	}
> +	up(&bprm_dentry->d_inode->i_sem);
> +#endif /* CONFIG_SECURITY_FS_CAPABILITIES */
