Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755352AbWKMVEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755352AbWKMVEz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755356AbWKMVEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:04:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:60203 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1755353AbWKMVEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:04:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ksV9aVPJT3yCe7oxZVcx3suqSZpIs0tJeit5TolGCfxDtImPHhWoka1qZYthd0Fe3RILJodmDwatoQalPn6kXUMbCiOCIi4u17lnD5k33LNU6/rKeU9TzJKzeKDtTazBSorw4EORd2auSePofdmmhghFdM7KCcJV7n9aio7Oe08=
Date: Tue, 14 Nov 2006 00:04:43 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Chris Friedhoff <chris@friedhoff.org>
Subject: Re: [PATCH 1/1] security: introduce fs caps
Message-ID: <20061113210443.GD4971@martell.zuzino.mipt.ru>
References: <20061108222453.GA6408@sergelap.austin.ibm.com> <20061108224837.GG4972@martell.zuzino.mipt.ru> <20061108235203.GA7987@sergelap.austin.ibm.com> <20061109052733.GA4976@martell.zuzino.mipt.ru> <20061113164326.GA11355@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061113164326.GA11355@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 10:43:26AM -0600, Serge E. Hallyn wrote:
> Quoting Alexey Dobriyan (adobriyan@gmail.com):
> > On Wed, Nov 08, 2006 at 05:52:03PM -0600, Serge E. Hallyn wrote:
> > > > > +	__u32 version;
> > > > > +	__u32 effective;
> > > > > +	__u32 permitted;
> > > > > +	__u32 inheritable;
> > > > > +};
> > > > > +
> > > > > +static inline void convert_to_le(struct vfs_cap_data_struct *cap)
> > > > > +{
> > > > > +	cap->version = le32_to_cpu(cap->version);
> > > > > +	cap->effective = le32_to_cpu(cap->effective);
> > > > > +	cap->permitted = le32_to_cpu(cap->permitted);
> > > > > +	cap->inheritable = le32_to_cpu(cap->inheritable);
> > > > > +}
> > > >
> > > > This pretty much defeats sparse endian checking. You will get warnings
> > > > regardless of whether u32 or le32 are used.
> > >
> > > But I don't get any sparse warnings with make C=1.  Am I doing something
> > > wrong?
> >
> > You need (temporarily) to use CF:
> >
> > 	make C=1 CF=-D__CHECK_ENDIAN__ ...
>
> The following patch on top of the existing one eliminates the warning.
> Does it appear consistent with what you were suggesting?

> If it is ok, I'll resend the full patch.

Yes, that's it, modulo:

> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> +#ifdef CONFIG_SECURITY_FS_CAPABILITIES

This is exportable header, so no CONFIG_*

> +#define XATTR_CAPS_SUFFIX "capability"
> +#define XATTR_NAME_CAPS XATTR_SECURITY_PREFIX XATTR_CAPS_SUFFIX
> +struct vfs_cap_data_disk {
> +	__le32 version;
> +	__le32 effective;
> +	__le32 permitted;
> +	__le32 inheritable;
> +};
> +#endif
>
>  #ifdef __KERNEL__
>
>  #include <linux/spinlock.h>
>  #include <asm/current.h>
>
> +#ifdef CONFIG_SECURITY_FS_CAPABILITIES
> +struct vfs_cap_data {
> +	__u32 version;
> +	__u32 effective;
> +	__u32 permitted;
> +	__u32 inheritable;
> +};

Now you're in kernel, so you can happily use u32 without undescores.

> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -155,7 +147,8 @@ static int set_file_caps(struct linux_bi
>  {
>  	struct dentry *dentry;
>  	ssize_t rc;

> @@ -178,19 +171,19 @@ static int set_file_caps(struct linux_bi
>  		return rc;
>  	}
>
> -	if (rc != sizeof(cap_struct)) {
> +	if (rc != sizeof(dcaps)) {
>  		printk(KERN_NOTICE "%s: got wrong size for getxattr (%d)\n",
>  					__FUNCTION__, rc);

rc is ssize_t, so "%zd".

