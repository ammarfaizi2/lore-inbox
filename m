Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVFAHlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVFAHlL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 03:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVFAHlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 03:41:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60389 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261317AbVFAHlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 03:41:00 -0400
Date: Wed, 1 Jun 2005 09:40:59 +0200
From: Jan Kara <jack@suse.cz>
To: akpm@osdl.org
Cc: sct@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix log_do_checkpoint() assertion failure
Message-ID: <20050601074059.GD5933@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5G06lTa6Jq83wMTw"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  attached one liner fixes possible false assertion failure in
log_do_checkpoint(). We might fail to detect that we actually made a
progress when cleaning up the checkpoint lists if we don't retry after
writing something to disk. The patch was confirmed to fix observed
assertion failures for several users. Please apply.

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jbd-2.6.12-rc5-1-checkretry.diff"

When we flushed some buffers we need to retry scanning the list.
Otherwise we can fail to detect our progress.

Signed-off-by: Jan Kara <jack@suse.cz>

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

--5G06lTa6Jq83wMTw--
