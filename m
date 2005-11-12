Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbVKLThI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbVKLThI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 14:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbVKLThH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 14:37:07 -0500
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:40585 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S932476AbVKLThG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 14:37:06 -0500
Date: Sat, 12 Nov 2005 20:17:08 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: sparc64: Oops in pci_alloc_consistent with cingergyT2
Message-ID: <20051112191707.GA25502@bogon.ms20.nix>
References: <20051111153354.GA19838@bogon.ms20.nix> <20051111.120950.06356722.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051111.120950.06356722.davem@davemloft.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2005 at 12:09:50PM -0800, David S. Miller wrote:
> From: Guido Guenther <agx@sigxcpu.org>
> Date: Fri, 11 Nov 2005 16:33:55 +0100
> 
> > This is due to the fact that cinergyt2_alloc_stream_urbs calls
> > pci_alloc_consistent with a NULL argument for the pci dev (it's a USB
> > device):
> > 
> > cinergyt2->streambuf = pci_alloc_consistent(NULL,
> >                                               STREAM_URB_COUNT*STREAM_BUF_SIZE,
> >                                               &cinergyt2->streambuf_dmahandle);
> > 
> > dma_alloc_coherent doesn't seem to be implemented on sparc64, what would
> > be the right way to tackle this?
> 
> It should be using "usb_buffer_alloc()" or similar.
> 
> No USB driver should be calling the DMA mapping interfaces
> directly.
> 
> Where is this driver?  I can't find it in the 2.6.x sources.
It's in media/dvb/cinergyT2. The attached patch gives me nice television
on an US5 - but the tv program is crappy as usual.
Cheers and thanks,
 -- Guido

P.S.: I didn't check if all the ioctls are really compatible, but the
ones I checked seem to be.

--- linux-2.6.14.orig/drivers/media/dvb/cinergyT2/cinergyT2.c	2005-11-12 19:08:05.000000000 +0100
+++ linux-2.6.14/drivers/media/dvb/cinergyT2/cinergyT2.c	2005-11-12 19:06:51.000000000 +0100
@@ -275,7 +275,7 @@
 		if (cinergyt2->stream_urb[i])
 			usb_free_urb(cinergyt2->stream_urb[i]);
 
-	pci_free_consistent(NULL, STREAM_URB_COUNT*STREAM_BUF_SIZE,
+	usb_buffer_free(cinergyt2->udev, STREAM_URB_COUNT*STREAM_BUF_SIZE,
 			    cinergyt2->streambuf, cinergyt2->streambuf_dmahandle);
 }
 
@@ -283,9 +283,8 @@
 {
 	int i;
 
-	cinergyt2->streambuf = pci_alloc_consistent(NULL,
-					      STREAM_URB_COUNT*STREAM_BUF_SIZE,
-					      &cinergyt2->streambuf_dmahandle);
+	cinergyt2->streambuf = usb_buffer_alloc(cinergyt2->udev, STREAM_URB_COUNT*STREAM_BUF_SIZE,
+					      SLAB_ATOMIC, &cinergyt2->streambuf_dmahandle);
 	if (!cinergyt2->streambuf) {
 		dprintk(1, "failed to alloc consistent stream memory area, bailing out!\n");
 		return -ENOMEM;
--- linux-2.6.14.orig/include/linux/compat_ioctl.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14/include/linux/compat_ioctl.h	2005-11-12 19:44:58.000000000 +0100
@@ -786,3 +786,74 @@
 COMPATIBLE_IOCTL(HIDIOCSFLAG)
 COMPATIBLE_IOCTL(HIDIOCGCOLLECTIONINDEX)
 COMPATIBLE_IOCTL(HIDIOCGCOLLECTIONINFO)
+/* dvb */
+COMPATIBLE_IOCTL(AUDIO_STOP)
+COMPATIBLE_IOCTL(AUDIO_PLAY)
+COMPATIBLE_IOCTL(AUDIO_PAUSE)
+COMPATIBLE_IOCTL(AUDIO_CONTINUE)
+COMPATIBLE_IOCTL(AUDIO_SELECT_SOURCE)
+COMPATIBLE_IOCTL(AUDIO_SET_MUTE)
+COMPATIBLE_IOCTL(AUDIO_SET_AV_SYNC)
+COMPATIBLE_IOCTL(AUDIO_SET_BYPASS_MODE)
+COMPATIBLE_IOCTL(AUDIO_CHANNEL_SELECT)
+COMPATIBLE_IOCTL(AUDIO_GET_STATUS)
+COMPATIBLE_IOCTL(AUDIO_GET_CAPABILITIES)
+COMPATIBLE_IOCTL(AUDIO_CLEAR_BUFFER)
+COMPATIBLE_IOCTL(AUDIO_SET_ID)
+COMPATIBLE_IOCTL(AUDIO_SET_MIXER)
+COMPATIBLE_IOCTL(AUDIO_SET_STREAMTYPE)
+COMPATIBLE_IOCTL(AUDIO_SET_EXT_ID)
+COMPATIBLE_IOCTL(AUDIO_SET_ATTRIBUTES)
+COMPATIBLE_IOCTL(AUDIO_SET_KARAOKE)
+COMPATIBLE_IOCTL(DMX_START)
+COMPATIBLE_IOCTL(DMX_STOP)
+COMPATIBLE_IOCTL(DMX_SET_FILTER)
+COMPATIBLE_IOCTL(DMX_SET_PES_FILTER)
+COMPATIBLE_IOCTL(DMX_SET_BUFFER_SIZE)
+COMPATIBLE_IOCTL(DMX_GET_EVENT)
+COMPATIBLE_IOCTL(DMX_GET_PES_PIDS)
+COMPATIBLE_IOCTL(DMX_GET_CAPS)
+COMPATIBLE_IOCTL(DMX_SET_SOURCE)
+COMPATIBLE_IOCTL(DMX_GET_STC)
+COMPATIBLE_IOCTL(FE_GET_INFO)
+COMPATIBLE_IOCTL(FE_DISEQC_RESET_OVERLOAD)
+COMPATIBLE_IOCTL(FE_DISEQC_SEND_MASTER_CMD)
+COMPATIBLE_IOCTL(FE_DISEQC_RECV_SLAVE_REPLY)
+COMPATIBLE_IOCTL(FE_DISEQC_SEND_BURST)
+COMPATIBLE_IOCTL(FE_SET_TONE)
+COMPATIBLE_IOCTL(FE_SET_VOLTAGE)
+COMPATIBLE_IOCTL(FE_ENABLE_HIGH_LNB_VOLTAGE)
+COMPATIBLE_IOCTL(FE_READ_STATUS)
+COMPATIBLE_IOCTL(FE_READ_BER)
+COMPATIBLE_IOCTL(FE_READ_SIGNAL_STRENGTH)
+COMPATIBLE_IOCTL(FE_READ_SNR)
+COMPATIBLE_IOCTL(FE_READ_UNCORRECTED_BLOCKS)
+COMPATIBLE_IOCTL(FE_SET_FRONTEND)
+COMPATIBLE_IOCTL(FE_GET_FRONTEND)
+COMPATIBLE_IOCTL(FE_GET_EVENT)
+COMPATIBLE_IOCTL(FE_DISHNETWORK_SEND_LEGACY_CMD)
+COMPATIBLE_IOCTL(VIDEO_STOP)
+COMPATIBLE_IOCTL(VIDEO_PLAY)
+COMPATIBLE_IOCTL(VIDEO_FREEZE)
+COMPATIBLE_IOCTL(VIDEO_CONTINUE)
+COMPATIBLE_IOCTL(VIDEO_SELECT_SOURCE)
+COMPATIBLE_IOCTL(VIDEO_SET_BLANK)
+COMPATIBLE_IOCTL(VIDEO_GET_STATUS)
+COMPATIBLE_IOCTL(VIDEO_GET_EVENT)
+COMPATIBLE_IOCTL(VIDEO_SET_DISPLAY_FORMAT)
+COMPATIBLE_IOCTL(VIDEO_STILLPICTURE)
+COMPATIBLE_IOCTL(VIDEO_FAST_FORWARD)
+COMPATIBLE_IOCTL(VIDEO_SLOWMOTION)
+COMPATIBLE_IOCTL(VIDEO_GET_CAPABILITIES)
+COMPATIBLE_IOCTL(VIDEO_CLEAR_BUFFER)
+COMPATIBLE_IOCTL(VIDEO_SET_ID)
+COMPATIBLE_IOCTL(VIDEO_SET_STREAMTYPE)
+COMPATIBLE_IOCTL(VIDEO_SET_FORMAT)
+COMPATIBLE_IOCTL(VIDEO_SET_SYSTEM)
+COMPATIBLE_IOCTL(VIDEO_SET_HIGHLIGHT)
+COMPATIBLE_IOCTL(VIDEO_SET_SPU)
+COMPATIBLE_IOCTL(VIDEO_SET_SPU_PALETTE)
+COMPATIBLE_IOCTL(VIDEO_GET_NAVI)
+COMPATIBLE_IOCTL(VIDEO_SET_ATTRIBUTES)
+COMPATIBLE_IOCTL(VIDEO_GET_SIZE)
+COMPATIBLE_IOCTL(VIDEO_GET_FRAME_RATE)
--- linux-2.6.14.orig/fs/compat_ioctl.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14/fs/compat_ioctl.c	2005-11-12 19:51:50.000000000 +0100
@@ -121,6 +121,11 @@
 
 #include <linux/hiddev.h>
 
+#include <linux/dvb/audio.h>
+#include <linux/dvb/dmx.h>
+#include <linux/dvb/frontend.h>
+#include <linux/dvb/video.h>
+
 #undef INCLUDES
 #endif
 
