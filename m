Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293447AbSCUGUD>; Thu, 21 Mar 2002 01:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293448AbSCUGTx>; Thu, 21 Mar 2002 01:19:53 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:58891 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S293447AbSCUGTl>;
	Thu, 21 Mar 2002 01:19:41 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15513.30999.494913.910369@gargle.gargle.HOWL>
Date: Thu, 21 Mar 2002 17:09:27 +1100
From: Christopher Yeoh <cyeoh@samba.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] fcntl returns wrong error code
X-Mailer: VM 7.03 under Emacs 21.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When fcntl(fd, F_DUPFD, b) is called where 'b' is greater than the
maximum allowable value EINVAL should be returned. From POSIX:

"[EINVAL] The cmd argument is invalid, or the cmd argument is F_DUPFD and
arg is negative or greater than or equal to {OPEN_MAX}, or ..."

Currently we instead return EMFILE. The following patch (against
2.4.19pre-4) fixes this behaviour:

--- linux-2.4.18/fs/fcntl.c~	Mon Sep 24 05:13:11 2001
+++ linux-2.4.18/fs/fcntl.c	Thu Mar 21 16:50:06 2002
@@ -120,8 +120,13 @@
 	int ret;
 
 	ret = locate_fd(files, file, start);
-	if (ret < 0) 
+	if (ret < 0) {
+		/* We should return EINVAL instead of EMFILE if the
+		   request for the fd starts beyond the valid range */
+		if (ret==-EMFILE && start>=current->rlim[RLIMIT_NOFILE].rlim_cur)
+			ret = -EINVAL;
 		goto out_putf;
+	}
 	allocate_fd(files, file, ret);
 	return ret;

Chris.
-- 
cyeoh@au.ibm.com
IBM OzLabs Linux Development Group
Canberra, Australia
