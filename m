Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbVKUX6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbVKUX6k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVKUX6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:58:40 -0500
Received: from pat.uio.no ([129.240.130.16]:35244 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751252AbVKUX6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:58:39 -0500
Subject: Re: infinite loop? with mmap, nfs, pwrite, O_DIRECT
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: theonetruekenny@yahoo.com, cel@citi.umich.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051121153454.1907d92a.akpm@osdl.org>
References: <20051121213913.61220.qmail@web34115.mail.mud.yahoo.com>
	 <1132612974.8011.12.camel@lade.trondhjem.org>
	 <20051121153454.1907d92a.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 21 Nov 2005 18:58:23 -0500
Message-Id: <1132617503.8011.35.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.729, required 12,
	autolearn=disabled, AWL 1.08, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 15:34 -0800, Andrew Morton wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> >
> >  Anything that calls lock_page() should be avoided in O_DIRECT,
> 
> Why?
> 
> And it's still doing lock_page():
> 
> 	nfs_file_direct_write()
> 	->filemap_fdatawrite()
> 	  ->do_writepages()
> 	    ->nfs_writepages()
> 	      ->generic_writepages()
> 	        ->mpage_writepages()
> 	          ->lock_page()

True.

> > however
> >   we should be able to call invalidate_inode_pages() since that doesn't
> >   wait on the page lock.
> 
> invalidate_inode_pages2() is better.


> And using generic_file_direct_IO() is
> better still, since it handles mmap coherency and only work upon that part
> of the file which is actually undergoing IO.

Unlike local filesystems, we don't want to have to take the i_sem in any
of the direct IO paths. The latter is just a liability as far as
applications are concerned: it doesn't offer any protection for local
data (there _is_ no local data to protect), but gets seriously in the
way of write parallelism.

The only difference I can see between the two paths is the call to
unmap_mapping_range(). What effect would that have?

Cheers,
  Trond

