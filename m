Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWIYKvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWIYKvy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 06:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWIYKvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 06:51:54 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:63182 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751114AbWIYKvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 06:51:53 -0400
Subject: [PATCH] usb-serial: possible irq lock inversion (PPP vs.
	usb/serial)
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: gregkh@suse.de, Andrew Morton <akpm@osdl.org>
Cc: linux-usb-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       arjan <arjan@infradead.org>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 12:51:41 +0200
Message-Id: <1159181501.5018.17.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


=========================================================
[ INFO: possible irq lock inversion dependency detected ]
---------------------------------------------------------
ksoftirqd/0/3 just changed the state of lock:
 (&ap->xmit_lock){-+..}, at: [<f9337224>] ppp_async_push+0x2f/0x3b3 [ppp_async]
but this lock took another, soft-irq-unsafe lock in the past:
 (&port->lock){--..}

and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
no locks held by ksoftirqd/0/3.

the first lock's dependencies:
-> (&ap->xmit_lock){-+..} ops: 0 {
   initial-use  at:
                        [<c043bf43>] lock_acquire+0x4b/0x6c
                        [<c06086a8>] _spin_lock_bh+0x1e/0x2d
                        [<f9337224>] ppp_async_push+0x2f/0x3b3 [ppp_async]
                        [<f93375b8>] ppp_async_send+0x10/0x3d [ppp_async]
                        [<f932f071>] ppp_channel_push+0x3a/0x94 [ppp_generic]
                        [<f9330395>] ppp_write+0xd5/0xe1 [ppp_generic]
                        [<c0471f23>] vfs_write+0xab/0x157
                        [<c0472568>] sys_write+0x3b/0x60
                        [<c0403faf>] syscall_call+0x7/0xb
   in-softirq-W at:
                        [<c043bf43>] lock_acquire+0x4b/0x6c
                        [<c06086a8>] _spin_lock_bh+0x1e/0x2d
                        [<f9337224>] ppp_async_push+0x2f/0x3b3 [ppp_async]
                        [<f9337aea>] ppp_async_process+0x48/0x5b [ppp_async]
                        [<c04294b4>] tasklet_action+0x65/0xca
                        [<c04293d5>] __do_softirq+0x78/0xf2
                        [<c040662f>] do_softirq+0x5a/0xbe
   hardirq-on-W at:
                        [<c043bf43>] lock_acquire+0x4b/0x6c
                        [<c06086a8>] _spin_lock_bh+0x1e/0x2d
                        [<f9337224>] ppp_async_push+0x2f/0x3b3 [ppp_async]
                        [<f93375b8>] ppp_async_send+0x10/0x3d [ppp_async]
                        [<f932f071>] ppp_channel_push+0x3a/0x94 [ppp_generic]
                        [<f9330395>] ppp_write+0xd5/0xe1 [ppp_generic]
                        [<c0471f23>] vfs_write+0xab/0x157
                        [<c0472568>] sys_write+0x3b/0x60
                        [<c0403faf>] syscall_call+0x7/0xb
 }
 ... key      at: [<f933b208>] __key.19284+0x0/0xffffce72 [ppp_async]
 -> (&port->lock){--..} ops: 0 {
    initial-use  at:
                          [<c043bf43>] lock_acquire+0x4b/0x6c
                          [<c060867b>] _spin_lock+0x19/0x28
                          [<f9324478>] usb_serial_generic_write+0x79/0x23d [usbserial]
                          [<f9322531>] serial_write+0x8a/0x99 [usbserial]
                          [<c052dbed>] write_chan+0x22e/0x2a8
                          [<c052b530>] tty_write+0x148/0x1ce
                          [<c0471f23>] vfs_write+0xab/0x157
                          [<c0472568>] sys_write+0x3b/0x60
                          [<c0403faf>] syscall_call+0x7/0xb
    softirq-on-W at:
                          [<c043bf43>] lock_acquire+0x4b/0x6c
                          [<c060867b>] _spin_lock+0x19/0x28
                          [<f9324478>] usb_serial_generic_write+0x79/0x23d [usbserial]
                          [<f9322531>] serial_write+0x8a/0x99 [usbserial]
                          [<c052dbed>] write_chan+0x22e/0x2a8
                          [<c052b530>] tty_write+0x148/0x1ce
                          [<c0471f23>] vfs_write+0xab/0x157
                          [<c0472568>] sys_write+0x3b/0x60
                          [<c0403faf>] syscall_call+0x7/0xb
    hardirq-on-W at:
                          [<c043bf43>] lock_acquire+0x4b/0x6c
                          [<c060867b>] _spin_lock+0x19/0x28
                          [<f9324478>] usb_serial_generic_write+0x79/0x23d [usbserial]
                          [<f9322531>] serial_write+0x8a/0x99 [usbserial]
                          [<c052dbed>] write_chan+0x22e/0x2a8
                          [<c052b530>] tty_write+0x148/0x1ce
                          [<c0471f23>] vfs_write+0xab/0x157
                          [<c0472568>] sys_write+0x3b/0x60
                          [<c0403faf>] syscall_call+0x7/0xb
  }
  ... key      at: [<f932b08c>] __key.15523+0x0/0xffff9965 [usbserial]
 ... acquired at:
   [<c043bf43>] lock_acquire+0x4b/0x6c
   [<c060867b>] _spin_lock+0x19/0x28
   [<f9324478>] usb_serial_generic_write+0x79/0x23d [usbserial]
   [<f9322531>] serial_write+0x8a/0x99 [usbserial]
   [<f933729c>] ppp_async_push+0xa7/0x3b3 [ppp_async]
   [<f93375da>] ppp_async_send+0x32/0x3d [ppp_async]
   [<f932f071>] ppp_channel_push+0x3a/0x94 [ppp_generic]
   [<f9330395>] ppp_write+0xd5/0xe1 [ppp_generic]
   [<c0471f23>] vfs_write+0xab/0x157
   [<c0472568>] sys_write+0x3b/0x60
   [<c0403faf>] syscall_call+0x7/0xb

Change port->lock locking to softirq-safe, other locks down the
call-chain appear to be hardirq-safe so this should do.

(compile tested only due to lack of hardware)

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 drivers/usb/serial/cyberjack.c   |    6 +++---
 drivers/usb/serial/generic.c     |    6 +++---
 drivers/usb/serial/ipw.c         |    6 +++---
 drivers/usb/serial/ir-usb.c      |    6 +++---
 drivers/usb/serial/keyspan_pda.c |    6 +++---
 drivers/usb/serial/omninet.c     |    6 +++---
 drivers/usb/serial/safe_serial.c |    6 +++---
 7 files changed, 21 insertions(+), 21 deletions(-)

Index: linux-2.6-mm/drivers/usb/serial/cyberjack.c
===================================================================
--- linux-2.6-mm.orig/drivers/usb/serial/cyberjack.c
+++ linux-2.6-mm/drivers/usb/serial/cyberjack.c
@@ -214,14 +214,14 @@ static int cyberjack_write (struct usb_s
 		return (0);
 	}
 
-	spin_lock(&port->lock);
+	spin_lock_bh(&port->lock);
 	if (port->write_urb_busy) {
-		spin_unlock(&port->lock);
+		spin_unlock_bh(&port->lock);
 		dbg("%s - already writing", __FUNCTION__);
 		return 0;
 	}
 	port->write_urb_busy = 1;
-	spin_unlock(&port->lock);
+	spin_unlock_bh(&port->lock);
 
 	spin_lock_irqsave(&priv->lock, flags);
 
Index: linux-2.6-mm/drivers/usb/serial/generic.c
===================================================================
--- linux-2.6-mm.orig/drivers/usb/serial/generic.c
+++ linux-2.6-mm/drivers/usb/serial/generic.c
@@ -175,14 +175,14 @@ int usb_serial_generic_write(struct usb_
 
 	/* only do something if we have a bulk out endpoint */
 	if (serial->num_bulk_out) {
-		spin_lock(&port->lock);
+		spin_lock_bh(&port->lock);
 		if (port->write_urb_busy) {
-			spin_unlock(&port->lock);
+			spin_unlock_bh(&port->lock);
 			dbg("%s - already writing", __FUNCTION__);
 			return 0;
 		}
 		port->write_urb_busy = 1;
-		spin_unlock(&port->lock);
+		spin_unlock_bh(&port->lock);
 
 		count = (count > port->bulk_out_size) ? port->bulk_out_size : count;
 
Index: linux-2.6-mm/drivers/usb/serial/ipw.c
===================================================================
--- linux-2.6-mm.orig/drivers/usb/serial/ipw.c
+++ linux-2.6-mm/drivers/usb/serial/ipw.c
@@ -394,14 +394,14 @@ static int ipw_write(struct usb_serial_p
 		return 0;
 	}
 
-	spin_lock(&port->lock);
+	spin_lock_bh(&port->lock);
 	if (port->write_urb_busy) {
-		spin_unlock(&port->lock);
+		spin_unlock_bh(&port->lock);
 		dbg("%s - already writing", __FUNCTION__);
 		return 0;
 	}
 	port->write_urb_busy = 1;
-	spin_unlock(&port->lock);
+	spin_unlock_bh(&port->lock);
 
 	count = min(count, port->bulk_out_size);
 	memcpy(port->bulk_out_buffer, buf, count);
Index: linux-2.6-mm/drivers/usb/serial/ir-usb.c
===================================================================
--- linux-2.6-mm.orig/drivers/usb/serial/ir-usb.c
+++ linux-2.6-mm/drivers/usb/serial/ir-usb.c
@@ -342,14 +342,14 @@ static int ir_write (struct usb_serial_p
 	if (count == 0)
 		return 0;
 
-	spin_lock(&port->lock);
+	spin_lock_bh(&port->lock);
 	if (port->write_urb_busy) {
-		spin_unlock(&port->lock);
+		spin_unlock_bh(&port->lock);
 		dbg("%s - already writing", __FUNCTION__);
 		return 0;
 	}
 	port->write_urb_busy = 1;
-	spin_unlock(&port->lock);
+	spin_unlock_bh(&port->lock);
 
 	transfer_buffer = port->write_urb->transfer_buffer;
 	transfer_size = min(count, port->bulk_out_size - 1);
Index: linux-2.6-mm/drivers/usb/serial/keyspan_pda.c
===================================================================
--- linux-2.6-mm.orig/drivers/usb/serial/keyspan_pda.c
+++ linux-2.6-mm/drivers/usb/serial/keyspan_pda.c
@@ -518,13 +518,13 @@ static int keyspan_pda_write(struct usb_
 	   the TX urb is in-flight (wait until it completes)
 	   the device is full (wait until it says there is room)
 	*/
-	spin_lock(&port->lock);
+	spin_lock_bh(&port->lock);
 	if (port->write_urb_busy || priv->tx_throttled) {
-		spin_unlock(&port->lock);
+		spin_unlock_bh(&port->lock);
 		return 0;
 	}
 	port->write_urb_busy = 1;
-	spin_unlock(&port->lock);
+	spin_unlock_bh(&port->lock);
 
 	/* At this point the URB is in our control, nobody else can submit it
 	   again (the only sudden transition was the one from EINPROGRESS to
Index: linux-2.6-mm/drivers/usb/serial/omninet.c
===================================================================
--- linux-2.6-mm.orig/drivers/usb/serial/omninet.c
+++ linux-2.6-mm/drivers/usb/serial/omninet.c
@@ -256,14 +256,14 @@ static int omninet_write (struct usb_ser
 		return (0);
 	}
 
-	spin_lock(&wport->lock);
+	spin_lock_bh(&wport->lock);
 	if (wport->write_urb_busy) {
-		spin_unlock(&wport->lock);
+		spin_unlock_bh(&wport->lock);
 		dbg("%s - already writing", __FUNCTION__);
 		return 0;
 	}
 	wport->write_urb_busy = 1;
-	spin_unlock(&wport->lock);
+	spin_unlock_bh(&wport->lock);
 
 	count = (count > OMNINET_BULKOUTSIZE) ? OMNINET_BULKOUTSIZE : count;
 
Index: linux-2.6-mm/drivers/usb/serial/safe_serial.c
===================================================================
--- linux-2.6-mm.orig/drivers/usb/serial/safe_serial.c
+++ linux-2.6-mm/drivers/usb/serial/safe_serial.c
@@ -298,14 +298,14 @@ static int safe_write (struct usb_serial
 		dbg ("%s - write request of 0 bytes", __FUNCTION__);
 		return (0);
 	}
-	spin_lock(&port->lock);
+	spin_lock_bh(&port->lock);
 	if (port->write_urb_busy) {
-		spin_unlock(&port->lock);
+		spin_unlock_bh(&port->lock);
 		dbg("%s - already writing", __FUNCTION__);
 		return 0;
 	}
 	port->write_urb_busy = 1;
-	spin_unlock(&port->lock);
+	spin_unlock_bh(&port->lock);
 
 	packet_length = port->bulk_out_size;	// get max packetsize
 


