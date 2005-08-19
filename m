Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbVHWPRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVHWPRT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 11:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbVHWPRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 11:17:18 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:2596 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S932201AbVHWPRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 11:17:17 -0400
Message-ID: <4305D437.4000703@tu-harburg.de>
Date: Fri, 19 Aug 2005 14:44:39 +0200
From: Jan Blunck <j.blunck@tu-harburg.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
CC: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][RESEND] don't allow sys_readahead() on files opened with
 O_DIRECT
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------000306080506000606030003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000306080506000606030003
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

IMO sys_readahead() doesn't make sense if the file is opened with
O_DIRECT, because the page cache is stuffed but never used. Therefore
this patch changes that by letting the call return with -EINVAL.

Signed-off-by: Jan Blunck <j.blunck@tu-harburg.de>


--------------000306080506000606030003
Content-Type: text/x-patch;
 name="filemap.c_direct_IO_readahead.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="filemap.c_direct_IO_readahead.diff"

 mm/filemap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: experimental-jb/mm/filemap.c
===================================================================
--- experimental-jb.orig/mm/filemap.c
+++ experimental-jb/mm/filemap.c
@@ -1111,7 +1111,8 @@ static ssize_t
 do_readahead(struct address_space *mapping, struct file *filp,
 	     unsigned long index, unsigned long nr)
 {
-	if (!mapping || !mapping->a_ops || !mapping->a_ops->readpage)
+	if (!mapping || !mapping->a_ops || !mapping->a_ops->readpage
+	    || (filp->f_flags & O_DIRECT))
 		return -EINVAL;
 
 	force_page_cache_readahead(mapping, filp, index,

--------------000306080506000606030003--

