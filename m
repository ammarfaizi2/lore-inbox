Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264850AbTE1UEP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 16:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264854AbTE1UEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 16:04:15 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:60813 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264850AbTE1UEL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 16:04:11 -0400
Date: Wed, 28 May 2003 15:17:09 -0500
Subject: [CHECKER][PATCH] cmpci user-pointer fix
Content-Type: multipart/mixed; boundary=Apple-Mail-17-683902250
Mime-Version: 1.0 (Apple Message framework v552)
Cc: Junfeng Yang <yjf@stanford.edu>
To: linux-kernel@vger.kernel.org
From: Hollis Blanchard <hollisb@us.ibm.com>
Message-Id: <5C5CFB74-9149-11D7-8297-000A95A0560C@us.ibm.com>
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-17-683902250
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Here's what the Stanford tool said:
---------------------------------------------------------
[BUG] at least bad programming practice. file_operations.write ->
cm_write -> trans_ac3. write can take tainted. write can take tainted
inputs. the pointer is vefied in cm_write

/home/junfeng/linux-2.5.63/sound/oss/cmpci.c:593:trans_ac3:
ERROR:TAINTED:593:593: dereferencing tainted ptr 'src' [Callstack:
/home/junfeng/linux-2.5.63/fs/read_write.c:307:vfs_write((tainted
1)(tainted 2)) ->
/home/junfeng/linux-2.5.63/fs/read_write.c:241:cm_write((tainted
1)(tainted 2)) ->
/home/junfeng/linux-2.5.63/sound/oss/cmpci.c:1662:trans_ac3((tainted
2))]

         unsigned long data;
         unsigned long *dst = (unsigned long *) dest;
         unsigned short *src = (unsigned short *)source;

         do {

Error --->
                 data = (unsigned long) *src++;
                 data <<= 12;                    // ok for 16-bit data
                 if (s->spdif_counter == 2 || s->spdif_counter == 3)
---------------------------------------------------------
[BUG] at least bad programming practice. file_operations.write ->
cm_write -> trans_ac3. write can take tainted. write can take tainted
inputs. the pointer is vefied in cm_write

/home/junfeng/linux-2.5.63/sound/oss/cmpci.c:593:trans_ac3:
ERROR:TAINTED:593:593: dereferencing tainted ptr 'src' [Callstack:
/home/junfeng/linux-2.5.63/fs/read_write.c:307:vfs_write((tainted
1)(tainted 2)) ->
/home/junfeng/linux-2.5.63/fs/read_write.c:241:cm_write((tainted
1)(tainted 2)) ->
/home/junfeng/linux-2.5.63/sound/oss/cmpci.c:1662:trans_ac3((tainted
2))]

         unsigned long data;
         unsigned long *dst = (unsigned long *) dest;
         unsigned short *src = (unsigned short *)source;

         do {

Error --->
                 data = (unsigned long) *src++;
                 data <<= 12;                    // ok for 16-bit data
                 if (s->spdif_counter == 2 || s->spdif_counter == 3)
                         data |= 0x40000000;     // indicate AC-3 raw 
data
---------------------------------------------------------

I believe the attached patch fixes it. cm_write was calling access_ok, 
but after that you must still access user space through the 
get/put/copy*_user functions. It should be safe to return -EFAULT at 
these points in cm_write, since there are other returns already in the 
code above and below that. Compile-tested only.

Junfeng, the checker seems to have missed the "*dst0++ = *src++;" bits 
at the bottom of the patch... or at least it wasn't in the mail I saw 
("4 potential user-pointer errors", 2 May 2003).

-- 
Hollis Blanchard
IBM Linux Technology Center

--Apple-Mail-17-683902250
Content-Disposition: attachment;
	filename=cmpci-userptr.diff
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="cmpci-userptr.diff"

--- linux-2.5.70/sound/oss/cmpci.c.orig	Sat May 24 19:00:00 2003
+++ linux-2.5.70/sound/oss/cmpci.c	Wed May 28 14:53:15 2003
@@ -580,15 +580,17 @@
 	spin_unlock_irqrestore(&s->lock, flags);
 }
 
-static void trans_ac3(struct cm_state *s, void *dest, const char *source, int size)
+static int trans_ac3(struct cm_state *s, void *dest, const char *source, int size)
 {
 	int   i = size / 2;
+	int err;
 	unsigned long data;
 	unsigned long *dst = (unsigned long *) dest;
 	unsigned short *src = (unsigned short *)source;
 
 	do {
-		data = (unsigned long) *src++;
+		if ((err = __get_user(data, src++)))
+			return err;
 		data <<= 12;			// ok for 16-bit data
 		if (s->spdif_counter == 2 || s->spdif_counter == 3)
 			data |= 0x40000000;	// indicate AC-3 raw data
@@ -605,6 +607,8 @@
 		if (s->spdif_counter == 384)
 			s->spdif_counter = 0;
 	} while (--i);
+
+	return 0;
 }
 
 static void set_adc_rate_unlocked(struct cm_state *s, unsigned rate)
@@ -1655,13 +1659,16 @@
 			continue;
 		}
 		if (s->status & DO_AC3_SW) {
+			int err;
+
 			// clip exceeded data, caught by 033 and 037
 			if (swptr + 2 * cnt > s->dma_dac.dmasize)
 				cnt = (s->dma_dac.dmasize - swptr) / 2;
-			trans_ac3(s, s->dma_dac.rawbuf + swptr, buffer, cnt);
+			if ((err = trans_ac3(s, s->dma_dac.rawbuf + swptr, buffer, cnt)))
+				return err;
 			swptr = (swptr + 2 * cnt) % s->dma_dac.dmasize;
 		} else if (s->status & DO_DUAL_DAC) {
-			int	i;
+			int	i, err;
 			unsigned long *src, *dst0, *dst1;
 
 			src = (unsigned long *) buffer;
@@ -1669,8 +1676,10 @@
 			dst1 = (unsigned long *) (s->dma_adc.rawbuf + swptr);
 			// copy left/right sample at one time
 			for (i = 0; i <= cnt / 4; i++) {
-				*dst0++ = *src++;
-				*dst1++ = *src++;
+				if ((err = __get_user(*dst0++, src++)))
+					return err;
+				if ((err = __get_user(*dst1++, src++)))
+					return err;
 			}
 			swptr = (swptr + cnt) % s->dma_dac.dmasize;
 		} else {

--Apple-Mail-17-683902250--

