Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbWCWHKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbWCWHKO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 02:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWCWHKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 02:10:14 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:39813 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932480AbWCWHKM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 02:10:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CZCNnY8osOj2tmpwPcNVAedR2DJ7S6GPuclxw0dYzVhPQE6yNNRzu+wGbzjxY8TpA0GR5gKEVORNWJUu+NMITWSBz8T1onwYv6Q+P6IyUqa+PRQQJVDjFvd5KgSYY5MjbzFspEB+Fr6Nvip2gA7VBGSOMecQaMHW6Z9AtnG0aak=
Message-ID: <489ecd0c0603222310j3f2b9804k30bca1adce33804d@mail.gmail.com>
Date: Thu, 23 Mar 2006 15:10:11 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix bug: flat binary loader doesn't check fd table full
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

   In the binfmt_flat.c, the flat binary loader should check file
descriptor table and install the fd on the file.

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 108d56b..6388187 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -493,6 +493,13 @@ static int load_flat_file(struct linux_b
        if (data_len + bss_len > rlim)
                return -ENOMEM;

+       /* check file descriptor */
+       int retval = get_unused_fd();
+       if (retval < 0)
+               return -EMFILE;
+       get_file(bprm->file);
+       fd_install(retval, bprm->file);
+
        /* Flush all traces of the currently running executable */
        if (id == 0) {
                result = flush_old_exec(bprm);

signed-off-by: Luke Yang <luke.adi@gmail.com>
--
Best regards,
Luke Yang
magic.yyang@gmail.com; luke.adi@gmail.com
