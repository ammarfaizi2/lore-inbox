Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbUCWDfX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 22:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbUCWDfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 22:35:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:3800 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262219AbUCWDfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 22:35:16 -0500
Date: Mon, 22 Mar 2004 19:35:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: piotr@larroy.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm1
Message-Id: <20040322193502.41704cda.akpm@osdl.org>
In-Reply-To: <20040322195450.GB2306@larroy.com>
References: <20040316015338.39e2c48e.akpm@osdl.org>
	<20040322125305.GA2306@larroy.com>
	<20040322073327.754a5b42.akpm@osdl.org>
	<20040322195450.GB2306@larroy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

piotr@larroy.com (Pedro Larroy) wrote:
>
> On Mon, Mar 22, 2004 at 07:33:27AM -0800, Andrew Morton wrote:
>  > piotr@larroy.com (Pedro Larroy) wrote:
>  > >
>  > > Where would kernel leaked ram be accounted?
>  > 
>  > /proc/meminfo, /proc/vmstat and /proc/slabinfo.  Also sysrq-M.

A memory leak was introduced in the ext3 changes.



 25-akpm/fs/jbd/commit.c |    8 ++++++++
 1 files changed, 8 insertions(+)

diff -puN fs/jbd/commit.c~jbd-move-locked-buffers-leak-fixes fs/jbd/commit.c
--- 25/fs/jbd/commit.c~jbd-move-locked-buffers-leak-fixes	2004-03-22 19:34:37.492865816 -0800
+++ 25-akpm/fs/jbd/commit.c	2004-03-22 19:34:41.987182576 -0800
@@ -296,6 +296,13 @@ write_out_data:
 		}
 	}
 
+	if (bufs) {
+		spin_unlock(&journal->j_list_lock);
+		ll_rw_block(WRITE, bufs, wbuf);
+		journal_brelse_array(wbuf, bufs);
+		spin_lock(&journal->j_list_lock);
+	}
+
 	/*
 	 * Wait for all previously submitted IO to complete.
 	 */
@@ -322,6 +329,7 @@ write_out_data:
 			jh->b_transaction = NULL;
 			jbd_unlock_bh_state(bh);
 			journal_remove_journal_head(bh);
+			put_bh(bh);
 		} else {
 			jbd_unlock_bh_state(bh);
 		}

_

