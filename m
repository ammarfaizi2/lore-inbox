Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751912AbWCIVsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbWCIVsZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 16:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbWCIVsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 16:48:25 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:10632 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751912AbWCIVsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 16:48:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oIFsss2XS3Zu1OJ6H7Bc8xLfBxDKJKJYcw9QW1SqjTT2oYQgxKju5H3TRNzjt5kelNBwRQ5F/Ohjd1KJOM4b/Dwn3E++SjPCNAZ7k/fr7nCS5hK+F8eXJxWUJ/KnyssGvDAemm72V5xovzrVNSWBPa9ryY2wKSqa89uZA25IaMc=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix unlikely NULL pointer deref in kallsyms
Date: Thu, 9 Mar 2006 22:48:47 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603092248.47344.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The Coverity checker noticed that kallsyms may dereference a NULL pointer 
(in two places) in the function write_src() if malloc() fails.
In addition, malloc() returns a void*, so there's no need to cast the 
return value.

The amount requested is small, so this is unlikely to happen, but not 
impossible.

To fix the problem, if malloc() should fail, print a descriptive error and 
exit.
A lot better than just dereferencing a NULL pointer and crashing.

This fixes coverity bug #398


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 scripts/kallsyms.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

--- linux-2.6.16-rc5-git12-orig/scripts/kallsyms.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-rc5-git12/scripts/kallsyms.c	2006-03-09 22:41:17.000000000 +0100
@@ -272,7 +272,12 @@ static void write_src(void)
 
 	/* table of offset markers, that give the offset in the compressed stream
 	 * every 256 symbols */
-	markers = (unsigned int *) malloc(sizeof(unsigned int) * ((table_cnt + 255) / 256));
+	markers = malloc(sizeof(unsigned int) * ((table_cnt + 255) / 256));
+	if (!markers) {
+		fprintf(stderr, "kallsyms failure: "
+			"unable to allocate required memory\n");
+		exit(EXIT_FAILURE);
+	}
 
 	output_label("kallsyms_names");
 	off = 0;



