Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263780AbTE3QWr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 12:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263781AbTE3QWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 12:22:47 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:36270 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263780AbTE3QWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 12:22:46 -0400
Date: Fri, 30 May 2003 09:36:06 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: hch@infradead.org, robn@verdi.et.tudelft.nl, root@chaos.analogic.com,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br, sct@redhat.com
Subject: Re: 2.4 bug: fifo-write causes diskwrites to read-only fs !
Message-Id: <20030530093606.657a9ca2.akpm@digeo.com>
In-Reply-To: <1054307933.3749.313.camel@sisko.scot.redhat.com>
References: <Pine.LNX.4.53.0305281612160.13968@chaos>
	<200305282052.h4SKqUBw016537@verdi.et.tudelft.nl>
	<20030530132112.GA9572@redhat.com>
	<20030530155820.A11144@infradead.org>
	<1054307933.3749.313.camel@sisko.scot.redhat.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 May 2003 16:36:06.0880 (UTC) FILETIME=[918E2600:01C326C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" <sct@redhat.com> wrote:
>
> It's pure cut-and-paste from the update_atime immediately above it.  But
> sure, we can clean them both up while we're at it if you want.

2.5 seems to have gained a handy library function.

diff -puN fs/pipe.c~pipe-rofs-fix fs/pipe.c
--- 25/fs/pipe.c~pipe-rofs-fix	2003-05-30 09:33:29.000000000 -0700
+++ 25-akpm/fs/pipe.c	2003-05-30 09:34:08.000000000 -0700
@@ -208,10 +208,8 @@ pipe_write(struct file *filp, const char
 		wake_up_interruptible(PIPE_WAIT(*inode));
 		kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
 	}
-	if (ret > 0) {
-		inode->i_ctime = inode->i_mtime = CURRENT_TIME;
-		mark_inode_dirty(inode);
-	}
+	if (ret > 0)
+		inode_update_time(inode, 1);	/* mtime and ctime */
 	return ret;
 }
 

_

