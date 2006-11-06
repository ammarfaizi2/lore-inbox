Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753816AbWKFV3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816AbWKFV3l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 16:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753830AbWKFV3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 16:29:41 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:15364 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1753816AbWKFV3j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 16:29:39 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 2.6.19-rc4] usb urb unlink/free clenup
Date: Mon, 6 Nov 2006 22:28:37 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200611062228.38937.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


	In many places usb_(unlink,kill,free)_urb() are called this way:

if (urb)
	usb_something_urb(...);

which is not needed because functions like usb_unlink_urb() and usb_free_urb() are defined this way:

void usb_free_urb(struct urb *urb)
{
        if (urb)
                kref_put(&urb->kref, urb_destroy);
}

int usb_unlink_urb(struct urb *urb)
{
        if (!urb)
                return -EINVAL;
	...
}

We do not need to check for urb != NULL before we call them. It is also possible to do similar cleanup
for usb_kill_urb(). The thing is it does urb check at the begining but right before is 
might_sleep():

void usb_kill_urb(struct urb *urb)
{
        might_sleep();
        if (!(urb && urb->dev && urb->dev->bus))
                return;
	...

which confuses me. I would like to know what to do about it. Can this be rewritten this way?:

void usb_kill_urb(struct urb *urb)
{
	if (!urb)
		return;
        might_sleep();
        if (!urb->dev || !urb->dev->bus))
                return;
	...

Or maybe there is no need for this?

For now here is the patch against 2.6.19-rc4 (not -mm).

Regards,

	Mariusz Kozlowski

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
---

diff -up --recursive linux-2.6.19-rc4-orig/Documentation/DocBook/writing_usb_driver.tmpl linux-2.6.19-rc4/Documentation/DocBook/writing_usb_driver.tmpl
--- linux-2.6.19-rc4-orig/Documentation/DocBook/writing_usb_driver.tmpl 2006-11-06 17:06:39.000000000 +0100
+++ linux-2.6.19-rc4/Documentation/DocBook/writing_usb_driver.tmpl      2006-11-06 19:50:58.000000000 +0100
@@ -345,8 +345,7 @@ static inline void skel_delete (struct u
         usb_buffer_free (dev->udev, dev->bulk_out_size,
             dev->bulk_out_buffer,
             dev->write_urb->transfer_dma);
-    if (dev->write_urb != NULL)
-        usb_free_urb (dev->write_urb);
+    usb_free_urb (dev->write_urb);
     kfree (dev);
 }
   </programlisting>
diff -up --recursive linux-2.6.19-rc4-orig/drivers/char/watchdog/pcwd_usb.c linux-2.6.19-rc4/drivers/char/watchdog/pcwd_usb.c
--- linux-2.6.19-rc4-orig/drivers/char/watchdog/pcwd_usb.c      2006-11-06 17:07:20.000000000 +0100
+++ linux-2.6.19-rc4/drivers/char/watchdog/pcwd_usb.c   2006-11-06 19:51:32.000000000 +0100
@@ -561,8 +561,7 @@ static struct notifier_block usb_pcwd_no
  */
 static inline void usb_pcwd_delete (struct usb_pcwd_private *usb_pcwd)
 {
-       if (usb_pcwd->intr_urb != NULL)
-               usb_free_urb (usb_pcwd->intr_urb);
+       usb_free_urb (usb_pcwd->intr_urb);
        if (usb_pcwd->intr_buffer != NULL)
                usb_buffer_free(usb_pcwd->udev, usb_pcwd->intr_size,
                                usb_pcwd->intr_buffer, usb_pcwd->intr_dma);
diff -up --recursive linux-2.6.19-rc4-orig/drivers/input/joystick/iforce/iforce-usb.c linux-2.6.19-rc4/drivers/input/joystick/iforce/iforce-usb.c
--- linux-2.6.19-rc4-orig/drivers/input/joystick/iforce/iforce-usb.c    2006-11-06 17:07:30.000000000 +0100
+++ linux-2.6.19-rc4/drivers/input/joystick/iforce/iforce-usb.c 2006-11-06 19:52:04.000000000 +0100
@@ -178,9 +178,9 @@ static int iforce_usb_probe(struct usb_i
 
 fail:
        if (iforce) {
-               if (iforce->irq) usb_free_urb(iforce->irq);
-               if (iforce->out) usb_free_urb(iforce->out);
-               if (iforce->ctrl) usb_free_urb(iforce->ctrl);
+               usb_free_urb(iforce->irq);
+               usb_free_urb(iforce->out);
+               usb_free_urb(iforce->ctrl);
                kfree(iforce);
        }
 
diff -up --recursive linux-2.6.19-rc4-orig/drivers/isdn/gigaset/usb-gigaset.c linux-2.6.19-rc4/drivers/isdn/gigaset/usb-gigaset.c
--- linux-2.6.19-rc4-orig/drivers/isdn/gigaset/usb-gigaset.c    2006-11-06 17:07:30.000000000 +0100
+++ linux-2.6.19-rc4/drivers/isdn/gigaset/usb-gigaset.c 2006-11-06 19:53:52.000000000 +0100
@@ -818,11 +818,9 @@ error:
        if (ucs->read_urb)
                usb_kill_urb(ucs->read_urb);
        kfree(ucs->bulk_out_buffer);
-       if (ucs->bulk_out_urb != NULL)
-               usb_free_urb(ucs->bulk_out_urb);
+       usb_free_urb(ucs->bulk_out_urb);
        kfree(cs->inbuf[0].rcvbuf);
-       if (ucs->read_urb != NULL)
-               usb_free_urb(ucs->read_urb);
+       usb_free_urb(ucs->read_urb);
        usb_set_intfdata(interface, NULL);
        ucs->read_urb = ucs->bulk_out_urb = NULL;
        cs->inbuf[0].rcvbuf = ucs->bulk_out_buffer = NULL;
@@ -850,11 +848,9 @@ static void gigaset_disconnect(struct us
        usb_kill_urb(ucs->bulk_out_urb);        /* FIXME: only if active? */
 
        kfree(ucs->bulk_out_buffer);
-       if (ucs->bulk_out_urb != NULL)
-               usb_free_urb(ucs->bulk_out_urb);
+       usb_free_urb(ucs->bulk_out_urb);
        kfree(cs->inbuf[0].rcvbuf);
-       if (ucs->read_urb != NULL)
-               usb_free_urb(ucs->read_urb);
+       usb_free_urb(ucs->read_urb);
        ucs->read_urb = ucs->bulk_out_urb = NULL;
        cs->inbuf[0].rcvbuf = ucs->bulk_out_buffer = NULL;
 
diff -up --recursive linux-2.6.19-rc4-orig/drivers/isdn/hisax/hfc_usb.c linux-2.6.19-rc4/drivers/isdn/hisax/hfc_usb.c
--- linux-2.6.19-rc4-orig/drivers/isdn/hisax/hfc_usb.c  2006-11-06 17:07:32.000000000 +0100
+++ linux-2.6.19-rc4/drivers/isdn/hisax/hfc_usb.c       2006-11-06 20:59:15.000000000 +0100
@@ -574,22 +574,18 @@ stop_isoc_chain(usb_fifo * fifo)
        int i;
 
        for (i = 0; i < 2; i++) {
-               if (fifo->iso[i].purb) {
 #ifdef CONFIG_HISAX_DEBUG
-                       DBG(USB_DBG,
-                           "HFC-S USB: Stopping iso chain for fifo %i.%i",
-                           fifo->fifonum, i);
+               DBG(USB_DBG,
+                   "HFC-S USB: Stopping iso chain for fifo %i.%i",
+                   fifo->fifonum, i);
 #endif
-                       usb_unlink_urb(fifo->iso[i].purb);
-                       usb_free_urb(fifo->iso[i].purb);
-                       fifo->iso[i].purb = NULL;
-               }
-       }
-       if (fifo->urb) {
-               usb_unlink_urb(fifo->urb);
-               usb_free_urb(fifo->urb);
-               fifo->urb = NULL;
-       }
+               usb_unlink_urb(fifo->iso[i].purb);
+               usb_free_urb(fifo->iso[i].purb);
+               fifo->iso[i].purb = NULL;
+       }
+       usb_unlink_urb(fifo->urb);
+       usb_free_urb(fifo->urb);
+       fifo->urb = NULL;
        fifo->active = 0;
 }
 
@@ -1629,11 +1625,9 @@ hfc_usb_probe(struct usb_interface *intf
 #endif
                        /* init the chip and register the driver */
                        if (usb_init(context)) {
-                               if (context->ctrl_urb) {
-                                       usb_unlink_urb(context->ctrl_urb);
-                                       usb_free_urb(context->ctrl_urb);
-                                       context->ctrl_urb = NULL;
-                               }
+                               usb_unlink_urb(context->ctrl_urb);
+                               usb_free_urb(context->ctrl_urb);
+                               context->ctrl_urb = NULL;
                                kfree(context);
                                return (-EIO);
                        }
@@ -1685,21 +1679,17 @@ hfc_usb_disconnect(struct usb_interface
                                    i);
 #endif
                        }
-                       if (context->fifos[i].urb) {
-                               usb_unlink_urb(context->fifos[i].urb);
-                               usb_free_urb(context->fifos[i].urb);
-                               context->fifos[i].urb = NULL;
-                       }
+                       usb_unlink_urb(context->fifos[i].urb);
+                       usb_free_urb(context->fifos[i].urb);
+                       context->fifos[i].urb = NULL;
                }
                context->fifos[i].active = 0;
        }
        /* wait for all URBS to terminate */
        mdelay(10);
-       if (context->ctrl_urb) {
-               usb_unlink_urb(context->ctrl_urb);
-               usb_free_urb(context->ctrl_urb);
-               context->ctrl_urb = NULL;
-       }
+       usb_unlink_urb(context->ctrl_urb);
+       usb_free_urb(context->ctrl_urb);
+       context->ctrl_urb = NULL;
        hisax_unregister(&context->d_if);
        kfree(context);         /* free our structure again */
 }                              /* hfc_usb_disconnect */
diff -up --recursive linux-2.6.19-rc4-orig/drivers/media/dvb/cinergyT2/cinergyT2.c linux-2.6.19-rc4/drivers/media/dvb/cinergyT2/cinergyT2.c
--- linux-2.6.19-rc4-orig/drivers/media/dvb/cinergyT2/cinergyT2.c       2006-11-06 17:07:38.000000000 +0100
+++ linux-2.6.19-rc4/drivers/media/dvb/cinergyT2/cinergyT2.c    2006-11-06 19:54:42.000000000 +0100
@@ -275,8 +275,7 @@ static void cinergyt2_free_stream_urbs (
        int i;
 
        for (i=0; i<STREAM_URB_COUNT; i++)
-               if (cinergyt2->stream_urb[i])
-                       usb_free_urb(cinergyt2->stream_urb[i]);
+               usb_free_urb(cinergyt2->stream_urb[i]);
 
        usb_buffer_free(cinergyt2->udev, STREAM_URB_COUNT*STREAM_BUF_SIZE,
                            cinergyt2->streambuf, cinergyt2->streambuf_dmahandle);
diff -up --recursive linux-2.6.19-rc4-orig/drivers/media/dvb/ttusb-dec/ttusb_dec.c linux-2.6.19-rc4/drivers/media/dvb/ttusb-dec/ttusb_dec.c
--- linux-2.6.19-rc4-orig/drivers/media/dvb/ttusb-dec/ttusb_dec.c       2006-11-06 17:07:39.000000000 +0100
+++ linux-2.6.19-rc4/drivers/media/dvb/ttusb-dec/ttusb_dec.c    2006-11-06 19:55:08.000000000 +0100
@@ -1135,8 +1135,7 @@ static void ttusb_dec_free_iso_urbs(stru
        dprintk("%s\n", __FUNCTION__);
 
        for (i = 0; i < ISO_BUF_COUNT; i++)
-               if (dec->iso_urb[i])
-                       usb_free_urb(dec->iso_urb[i]);
+               usb_free_urb(dec->iso_urb[i]);
 
        pci_free_consistent(NULL,
                            ISO_FRAME_SIZE * (FRAMES_PER_ISO_BUF *
diff -up --recursive linux-2.6.19-rc4-orig/drivers/media/video/pvrusb2/pvrusb2-hdw.c linux-2.6.19-rc4/drivers/media/video/pvrusb2/pvrusb2-hdw.c
--- linux-2.6.19-rc4-orig/drivers/media/video/pvrusb2/pvrusb2-hdw.c     2006-11-06 17:07:44.000000000 +0100
+++ linux-2.6.19-rc4/drivers/media/video/pvrusb2/pvrusb2-hdw.c  2006-11-06 20:53:42.000000000 +0100
@@ -1953,8 +1953,8 @@ struct pvr2_hdw *pvr2_hdw_create(struct 
        return hdw;
  fail:
        if (hdw) {
-               if (hdw->ctl_read_urb) usb_free_urb(hdw->ctl_read_urb);
-               if (hdw->ctl_write_urb) usb_free_urb(hdw->ctl_write_urb);
+               usb_free_urb(hdw->ctl_read_urb);
+               usb_free_urb(hdw->ctl_write_urb);
                if (hdw->ctl_read_buffer) kfree(hdw->ctl_read_buffer);
                if (hdw->ctl_write_buffer) kfree(hdw->ctl_write_buffer);
                if (hdw->controls) kfree(hdw->controls);
@@ -2575,12 +2575,10 @@ static void pvr2_ctl_timeout(unsigned lo
        struct pvr2_hdw *hdw = (struct pvr2_hdw *)data;
        if (hdw->ctl_write_pend_flag || hdw->ctl_read_pend_flag) {
                hdw->ctl_timeout_flag = !0;
-               if (hdw->ctl_write_pend_flag && hdw->ctl_write_urb) {
+               if (hdw->ctl_write_pend_flag)
                        usb_unlink_urb(hdw->ctl_write_urb);
-               }
-               if (hdw->ctl_read_pend_flag && hdw->ctl_read_urb) {
+               if (hdw->ctl_read_pend_flag)
                        usb_unlink_urb(hdw->ctl_read_urb);
-               }
        }
 }
 
diff -up --recursive linux-2.6.19-rc4-orig/drivers/media/video/pvrusb2/pvrusb2-io.c linux-2.6.19-rc4/drivers/media/video/pvrusb2/pvrusb2-io.c
--- linux-2.6.19-rc4-orig/drivers/media/video/pvrusb2/pvrusb2-io.c      2006-11-06 17:07:44.000000000 +0100
+++ linux-2.6.19-rc4/drivers/media/video/pvrusb2/pvrusb2-io.c   2006-11-06 19:56:35.000000000 +0100
@@ -289,7 +289,7 @@ static void pvr2_buffer_done(struct pvr2
        pvr2_buffer_set_none(bp);
        bp->signature = 0;
        bp->stream = NULL;
-       if (bp->purb) usb_free_urb(bp->purb);
+       usb_free_urb(bp->purb);
        pvr2_trace(PVR2_TRACE_BUF_POOL,"/*---TRACE_FLOW---*/"
                   " bufferDone     %p",bp);
 }
diff -up --recursive linux-2.6.19-rc4-orig/drivers/media/video/pwc/pwc-if.c linux-2.6.19-rc4/drivers/media/video/pwc/pwc-if.c
--- linux-2.6.19-rc4-orig/drivers/media/video/pwc/pwc-if.c      2006-11-06 17:07:44.000000000 +0100
+++ linux-2.6.19-rc4/drivers/media/video/pwc/pwc-if.c   2006-11-06 19:57:00.000000000 +0100
@@ -867,8 +867,7 @@ int pwc_isoc_init(struct pwc_device *pde
        if (ret) {
                /* De-allocate in reverse order */
                while (i >= 0) {
-                       if (pdev->sbuf[i].urb != NULL)
-                               usb_free_urb(pdev->sbuf[i].urb);
+                       usb_free_urb(pdev->sbuf[i].urb);
                        pdev->sbuf[i].urb = NULL;
                        i--;
                }
diff -up --recursive linux-2.6.19-rc4-orig/drivers/media/video/sn9c102/sn9c102_core.c linux-2.6.19-rc4/drivers/media/video/sn9c102/sn9c102_core.c
--- linux-2.6.19-rc4-orig/drivers/media/video/sn9c102/sn9c102_core.c    2006-11-06 17:07:45.000000000 +0100
+++ linux-2.6.19-rc4/drivers/media/video/sn9c102/sn9c102_core.c 2006-11-06 19:57:35.000000000 +0100
@@ -775,7 +775,7 @@ static int sn9c102_start_transfer(struct
        return 0;
 
 free_urbs:
-       for (i = 0; (i < SN9C102_URBS) &&  cam->urb[i]; i++)
+       for (i = 0; i < SN9C102_URBS; i++)
                usb_free_urb(cam->urb[i]);
 
 free_buffers:
diff -up --recursive linux-2.6.19-rc4-orig/drivers/media/video/usbvideo/quickcam_messenger.c linux-2.6.19-rc4/drivers/media/video/usbvideo/quickcam_messenger.c
--- linux-2.6.19-rc4-orig/drivers/media/video/usbvideo/quickcam_messenger.c     2006-11-06 17:07:45.000000000 +0100
+++ linux-2.6.19-rc4/drivers/media/video/usbvideo/quickcam_messenger.c  2006-11-06 19:58:08.000000000 +0100
@@ -190,8 +190,7 @@ static int qcm_alloc_int_urb(struct qcm 
 
 static void qcm_free_int(struct qcm *cam)
 {
-       if (cam->button_urb)
-               usb_free_urb(cam->button_urb);
+       usb_free_urb(cam->button_urb);
 }
 #endif /* CONFIG_INPUT */
 
diff -up --recursive linux-2.6.19-rc4-orig/drivers/media/video/zc0301/zc0301_core.c linux-2.6.19-rc4/drivers/media/video/zc0301/zc0301_core.c
--- linux-2.6.19-rc4-orig/drivers/media/video/zc0301/zc0301_core.c      2006-11-06 17:07:46.000000000 +0100
+++ linux-2.6.19-rc4/drivers/media/video/zc0301/zc0301_core.c   2006-11-06 19:58:40.000000000 +0100
@@ -489,7 +489,7 @@ static int zc0301_start_transfer(struct 
        return 0;
 
 free_urbs:
-       for (i = 0; (i < ZC0301_URBS) &&  cam->urb[i]; i++)
+       for (i = 0; i < ZC0301_URBS; i++)
                usb_free_urb(cam->urb[i]);
 
 free_buffers:
diff -up --recursive linux-2.6.19-rc4-orig/drivers/net/irda/irda-usb.c linux-2.6.19-rc4/drivers/net/irda/irda-usb.c
--- linux-2.6.19-rc4-orig/drivers/net/irda/irda-usb.c   2006-11-06 17:07:55.000000000 +0100
+++ linux-2.6.19-rc4/drivers/net/irda/irda-usb.c        2006-11-06 19:59:15.000000000 +0100
@@ -1793,10 +1793,8 @@ err_out_3:
 err_out_2:
        usb_free_urb(self->tx_urb);
 err_out_1:
-       for (i = 0; i < self->max_rx_urb; i++) {
-               if (self->rx_urb[i])
-                       usb_free_urb(self->rx_urb[i]);
-       }
+       for (i = 0; i < self->max_rx_urb; i++)
+               usb_free_urb(self->rx_urb[i]);
        free_netdev(net);
 err_out:
        return ret;
diff -up --recursive linux-2.6.19-rc4-orig/drivers/net/wireless/zd1201.c linux-2.6.19-rc4/drivers/net/wireless/zd1201.c
--- linux-2.6.19-rc4-orig/drivers/net/wireless/zd1201.c 2006-11-06 17:07:59.000000000 +0100
+++ linux-2.6.19-rc4/drivers/net/wireless/zd1201.c      2006-11-06 19:59:49.000000000 +0100
@@ -1828,10 +1828,8 @@ err_start:
        /* Leave the device in reset state */
        zd1201_docmd(zd, ZD1201_CMDCODE_INIT, 0, 0, 0);
 err_zd:
-       if (zd->tx_urb)
-               usb_free_urb(zd->tx_urb);
-       if (zd->rx_urb)
-               usb_free_urb(zd->rx_urb);
+       usb_free_urb(zd->tx_urb);
+       usb_free_urb(zd->rx_urb);
        kfree(zd);
        return err;
 }
diff -up --recursive linux-2.6.19-rc4-orig/drivers/usb/input/ati_remote.c linux-2.6.19-rc4/drivers/usb/input/ati_remote.c
--- linux-2.6.19-rc4-orig/drivers/usb/input/ati_remote.c        2006-11-06 17:08:20.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/input/ati_remote.c     2006-11-06 19:23:09.000000000 +0100
@@ -630,11 +630,8 @@ static int ati_remote_alloc_buffers(stru
  */
 static void ati_remote_free_buffers(struct ati_remote *ati_remote)
 {
-       if (ati_remote->irq_urb)
-               usb_free_urb(ati_remote->irq_urb);
-
-       if (ati_remote->out_urb)
-               usb_free_urb(ati_remote->out_urb);
+       usb_free_urb(ati_remote->irq_urb);
+       usb_free_urb(ati_remote->out_urb);
 
        if (ati_remote->inbuf)
                usb_buffer_free(ati_remote->udev, DATA_BUFSIZE,
diff -up --recursive linux-2.6.19-rc4-orig/drivers/usb/input/ati_remote2.c linux-2.6.19-rc4/drivers/usb/input/ati_remote2.c
--- linux-2.6.19-rc4-orig/drivers/usb/input/ati_remote2.c       2006-11-06 17:08:20.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/input/ati_remote2.c    2006-11-06 19:24:20.000000000 +0100
@@ -372,8 +372,7 @@ static void ati_remote2_urb_cleanup(stru
        int i;
 
        for (i = 0; i < 2; i++) {
-               if (ar2->urb[i])
-                       usb_free_urb(ar2->urb[i]);
+               usb_free_urb(ar2->urb[i]);
 
                if (ar2->buf[i])
                        usb_buffer_free(ar2->udev, 4, ar2->buf[i], ar2->buf_dma[i]);
diff -up --recursive linux-2.6.19-rc4-orig/drivers/usb/input/hid-core.c linux-2.6.19-rc4/drivers/usb/input/hid-core.c
--- linux-2.6.19-rc4-orig/drivers/usb/input/hid-core.c  2006-11-06 17:08:20.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/input/hid-core.c       2006-11-06 19:25:20.000000000 +0100
@@ -2037,13 +2037,9 @@ static struct hid_device *usb_hid_config
        return hid;
 
 fail:
-
-       if (hid->urbin)
-               usb_free_urb(hid->urbin);
-       if (hid->urbout)
-               usb_free_urb(hid->urbout);
-       if (hid->urbctrl)
-               usb_free_urb(hid->urbctrl);
+       usb_free_urb(hid->urbin);
+       usb_free_urb(hid->urbout);
+       usb_free_urb(hid->urbctrl);
        hid_free_buffers(dev, hid);
        hid_free_device(hid);
 
@@ -2074,8 +2070,7 @@ static void hid_disconnect(struct usb_in
 
        usb_free_urb(hid->urbin);
        usb_free_urb(hid->urbctrl);
-       if (hid->urbout)
-               usb_free_urb(hid->urbout);
+       usb_free_urb(hid->urbout);
 
        hid_free_buffers(hid->dev, hid);
        hid_free_device(hid);
diff -up --recursive linux-2.6.19-rc4-orig/drivers/usb/input/usbkbd.c linux-2.6.19-rc4/drivers/usb/input/usbkbd.c
--- linux-2.6.19-rc4-orig/drivers/usb/input/usbkbd.c    2006-11-06 17:08:20.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/input/usbkbd.c 2006-11-06 19:26:18.000000000 +0100
@@ -208,10 +208,8 @@ static int usb_kbd_alloc_mem(struct usb_
 
 static void usb_kbd_free_mem(struct usb_device *dev, struct usb_kbd *kbd)
 {
-       if (kbd->irq)
-               usb_free_urb(kbd->irq);
-       if (kbd->led)
-               usb_free_urb(kbd->led);
+       usb_free_urb(kbd->irq);
+       usb_free_urb(kbd->led);
        if (kbd->new)
                usb_buffer_free(dev, 8, kbd->new, kbd->new_dma);
        if (kbd->cr)
diff -up --recursive linux-2.6.19-rc4-orig/drivers/usb/misc/auerswald.c linux-2.6.19-rc4/drivers/usb/misc/auerswald.c
--- linux-2.6.19-rc4-orig/drivers/usb/misc/auerswald.c  2006-11-06 17:08:20.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/misc/auerswald.c       2006-11-06 20:36:05.000000000 +0100
@@ -704,9 +704,7 @@ static void auerbuf_free (pauerbuf_t bp)
 {
        kfree(bp->bufp);
        kfree(bp->dr);
-       if (bp->urbp) {
-               usb_free_urb(bp->urbp);
-       }
+       usb_free_urb(bp->urbp);
        kfree(bp);
 }
 
@@ -1085,10 +1083,8 @@ exit:
 */
 static void auerswald_int_free (pauerswald_t cp)
 {
-       if (cp->inturbp) {
-               usb_free_urb(cp->inturbp);
-               cp->inturbp = NULL;
-       }
+       usb_free_urb(cp->inturbp);
+       cp->inturbp = NULL;
        kfree(cp->intbufp);
        cp->intbufp = NULL;
 }
diff -up --recursive linux-2.6.19-rc4-orig/drivers/usb/misc/legousbtower.c linux-2.6.19-rc4/drivers/usb/misc/legousbtower.c
--- linux-2.6.19-rc4-orig/drivers/usb/misc/legousbtower.c       2006-11-06 17:08:21.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/misc/legousbtower.c    2006-11-06 19:27:16.000000000 +0100
@@ -317,12 +317,8 @@ static inline void tower_delete (struct 
        tower_abort_transfers (dev);
 
        /* free data structures */
-       if (dev->interrupt_in_urb != NULL) {
-               usb_free_urb (dev->interrupt_in_urb);
-       }
-       if (dev->interrupt_out_urb != NULL) {
-               usb_free_urb (dev->interrupt_out_urb);
-       }
+       usb_free_urb (dev->interrupt_in_urb);
+       usb_free_urb (dev->interrupt_out_urb);
        kfree (dev->read_buffer);
        kfree (dev->interrupt_in_buffer);
        kfree (dev->interrupt_out_buffer);
diff -up --recursive linux-2.6.19-rc4-orig/drivers/usb/misc/phidgetkit.c linux-2.6.19-rc4/drivers/usb/misc/phidgetkit.c
--- linux-2.6.19-rc4-orig/drivers/usb/misc/phidgetkit.c 2006-11-06 17:08:21.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/misc/phidgetkit.c      2006-11-06 19:27:48.000000000 +0100
@@ -650,8 +650,7 @@ out2:
                device_remove_file(kit->dev, &dev_output_attrs[i]);
 out:
        if (kit) {
-               if (kit->irq)
-                       usb_free_urb(kit->irq);
+               usb_free_urb(kit->irq);
                if (kit->data)
                        usb_buffer_free(dev, URB_INT_SIZE, kit->data, kit->data_dma);
                if (kit->dev)
diff -up --recursive linux-2.6.19-rc4-orig/drivers/usb/misc/phidgetmotorcontrol.c linux-2.6.19-rc4/drivers/usb/misc/phidgetmotorcontrol.c
--- linux-2.6.19-rc4-orig/drivers/usb/misc/phidgetmotorcontrol.c        2006-11-06 17:08:21.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/misc/phidgetmotorcontrol.c     2006-11-06 19:28:17.000000000 +0100
@@ -392,8 +392,7 @@ out2:
                device_remove_file(mc->dev, &dev_attrs[i]);
 out:
        if (mc) {
-               if (mc->irq)
-                       usb_free_urb(mc->irq);
+               usb_free_urb(mc->irq);
                if (mc->data)
                        usb_buffer_free(dev, URB_INT_SIZE, mc->data, mc->data_dma);
                if (mc->dev)
diff -up --recursive linux-2.6.19-rc4-orig/drivers/usb/net/catc.c linux-2.6.19-rc4/drivers/usb/net/catc.c
--- linux-2.6.19-rc4-orig/drivers/usb/net/catc.c        2006-11-06 17:08:21.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/net/catc.c     2006-11-06 19:29:53.000000000 +0100
@@ -786,14 +786,10 @@ static int catc_probe(struct usb_interfa
        if ((!catc->ctrl_urb) || (!catc->tx_urb) || 
            (!catc->rx_urb) || (!catc->irq_urb)) {
                err("No free urbs available.");
-               if (catc->ctrl_urb)
-                       usb_free_urb(catc->ctrl_urb);
-               if (catc->tx_urb)
-                       usb_free_urb(catc->tx_urb);
-               if (catc->rx_urb)
-                       usb_free_urb(catc->rx_urb);
-               if (catc->irq_urb)
-                       usb_free_urb(catc->irq_urb);
+               usb_free_urb(catc->ctrl_urb);
+               usb_free_urb(catc->tx_urb);
+               usb_free_urb(catc->rx_urb);
+               usb_free_urb(catc->irq_urb);
                free_netdev(netdev);
                return -ENOMEM;
        }
diff -up --recursive linux-2.6.19-rc4-orig/drivers/usb/serial/ftdi_sio.c linux-2.6.19-rc4/drivers/usb/serial/ftdi_sio.c
--- linux-2.6.19-rc4-orig/drivers/usb/serial/ftdi_sio.c 2006-11-06 17:08:21.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/serial/ftdi_sio.c      2006-11-06 20:43:28.000000000 +0100
@@ -1202,10 +1202,8 @@ static int ftdi_sio_attach (struct usb_s
        INIT_WORK(&priv->rx_work, ftdi_process_read, port);
 
        /* Free port's existing write urb and transfer buffer. */
-       if (port->write_urb) {
-               usb_free_urb (port->write_urb);
-               port->write_urb = NULL;
-       }
+       usb_free_urb (port->write_urb);
+       port->write_urb = NULL;
        kfree(port->bulk_out_buffer);
        port->bulk_out_buffer = NULL;
 
diff -up --recursive linux-2.6.19-rc4-orig/drivers/usb/serial/keyspan.c linux-2.6.19-rc4/drivers/usb/serial/keyspan.c
--- linux-2.6.19-rc4-orig/drivers/usb/serial/keyspan.c  2006-11-06 17:08:21.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/serial/keyspan.c       2006-11-06 19:32:46.000000000 +0100
@@ -2306,22 +2306,16 @@ static void keyspan_shutdown (struct usb
        }
 
        /* Now free them */
-       if (s_priv->instat_urb)
-               usb_free_urb(s_priv->instat_urb);
-       if (s_priv->glocont_urb)
-               usb_free_urb(s_priv->glocont_urb);
+       usb_free_urb(s_priv->instat_urb);
+       usb_free_urb(s_priv->glocont_urb);
        for (i = 0; i < serial->num_ports; ++i) {
                port = serial->port[i];
                p_priv = usb_get_serial_port_data(port);
-               if (p_priv->inack_urb)
-                       usb_free_urb(p_priv->inack_urb);
-               if (p_priv->outcont_urb)
-                       usb_free_urb(p_priv->outcont_urb);
+               usb_free_urb(p_priv->inack_urb);
+               usb_free_urb(p_priv->outcont_urb);
                for (j = 0; j < 2; j++) {
-                       if (p_priv->in_urbs[j])
-                               usb_free_urb(p_priv->in_urbs[j]);
-                       if (p_priv->out_urbs[j])
-                               usb_free_urb(p_priv->out_urbs[j]);
+                       usb_free_urb(p_priv->in_urbs[j]);
+                       usb_free_urb(p_priv->out_urbs[j]);
                }
        }
 
diff -up --recursive linux-2.6.19-rc4-orig/drivers/usb/serial/mct_u232.c linux-2.6.19-rc4/drivers/usb/serial/mct_u232.c
--- linux-2.6.19-rc4-orig/drivers/usb/serial/mct_u232.c 2006-11-06 17:08:21.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/serial/mct_u232.c      2006-11-06 20:45:41.000000000 +0100
@@ -358,10 +358,8 @@ static int mct_u232_startup (struct usb_
        /* Puh, that's dirty */
        port = serial->port[0];
        rport = serial->port[1];
-       if (port->read_urb) {
-               /* No unlinking, it wasn't submitted yet. */
-               usb_free_urb(port->read_urb);
-       }
+       /* Unlinking, if submitted. */
+       usb_free_urb(port->read_urb);
        port->read_urb = rport->interrupt_in_urb;
        rport->interrupt_in_urb = NULL;
        port->read_urb->context = port;
diff -up --recursive linux-2.6.19-rc4-orig/drivers/usb/serial/option.c linux-2.6.19-rc4/drivers/usb/serial/option.c
--- linux-2.6.19-rc4-orig/drivers/usb/serial/option.c   2006-11-06 17:08:21.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/serial/option.c        2006-11-06 19:34:20.000000000 +0100
@@ -696,16 +696,12 @@ static void option_shutdown(struct usb_s
                portdata = usb_get_serial_port_data(port);
 
                for (j = 0; j < N_IN_URB; j++) {
-                       if (portdata->in_urbs[j]) {
-                               usb_free_urb(portdata->in_urbs[j]);
-                               portdata->in_urbs[j] = NULL;
-                       }
+                       usb_free_urb(portdata->in_urbs[j]);
+                       portdata->in_urbs[j] = NULL;
                }
                for (j = 0; j < N_OUT_URB; j++) {
-                       if (portdata->out_urbs[j]) {
-                               usb_free_urb(portdata->out_urbs[j]);
-                               portdata->out_urbs[j] = NULL;
-                       }
+                       usb_free_urb(portdata->out_urbs[j]);
+                       portdata->out_urbs[j] = NULL;
                }
        }
 
diff -up --recursive linux-2.6.19-rc4-orig/drivers/usb/serial/sierra.c linux-2.6.19-rc4/drivers/usb/serial/sierra.c
--- linux-2.6.19-rc4-orig/drivers/usb/serial/sierra.c   2006-11-06 17:08:21.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/serial/sierra.c        2006-11-06 19:35:07.000000000 +0100
@@ -584,16 +584,12 @@ static void sierra_shutdown(struct usb_s
                portdata = usb_get_serial_port_data(port);
 
                for (j = 0; j < N_IN_URB; j++) {
-                       if (portdata->in_urbs[j]) {
-                               usb_free_urb(portdata->in_urbs[j]);
-                               portdata->in_urbs[j] = NULL;
-                       }
+                       usb_free_urb(portdata->in_urbs[j]);
+                       portdata->in_urbs[j] = NULL;
                }
                for (j = 0; j < N_OUT_URB; j++) {
-                       if (portdata->out_urbs[j]) {
-                               usb_free_urb(portdata->out_urbs[j]);
-                               portdata->out_urbs[j] = NULL;
-                       }
+                       usb_free_urb(portdata->out_urbs[j]);
+                       portdata->out_urbs[j] = NULL;
                }
        }
 
diff -up --recursive linux-2.6.19-rc4-orig/drivers/usb/serial/usb-serial.c linux-2.6.19-rc4/drivers/usb/serial/usb-serial.c
--- linux-2.6.19-rc4-orig/drivers/usb/serial/usb-serial.c       2006-11-06 17:08:21.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/serial/usb-serial.c    2006-11-06 19:36:24.000000000 +0100
@@ -952,32 +952,28 @@ probe_error:
                port = serial->port[i];
                if (!port)
                        continue;
-               if (port->read_urb)
-                       usb_free_urb (port->read_urb);
+               usb_free_urb (port->read_urb);
                kfree(port->bulk_in_buffer);
        }
        for (i = 0; i < num_bulk_out; ++i) {
                port = serial->port[i];
                if (!port)
                        continue;
-               if (port->write_urb)
-                       usb_free_urb (port->write_urb);
+               usb_free_urb (port->write_urb);
                kfree(port->bulk_out_buffer);
        }
        for (i = 0; i < num_interrupt_in; ++i) {
                port = serial->port[i];
                if (!port)
                        continue;
-               if (port->interrupt_in_urb)
-                       usb_free_urb (port->interrupt_in_urb);
+               usb_free_urb (port->interrupt_in_urb);
                kfree(port->interrupt_in_buffer);
        }
        for (i = 0; i < num_interrupt_out; ++i) {
                port = serial->port[i];
                if (!port)
                        continue;
-               if (port->interrupt_out_urb)
-                       usb_free_urb (port->interrupt_out_urb);
+               usb_free_urb (port->interrupt_out_urb);
                kfree(port->interrupt_out_buffer);
        }
 
diff -up --recursive linux-2.6.19-rc4-orig/sound/usb/usbmixer.c linux-2.6.19-rc4/sound/usb/usbmixer.c
--- linux-2.6.19-rc4-orig/sound/usb/usbmixer.c  2006-11-06 17:09:28.000000000 +0100
+++ linux-2.6.19-rc4/sound/usb/usbmixer.c       2006-11-06 20:15:04.000000000 +0100
@@ -1620,8 +1620,7 @@ static void snd_usb_mixer_free(struct us
                kfree(mixer->urb->transfer_buffer);
                usb_free_urb(mixer->urb);
        }
-       if (mixer->rc_urb)
-               usb_free_urb(mixer->rc_urb);
+       usb_free_urb(mixer->rc_urb);
        kfree(mixer->rc_setup_packet);
        kfree(mixer);
 }
