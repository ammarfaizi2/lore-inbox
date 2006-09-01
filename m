Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWIAW1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWIAW1o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 18:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWIAW1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 18:27:44 -0400
Received: from mx1.suse.de ([195.135.220.2]:8079 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751107AbWIAW1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 18:27:43 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: Novell, SUSE Labs
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Generic infrastructure for acls
Date: Sat, 2 Sep 2006 00:32:02 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
       Kay Sievers <kay.sievers@vrfy.org>
References: <20060901221421.968954146@winden.suse.de> <20060901221457.803728153@winden.suse.de> <20060901144423.aa306d36.akpm@osdl.org>
In-Reply-To: <20060901144423.aa306d36.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609020032.02595.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 01 September 2006 23:44, Andrew Morton wrote:
> On Sat, 02 Sep 2006 00:14:22 +0200
>
> Andreas Gruenbacher <agruen@suse.de> wrote:
> > +generic_acl_list(struct inode *inode, struct generic_acl_operations
> > *ops, +		 int type, char *list, size_t list_size)
> > +{
> > +	struct posix_acl *acl;
> > +	const char *name;
> > +	size_t size;
> > +
> > +	acl = ops->getacl(inode, type);
> > +	if (!acl)
> > +		return 0;
> > +	posix_acl_release(acl);
> > +
> > +	switch(type) {
> > +		case ACL_TYPE_ACCESS:
> > +			name = POSIX_ACL_XATTR_ACCESS;
> > +			break;
> > +
> > +		case ACL_TYPE_DEFAULT:
> > +			name = POSIX_ACL_XATTR_DEFAULT;
> > +			break;
> > +
> > +		default:
> > +			return 0;
> > +	}
> > +	size = strlen(name) + 1;
> > +	if (list && size <= list_size)
> > +		memcpy(list, name, size);
> > +	return size;
> > +}
>
> That's a clumsy-looking interface.

We could get rid of the switch by passing in the type and the name, but 
otherwise that's pretty exactly what's needed, no matter if done in a 
fs-dependent or independent way.

> How is the caller to know that *list got filled in? By checking the 
generic_acl_list() return value against `list_size'?

The return value determines how many bytes have been used or would be needed 
in the buffer -- generic_listxattr() in fs/xattr.c has this code:

> for_each_xattr_handler(handlers, handler) {
>     size = handler->list(inode, buf, buffer_size, NULL, 0);
>     if (size > buffer_size) 
>         return -ERANGE;
>     buf += size;
>     buffer_size -= size;
> }

Andreas

-- 
VGER BF report: H 0
