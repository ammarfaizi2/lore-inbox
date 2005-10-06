Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbVJFQlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVJFQlh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 12:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbVJFQlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 12:41:37 -0400
Received: from pat.uio.no ([129.240.130.16]:26568 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750951AbVJFQlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 12:41:36 -0400
Subject: Re: [RFC] atomic create+open
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu>
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Thu, 06 Oct 2005 12:41:04 -0400
Message-Id: <1128616864.8396.32.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.1, required 12,
	autolearn=disabled, AWL 0.90, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 06.10.2005 Klokka 16:38 (+0200) skreiv Miklos Szeredi:
> Currently it's impossible to implement a network filesystem that is
> 
>   a) served by an unprivileged userspace process
> 
>   b) supports "strange" open semantics, e.g.:
> 
>        open("foo", O_WRONLY | O_CREAT, 0400);
> 
>   c) not overly "hacky"
> 
> The basic problem is that because of a) permission checking cannot be
> separated from the actual operations.
> 
> By the time the ->open method is called, the file has been created
> with a read-only mode, and the server won't be able to open it in
> write mode.
> 
> Several hacks come to mind for solving this, but these have severe
> problems and are excluded.
> 
> One approach for solving this properly is to add a new atomic
> create+open method to inode operations.  The prototype would be a
> merger of ->create() and ->open, like this:
> 
>   int (*create_open) (struct inode *dir, struct dentry *dentry, int mode,
>                       struct file *filp);

The reason why we do it as a lookup intent is because this has to be
atomic lookup+create+open in order to be at all useful to NFS.

Just doing create+open atomically is worthless since it leaves you with
a bunch of races where someone on the server can create, say, a symlink
between the RPC call to lookup and the RPC call that creates the file.

> A different approach is to extend the open_intents structure and allow
> the filesystem to do the open from ->create(), but this is a much less
> clean interface. Trond Myklebust has a patch that does this (no longer
> applies):
> 
>   http://client.linux-nfs.org/Linux-2.6.x/2.6.12/linux-2.6.12-63-open_file_intents.dif

I'm going to fix this up.

Cheers,
  Trond

