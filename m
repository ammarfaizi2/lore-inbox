Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263147AbRFEDkT>; Mon, 4 Jun 2001 23:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263149AbRFEDkI>; Mon, 4 Jun 2001 23:40:08 -0400
Received: from hera.cwi.nl ([192.16.191.8]:61943 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S263145AbRFEDkB>;
	Mon, 4 Jun 2001 23:40:01 -0400
Date: Tue, 5 Jun 2001 05:39:47 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106050339.FAA180067.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, mdharm-kernel@one-eyed-alien.net
Subject: Re: Unit attention in USB storage
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> [things work better when "Unit Attention: not ready to ready transition"
>> is not regarded as an error]

> I suggest trying this with 2.4.5 -- several people report that kernel
> works much better than previous ones with usb-storage.

The details of the behaviour are a bit different, but the essence
is unchanged: with the same .config as the 2.4.3 I reported on,
2.4.5 failed. (With a different one it was successful. It is a
matter of timing.) Again adding the patch:

diff -r -u ../linux-2.4.5/linux/drivers/usb/storage/debug.c linux/drivers/usb/storage/debug.c
--- ../linux-2.4.5/linux/drivers/usb/storage/debug.c    Sat Sep  9 01:39:12 2000
+++ linux/drivers/usb/storage/debug.c   Tue Jun  5 05:23:46 2001
@@ -302,6 +302,8 @@
        case 0x1C00: what="defect list not found"; break;
        case 0x2400: what="invalid field in CDB"; break;
        case 0x2703: what="associated write protect"; break;
+       case 0x2800: what="not ready to ready transtion (media change?)";
+               break;
        case 0x2903: what="bus device reset function occurred"; break;
        case 0x2904: what="device internal reset"; break;
        case 0x2B00: what="copy can't execute since host can't disconnect"; 
diff -r -u ../linux-2.4.5/linux/drivers/usb/storage/transport.c linux/drivers/usb/storage/transport.c
--- ../linux-2.4.5/linux/drivers/usb/storage/transport.c        Wed Apr 18 20:49:12 2001
+++ linux/drivers/usb/storage/transport.c       Tue Jun  5 05:23:13 2001
@@ -793,6 +793,15 @@
                /* If things are really okay, then let's show that */
                if ((srb->sense_buffer[2] & 0xf) == 0x0)
                        srb->result = GOOD << 1;
+
+               /* A transition from non-ready to ready sounds OK. */
+               if ((srb->sense_buffer[2] & 0xf) == 0x6 /* unit attention */
+                   && srb->sense_buffer[12] == 0x28
+                   && srb->sense_buffer[13] == 0 /* not ready -> ready */) {
+                       srb->result = GOOD << 1;
+                       srb->sense_buffer[0] = 0;
+               }
+
        } else /* if (need_auto_sense) */
                srb->result = GOOD << 1;
 
makes things work.

Andries
