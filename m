Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVFCMUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVFCMUS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 08:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVFCMUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 08:20:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11683 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261233AbVFCMUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 08:20:10 -0400
Date: Fri, 3 Jun 2005 13:20:58 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       XIAO Gang <xiao@unice.fr>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Suggestion on "int len" sanity
Message-ID: <20050603122058.GF29811@parcelfarce.linux.theplanet.co.uk>
References: <429EB537.4060305@unice.fr> <20050602084840.GA32519@wohnheim.fh-wedel.de> <Pine.LNX.4.62.0506031143100.16362@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506031143100.16362@numbat.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 11:45:51AM +0200, Geert Uytterhoeven wrote:
> On Thu, 2 Jun 2005, [iso-8859-1] J?rn Engel wrote:
> > int vfs_readlink(struct dentry *dentry, char __user *buffer, int buflen, const char *link)
> > {
> > 	union {
> > 		unsigned len;
>                 ^^^^^^^^
> Plain unsigned is deprecated.
> 
> > 		int ret;
> > 	} u;
> 
> Ugh...

Ugh, indeed - who the hell had come up with _that_?

> > 
> > 	u.ret = PTR_ERR(link);
> > 	if (IS_ERR(link))
> > 		goto out;
> > 
> > 	u.len = strlen(link);
> > 	if (u.len > (unsigned) buflen)
> > 		u.len = buflen;
> > 	if (copy_to_user(buffer, link, u.len))
> > 		u.ret = -EFAULT;
> > out:
> > 	return u.ret;
> > }
> 
> buflen should be size_t.
> 
> Since the return value may be negative, it should be signed. But int is not an
> option, since size_t is 64 bit on 64-bit machines, while int is still 32-bit.
> So the return type should be ssize_t.

BS from the beginning to end - we are talking about symlink bodies.
These are *not* going to be 2Gb long.

And that quite neatly shows why the whole plan is a non-starter - you need
to understand what's going on in the code being mangled.
