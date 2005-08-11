Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbVHKOgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbVHKOgh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 10:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbVHKOgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 10:36:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20665 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751047AbVHKOgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 10:36:36 -0400
Message-ID: <42FB6255.10807@redhat.com>
Date: Thu, 11 Aug 2005 10:36:05 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH]  largefile support for accounting
Content-Type: multipart/mixed;
 boundary="------------000907000206010901000609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000907000206010901000609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

There is a problem in the accounting subsystem in the kernel can not
correctly handle files larger than 2GB.  The output file containing
the process accounting data can grow very large if the system is large
enough and active enough.  If the 2GB limit is reached, then the system
simply stops storing process accounting data.

Another annoying problem is that once the system reaches this 2GB limit,
then every process which exits will receive a signal, SIGXFSZ.  This
signal is generated because an attempt was made to write beyond the limit
for the file descriptor.  This signal makes it look like every process
has exited due to a signal, when in fact, they have not.

The solution is to add the O_LARGEFILE flag to the list of flags used
to open the accounting file.  The rest of the accounting support is
already largefile safe.

The changes were tested by constructing a large file (just short of 2GB),
enabling accounting, and then running enough commands to cause the
accounting data generated to increase the size of the file to 2GB.  Without
the changes, the file grows to 2GB and the last command run in the test
script appears to exit due a signal when it has not.  With the changes,
things work as expected and quietly.

There are some user level changes required so that it can deal with
largefiles, but those are being handled separately.

Signed-off-by: Peter Staubach <staubach@redhat.com>

--------------000907000206010901000609
Content-Type: text/plain;
 name="devel"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="devel"

--- linux-2.6.12/kernel/acct.c.org	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.12/kernel/acct.c	2005-08-10 15:12:46.000000000 -0400
@@ -220,7 +220,7 @@ asmlinkage long sys_acct(const char __us
 			return (PTR_ERR(tmp));
 		}
 		/* Difference from BSD - they don't do O_APPEND */
-		file = filp_open(tmp, O_WRONLY|O_APPEND, 0);
+		file = filp_open(tmp, O_WRONLY | O_APPEND | O_LARGEFILE, 0);
 		putname(tmp);
 		if (IS_ERR(file)) {
 			return (PTR_ERR(file));

--------------000907000206010901000609--
