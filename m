Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130548AbRAATsu>; Mon, 1 Jan 2001 14:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130754AbRAATsk>; Mon, 1 Jan 2001 14:48:40 -0500
Received: from zeus.kernel.org ([209.10.41.242]:32781 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130548AbRAATsc>;
	Mon, 1 Jan 2001 14:48:32 -0500
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] cs46xx deadlocks in non-blocking read
From: David Huggins-Daines <dhd@eradicator.org>
Organization: None worth mentioning
Date: 01 Jan 2001 14:17:02 -0500
Message-ID: <87y9wvhykx.fsf@monolith.cepstral.com>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch, the cs46xx driver in 2.4-prelease (well, in
-test12, at least) will hang the machine as soon as someone tries to
read from it in non-blocking mode.

The cs_read() function already removes the wait queue on exit, so it's
basically a correctness fix.

I've already sent this to Nils/Thomas but since it hasn't materialized
in prerelease or ac1, and since it's quite small and needed for a
number of things to function correctly, I'm sending it again in the
hopes that it will get applied before 2.4 final.

Cheers

--- linux-2.4/drivers/sound/cs46xx.c~	Sun Dec 31 18:24:54 2000
+++ linux-2.4/drivers/sound/cs46xx.c	Mon Jan  1 14:03:19 2001
@@ -1971,7 +1971,6 @@
 			start_adc(state);
 			if (file->f_flags & O_NONBLOCK) {
 				if (!ret) ret = -EAGAIN;
-				remove_wait_queue(&state->dmabuf.wait, &wait);
 				break;
  			}
 			schedule();

-- 
David Huggins-Daines		-		dhd@eradicator.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
