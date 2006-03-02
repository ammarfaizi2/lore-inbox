Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWCBC0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWCBC0a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 21:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWCBC0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 21:26:30 -0500
Received: from pat.uio.no ([129.240.130.16]:31880 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750744AbWCBC03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 21:26:29 -0500
Subject: Re: [RFC] vfs: cleanup of permission()
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Sam Vilain <sam@vilain.net>
Cc: Herbert Poetzl <herbert@13thfloor.at>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <44064BF7.9040605@vilain.net>
References: <20060228052606.GA6494@MAIL.13thfloor.at>
	 <1141202744.11585.20.camel@lade.trondhjem.org>
	 <20060301131149.GD26837@MAIL.13thfloor.at>
	 <1141256563.26382.8.camel@netapplinux-10.connectathon.org>
	 <44064BF7.9040605@vilain.net>
Content-Type: text/plain
Date: Wed, 01 Mar 2006 18:26:10 -0800
Message-Id: <1141266370.26382.42.camel@netapplinux-10.connectathon.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.45, required 12,
	autolearn=disabled, AWL 2.50, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-02 at 14:35 +1300, Sam Vilain wrote:
> Trond Myklebust wrote:
> >>the second part is actually a hack to help nfs and fuse
> >>to get the 'required' information until there is a proper
> >>interface (at the vfs not inode level) to pass relevant
> >>information (probably dentry/vfsmount/flags)
> > The nameidata _IS_ the vfs structure for storing path context
> > information. You seem to be suggesting we need yet another one. Why?
> 
> Because you can't make a nameidata without a lookup, and file based 
> operations don't do a lookup.  However you still have the vfsmnt and 
> inode hanging off the file struct.

Which is fine by NFS, at least. We don't care about performing
permissions checks in those cases anyway, so a NULL nameidata is OK. The
only cases where we currently need to take action in ->permission() are

 1) path walks (checking MAY_EXEC on the directory)
 2) open() (on NFSv2/v3 only)
 3) access()

In the future we can/should probably eliminate (2) by making an
atomic_open() for NFSv2/v3, so that we can correctly set the credential
that was used for the open() permissions check in the struct file.

> Either that or we make a dummy nameidata structure for this situation, 
> possibly a filehandle relative lookup as used by openat() et al.
> 
> >>>Secondly, an intent is _not_ a permissions mask by any stretch of the
> >>>imagination.
> >>see above
> >>>IOW: at the very least make that intent flag a separate parameter.
> >>IMHO it would be good to remove them completely form the
> >>current permission() checks.
> > Vetoed!
> > Redundant RPC calls have performance costs to the client, the server and
> > the network. That intent information is there in order to allow the
> > filesystem to figure out whether or not it needs to do the permissions
> > check, or if that check is already being done by other operations.
> > Removing the intents are therefore not an option.
> 
> OK, so we either make it an extra parameter or 'properly' stack them 
> into a single word.  Do you have any preferences either way there?

An extra parameter should suffice for (1) and (2).

Cheers,
  Trond

