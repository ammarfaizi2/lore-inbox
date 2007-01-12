Return-Path: <linux-kernel-owner+w=401wt.eu-S1161055AbXALJ4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161055AbXALJ4h (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 04:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbXALJ4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 04:56:37 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:54568 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with SMTP id S1161055AbXALJ4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 04:56:36 -0500
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jan 2007 04:56:35 EST
Message-ID: <45A75906.5050609@dev.rtsoft.ru>
Date: Fri, 12 Jan 2007 12:46:46 +0300
From: Dmitry Antipov <antipov@dev.rtsoft.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.20-rc4: force fcntl(..., FASYNC) to return -EINVAL when
 f_op->fasync is NULL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is a proposal fix needed to receive an error when the user requests
'fcntl(fd, F_SETFL, FASYNC)' but lower levels are too poor to handle this.

Dmitry

--- .orig-2.6.20-rc4/fs/fcntl.c	2007-01-12 08:27:10.000000000 +0300
+++ 2.6.20-rc4/fs/fcntl.c	2007-01-12 09:56:14.000000000 +0300
@@ -236,11 +236,11 @@

  	lock_kernel();
  	if ((arg ^ filp->f_flags) & FASYNC) {
-		if (filp->f_op && filp->f_op->fasync) {
+		error = -EINVAL;
+		if (filp->f_op && filp->f_op->fasync)
  			error = filp->f_op->fasync(fd, filp, (arg & FASYNC) != 0);
-			if (error < 0)
-				goto out;
-		}
+		if (error < 0)
+			goto out;
  	}

  	filp->f_flags = (arg & SETFL_MASK) | (filp->f_flags & ~SETFL_MASK);
