Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVFBI6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVFBI6l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 04:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVFBI5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 04:57:46 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:2250 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261282AbVFBIsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 04:48:51 -0400
Date: Thu, 2 Jun 2005 10:48:40 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: XIAO Gang <xiao@unice.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suggestion on "int len" sanity
Message-ID: <20050602084840.GA32519@wohnheim.fh-wedel.de>
References: <429EB537.4060305@unice.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <429EB537.4060305@unice.fr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 June 2005 09:28:55 +0200, XIAO Gang wrote:
> 
> Examples:
> 
> 1. In the types of sys_[gs]ethostname, sys_[gs]etdomainname, "int len" 
> could be replaced
> by "unsigned int" or "size_t" and sanity check simplified.

If you really want that fun, try changing it to "unsigned long long"
on your private machine and do some testing.

Hint: arch/i386/kernel/syscall_table.S

> 2. In mm/shmem.c, shmem_symlink(), we have "len = strlen(symname) + 1;". 
> Although it is highly
> improbable that strlen(symname) overflows, it is more correct to declare 
> "size_t len;".

Yep, looks sane.

> 3. The similar situation occurs in fs/namei.c, vfs_readlink(). Here it does 
> not matter if len
> is declared to be unsigned, but for size_t, we have to take care about the 
> size of size_t.

You could possibly change the code to:

int vfs_readlink(struct dentry *dentry, char __user *buffer, int buflen, const char *link)
{
	union {
		unsigned len;
		int ret;
	} u;

	u.ret = PTR_ERR(link);
	if (IS_ERR(link))
		goto out;

	u.len = strlen(link);
	if (u.len > (unsigned) buflen)
		u.len = buflen;
	if (copy_to_user(buffer, link, u.len))
		u.ret = -EFAULT;
out:
	return u.ret;
}

But what would we gain, except for a few additional lines?

Jörn

-- 
Happiness isn't having what you want, it's wanting what you have.
-- unknown
