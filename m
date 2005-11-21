Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbVKUXfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbVKUXfL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbVKUXfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:35:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18114 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932480AbVKUXfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:35:09 -0500
Date: Mon, 21 Nov 2005 15:34:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: theonetruekenny@yahoo.com, cel@citi.umich.edu,
       linux-kernel@vger.kernel.org
Subject: Re: infinite loop? with mmap, nfs, pwrite, O_DIRECT
Message-Id: <20051121153454.1907d92a.akpm@osdl.org>
In-Reply-To: <1132612974.8011.12.camel@lade.trondhjem.org>
References: <20051121213913.61220.qmail@web34115.mail.mud.yahoo.com>
	<1132612974.8011.12.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
>  Anything that calls lock_page() should be avoided in O_DIRECT,

Why?

And it's still doing lock_page():

	nfs_file_direct_write()
	->filemap_fdatawrite()
	  ->do_writepages()
	    ->nfs_writepages()
	      ->generic_writepages()
	        ->mpage_writepages()
	          ->lock_page()

> however
>   we should be able to call invalidate_inode_pages() since that doesn't
>   wait on the page lock.

invalidate_inode_pages2() is better.  And using generic_file_direct_IO() is
better still, since it handles mmap coherency and only work upon that part
of the file which is actually undergoing IO.

