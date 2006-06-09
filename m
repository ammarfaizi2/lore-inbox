Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWFIILY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWFIILY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 04:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWFIILY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 04:11:24 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:22170 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751433AbWFIILW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 04:11:22 -0400
Message-ID: <349840678.85381@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060609081119.231751179@localhost.localdomain>
References: <20060609080801.741901069@localhost.localdomain>
Date: Fri, 09 Jun 2006 16:08:02 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 1/5] readahead: no RA_FLAG_EOF on single page file
Content-Disposition: inline; filename=readahead-reduce-close-call.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dot not set RA_FLAG_EOF on single page files.

readahead_close() will be called if RA_FLAG_EOF is there on file close.
It detects readahead hit/miss, and adjust ra_expected_bytes correspondingly.
Single page files are uninteresting for it. Since near 40% desktop
files are <= 4k, this patch can reduce many useless readahead_close()
invocations.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


--- linux-2.6.17-rc5-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc5-mm3/mm/readahead.c
@@ -1037,7 +1037,8 @@ static int ra_dispatch(struct file_ra_st
 		ra->readahead_index = eof_index;
 		if (ra->lookahead_index > eof_index)
 			ra->lookahead_index = eof_index;
-		ra->flags |= RA_FLAG_EOF;
+		if (eof_index > 1)
+			ra->flags |= RA_FLAG_EOF;
 	}
 
 	/* Disable look-ahead for loopback file. */

--
