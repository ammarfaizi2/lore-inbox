Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269209AbUISKQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269209AbUISKQy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 06:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269210AbUISKQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 06:16:53 -0400
Received: from cantor.suse.de ([195.135.220.2]:9963 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269209AbUISKQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 06:16:05 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Labs
To: James Morris <jmorris@redhat.com>
Subject: Re: [PATCH 1/6] xattr consolidation v2 - generic xattr API
Date: Sun, 19 Sep 2004 12:13:57 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, <viro@parcelfarce.linux.theplanet.co.uk>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>, <linux-kernel@vger.kernel.org>
References: <Xine.LNX.4.44.0409181943030.12816-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0409181943030.12816-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409191213.57977.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 September 2004 01:47, James Morris wrote:
> On Sun, 19 Sep 2004, Andreas Gruenbacher wrote:
> > This currently is only relevant for the security attribute. Selinux
> > always returns the same attribute name so it can't trigger this problem,
> > but other LSMs might do something different.
> >
> > We can add a list_size parameter to xattr_handler->list to get this
> > fixed. We should change the name_len parameter of xattr_handler->list
> > from int to size_t:
>
> Ahh, I thought we had the inode semaphore (never trust documentation).
> Why don't we take that instead in listxattr() ?

Documentation/filesystems/Locking seems to be accurate. Originally we were 
taking inode->i_sem for all four xattr operations. It turned out that this 
caused lock contention for acls. Selinux increases the frequency of xattr 
operations, so always taking i_sem would be even worse now.

> The name_len thing seems kludgy.

The old handler API was fine at the FS level where locking was guaranteed 
anyways. At the VFS level we should do better. Passing in the buffer and the 
buffer size at the same time gets us rid of the problem without requiring any 
locking.

> > I also noticed that your additions to fs/xattr.c use a slightly different
> > coding style than the rest of the file. You might want to change that as
> > well.
>
> I was using Linus-recommended coding style, but it can be changed I guess.

Both styles are being used in VFS. Choose one; I don't mind much.

-- Andreas.
