Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946247AbWKAFhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946247AbWKAFhj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946111AbWKAFh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:37:26 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:58256 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946270AbWKAFgo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:36:44 -0500
Message-Id: <20061101053656.487219000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:33:53 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Karsten Wiese <annabellesgarden@yahoo.de>,
       Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 13/61] ALSA: Repair snd-usb-usx2y for usb 2.6.18
Content-Disposition: inline; filename=alsa-repair-snd-usb-usx2y-for-usb-2.6.18.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Karsten Wiese <annabellesgarden@yahoo.de>

urb->start_frame rolls over beyond MAX_INT now.
This is for stable kernel and stable alsa.

From: Karsten Wiese <annabellesgarden@yahoo.de>
Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 sound/usb/usx2y/usbusx2yaudio.c |   18 ++++++------------
 sound/usb/usx2y/usx2yhwdeppcm.c |   15 +++++----------
 2 files changed, 11 insertions(+), 22 deletions(-)

--- linux-2.6.18.1.orig/sound/usb/usx2y/usbusx2yaudio.c
+++ linux-2.6.18.1/sound/usb/usx2y/usbusx2yaudio.c
@@ -322,7 +322,7 @@ static void i_usX2Y_urb_complete(struct 
 		usX2Y_error_urb_status(usX2Y, subs, urb);
 		return;
 	}
-	if (likely((0xFFFF & urb->start_frame) == usX2Y->wait_iso_frame))
+	if (likely(urb->start_frame == usX2Y->wait_iso_frame))
 		subs->completed_urb = urb;
 	else {
 		usX2Y_error_sequence(usX2Y, subs, urb);
@@ -335,13 +335,9 @@ static void i_usX2Y_urb_complete(struct 
 		    atomic_read(&capsubs->state) >= state_PREPARED &&
 		    (playbacksubs->completed_urb ||
 		     atomic_read(&playbacksubs->state) < state_PREPARED)) {
-			if (!usX2Y_usbframe_complete(capsubs, playbacksubs, urb->start_frame)) {
-				if (nr_of_packs() <= urb->start_frame &&
-				    urb->start_frame <= (2 * nr_of_packs() - 1))	// uhci and ohci
-					usX2Y->wait_iso_frame = urb->start_frame - nr_of_packs();
-				else
-					usX2Y->wait_iso_frame +=  nr_of_packs();
-			} else {
+			if (!usX2Y_usbframe_complete(capsubs, playbacksubs, urb->start_frame))
+				usX2Y->wait_iso_frame += nr_of_packs();
+			else {
 				snd_printdd("\n");
 				usX2Y_clients_stop(usX2Y);
 			}
@@ -495,7 +491,6 @@ static int usX2Y_urbs_start(struct snd_u
 		if (subs != NULL && atomic_read(&subs->state) >= state_PREPARED)
 			goto start;
 	}
-	usX2Y->wait_iso_frame = -1;
 
  start:
 	usX2Y_subs_startup(subs);
@@ -516,10 +511,9 @@ static int usX2Y_urbs_start(struct snd_u
 				snd_printk (KERN_ERR "cannot submit datapipe for urb %d, err = %d\n", i, err);
 				err = -EPIPE;
 				goto cleanup;
-			} else {
-				if (0 > usX2Y->wait_iso_frame)
+			} else
+				if (i == 0)
 					usX2Y->wait_iso_frame = urb->start_frame;
-			}
 			urb->transfer_flags = 0;
 		} else {
 			atomic_set(&subs->state, state_STARTING1);
--- linux-2.6.18.1.orig/sound/usb/usx2y/usx2yhwdeppcm.c
+++ linux-2.6.18.1/sound/usb/usx2y/usx2yhwdeppcm.c
@@ -243,7 +243,7 @@ static void i_usX2Y_usbpcm_urb_complete(
 		usX2Y_error_urb_status(usX2Y, subs, urb);
 		return;
 	}
-	if (likely((0xFFFF & urb->start_frame) == usX2Y->wait_iso_frame))
+	if (likely(urb->start_frame == usX2Y->wait_iso_frame))
 		subs->completed_urb = urb;
 	else {
 		usX2Y_error_sequence(usX2Y, subs, urb);
@@ -256,13 +256,9 @@ static void i_usX2Y_usbpcm_urb_complete(
 	if (capsubs->completed_urb && atomic_read(&capsubs->state) >= state_PREPARED &&
 	    (NULL == capsubs2 || capsubs2->completed_urb) &&
 	    (playbacksubs->completed_urb || atomic_read(&playbacksubs->state) < state_PREPARED)) {
-		if (!usX2Y_usbpcm_usbframe_complete(capsubs, capsubs2, playbacksubs, urb->start_frame)) {
-			if (nr_of_packs() <= urb->start_frame &&
-			    urb->start_frame <= (2 * nr_of_packs() - 1))	// uhci and ohci
-				usX2Y->wait_iso_frame = urb->start_frame - nr_of_packs();
-			else
-				usX2Y->wait_iso_frame +=  nr_of_packs();
-		} else {
+		if (!usX2Y_usbpcm_usbframe_complete(capsubs, capsubs2, playbacksubs, urb->start_frame))
+			usX2Y->wait_iso_frame += nr_of_packs();
+		else {
 			snd_printdd("\n");
 			usX2Y_clients_stop(usX2Y);
 		}
@@ -433,7 +429,6 @@ static int usX2Y_usbpcm_urbs_start(struc
 		if (subs != NULL && atomic_read(&subs->state) >= state_PREPARED)
 			goto start;
 	}
-	usX2Y->wait_iso_frame = -1;
 
  start:
 	usX2Y_usbpcm_subs_startup(subs);
@@ -459,7 +454,7 @@ static int usX2Y_usbpcm_urbs_start(struc
 						goto cleanup;
 					}  else {
 						snd_printdd("%i\n", urb->start_frame);
-						if (0 > usX2Y->wait_iso_frame)
+						if (u == 0)
 							usX2Y->wait_iso_frame = urb->start_frame;
 					}
 					urb->transfer_flags = 0;

--
