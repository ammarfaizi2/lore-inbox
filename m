Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267344AbUIARYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267344AbUIARYP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 13:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267367AbUIAPzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:55:17 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:2483 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267353AbUIAPvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:51:47 -0400
Date: Wed, 1 Sep 2004 16:51:23 +0100
Message-Id: <200409011551.i81FpNha000690@delerium.codemonkey.org.uk>
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix NULL dereference in OSS v_midi driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spotted with the source checker from Coverity.com.

Signed-off-by: Dave Jones <davej@redhat.com>


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/sound/oss/v_midi.c linux-2.6/sound/oss/v_midi.c
--- bk-linus/sound/oss/v_midi.c	2004-06-03 13:40:31.000000000 +0100
+++ linux-2.6/sound/oss/v_midi.c	2004-06-03 13:43:00.000000000 +0100
@@ -90,11 +90,12 @@ static void v_midi_close (int dev)
 static int v_midi_out (int dev, unsigned char midi_byte)
 {
 	vmidi_devc *devc = midi_devs[dev]->devc;
-	vmidi_devc *pdevc = midi_devs[devc->pair_mididev]->devc;
+	vmidi_devc *pdevc;
 
 	if (devc == NULL)
-		return -(ENXIO);
+		return -ENXIO;
 
+	pdevc = midi_devs[devc->pair_mididev]->devc;
 	if (pdevc->input_opened > 0){
 		if (MIDIbuf_avail(pdevc->my_mididev) > 500)
 			return 0;
