Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265647AbSJSSGY>; Sat, 19 Oct 2002 14:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265648AbSJSSGY>; Sat, 19 Oct 2002 14:06:24 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:30609 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S265647AbSJSSGX>;
	Sat, 19 Oct 2002 14:06:23 -0400
Message-ID: <3DB1A09A.2070704@colorfullife.com>
Date: Sat, 19 Oct 2002 20:12:42 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] use correct wakeups in fs/pipe.c
Content-Type: multipart/mixed;
 boundary="------------080109000108040808000102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080109000108040808000102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

wake_up_interruptible() and _sync() calls are reversed in pipe_read().

The attached patches only calls _sync if a schedule() call follows.

--
	Manfred

--------------080109000108040808000102
Content-Type: text/plain;
 name="patch-pipefix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-pipefix"

--- 2.5/fs/pipe.c	Sat Oct 19 11:40:14 2002
+++ build-2.5/fs/pipe.c	Sat Oct 19 19:44:04 2002
@@ -109,7 +109,7 @@
 			break;
 		}
 		if (do_wakeup) {
-			wake_up_interruptible(PIPE_WAIT(*inode));
+			wake_up_interruptible_sync(PIPE_WAIT(*inode));
  			kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
 		}
 		pipe_wait(inode);
@@ -117,7 +117,7 @@
 	up(PIPE_SEM(*inode));
 	/* Signal writers asynchronously that there is more room.  */
 	if (do_wakeup) {
-		wake_up_interruptible_sync(PIPE_WAIT(*inode));
+		wake_up_interruptible(PIPE_WAIT(*inode));
 		kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
 	}
 	if (ret > 0)

--------------080109000108040808000102--

