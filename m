Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264428AbTDOKbJ (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 06:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264429AbTDOKbJ (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 06:31:09 -0400
Received: from tmi.comex.ru ([217.10.33.92]:56468 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S264428AbTDOKbI (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 06:31:08 -0400
To: neilb@unsw.edu.au
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH-2.4] raid5 oopses on 2nd failed device
From: Alex Tomas <alexey@technomagesinc.com>
Organization: HOME
Date: Tue, 15 Apr 2003 14:42:29 +0400
Message-ID: <m3adest52i.fsf@tmi.comex.ru>
User-Agent: Gnus/5.090017 (Oort Gnus v0.17) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi!

it looks like raid5 is buggy. as 2nd device is failed, I got oops.
it's BUG at raid5.c:212. this is because sh->written[N] isn't NULL.
raid5d thread try to handle this stripe, but following condition
skip handling:

        /* might be able to return some write requests if the parity block
         * is safe, or on a failed drive
         */
        bh = sh->bh_cache[sh->pd_idx];
        if ( written &&
             ( (conf->disks[sh->pd_idx].operational && !buffer_locked(bh) && buffer_uptodate(bh))
               || (failed == 1 && failed_num == sh->pd_idx))
            ) {

I suggest to fail requests which can't be returned as successful.

with best regards


diff -puNr linux/drivers/md/raid5.c edited/drivers/md/raid5.c
--- linux/drivers/md/raid5.c	Wed Jan 15 20:18:37 2003
+++ edited/drivers/md/raid5.c	Tue Apr 15 12:59:24 2003
@@ -938,7 +938,19 @@ static void handle_stripe(struct stripe_
 		    }
 		}
 	}
-		
+	
+	/* if already written requests can't be returned as successful fail them */
+	if (failed > 1 && written) {
+		for (i=disks; i--; ) {
+			if (sh->bh_written[i]) written--;
+			while ((bh = sh->bh_written[i])) {
+				sh->bh_written[i] = bh->b_reqnext;
+				bh->b_reqnext = return_fail;
+				return_fail = bh;
+			}
+		}
+	}
+
 	/* Now we might consider reading some blocks, either to check/generate
 	 * parity, or to satisfy requests
 	 */

