Return-Path: <linux-kernel-owner+w=401wt.eu-S932245AbXADSzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbXADSzG (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 13:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbXADSzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 13:55:05 -0500
Received: from smtp0.osdl.org ([65.172.181.24]:43608 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932086AbXADSyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 13:54:45 -0500
Date: Thu, 4 Jan 2007 10:54:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted
 bad_inode_ops return values
Message-Id: <20070104105430.1de994a7.akpm@osdl.org>
In-Reply-To: <459D4897.4020408@redhat.com>
References: <459C4038.6020902@redhat.com>
	<20070103162643.5c479836.akpm@osdl.org>
	<459D3E8E.7000405@redhat.com>
	<20070104102659.8c61d510.akpm@osdl.org>
	<459D4897.4020408@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jan 2007 12:33:59 -0600
Eric Sandeen <sandeen@redhat.com> wrote:

> Andrew Morton wrote:
> > On Thu, 04 Jan 2007 11:51:10 -0600
> > Eric Sandeen <sandeen@redhat.com> wrote:
> 
> >> Also - is it ok to alias a function with one signature to a function with
> >> another signature?
> > 
> > Ordinarily I'd say no wucking fay, but that's effectively what we've been
> > doing in there for ages, and it seems to work.
> 
> Hmm that gives me a lot of confidence ;-)  I'd hate to carry along bad
> assumptions while we try to make this all kosher... but I'm willing to
> defer to popular opinion on this one....

yeah, I'm a bit wobbly about it.  Linus, what do you think?

> > I'd be a bit worried if any of these functions were returning pointers,
> > because one could certainly conceive of an arch+compiler combo which
> > returns pointers in a different register from integers (680x0?) but that's
> > not happening here.
> 
> Well, one is...
> 
> static long * return_EIO_ptr(void)
> {
>         return ERR_PTR(-EIO);
> }
> ...
> static struct dentry *bad_inode_lookup(struct inode * dir,
>                         struct dentry *dentry, struct nameidata *nd)
>         __attribute__((alias("return_EIO_ptr")));
> 
> Maybe it'd be better to lose the alias in this case then?  and go back
> to this:
> 
> static struct dentry *bad_inode_lookup(struct inode * dir,
>                         struct dentry *dentry, struct nameidata *nd)
> {
>         return ERR_PTR(-EIO);
> }

A bit saner, but again, the old code used the same function for *everything*
and apart from the 32/64-bit thing, it worked.

Half a kb isn't much of course, but we've done lots of changes for a lot
less...


