Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946006AbWJaVUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946006AbWJaVUK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 16:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946004AbWJaVUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 16:20:10 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:47249 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423650AbWJaVUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 16:20:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Z/hAJlSLXhLYZ2YRySLBEOlB7fK9kJNy69WV3uwiw+dmPAGTjgbspSMuJe8sCn7Ma6qJ9/sV/YD/r0Qrs0NK/ipMeX+jzxG/IXDyCEYjXntz9OLmcGYjkrSDdoNtgTLzzEPYjyGCQYa1AdP4mb4MAQmLYWpKRzhUW+549dXP8P4=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix potential NULL pointer dereference in echoaudio midi.
Date: Tue, 31 Oct 2006 22:21:40 +0100
User-Agent: KMail/1.9.4
Cc: Giuliano Pochini <pochini@shiny.it>, Takashi Iwai <tiwai@suse.de>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610312221.41089.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In sound/pci/echoaudio/midi.c::snd_echo_midi_output_write(), there's a risk
of dereferencing a NULL 'chip->midi_out'.
This patch contains the obvious fix as also used a bit higher up in the 
same function.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

diff --git a/sound/pci/echoaudio/midi.c b/sound/pci/echoaudio/midi.c
index e31f0f1..69ef9f0 100644
--- a/sound/pci/echoaudio/midi.c
+++ b/sound/pci/echoaudio/midi.c
@@ -236,7 +236,8 @@ static void snd_echo_midi_output_write(u
 	}
 
 	/* We restart the timer only if there is some data left to send */
-	if (!snd_rawmidi_transmit_empty(chip->midi_out) && chip->tinuse) {
+	if (chip->midi_out && !snd_rawmidi_transmit_empty(chip->midi_out) &&
+			chip->tinuse) {
 		/* The timer will expire slightly after the data has been
 		   sent */
 		time = (sent << 3) / 25 + 1;	/* 8/25=0.32ms to send a byte */


