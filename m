Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276831AbRJZA0A>; Thu, 25 Oct 2001 20:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276832AbRJZAZw>; Thu, 25 Oct 2001 20:25:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:130 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S276831AbRJZAZg>;
	Thu, 25 Oct 2001 20:25:36 -0400
Date: Thu, 25 Oct 2001 17:25:41 -0700 (PDT)
Message-Id: <20011025.172541.102577469.davem@redhat.com>
To: axboe@suse.de
Cc: ch@westend.com, harlan@artselect.com, linux-kernel@vger.kernel.org
Subject: SCSI tape crashes (was Re: BUG() in asm/pci.h:142 with 2.4.13)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011025193248.J4795@suse.de>
In-Reply-To: <20011025131107.C4795@suse.de>
	<20011025192351.A9823@westend.com>
	<20011025193248.J4795@suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jens Axboe <axboe@suse.de>
   Date: Thu, 25 Oct 2001 19:32:48 +0200

   On Thu, Oct 25 2001, Christian Hammers wrote:
   > This patch did not prevent the crash. Again immediately after rewinding the
   > tape when it began to write. I'll try now the 2.4.12-ac6... and it works.
   
   Ok, someone else is meddling with the scatterlist then. I'll take a 2nd
   look.

Can people try out this patch?  I believe this will fix the bug.

--- drivers/scsi/st.c.~1~	Sun Oct 21 02:47:53 2001
+++ drivers/scsi/st.c	Thu Oct 25 17:23:45 2001
@@ -3233,6 +3233,7 @@
 				break;
 			}
 		}
+		tb->sg[0].page = NULL;
 		if (tb->sg[segs].address == NULL) {
 			kfree(tb);
 			tb = NULL;
@@ -3264,6 +3265,7 @@
 					tb = NULL;
 					break;
 				}
+				tb->sg[segs].page = NULL;
 				tb->sg[segs].length = b_size;
 				got += b_size;
 				segs++;
@@ -3337,6 +3339,7 @@
 			normalize_buffer(STbuffer);
 			return FALSE;
 		}
+		STbuffer->sg[segs].page = NULL;
 		STbuffer->sg[segs].length = b_size;
 		STbuffer->sg_segs += 1;
 		got += b_size;
