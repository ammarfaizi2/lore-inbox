Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVFAHuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVFAHuh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 03:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVFAHuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 03:50:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59110 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261321AbVFAHuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 03:50:11 -0400
Date: Wed, 1 Jun 2005 09:50:08 +0200
From: Jan Kara <jack@suse.cz>
To: akpm@osdl.org
Cc: sct@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix list scanning in __cleanup_transaction
Message-ID: <20050601075008.GE5933@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZJcv+A0YCCLh2VIg"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZJcv+A0YCCLh2VIg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  attached patch fixes a bug in list scanning that can cause we skip the
last buffer on the checkpoint list (and hence fail to do any progress
under some rather unfavorable conditions). The problem is we first do
jh=next_jh and then test } while (jh!=last_jh); . Hence we skip the last
buffer on the list (if it was not the only buffer on the list). As we
already do jh=next_jh; in the beginning of the loop we are safe to just
remove the assignment in the end. It can happen that 'jh' will be freed
at the point we test jh != last_jh but that does not matter as we never
*dereference* the pointer. Please apply.

								Honza 

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--ZJcv+A0YCCLh2VIg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jbd-2.6.12-rc5-2-checkskip.diff"

We already move to the next member of the list in the beginning of the loop.
When we move in the end of the loop we can unintentionally forget to scan
the last buffer of the list.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.12-rc5-1-checkretry/fs/jbd/checkpoint.c linux-2.6.12-rc5-2-checkskip/fs/jbd/checkpoint.c
--- linux-2.6.12-rc5-1-checkretry/fs/jbd/checkpoint.c	2005-05-27 11:15:31.000000000 +0200
+++ linux-2.6.12-rc5-2-checkskip/fs/jbd/checkpoint.c	2005-05-27 11:18:08.000000000 +0200
@@ -188,7 +188,6 @@ static int __cleanup_transaction(journal
 		} else {
 			jbd_unlock_bh_state(bh);
 		}
-		jh = next_jh;
 	} while (jh != last_jh);
 
 	return ret;

--ZJcv+A0YCCLh2VIg--
