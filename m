Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbVCVVzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbVCVVzV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 16:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVCVVzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 16:55:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55243 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262057AbVCVVwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 16:52:06 -0500
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16960.37814.651437.634849@segfault.boston.redhat.com>
Date: Tue, 22 Mar 2005 16:52:54 -0500
To: linux-kernel@vger.kernel.org
Subject: unused 'size' assignment in filemap_nopage
X-Mailer: VM 7.19 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

filemap_nopage has the following code:

retry_all:
	size = (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
	if (pgoff >= size)
		goto outside_data_content;

	/* If we don't want any read-ahead, don't bother */
	if (VM_RandomReadHint(area))
		goto no_cached_page;

	/*
	 * The "size" of the file, as far as mmap is concerned, isn't bigger
	 * than the mapping
	 */
	if (size > endoff)
		size = endoff;


After this, size is not referenced.  So, either this potential reassignment
of size is superfluous, or we are missing some other code later on in the
function.  If it is the former, I've attached a patch which will remove the
code.

Thanks,

Jeff

--- linux-2.6.12-rc1/mm/filemap.c.orig	2005-03-22 16:28:01.429426880 -0500
+++ linux-2.6.12-rc1/mm/filemap.c	2005-03-22 16:29:22.564092536 -0500
@@ -1191,13 +1191,6 @@ retry_all:
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
