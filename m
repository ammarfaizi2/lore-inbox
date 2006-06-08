Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbWFHS3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWFHS3x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 14:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbWFHS3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 14:29:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2467 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964928AbWFHS3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 14:29:52 -0400
Message-ID: <44886C9F.7030807@redhat.com>
Date: Thu, 08 Jun 2006 14:29:51 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.4.1 (X11/20060420)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ftruncate does not always update m/ctime
Content-Type: multipart/mixed;
 boundary="------------010900010104030001010004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010900010104030001010004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

In the course of trying to track down a bug where a file mtime was not
being updated correctly, it was discovered that the m/ctime updates were
not quite being handled correctly for ftruncate() calls.

Quoth SUSv3:

open(2):

        If O_TRUNC is set and the file did previously exist, upon
        successful completion, open() shall mark for update the st_ctime
        and st_mtime fields of the file.

truncate(2):

        Upon successful completion, if the file size is changed, this
        function shall mark for update the st_ctime and st_mtime fields
        of the file, and the S_ISUID and S_ISGID bits of the file mode
        may be cleared.

ftruncate(2):

        Upon successful completion, if fildes refers to a regular file,
        the ftruncate() function shall mark for update the st_ctime and
        st_mtime fields of the file and the S_ISUID and S_ISGID bits of
        the file mode may be cleared. If the ftruncate() function is
        unsuccessful, the file is unaffected.

The open(O_TRUNC) and truncate cases were being handled correctly, but
the ftruncate case was being handled like the truncate case.  The
semantics of truncate and ftruncate don't quite match, so ftruncate
needs to be handled slightly differently.

The attached patch should address this issue for ftruncate(2).

My thanx to Stephen Tweedie and Trond Myklebust for their help in
understanding the situation and semantics.

    Thanx...

       ps

Signed-off-by: Peter Staubach <staubach@redhat.com>

--------------010900010104030001010004
Content-Type: text/plain;
 name="ftruncate_mtime.devel"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ftruncate_mtime.devel"

--- linux-2.6.16.x86_64/fs/open.c.org
+++ linux-2.6.16.x86_64/fs/open.c
@@ -322,7 +322,7 @@ static long do_sys_ftruncate(unsigned in
 
 	error = locks_verify_truncate(inode, file, length);
 	if (!error)
-		error = do_truncate(dentry, length, 0, file);
+		error = do_truncate(dentry, length, ATTR_MTIME|ATTR_CTIME, file);
 out_putf:
 	fput(file);
 out:

--------------010900010104030001010004--
