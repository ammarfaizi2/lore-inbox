Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbUCRWa0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 17:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUCRWa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 17:30:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:57991 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261340AbUCRWaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 17:30:07 -0500
Date: Thu, 18 Mar 2004 14:32:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: andrea@suse.de, mjy@geizhals.at, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-Id: <20040318143205.6a9c4e89.akpm@osdl.org>
In-Reply-To: <s5hlllycgz3.wl@alsa2.suse.de>
References: <40591EC1.1060204@geizhals.at>
	<20040318060358.GC29530@dualathlon.random>
	<s5hlllycgz3.wl@alsa2.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai@suse.de> wrote:
>
> --- linux-2.6.4-8/fs/jbd/commit.c-dist	2004-03-16 23:00:40.000000000 +0100
> +++ linux-2.6.4-8/fs/jbd/commit.c	2004-03-18 02:42:41.043448624 +0100
> @@ -290,6 +290,9 @@ write_out_data_locked:
>  			commit_transaction->t_sync_datalist = jh;
>  			break;
>  		}
> +
> +		if (need_resched())
> +			break;
>  	} while (jh != last_jh);
>  
>  	if (bufs || need_resched()) {

Yup, this has problems.

What we're doing here is walking (under spinlock) a ring of buffers
searching for unlocked dirty ones to write out.

Suppose the ring has thousands of locked buffers and there is a RT task
scheduling at 1kHz.  Each time need_resched() comes true we break out of
the search, schedule away and then restart the search from the beginning.

So if the time to walk that ring of buffers exceeds one millisecond the
kernel will make no progress.  Eventually things will fix themselves up as
the I/O completes against those buffers but in the meanwhile we chew 100%
of CPU.

A few lines higher up we advance the searching start point so the next
search will start at the current position.  But that's when it is known
that we made some forward progress.  In the above patch we are vulnerable
to the situation where _all_ of the buffers on that ring are locked.

The below might suit, although I haven't tested it.  It needs careful
testing too - it will impact I/O scheduling efficiency.



--- 25/fs/jbd/commit.c~a	Thu Mar 18 14:23:40 2004
+++ 25-akpm/fs/jbd/commit.c	Thu Mar 18 14:28:46 2004
@@ -280,6 +280,22 @@ write_out_data_locked:
 					goto write_out_data;
 				}
 			}
+		} else if (need_resched()) {
+			/*
+			 * A locked buffer, and we're being a CPU pig.  We
+			 * cannot just schedule away because it may be the case
+			 * that *all* the buffers are locked.  So let's just
+			 * wait until this buffer has been written.
+			 *
+			 * If we already have some buffers in wbuf[] then fine,
+			 * we're making forward progress.
+			 */
+			if (bufs)
+				break;
+			commit_transaction->t_sync_datalist = jh;
+			spin_unlock(&journal->j_list_lock);
+			wait_on_buffer(bh);
+			goto write_out_data;
 		}
 		if (bufs == ARRAY_SIZE(wbuf)) {
 			/*

_

