Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262478AbVCWNsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbVCWNsq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 08:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVCWNqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 08:46:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32388 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262399AbVCWNoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 08:44:05 -0500
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16961.29363.691868.785104@segfault.boston.redhat.com>
Date: Wed, 23 Mar 2005 08:44:19 -0500
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unused 'size' assignment in filemap_nopage
In-Reply-To: <E1DE3jC-0001Lq-00@gondolin.me.apana.org.au>
References: <16960.37814.651437.634849@segfault.boston.redhat.com>
	<E1DE3jC-0001Lq-00@gondolin.me.apana.org.au>
X-Mailer: VM 7.19 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: unused 'size' assignment in filemap_nopage; Herbert Xu <herbert@gondor.apana.org.au> adds:

herbert> Jeff Moyer <jmoyer@redhat.com> wrote:
>> After this, size is not referenced.  So, either this potential
>> reassignment of size is superfluous, or we are missing some other code
>> later on in the function.  If it is the former, I've attached a patch
>> which will remove the code.

herbert> Yes it's obsolete.  You can remove endoff as well.

Okay, here's the patch.

Thanks,

Jeff

--- linux-2.6.11/mm/filemap.c.orig	2005-03-23 08:32:38.182822976 -0500
+++ linux-2.6.11/mm/filemap.c	2005-03-23 08:33:34.966190592 -0500
@@ -1175,11 +1175,10 @@ struct page * filemap_nopage(struct vm_a
 	struct file_ra_state *ra = &file->f_ra;
 	struct inode *inode = mapping->host;
 	struct page *page;
-	unsigned long size, pgoff, endoff;
+	unsigned long size, pgoff;
 	int did_readaround = 0, majmin = VM_FAULT_MINOR;
 
 	pgoff = ((address - area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
-	endoff = ((area->vm_end - area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
 
 retry_all:
 	size = (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
@@ -1191,13 +1190,6 @@ retry_all:
 		goto no_cached_page;
 
 	/*
-	 * The "size" of the file, as far as mmap is concerned, isn't bigger
-	 * than the mapping
-	 */
-	if (size > endoff)
-		size = endoff;
-
-	/*
 	 * The readahead code wants to be told about each and every page
 	 * so it can build and shrink its windows appropriately
 	 *
