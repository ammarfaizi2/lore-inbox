Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVFFMor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVFFMor (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 08:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVFFMor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 08:44:47 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:3870 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S261370AbVFFMo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 08:44:29 -0400
Message-ID: <42A44515.4020701@tu-harburg.de>
Date: Mon, 06 Jun 2005 14:44:05 +0200
From: Jan Blunck <j.blunck@tu-harburg.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] don't allow sys_readahead() on files opened with O_DIRECT
References: <42A435DE.50302@tu-harburg.de> <20050606114324.GA7774@infradead.org>
In-Reply-To: <20050606114324.GA7774@infradead.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------080108030505060106000608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080108030505060106000608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Christoph Hellwig wrote:
> your check is wrong, it's testing whether the filesystem supports O_DIRECT, not
> whether sys_readahead is used on a file descriptor that has been opened with O_DIRECT

D'oh! You're right.

Jan


--------------080108030505060106000608
Content-Type: text/x-patch;
 name="filemap.c_direct_IO_readahead.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="filemap.c_direct_IO_readahead.diff"

do_readahead() doesn't make sense if the file is opened with O_DIRECT, 
since only the page cache is stuffed but never used.

Signed-off-by: Jan Blunck <j.blunck@tu-harburg.de>

 mm/filemap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: experimental-um/mm/filemap.c
===================================================================
--- experimental-um.orig/mm/filemap.c
+++ experimental-um/mm/filemap.c
@@ -1110,7 +1110,8 @@ static ssize_t
 do_readahead(struct address_space *mapping, struct file *filp,
 	     unsigned long index, unsigned long nr)
 {
-	if (!mapping || !mapping->a_ops || !mapping->a_ops->readpage)
+	if (!mapping || !mapping->a_ops || !mapping->a_ops->readpage
+	    || (filp->f_flags & O_DIRECT))
 		return -EINVAL;
 
 	force_page_cache_readahead(mapping, filp, index,

--------------080108030505060106000608--
