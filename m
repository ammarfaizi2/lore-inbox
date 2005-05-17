Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVEQFDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVEQFDG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 01:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVEQFDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 01:03:04 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:15522 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261697AbVEQE6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 00:58:22 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Kris Karas <ktk@enterprise.bidmc.harvard.edu>
Subject: Re: Problem report: 2.6.12-rc4 ps2 keyboard being misdetected as /dev/input/mouse0
Date: Mon, 16 May 2005 23:58:14 -0500
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Greg Stark <gsstark@mit.edu>
References: <87zmuveoty.fsf@stark.xeocode.com> <200505160036.30628.dtor_core@ameritech.net> <4289682B.8060403@enterprise.bidmc.harvard.edu>
In-Reply-To: <4289682B.8060403@enterprise.bidmc.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505162358.15099.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 May 2005 22:42, Kris Karas wrote:
> Dmitry Torokhov wrote:
> 
> >On Monday 16 May 2005 00:12, Greg Stark wrote:
> >  
> >
> >>I just updated to 2.6.12-rc4 and now /dev/input/mouse0 seems to be my ps2
> >>keyboard.
> >>
> >Please use /dev/input/mice for accessing your mouse.
> >
> 
> One possibly interesting mouse issue in 2.6.12-rc[1..4] is that when 
> using /dev/psaux, I have found that my mouse cursor under GPM seems to 
> be triggered into un-hiding when I issue some random number of 
> non-hiding key-down events.  That is, press and release the keyboard 
> shift key say 3 or 5 or 10 times, and the console mouse cursor will 
> appear, just as if the mouse had been moved.  This bug is not in 2.6.11 
> (nor Alan's 2.6.11-ac7, fwiw).
> 

This is caused by atkbd's scrolling support + GPM not expecting to see a
0-motion packets from devices... I'd say we need to fix GPM not to set
GPM_MOVE in these cases; I have looked into adjusting mousedev but it is
too ugly for words to suppress them there.

Although... maybe the patch below is not too ugly.

-- 
Dmitry

Input: mousedev - try not to report 0-motion 0-button mouse events
       to userspace. GPM considers such packets motion data and
       starts displaying selection cursor.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
--

 mousedev.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

Index: dtor/drivers/input/mousedev.c
===================================================================
--- dtor.orig/drivers/input/mousedev.c
+++ dtor/drivers/input/mousedev.c
@@ -9,7 +9,7 @@
  * the Free Software Foundation.
  */
 
-#define MOUSEDEV_MINOR_BASE 	32
+#define MOUSEDEV_MINOR_BASE	32
 #define MOUSEDEV_MINORS		32
 #define MOUSEDEV_MIX		31
 
@@ -101,6 +101,7 @@ struct mousedev_list {
 	unsigned char ready, buffer, bufsiz;
 	unsigned char imexseq, impsseq;
 	enum mousedev_emul mode;
+	unsigned long last_buttons;
 };
 
 #define MOUSEDEV_SEQ_LEN	6
@@ -202,7 +203,7 @@ static void mousedev_key_event(struct mo
 		case BTN_SIDE:		index = 3; break;
 		case BTN_4:
 		case BTN_EXTRA:		index = 4; break;
-		default: 		return;
+		default:		return;
 	}
 
 	if (value) {
@@ -224,7 +225,7 @@ static void mousedev_notify_readers(stru
 		spin_lock_irqsave(&list->packet_lock, flags);
 
 		p = &list->packets[list->head];
-		if (list->ready && p->buttons != packet->buttons) {
+		if (list->ready && p->buttons != mousedev->packet.buttons) {
 			unsigned int new_head = (list->head + 1) % PACKET_QUEUE_LEN;
 			if (new_head != list->tail) {
 				p = &list->packets[list->head = new_head];
@@ -249,10 +250,13 @@ static void mousedev_notify_readers(stru
 		p->dz += packet->dz;
 		p->buttons = mousedev->packet.buttons;
 
-		list->ready = 1;
+		if (p->dx || p->dy || p->dz || p->buttons != list->last_buttons)
+			list->ready = 1;
 
 		spin_unlock_irqrestore(&list->packet_lock, flags);
-		kill_fasync(&list->fasync, SIGIO, POLL_IN);
+
+		if (list->ready)
+			kill_fasync(&list->fasync, SIGIO, POLL_IN);
 	}
 
 	wake_up_interruptible(&mousedev->wait);
@@ -320,7 +324,7 @@ static void mousedev_event(struct input_
 					mousedev->pkt_count++;
 					/* Input system eats duplicate events, but we need all of them
 					 * to do correct averaging so apply present one forward
-			 		 */
+					 */
 					fx(0) = fx(1);
 					fy(0) = fy(1);
 				}
@@ -477,9 +481,10 @@ static void mousedev_packet(struct mouse
 	}
 
 	if (!p->dx && !p->dy && !p->dz) {
-		if (list->tail == list->head)
+		if (list->tail == list->head) {
 			list->ready = 0;
-		else
+			list->last_buttons = p->buttons;
+		} else
 			list->tail = (list->tail + 1) % PACKET_QUEUE_LEN;
 	}
 
@@ -695,7 +700,7 @@ static struct input_device_id mousedev_i
 		.absbit = { BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE) | BIT(ABS_TOOL_WIDTH) },
 	},	/* A touchpad */
 
-	{ }, 	/* Terminating entry */
+	{ },	/* Terminating entry */
 };
 
 MODULE_DEVICE_TABLE(input, mousedev_ids);
