Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316358AbSEOGxX>; Wed, 15 May 2002 02:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316359AbSEOGxW>; Wed, 15 May 2002 02:53:22 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:38572 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S316358AbSEOGxV>;
	Wed, 15 May 2002 02:53:21 -0400
Date: Wed, 15 May 2002 16:52:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix for sigio delivery
Message-Id: <20020515165240.7bf90b58.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch means that we keep the upper 16 bits of the si_code
field of the siginfo structure that is delivered with and SIGIOs.
We need this so that the code that actually copies the siginfo_t
out to user mode knows which part of the union to copy.  We currently
get away with out this information because we always copy at least
two ints worth of the union, but this s an ugly hack and I would
like to tidy it up.

Comments?

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.15/fs/fcntl.c 2.5.15-si.3/fs/fcntl.c
--- 2.5.15/fs/fcntl.c	Tue Apr 23 10:42:27 2002
+++ 2.5.15-si.3/fs/fcntl.c	Wed May 15 16:46:48 2002
@@ -435,7 +435,7 @@
 			   back to SIGIO in that case. --sct */
 			si.si_signo = fown->signum;
 			si.si_errno = 0;
-		        si.si_code  = reason & ~__SI_MASK;
+		        si.si_code  = reason;
 			/* Make sure we are called with one of the POLL_*
 			   reasons, otherwise we could leak kernel stack into
 			   userspace.  */
