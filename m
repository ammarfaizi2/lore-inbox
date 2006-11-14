Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755406AbWKNDEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755406AbWKNDEq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 22:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755407AbWKNDEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 22:04:46 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:53466 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1755406AbWKNDEp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 22:04:45 -0500
Date: Mon, 13 Nov 2006 21:01:24 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Chris Friedhoff <chris@friedhoff.org>
Subject: Re: [PATCH 1/1] security: introduce fs caps
Message-ID: <20061114030124.GA31893@sergelap>
References: <20061108222453.GA6408@sergelap.austin.ibm.com> <20061108224837.GG4972@martell.zuzino.mipt.ru> <20061108235203.GA7987@sergelap.austin.ibm.com> <20061109052733.GA4976@martell.zuzino.mipt.ru> <20061113164326.GA11355@sergelap.austin.ibm.com> <20061113210443.GD4971@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061113210443.GD4971@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexey Dobriyan (adobriyan@gmail.com):
> On Mon, Nov 13, 2006 at 10:43:26AM -0600, Serge E. Hallyn wrote:
> > Quoting Alexey Dobriyan (adobriyan@gmail.com):
> > > On Wed, Nov 08, 2006 at 05:52:03PM -0600, Serge E. Hallyn wrote:
> > > > > > +	__u32 version;
> > > > > > +	__u32 effective;
> > > > > > +	__u32 permitted;
> > > > > > +	__u32 inheritable;
> > > > > > +};
> > > > > > +
> > > > > > +static inline void convert_to_le(struct vfs_cap_data_struct *cap)
> > > > > > +{
> > > > > > +	cap->version = le32_to_cpu(cap->version);
> > > > > > +	cap->effective = le32_to_cpu(cap->effective);
> > > > > > +	cap->permitted = le32_to_cpu(cap->permitted);
> > > > > > +	cap->inheritable = le32_to_cpu(cap->inheritable);
> > > > > > +}
> > > > >
> > > > > This pretty much defeats sparse endian checking. You will get warnings
> > > > > regardless of whether u32 or le32 are used.
> > > >
> > > > But I don't get any sparse warnings with make C=1.  Am I doing something
> > > > wrong?
> > >
> > > You need (temporarily) to use CF:
> > >
> > > 	make C=1 CF=-D__CHECK_ENDIAN__ ...
> >
> > The following patch on top of the existing one eliminates the warning.
> > Does it appear consistent with what you were suggesting?
> 
> > If it is ok, I'll resend the full patch.
> 
> Yes, that's it, modulo:

Thanks, comments integrated with the exception of:

> > --- a/include/linux/capability.h
> > +++ b/include/linux/capability.h
> > +#ifdef CONFIG_SECURITY_FS_CAPABILITIES
> 
> This is exportable header, so no CONFIG_*
> 
> > +#define XATTR_CAPS_SUFFIX "capability"
> > +#define XATTR_NAME_CAPS XATTR_SECURITY_PREFIX XATTR_CAPS_SUFFIX
> > +struct vfs_cap_data_disk {
> > +	__le32 version;
> > +	__le32 effective;
> > +	__le32 permitted;
> > +	__le32 inheritable;
> > +};
> > +#endif
> >
> >  #ifdef __KERNEL__
> >
> >  #include <linux/spinlock.h>
> >  #include <asm/current.h>
> >
> > +#ifdef CONFIG_SECURITY_FS_CAPABILITIES
> > +struct vfs_cap_data {
> > +	__u32 version;
> > +	__u32 effective;
> > +	__u32 permitted;
> > +	__u32 inheritable;
> > +};
> 
> Now you're in kernel, so you can happily use u32 without undescores.

The rest of the file already uses __u32, so for consistency I'd
rather stick with __u32, unless there's a reason why it's really
discouraged.

Will send new patch in just a bit.

thanks,
-serge

> > --- a/security/commoncap.c
> > +++ b/security/commoncap.c
> > @@ -155,7 +147,8 @@ static int set_file_caps(struct linux_bi
> >  {
> >  	struct dentry *dentry;
> >  	ssize_t rc;
> 
> > @@ -178,19 +171,19 @@ static int set_file_caps(struct linux_bi
> >  		return rc;
> >  	}
> >
> > -	if (rc != sizeof(cap_struct)) {
> > +	if (rc != sizeof(dcaps)) {
> >  		printk(KERN_NOTICE "%s: got wrong size for getxattr (%d)\n",
> >  					__FUNCTION__, rc);
> 
> rc is ssize_t, so "%zd".
