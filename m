Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbVAHICf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVAHICf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbVAHHvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:51:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:35717 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261842AbVAHFsK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:10 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632653471@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:45 -0800
Message-Id: <11051632651067@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.16, 2004/12/15 16:33:06-08:00, david-b@pacbell.net

[PATCH] USB: ALSA and usb_dev->ep[] (4/15)

Makes an ALSA audio driver stop referencing the udev->epmaxpacket[] arrays.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 sound/usb/usx2y/usbusx2yaudio.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)


diff -Nru a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
--- a/sound/usb/usx2y/usbusx2yaudio.c	2005-01-07 15:49:29 -08:00
+++ b/sound/usb/usx2y/usbusx2yaudio.c	2005-01-07 15:49:29 -08:00
@@ -449,12 +449,16 @@
 	int i;
 	int is_playback = subs == subs->usX2Y->substream[SNDRV_PCM_STREAM_PLAYBACK];
 	struct usb_device *dev = subs->usX2Y->chip.dev;
+	struct usb_host_endpoint *ep;
 
 	snd_assert(!subs->prepared, return 0);
 
 	if (is_playback) {	/* allocate a temporary buffer for playback */
 		subs->datapipe = usb_sndisocpipe(dev, subs->endpoint);
-		subs->maxpacksize = dev->epmaxpacketout[subs->endpoint];
+		ep = dev->ep_out[subs->endpoint];
+		if (!ep)
+			return -EINVAL;
+		subs->maxpacksize = ep->desc.wMaxPacketSize;
 		if (NULL == subs->tmpbuf) {
 			subs->tmpbuf = kcalloc(NRPACKS, subs->maxpacksize, GFP_KERNEL);
 			if (NULL == subs->tmpbuf) {
@@ -464,7 +468,10 @@
 		}
 	} else {
 		subs->datapipe = usb_rcvisocpipe(dev, subs->endpoint);
-		subs->maxpacksize = dev->epmaxpacketin[subs->endpoint];
+		ep = dev->ep_in[subs->endpoint];
+		if (!ep)
+			return -EINVAL;
+		subs->maxpacksize = ep->desc.wMaxPacketSize;
 	}
 
 	/* allocate and initialize data urbs */

