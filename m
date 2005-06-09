Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbVFIAV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbVFIAV6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 20:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVFIAVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 20:21:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:5772 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262228AbVFIATU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 20:19:20 -0400
Date: Wed, 8 Jun 2005 17:18:15 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, jack@suse.cz, sct@redhat.com
Subject: [patch 07/09] ext3: fix log_do_checkpoint() assertion failure
Message-ID: <20050609001815.GN13152@shell0.pdx.osdl.net>
References: <20050608234637.GG13152@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608234637.GG13152@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix possible false assertion failure in log_do_checkpoint(). We might fail
to detect that we actually made a progress when cleaning up the checkpoint
lists if we don't retry after writing something to disk. The patch was
confirmed to fix observed assertion failures for several users.

When we flushed some buffers we need to retry scanning the list.
Otherwise we can fail to detect our progress.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.12-rc5/fs/jbd/checkpoint.c linux-2.6.12-rc5-1-checkretry/fs/jbd/checkpoint.c
--- linux-2.6.12-rc5/fs/jbd/checkpoint.c	2005-03-03 18:58:29.000000000 +0100
+++ linux-2.6.12-rc5-1-checkretry/fs/jbd/checkpoint.c	2005-05-27 11:15:31.000000000 +0200
@@ -339,8 +339,10 @@ int log_do_checkpoint(journal_t *journal
 			}
 		} while (jh != last_jh && !retry);
 
-		if (batch_count)
+		if (batch_count) {
 			__flush_batch(journal, bhs, &batch_count);
+			retry = 1;
+		}
 
 		/*
 		 * If someone cleaned up this transaction while we slept, we're
