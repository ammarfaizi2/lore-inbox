Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbTFJJxs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 05:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbTFJJxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 05:53:47 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:25051 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261414AbTFJJxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 05:53:12 -0400
Date: Tue, 10 Jun 2003 15:39:50 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Misc 2.5 Fixes: cp-user-cmpci
Message-ID: <20030610100950.GE2194@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030610100527.GA2194@in.ibm.com> <20030610100643.GB2194@in.ibm.com> <20030610100746.GC2194@in.ibm.com> <20030610100905.GD2194@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030610100905.GD2194@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fix copy/user problems. Not sure why cm_write() needs to do
acces_ok() on buffer twice. Also __get_user() return value isn't checked
in trans_ac3().


 sound/oss/cmpci.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff -puN sound/oss/cmpci.c~cp-user-cmpci sound/oss/cmpci.c
--- linux-2.5.70-ds/sound/oss/cmpci.c~cp-user-cmpci	2003-06-08 15:36:16.000000000 +0530
+++ linux-2.5.70-ds-dipankar/sound/oss/cmpci.c	2003-06-08 20:39:03.000000000 +0530
@@ -588,7 +588,8 @@ static void trans_ac3(struct cm_state *s
 	unsigned short *src = (unsigned short *)source;
 
 	do {
-		data = (unsigned long) *src++;
+		__get_user(data, src);
+		src++;
 		data <<= 12;			// ok for 16-bit data
 		if (s->spdif_counter == 2 || s->spdif_counter == 3)
 			data |= 0x40000000;	// indicate AC-3 raw data
@@ -1600,9 +1601,9 @@ static ssize_t cm_write(struct file *fil
 			return -ENXIO;
 		if (!s->dma_adc.ready && (ret = prog_dmabuf(s, 1)))
 			return ret;
-		if (!access_ok(VERIFY_READ, buffer, count))
-			return -EFAULT;
 	}
+	if (!access_ok(VERIFY_READ, buffer, count))
+		return -EFAULT;
 	ret = 0;
 
 	while (count > 0) {
@@ -1662,15 +1663,21 @@ static ssize_t cm_write(struct file *fil
 			swptr = (swptr + 2 * cnt) % s->dma_dac.dmasize;
 		} else if (s->status & DO_DUAL_DAC) {
 			int	i;
-			unsigned long *src, *dst0, *dst1;
+			unsigned long *src, *dst0, *dst1, data;
 
 			src = (unsigned long *) buffer;
 			dst0 = (unsigned long *) (s->dma_dac.rawbuf + swptr);
 			dst1 = (unsigned long *) (s->dma_adc.rawbuf + swptr);
 			// copy left/right sample at one time
 			for (i = 0; i <= cnt / 4; i++) {
-				*dst0++ = *src++;
-				*dst1++ = *src++;
+				if (__get_user(data, src))
+					return ret ? ret : -EFAULT;
+				*dst0++ = data;
+				src++;
+				if (__get_user(data, src))
+					return ret ? ret : -EFAULT;
+				*dst1++ = data;
+				src++;
 			}
 			swptr = (swptr + cnt) % s->dma_dac.dmasize;
 		} else {

_
