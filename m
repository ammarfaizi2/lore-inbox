Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTJFOYc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 10:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbTJFOYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 10:24:32 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:56203 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S262110AbTJFOYa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 10:24:30 -0400
Message-ID: <3F817BEC.8090006@terra.com.br>
Date: Mon, 06 Oct 2003 11:27:56 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: gadio@netvision.net.il
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] copy_{to|from}_user checks in ide-tape
Content-Type: multipart/mixed;
 boundary="------------000808040000020805000209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000808040000020805000209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Gadi,

(unchecked values found by smatch).

	Patch against 2.6-test6.

	idetape_copy_stage_{from|to}_user assume that copy_{from|to}_user 
will always return 0, which seems wrong.

	*But* I'm not sure if the copy fails we should "return" or "continue" 
to try again. This patch follows the former approach.

	In either case, if we fail and give up at some point, there's no way 
to return the error code, since these functions return void. I don't 
know squad about this driver, but I think this kind of "assumes 
everything will turn out OK" API is wrong.

	Please consider applying and let me know if you want to re-implement 
the copy_stage functions to return a OK/Non-OK value.

	Cheers,

Felipe

--------------000808040000020805000209
Content-Type: text/plain;
 name="ide-tape_copy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-tape_copy.patch"

--- linux-2.6.0-test6/drivers/ide/ide-tape.c.orig	2003-10-06 11:13:00.000000000 -0300
+++ linux-2.6.0-test6/drivers/ide/ide-tape.c	2003-10-06 11:17:42.000000000 -0300
@@ -3026,7 +3026,8 @@
 		}
 #endif /* IDETAPE_DEBUG_BUGS */
 		count = min((unsigned int)(bh->b_size - atomic_read(&bh->b_count)), (unsigned int)n);
-		copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf, count);
+		if (copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf, count))
+			return;
 		n -= count;
 		atomic_add(count, &bh->b_count);
 		buf += count;
@@ -3053,7 +3054,8 @@
 		}
 #endif /* IDETAPE_DEBUG_BUGS */
 		count = min(tape->b_count, n);
-		copy_to_user(buf, tape->b_data, count);
+		if (copy_to_user(buf, tape->b_data, count))
+			return;
 		n -= count;
 		tape->b_data += count;
 		tape->b_count -= count;

--------------000808040000020805000209--

