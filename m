Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWF1PCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWF1PCn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 11:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWF1PCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 11:02:41 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:5017 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751196AbWF1PCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 11:02:40 -0400
Date: Wed, 28 Jun 2006 10:02:19 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mcthomps@us.ibm.com, toml@us.ibm.com, yoder1@us.ibm.com,
       James Morris <jmorris@namei.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Erez Zadok <ezk@cs.sunysb.edu>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 10/13: eCryptfs] Mmap operations
Message-ID: <20060628150219.GB2802@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20060513033742.GA18598@hellewell.homeip.net> <20060513034708.GJ18631@hellewell.homeip.net> <84144f020606280716y2bea236du2ea84018e15a7d0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020606280716y2bea236du2ea84018e15a7d0a@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 05:16:34PM +0300, Pekka Enberg wrote:
> On 5/13/06, Phillip Hellewell <phillip@hellewell.homeip.net> wrote:
> >+static struct page *ecryptfs_get1page(struct file *file, int index)
> >+{
> >+       struct page *page;
> >+       struct dentry *dentry;
> >+       struct inode *inode;
> >+       struct address_space *mapping;
> >+
> >+       dentry = file->f_dentry;
> >+       inode = dentry->d_inode;
> >+       mapping = inode->i_mapping;
> >+       page = read_cache_page(mapping, index,
> >+                              (filler_t *)mapping->a_ops->readpage,
> >+                              (void *)file);
> >+       if (IS_ERR(page))
> >+               goto out;
> >+       wait_on_page_locked(page);
> 
> Why no check for PageUptodate?

It happens, but a bit later. ecryptfs_get1page() is called from
write_zeros(). Then write_zeros() calls ecryptfs_prepare_write(),
which does a PageUptodate() check.

Mike
