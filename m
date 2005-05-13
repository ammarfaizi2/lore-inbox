Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbVEMDtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbVEMDtP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 23:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVEMDtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 23:49:15 -0400
Received: from pat.uio.no ([129.240.130.16]:692 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262227AbVEMDtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 23:49:10 -0400
Subject: Re: NFS: msync required for data writes to server?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: linda.dunaphant@ccur.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050512194210.10a9dc93.akpm@osdl.org>
References: <1115925686.6319.3.camel@lindad>
	 <20050512175720.74ea6a3e.akpm@osdl.org> <1115950903.6319.25.camel@lindad>
	 <20050512194210.10a9dc93.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 12 May 2005 20:48:48 -0700
Message-Id: <1115956128.12175.11.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.849, required 12,
	autolearn=disabled, AWL 2.15, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 12.05.2005 Klokka 19:42 (-0700) skreiv Andrew Morton:
> >  Looking at the differences in fs/nfs between these trees I found a
> >  change to nfs_file_release() in fs/nfs/file.c. When I applied this
> >  change to my 2.6.9 tree, the data was written out to the server.
> > 
> >  @@ -105,6 +108,9 @@
> >   static int
> >   nfs_file_release(struct inode *inode, struct file *filp)
> >   {
> >  +       /* Ensure that dirty pages are flushed out with the right creds
> >  */
> >  +       if (filp->f_mode & FMODE_WRITE)
> >  +               filemap_fdatawrite(filp->f_mapping);
> >          return NFS_PROTO(inode)->file_release(inode, filp);
> >   }
> 
> Well yes, that'll sync the file on close, but it doesn't explain the
> original problem.

See the above comment and the changelog entry for that patch. The
problem is and was that writepage() does not take a struct file
argument, and so we have to guess which RPC credentials to use when
writing out the dirty pages.

Before we had RPCSEC_GSS, we could cache the credential of the last
person who opened the file, and expect that it would be usable for
writing out dirty pages since the AUTH_SYS credentials have an infinite
lifetime. With the advent of strong security, and credentials with a
finite lifetime, that became risky behaviour, and so we now actually
look for which files are still open at the moment when writepage is
called.
The problem was that the VFS does not flush dirty pages to disk on
file_release(), and hence the above patch which at least will do it for
NFS.

Cheers,
  Trond

