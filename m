Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbVAaCaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbVAaCaU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 21:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVAaCaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 21:30:20 -0500
Received: from fire.osdl.org ([65.172.181.4]:35033 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261894AbVAaCaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 21:30:00 -0500
Message-ID: <41FD9620.3010708@osdl.org>
Date: Sun, 30 Jan 2005 18:21:20 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, akpm <akpm@osdl.org>
Subject: [PATCH] wavefront: reduce stack usage
Content-Type: multipart/mixed;
 boundary="------------010503080804040902050305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010503080804040902050305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Reduce local stack usage in wavefront_load_gus_patch()
from 984 bytes to 140 bytes (on x86-32) by using kmalloc()
instead of stack for these 840 bytes:
	wavefront_patch_info samp, pat, prog; // 3 * 280

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
  sound/oss/wavfront.c |   56 
+++++++++++++++++++++++++++++++--------------------
  1 files changed, 35 insertions(+), 21 deletions(-)

--------------010503080804040902050305
Content-Type: text/x-patch;
 name="wavfront_stack.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wavfront_stack.patch"


diff -Naurp ./sound/oss/wavfront.c~wavfront_stack ./sound/oss/wavfront.c
--- ./sound/oss/wavfront.c~wavfront_stack	2004-10-18 14:54:32.000000000 -0700
+++ ./sound/oss/wavfront.c	2004-12-22 14:44:22.330034016 -0800
@@ -1516,45 +1516,56 @@ wavefront_load_gus_patch (int devno, int
 			  int offs, int count, int pmgr_flag)
 {
 	struct patch_info guspatch;
-	wavefront_patch_info samp, pat, prog;
+	wavefront_patch_info *samp, *pat, *prog;
 	wavefront_patch *patp;
 	wavefront_sample *sampp;
 	wavefront_program *progp;
 
 	int i,base_note;
 	long sizeof_patch;
+	int rc = -ENOMEM;
+
+	samp = kmalloc(3 * sizeof(wavefront_patch_info), GFP_KERNEL);
+	if (!samp)
+		goto free_fail;
+	pat = samp + 1;
+	prog = pat + 1;
 
 	/* Copy in the header of the GUS patch */
 
 	sizeof_patch = (long) &guspatch.data[0] - (long) &guspatch; 
 	if (copy_from_user(&((char *) &guspatch)[offs],
-			   &(addr)[offs], sizeof_patch - offs))
-		return -EFAULT;
+			   &(addr)[offs], sizeof_patch - offs)) {
+		rc = -EFAULT;
+		goto free_fail;
+	}
 
 	if ((i = wavefront_find_free_patch ()) == -1) {
-		return -EBUSY;
+		rc = -EBUSY;
+		goto free_fail;
 	}
-	pat.number = i;
-	pat.subkey = WF_ST_PATCH;
-	patp = &pat.hdr.p;
+	pat->number = i;
+	pat->subkey = WF_ST_PATCH;
+	patp = &pat->hdr.p;
 
 	if ((i = wavefront_find_free_sample ()) == -1) {
-		return -EBUSY;
+		rc = -EBUSY;
+		goto free_fail;
 	}
-	samp.number = i;
-	samp.subkey = WF_ST_SAMPLE;
-	samp.size = guspatch.len;
-	sampp = &samp.hdr.s;
+	samp->number = i;
+	samp->subkey = WF_ST_SAMPLE;
+	samp->size = guspatch.len;
+	sampp = &samp->hdr.s;
 
-	prog.number = guspatch.instr_no;
-	progp = &prog.hdr.pr;
+	prog->number = guspatch.instr_no;
+	progp = &prog->hdr.pr;
 
 	/* Setup the patch structure */
 
 	patp->amplitude_bias=guspatch.volume;
 	patp->portamento=0;
-	patp->sample_number= samp.number & 0xff;
-	patp->sample_msb= samp.number>>8;
+	patp->sample_number= samp->number & 0xff;
+	patp->sample_msb= samp->number >> 8;
 	patp->pitch_bend= /*12*/ 0;
 	patp->mono=1;
 	patp->retrigger=1;
@@ -1587,7 +1598,7 @@ wavefront_load_gus_patch (int devno, int
 
 	/* Program for this patch */
 
-	progp->layer[0].patch_number= pat.number; /* XXX is this right ? */
+	progp->layer[0].patch_number= pat->number; /* XXX is this right ? */
 	progp->layer[0].mute=1;
 	progp->layer[0].pan_or_mod=1;
 	progp->layer[0].pan=7;
@@ -1635,11 +1646,11 @@ wavefront_load_gus_patch (int devno, int
 
 	/* Now ship it down */
 
-	wavefront_send_sample (&samp, 
+	wavefront_send_sample (samp, 
 			       (unsigned short __user *) &(addr)[sizeof_patch],
 			       (guspatch.mode & WAVE_UNSIGNED) ? 1:0);
-	wavefront_send_patch (&pat);
-	wavefront_send_program (&prog);
+	wavefront_send_patch (pat);
+	wavefront_send_program (prog);
 
 	/* Now pan as best we can ... use the slave/internal MIDI device
 	   number if it exists (since it talks to the WaveFront), or the
@@ -1651,8 +1662,11 @@ wavefront_load_gus_patch (int devno, int
 				       ((guspatch.panning << 4) > 127) ?
 				       127 : (guspatch.panning << 4));
 	}
+	rc = 0;
 
-	return(0);
+free_fail:
+	kfree(samp);
+	return rc;
 }
 
 static int

--------------010503080804040902050305--
